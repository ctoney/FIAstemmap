#' Compute tree canopy cover percent of a subplot/microplot by crown overlay
#'
#' @export
crown_overlay_pct <- function(radius, trees) {
    crowns <- gdalraster::g_create("GEOMETRYCOLLECTION")
    for (i in seq_len(nrow(trees))) {
        x <- trees$DIST[i] * sin(trees$AZIMUTH[i] * (pi / 180))
        y <- trees$DIST[i] * cos(trees$AZIMUTH[i] * (pi / 180))
        crowns <- gdalraster::g_create("POINT", c(x, y)) |>
            gdalraster::g_buffer(trees$CRWIDTH[i] / 2, 60) |>
            gdalraster::g_add_geom(crowns)
    }
    plot_poly <- gdalraster::g_buffer("POINT (0 0)", radius, 60)
    gdalraster::g_intersection(plot_poly, gdalraster::g_unary_union(crowns)) |>
        gdalraster::g_area() / gdalraster::g_area(plot_poly) * 100
}
