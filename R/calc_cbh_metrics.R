#' Calculate canopy base height metrics for an FIA tree list
#'
#' `calc_cbh_metrics()` computes canopy base height metrics for an FIA tree list
#' based on measurements of uncompacted live crown ratio (`UNCRCD`) of
#' individual trees `>= 5.0` in. (`12.7` cm) diameter. Canopy base height
#' represents the lowest height at which canopy fuel, aggregated across multiple
#' tree crowns, can propagate fire vertically (see, e.g., Mast et al. 2026).
#' This function derives individual tree crown base heights from actual tree
#' height and the uncompacted crown ratio, and computes the mean, median,
#' \eqn{20^{th}}{20th} percentile and minimum.
#'
#' @param tree_list A data frame with tree records for one FIA plot.  Must have
#' columns `ACTUALHT` (tree actual height) and `UNCRCD` (uncompacted live crown
#' ratio as percentage).
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
calc_cbh_metrics <- function(tree_list, digits = 1) {


    NULL
}
