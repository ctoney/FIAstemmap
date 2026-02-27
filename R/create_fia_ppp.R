#' Create a 'spatstat' point pattern dataset for an FIA plot tree list
#'
#' `create_fia_ppp()` returns an object of class `"ppp"` representing the point
#' pattern of an FIA tree list in the 2-D plane. A point pattern object defines
#' the dataset for using a stem-mapped FIA plot with functions of the
#' \pkg{spatstat} library.
#'
#'
create_fia_ppp <- function(tree_list, live_only = TRUE, min_dia = 5.0,
                           linear_unit = "ft", macroplot = FALSE,
                           window = create_fia_owin(linear_unit, macroplot),
                           mark_cols = c("SPCD", "DIA", "ACTUALHT", "CRWIDTH"),
                           mark_as_factor = c("SPCD")) {



}
