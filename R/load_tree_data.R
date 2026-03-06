#' @noRd
#' @export
load_tree_data <- function(src, table = NULL, columns = NULL, sql = NULL) {

    default_cols <- c("PLT_CN", "SUBP", "TREE", "AZIMUTH", "DIST", "STATUSCD",
                      "SPCD", "DIA", "HT", "ACTUALHT", "CCLCD", "TPA_UNADJ")

    if (is.null(columns))
        columns <- default_cols

    if (!is.null(sql) && !is.null(table))
        stop("'table' and 'sql' are mutually exclusive", call. = FALSE)

    ds <- NULL
    if (is.null(table) && is.null(sql)) {
        ds <- try(methods::new(gdalraster::GDALVector, src), silent = TRUE)
    } else if (!is.null(table)) {
        ds <- try(methods::new(gdalraster::GDALVector, src, table), silent = TRUE)
    } else if (!is.null(sql)) {
        ds <- try(methods::new(gdalraster::GDALVector, src, sql), silent = TRUE)
    }

    if (!methods::is(ds, "Rcpp_GDALVector"))
        stop("failed to establish a connection to 'src'", call. = FALSE)

    if (!is.null(table) && !is.null(columns) && columns != "")
        ds$setSelectedFields(columns)



    ds$close()
}
