#' Create a 'spatstat' observation window for the FIA plot footprint
#'
#' `create_fia_owin()` returns an object of class `"owin"` from the
#' \pkg{spatstat} library, representing the observation window of an FIA plot
#' in the 2-D plane. The returned object is used when creating a \pkg{spatstat}
#' point pattern for an FIA plot tree list.
#'
#' @param linear_unit An optional character string specifying the linear
#' distance unit. Defaults to the native FIA unit of `"ft"``, but may be set to
#' `"m"` instead.
#' @param macroplot An optional logical value. The default is `FALSE`, which
#' defines the FIA plot footprint in terms of the standard four-subplot
#' configuration with subplot radius of 24 ft (7.3152 m). May be set to `TRUE`
#' in which case the observation window will be defined using the FIA optional
#' "macroplot" dimension instead (58.9 ft or 18.227 m radius, used only in
#' certain areas of the Pacific Northwest FIA region).
#' @param npoly Integer value giving the number of edges to use for polygon
#' approximation. Defaults to `720`.
#' @return
#' An object of class `"owin"` which defines the observation window for a point
#' pattern in the \pkg{spatstat} library.
#'
#' @seealso
#' [create_fia_ppp()]
#'
#' @examples
#' w <- create_fia_owin()
#' summary(w)
#'
#' w <- create_fia_owin("m")
#' summary(w)
#'
#' plot(w, main = "FIA standard four-subplot design")
#' @export
create_fia_owin <- function(linear_unit = "ft", macroplot = FALSE,
                            npoly = 360) {

    if (is.null(linear_unit))
        linear_unit <- "ft"
    else if (!(is.character(linear_unit) && length(linear_unit) == 1))
        stop("'linear_unit' must be a single character string", call. = FALSE)
    else
        linear_unit <- tolower(linear_unit)

    if (!(linear_unit %in% c("ft", "foot", "m", "meter", "metre")))
        stop("'linear_unit' is invalid", call. = FALSE)

    if (is.null(macroplot))
        macroplot <- FALSE
    else if (!(is.logical(macroplot) && length(macroplot) == 1))
        stop("'macroplot' must be a single logical value", call. = FALSE)

    if (is.null(npoly))
        npoly <- 720L
    else if (!(is.numeric(npoly) && length(npoly) == 1))
        stop("'npoly' must be a single integer value", call. = FALSE)

    # avoid points falling outside a subplot boundary due to rounding error by
    # adding 0.001 here
    subp_radius <- 24.001
    if (macroplot)
        subp_radius <- 59.801

    unit_conv <- 1  # FIA native unit ft
    unit_names <- c("foot", "feet")
    if (linear_unit %in% c("m", "meter", "metre")) {
        unit_conv <- 0.3048  # ft to m
        unit_names <- c("meter", "meters")
        subp_radius <- subp_radius * unit_conv
    }

    s1 <- spatstat.geom::disc(subp_radius, c(0, 0), npoly = npoly)
    s2 <- spatstat.geom::disc(subp_radius,
                              c(0, 120 * unit_conv),
                              npoly = npoly)
    s3 <- spatstat.geom::disc(subp_radius,
                              c(103.92 * unit_conv, -60 * unit_conv),
                              npoly = npoly)
    s4 <- spatstat.geom::disc(subp_radius,
                              c(-103.92 * unit_conv, -60 * unit_conv),
                              npoly = npoly)

    w <- spatstat.geom::union.owin(s1, s2, s3, s4)
    spatstat.geom::unitname(w) <- unit_names

    return(w)
}
