#' Compute fractional tree canopy cover of a subplot/microplot by crown overlay
#'
#' @param radius A numeric value giving the radius of the subplot/microplot
#' @param trees A data frame containing the tree list. Must have columns `DIST`
#' (stem distance from subplot center in same units as `radius`), `AZIMUTH`
#' (horizontal angle from subplot center to the stem location, `0:359`) and
#' `CRWIDTH` (tree crown width in the same units as `radius` and `DIST`).
#' @return 
#' A numeric value for tree canopy cover as percent of the subplot/microplot
#' covered by a vertical projection of circular crowns.
#' 
#' @export
crown_overlay_pct <- function(radius, trees) {
    x <- trees$DIST * sin(trees$AZIMUTH * (pi / 180))
    y <- trees$DIST * cos(trees$AZIMUTH * (pi / 180))

    crowns <- lapply(seq_len(nrow(trees)), \(i) {
        gdalraster::g_create("POINT", c(x[i], y[i])) |>
            gdalraster::g_buffer(trees$CRWIDTH[i] / 2)
    })
    
    crowns_poly <- gdalraster::g_build_collection(crowns) |>
        gdalraster::g_unary_union() 
    plot_poly <- gdalraster::g_buffer("POINT (0 0)", radius, quad_segs = 60L)

    gdalraster::g_intersection(plot_poly, crowns_poly) |>
        gdalraster::g_area() / gdalraster::g_area(plot_poly) * 100
}
