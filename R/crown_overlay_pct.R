#' Compute fractional tree canopy cover of a subplot/microplot by crown overlay
#'
#' @param plot_radius A numeric value giving the radius of the
#' subplot/microplot.
#' @param tree_list A data frame containing tree records for the
#' subplot/microplot. Must have columns `DIST` (stem distance from subplot
#' center in same units as `plot_radius`), `AZIMUTH` (horizontal angle from
#' subplot/microplot center to the stem location, in the range `0:359`) and
#' `CRWIDTH` (tree crown width in the same units as `plot_radius` and `DIST`).
#' @return
#' A numeric value for tree canopy cover as percent of the subplot/microplot
#' covered by a vertical projection of circular crowns.
#'
#' @export
crown_overlay_pct <- function(plot_radius, tree_list) {
    x <- tree_list$DIST * sin(tree_list$AZIMUTH * (pi / 180))
    y <- tree_list$DIST * cos(tree_list$AZIMUTH * (pi / 180))

    crowns <- lapply(seq_len(nrow(tree_list)), \(i) {
        gdalraster::g_create("POINT", c(x[i], y[i])) |>
            gdalraster::g_buffer(tree_list$CRWIDTH[i] / 2)
    })

    crowns_poly <- gdalraster::g_build_collection(crowns) |>
        gdalraster::g_unary_union()

    plot_poly <- gdalraster::g_buffer("POINT (0 0)", plot_radius, 90L)

    gdalraster::g_intersection(plot_poly, crowns_poly) |>
        gdalraster::g_area() / gdalraster::g_area(plot_poly) * 100
}
