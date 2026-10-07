#' Calculate canopy base height metrics from FIA tree data
#'
#' `calc_cbh_metrics()` computes canopy base height metrics for FIA tree data
#' based on measurements of uncompacted live crown ratio (`UNCRCD`) of
#' individual trees `>= 5.0` in. (`12.7` cm) diameter. Canopy base height
#' represents the lowest height at which canopy fuel, aggregated across multiple
#' tree crowns, can propagate fire vertically (see, e.g., Mast et al. 2026).
#' This function derives individual tree crown base heights from actual tree
#' height and the uncompacted crown ratio, and computes the mean, median,
#' \eqn{20^{th}}{20th} percentile and minimum.
#'
#' @param tree_data A data frame with tree records for one or more FIA plots.
#' Must have columns `ACTUALHT` (tree actual height) and `UNCRCD` (uncompacted
#' live crown ratio as percentage).
#' @param plot_id_col A character string giving the column name of the unique
#' plot identifier. If `NULL` and no column is named `PLT_CN`
#' (case-insensitive), the input data are assumed to be a single tree
#' list. If `PLT_CN` exists, it will be used as the plot ID column.
#' @param digits Optional integer indicating the number of digits to keep in the
#' return values (defaults to `1`).
#' @return
#' A list of canopy base height metrics aggregated from individual tree
#' crown base heights, with the following named elements: `cbh_mean`,
#' `cbh_median`, `cbh_pct20` and `cbh_min`.
#'
#' @references
#' Mast, C.N., L. Vallet, M.D. Hurteau, H. Zald, G.M. Jones, G.A. Woolsey,
#' W. Tinkham, C.M. Hoffman, E.J. Francis. 2026. Methods and implications of
#' canopy base height characterization for modeling crown fire potential.
#' _Fire Ecology_ 22(117). \doi{10.1186/s42408-026-00567-4}.
#'
#' @seealso
#' [calc_ht_metrics()], [calc_tcc_metrics()]
#'
#' @examples
#' calc_cbh_metrics(western_redcedar)
#'
#' @export
calc_cbh_metrics <- function(tree_table, plot_id_col = NULL, digits = 1) {
    if (missing(tree_table) || is.null(tree_table)) {
        stop(cli::format_error(c(
            "{.arg tree_table} is required",
        "x" = "A required argument is missing or NULL")))
    }

    if (!is.data.frame(tree_table)) {
        stop(cli::format_error(c(
            "{.arg tree_table} must be a {.cls data.frame}",
        "x" = "Invalid input type: {.cls {class(tree_table)}}")))
    }

    if (!is.null(plot_id_col)) {
        if (!(is.character(plot_id_col) && length(plot_id_col) == 1)) {
            stop(cli::format_error(c(
                "{.arg plot_id_col} must be a {.cls character} string",
            "x" = "{.arg plot_id_col} not a length-1 {.cls character} vector")))
        }
    }

    required_cols <- c("ACTUALHT", "UNCRCD")
    if (!all(required_cols %in% colnames(tree_table))) {
        stop(cli::format_error(c(
            "{.arg tree_table} is missing one or more required columns",
        "x" = "Missing column(s): {.fld {setdiff(required_cols, colnames(tree_table))}}")))
    }
}
