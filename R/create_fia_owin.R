#' Create a 'spatstat' observation window for the FIA plot footprint
#' 
#' `create_fia_owin()` returns an object of class `"owin"` representing the
#' observation window of an FIA plot in the 2-D plane. Class `"owin"` defines
#' such window for working with an FIA tree list as a point pattern dataset
#' via functions of the \pkg{spatstat} package.
#' 
#' @param linear_unit An optional character string specifying the linear
#' distance unit. Defaults to the native FIA unit of `"ft"``, but may be set to
#' `"m"`.
#' @param macroplot An optional logical value. The default is `FALSE` with the
#' FIA plot footprint defined in terms of the standard four-subplot
#' configuration with subplot radius of 24 ft (7.3152 m). May be set to `TRUE`
#' in which case the observation window will be defined in terms of the FIA
#' optional macroplot dimension instead (58.9 ft / 18.227 m raduis, used only
#' in certain areas of the Pacific Northwest FIA region).
#' @return
#' An object of class `"owin"` which defines the observation window for a point
#' pattern in the \pkg{spatstat} library.
#' 
#' @examples
#' w <- create_fia_owin()
#' plot(w, main = "FIA standard four-subplot design")
#' 
#' @export 
create_fia_owin <- function(linear_unit = "ft", macroplot = FALSE) {
    if (missing(linear_unit) || is.null(linear_unit))
        linear_unit <- "ft"
    else if (!is.character(linear_unit) && length(linear_unit) == 1)
        stop("'linear_unit' must be a single character string", call. = FALSE)
    else
        linear_unit <- tolower(linear_unit)

    if (missing(macroplot) || is.null(macroplot))
        macroplot <- FALSE
    else if (!is.logical(macroplot) && length(macroplot) == 1)
        stop("'macroplot' must be a single logical value", call. = FALSE)

    subp_radius <- 24.0
    if (macroplot)
        subp_radius <- 59.8

    unit_conv <- 1
    if (linear_unit == "m") {
        unit_conv <- 0.3048
        subp_radius <- subp_radius * unit_conv
    }

    s1 <- spatstat.geom::disc(subp_radius, c(0, 0), npoly = 360)
    s2 <- spatstat.geom::disc(subp_radius,
                              c(0, 120 * unit_conv),
                              npoly = 360)
    s3 <- spatstat.geom::disc(subp_radius,
                              c(103.92 * unit_conv, -60 * unit_conv),
                              npoly = 360)
    s4 <- spatstat.geom::disc(subp_radius,
                              c(-103.92 * unit_conv, -60 * unit_conv),
                              npoly = 360)

    spatstat.geom::union.owin(s1, s2) |>
        spatstat.geom::union.owin(s3) |>
        spatstat.geom::union.owin(s4)
}