#' Create a 'spatstat' point pattern dataset for an FIA plot tree list
#'
#' `create_fia_ppp()` returns an object of class `"ppp"` representing the point
#' pattern of an FIA tree list in the 2-D plane. A point pattern object defines
#' the dataset for using a stem-mapped FIA plot with functions of the
#' \pkg{spatstat} library.
#'
#' @details
#' The standard set of columns for tree list data in \pkg{FIAstemmap} is given
#' below, along with their status as required or optional for
#' `create_fia_ppp()`:
#' * `PLT_CN`: optional, `create_fia_ppp()` assumes input is for one plot
#' * `SUBP`: required subplot number
#' * `TREE`: required tree number within a subplot
#' * `AZIMUTH`: required horizontal angle from subplot center
#' * `DIST`: required distance from subplot center
#' * `STATUSCD`: required tree status code (1 = live, 2 = dead)
#' * `SPCD`: optional FIA species code
#' * `SPGRPCD`: optional FIA species group code
#' * `DIA`: optional tree diameter
#' * `HT`: optional tree height
#' * `ACTUALHT`: optional tree actual height (accounts for broken top)
#' * `CCLCD`: optional crown class code
#' * `TPA_UNADJ`: optional tree expansion factor (per acre)
#' * `CRWIDTH`: optional crown width
#' @param tree_list A data frame containing a set of tree records for one FIA
#' plot (see Deatils).
#' @param live_trees A logical value, `TRUE` to include live trees only (the
#' default, i.e., `STATUSCD == 1`).
#' @param min_dia A numeric value specifying the minimum diameter threshold
#' for included trees. The default is `5.0`. Trees less than 5-in. diameter but
#' \>= 1.0-in. diameter, denoted as "saplings", are only recorded in FIA
#' microplots so cannot be stem-mapped across the 4-subplot footprint.
#' @param linear_unit An optional character string specifying the linear
#' distance unit. Defaults to the native FIA unit of `"ft"``, but may be set to
#' `"m"` instead.
#' @param macroplot An optional logical value. The default is `FALSE`, which
#' defines the FIA plot footprint in terms of the standard four-subplot
#' configuration with subplot radius of 24 ft (7.3152 m). See
#' [create_fia_owin()]. By default, "macroplot trees" having `DIST` outside the
#' subplot boundary are not included.
#' @param window An optional object of class `"owin"` defining the observation
#' window of an FIA plot in the 2-D plane. Defaults to
#' `create_fia_owin(linear_unit, macroplot)`.
#' @param mark_cols An optional character vector of column names in `tree_list`
#' to designate as \pkg{spatstat} `marks` which carry additional information for
#' each data point in a point pattern object.
#' @param mark_as_factor An optional subset of `mark_cols` to be treated as
#' `factor` marks. If not already `factor`, these will be corced as such upon
#' input. `factor` marks are those that take only a finite number of possible
#' values (e.g. colors or types).
#' @return
#' An object of class `"ppp"` which defines a point pattern dataset for use
#' with functions of the \pkg{spatstat} library.
#'
#' @seealso
#' [create_fia_owin()]
#'
#' @examples
#' X <- create_fia_ppp(plantation)
#' summary(X)
#'
#' plot(X, main = "Pine plantation stem map")
#'
#' # plot trees as trees :)
#' X <- create_fia_ppp(plantation, mark_cols = "SPCD")
#' plot(X, main = "Pine plantation stem map",
#'      shape = "arrows", direction = 90, size = 12, cols = "darkgreen",
#'      legend = FALSE)
#' @export
create_fia_ppp <- function(tree_list, live_trees = TRUE, min_dia = 5,
                           linear_unit = "ft", macroplot = FALSE, window = NULL,
                           mark_cols = NULL, mark_as_factor = NULL) {

    if (missing(tree_list) || is.null(tree_list))
        stop("'tree_list' is required", call. = FALSE)

    if (!is.data.frame(tree_list))
        stop("'tree_list' must be a data frame", call. = FALSE)

    required_cols <- c("SUBP", "TREE", "AZIMUTH", "DIST", "STATUSCD")
    if (!all(required_cols %in% colnames(tree_list)))
        stop("'tree_list' is missing required columns", call. = FALSE)

    if (!all(unique(tree_list$SUBP) %in% c(1, 2, 3, 4)))
        stop("'tree_list$SUBP' contains invalid subplot numbers", call. = FALSE)

    if (any(tree_list$AZIMUTH < 0) || any(tree_list$AZIMUTH > 360))
        stop("'tree_list$AZIMUTH' contains values out of range", call. = FALSE)

    if (is.null(live_trees))
        live_trees <- TRUE
    else if (!(is.logical(live_trees) && length(live_trees) == 1))
        stop("'live_trees' must be a single logical value", call. = FALSE)

    if (is.null(min_dia))
        min_dia <- 5
    else if (!(is.numeric(min_dia) && length(min_dia) == 1))
        stop("'min_dia' must be a single numeric value", call. = FALSE)

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

    if (is.null(window))
        window <- create_fia_owin(linear_unit, macroplot)
    else if (!methods::is(window, "owin"))
        stop("'window' must be an object of class `owin`", call. = FALSE)

    if (!is.null(mark_cols) && !is.character(mark_cols))
        stop("'mark_cols' must be a character vector", call. = FALSE)
    else if (!all(mark_cols %in% colnames(tree_list)))
        stop("'tree_list' is missing one or more columns in 'mark_cols",
             call. = FALSE)

    if (!is.null(mark_as_factor) && !is.character(mark_as_factor))
        stop("'mark_as_factor' must be a character vector", call. = FALSE)
    else if (!all(mark_as_factor %in% mark_cols))
        stop("'mark_cols' is missing one or more columns in 'mark_as_factor",
             call. = FALSE)

    tree_list_in <- tree_list
    if (live_trees) {
        tree_list_in <- tree_list[tree_list$STATUSCD == 1 &
                                  tree_list$DIA >= min_dia, ]
    } else {
        tree_list_in <- tree_list[tree_list$DIA >= min_dia, ]
    }

    xy <- .get_tree_list_xy(tree_list_in)

    marks <- NULL
    if (!is.null(mark_cols))
        marks <- tree_list_in[, mark_cols]

    if (!is.null(mark_as_factor)) {
        if (is.vector(marks)) {
            if (!is.factor(marks))
                marks <- as.factor(marks)
        } else {
            for (col in mark_as_factor) {
                if (!is.factor(marks[, col]))
                    marks[, col] <- as.factor(marks[, col])
            }
        }
    }

    spatstat.geom::ppp(xy$x, xy$y, window = window, marks = marks)
}
