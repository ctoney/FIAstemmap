#' @export
plot_crowns <- function(tree_list, subplot = NULL, microplot = FALSE,
                        linear_unit = "ft", main = "") {

    if (is.null(subplot) || is.na(subplot))
        subplot <- FALSE

    if (subplot && microplot) {
        trees_in <- tree_list[tree_list$STATUSCD == 1 &
                              tree_list$SUBP == subplot &
                              tree_list$DIA < 5, ]
    } else if (subplot && !microplot) {
        trees_in <- tree_list[tree_list$STATUSCD == 1 &
                              tree_list$SUBP == subplot &
                              tree_list$DIA >= 5, ]
    } else {
        trees_in <- tree_list[tree_list$STATUSCD == 1 & tree_list$DIA >= 5, ]
    }

    trees_in$height <- pmin(trees_in$HT, trees_in$ACTUALHT, na.rm = TRUE)
    trees_in$dia_ft <- 0.0833333 * trees_in$DIA
    trees_in <- trees_in[order(trees_in$height), ]

    if (subplot) {
        pts <- vector(mode = "list", length = 2)
        names(pts) <- c("x", "y")
        pts$x <- tree_list$DIST * sin(tree_list$AZIMUTH * (pi / 180))
        pts$y <- tree_list$DIST * cos(tree_list$AZIMUTH * (pi / 180))
    } else {
        pts <- .get_tree_list_xy(trees_in)
    }

    crowns <- lapply(seq_len(nrow(trees_in)), \(i) {
        gdalraster::g_create("POINT", c(pts$x[i], pts$y[i])) |>
            gdalraster::g_buffer(trees_in$CRWIDTH[i] / 2)
    })

    rct <- as.list(gdalraster::g_build_collection(crowns) |>
                       gdalraster::g_envelope())
    names(rct) <- c("xmin", "xmax", "ymin", "ymax")

    if (subplot) {
        fia_poly <- gdalraster::g_buffer("POINT (0 0)", 24)
        stems <- lapply(seq_len(nrow(trees_in)), \(i) {
            gdalraster::g_create("POINT", c(pts$x[i], pts$y[i])) |>
                gdalraster::g_buffer(trees_in$dia_ft[i] / 2)
        })
    } else {
        fia_poly <- .get_fia_plot_geom(linear_unit = linear_unit)
    }

    xlab <- paste0("x (", linear_unit, ")")
    ylab <- paste0("y (", linear_unit, ")")
    gdalraster::plot_geom(fia_poly, xlab, ylab, main, border = "gray62",
                          lwd = 3, bbox = rct)

    for (i in seq_len(nrow(trees_in))) {
        # alternate green: #40c945
        gdalraster::plot_geom(crowns[[i]], col = "#328e13", border = NA,
                              add = TRUE)
        if (subplot) {
            gdalraster::plot_geom(stems[[i]], col = "#b85e00", border = NA,
                                  add = TRUE)
        }
    }

    invisible(NULL)
}
