#' Load tree data from a file or database connection
#'
#' `load_tree_data()` fetches tree records from a data source, most commonly
#' a comma-separated values (CSV) file, a SQLite database file (.db, .sqlite,
#' .gpkg), or a PostgreSQL database connection. Other data sources are also
#' possible. File-based sources can be read from compressed archives without
#' prior extraction (e.g., .zip), and network-hosted files can be read directly
#' without prior download (see Details).
#'
#' @details
#' A data source is typically specified as one of the following: **WIP**
#'
#' @param src A character string specifying the data source as a file name or
#' database connection string (see Details).
#' @param table Optional character string giving the name of a table in `src`
#' from which tree records will be fetched. Generally needed with RDBMS sources
#' containing multiple tables, as opposed to a single-table source such as a
#' CSV file.
#' @param columns Optional character vector specifying a subset of column names
#' in the source table to include in the result set.
#' @param sql Optional character string containing a SQL SELECT statement to
#' execute on `src` (instead of selecting all records potentially from a subset
#' of columns, i.e., mutually exclusive with `table` and/or `columns`).
#' @return
#' A data frame containing the tree records fetched from `src`.
#'
#' @export
load_tree_data <- function(src, table = NULL, columns = DEFAULT_TREE_COLUMNS,
                           sql = NULL) {

    if (missing(src) || is.null(src))
        stop("'src' is required")

    if (!(is.character(src) && length(src) == 1))
        stop("'src' must be a single character string")

    if (!is.null(table) && !is.null(sql))
        stop("'table' and 'sql' are mutually exclusive", call. = FALSE)

    if (!is.null(table) && !(is.character(table) && length(table == 1)))
        stop("'table' must be a single character string")

    if (!is.null(columns) && !is.character(columns))
        stop("'columns' must be a character vector")

    if (!is.null(sql) && !(is.character(sql) && length(sql == 1)))
        stop("'sql' must be a single character string")

    ds <- NULL
    if (is.null(table) && is.null(sql)) {
        ds <- try(methods::new(gdalraster::GDALVector, src), silent = TRUE)
    } else if (!is.null(table)) {
        ds <- try(methods::new(gdalraster::GDALVector, src, table),
                  silent = TRUE)
    } else if (!is.null(sql)) {
        ds <- try(methods::new(gdalraster::GDALVector, src, sql), silent = TRUE)
    }

    if (!methods::is(ds, "Rcpp_GDALVector"))
        stop("failed to establish a connection to 'src'", call. = FALSE)

    if (!is.null(columns) && columns[1] != "")
        ds$setSelectedFields(columns)

    cli::cli_progress_step("Fetching tree records")
    d <- ds$fetch(-1)

    ds$close()
    return(d)
}
