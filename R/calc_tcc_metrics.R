#' Predict plot-level canopy cover from individual tree measurements
#'
#' `calc_tcc_metrics()` computes plot-level predicted tree canopy cover (TCC)
#' from tree list data. A full set of stand structure components used to derive
#' the plot-level prediction are included in the output by default (see
#' Details).
#'
#' @details
#' This function supports two alternative methods for predicting plot-level TCC.
#'
#' The default method requires individual tree coordinates to be provided in the
#' input, as distance and azimuth from subplot centers for trees with diameter
#' \verb{>= 5 in.} (12.7 cm), or from microplot centers for "sapling" trees with
#' diameter \verb{>= 1 in.} (2.54 cm) but \verb{< 5 in.} (12.7 cm). This method
#' involves spatially explicit stem-mapping to account for crown overlap of the
#' mature trees, along with empirical modeling of the understory sapling
#' contribution to total canopy cover (Toney et al. 2009). The empirical model
#' for the sapling component also uses overstory tree point pattern as one of
#' its predictor variables (based on Ripley's K function, Ripley 1977).
#'
#' Alternatively, plot-level TCC can be predicted using a simplified approach
#' that does not include exact stem placement (`stem_map = FALSE`). A random
#' arrangement of stems is assumed in that case. This is the method used to
#' estimate percent canopy cover in the Forest Vegetation Simulator (Crookston
#' and Stage 1999).
#'
#' The stem-map method requires computation of several stand structure metrics
#' which are components of the overall model used to derive the plot-level TCC
#' estimate. These include:
#'
#' * individual tree crown widths via `calc_crwidth()` (if not provided in the
#' input tree list)
#' * individual subplot and microplot crown overlays via `calc_crown_overlay()`
#' * a stand height metric (`meanTreeHtBAW`) via `calc_ht_metrics()`
#' * plot-level counts of mature trees and saplings
#' * descriptive statistics for the tree spatial point pattern via
#' `create_fia_ppp() |> spatstat.explore::Lest()`
#'
#'
#'
#'
#'
#'
#'
#' @param tree_list A data frame with tree records for one FIA plot. In general,
#' the input data frame will have the columns specified in
#' [DEFAULT_TREE_COLUMNS] (see `?DEFAULT_TREE_COLUMNS`). Potentially, only a
#' subset of those columns will be needed depending on values given for the
#' arguments `stem_map`, `full_output` and `crwidth_col` described below.
#' @param stem_map A logical value indicating whether to map individual trees
#' explicitly using coordinates specified in terms of distance and azimuth from
#' subplot/microplot centers. The default is `TRUE`, in which case the input
#' `tree_list` must contain columns `"DIST"` and `"AZIMUTH"`. This argument may
#' be set to `FALSE` if individual tree locations are not available, in which
#' case TCC will be predicted assuming a random arrangement of the stems (see
#' Details).
#' @param full_output A logical value indicating whether to include the full set
#' of components used to derive the plot-level prediction. By default, the
#' output list includes subplot-level TCC estimates, live tree and sapling
#' counts, stand height metrics, and point pattern statistics, depending on the
#' value given for `stem_map` (see Details).
#' @param crwidth_col The name of a column in `tree_list` containing the
#' individual tree crown widths (case-sensitive). Defaults to `"CRWIDTH"`. If
#' the given column name does not exist in the input data frame, or this
#' argument is set to `NULL`, then crown widths will be computed with a call to
#' `calc_crwidth()`.
#' @param digits Optional integer indicating the number of digits to keep in the
#' return values (defaults to `1`). May be passed to `calc_crwidth()` and
#' `calc_ht_metrics()`.
#' @return
#' If `full_output = TRUE`, a named list with the element `model_tcc` containing
#' plot-level predicted tree canopy cover percent (`0:100`), and additional
#' named elements containing stand structure metrics as described in Details.
#' If `full_output = FALSE`, a single numeric value of plot-level predicted TCC
#' is returned instead.
#'
#' @references
#' Crookston, N.L. and A.R. Stage. 1999. Percent canopy cover and stand
#' structure statistics from the Forest Vegetation Simulator. Gen. Tech. Rep.
#' RMRS-GTR-24. Ogden, UT: U. S. Department of Agriculture, Forest Service,
#' Rocky Mountain Research Station. 11 p. Available:
#' \url{https://research.fs.usda.gov/treesearch/6261}.
#'
#' Ripley, B.D. 1977. Modelling spatial patterns. _Journal of the Royal
#' Statistical Society: Series B (Methodological)_, 39(2): 172–192.
#' \url{https://doi.org/10.1111/j.2517-6161.1977.tb01615.x}.
#'
#' Toney, C, J.D. Shaw and M.D. Nelson. 2009. A stem-map model for predicting
#' tree canopy cover of Forest Inventory and Analysis (FIA) plots. In:
#' McWilliams, Will; Moisen, Gretchen; Czaplewski, Ray, comps. _Forest Inventory
#' and Analysis (FIA) Symposium 2008_; October 21-23, 2008; Park City, UT. Proc.
#' RMRS-P-56CD. Fort Collins, CO: U.S. Department of Agriculture, Forest
#' Service, Rocky Mountain Research Station. 19 p. Available:
#' \url{https://research.fs.usda.gov/treesearch/33381}.
#'
#' @seealso
#' [calc_crwidth()], [calc_crown_overlay()], [calc_ht_metrics()],
#' [create_fia_ppp()]
#'
calc_tcc_metrics <- function(tree_list, stem_map = TRUE, full_output = TRUE,
                             crwidth_col = "CRWIDTH", digits = 1) {





}
