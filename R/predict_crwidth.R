#' @noRd
#' @export
predict_crwidth <- function(tree_list) {
    if (missing(tree_list) || is.null(tree_list))
        stop("'tree_list' is required", call. = FALSE)

    if (!is.data.frame(tree_list))
        stop("'tree_list' must be a data frame", call. = FALSE)

    required_cols <- c("SPCD", "STATUSCD", "DIA")
    if (!all(required_cols %in% colnames(tree_list)))
        stop("'tree_list' is missing required columns", call. = FALSE)

    if (!is.numeric(tree_list$SPCD))
        stop("'tree_list$SPCD' must be numeric or integer", call. = FALSE)
    if (any(is.na(tree_list$SPCD)))
        stop("'tree_list$SPCD' cannot have missing values", call. = FALSE)

    if (!is.numeric(tree_list$STATUSCD))
        stop("'tree_list$STATUSCD' must be numeric or integer", call. = FALSE)
    if (any(is.na(tree_list$STATUSCD)))
        stop("'tree_list$STATUSCD' cannot have missing values", call. = FALSE)

    if (!is.numeric(tree_list$DIA))
        stop("'tree_list$DIA' must be numeric", call. = FALSE)
    if (any(is.na(tree_list$DIA)))
        stop("'tree_list$DIA' cannot have missing values", call. = FALSE)

    # default regression coefficients if species-specific ones are missing
    # SPCD == 807, blue oak
    b_default <- cw_coef[cw_coef$SPCD == 807, c("b0", "b1", "b2")]

    cw <- rep_len(NA_real_, nrow(tree_list))

    # special case for large trees of certain species in the PNW region:
    # use the "old growth" equation from Gill et al. (2000)
    old_growth_trees <- tree_list$DIA > 50 & tree_list$STATUSCD == 1 &
        tree_list$SPCD %in% c(11, 98, 108, 119, 122, 202, 242, 263, 264)

    cw[old_growth_trees] <- 16.449 + 0.4067 * tree_list$DIA[old_growth_trees]

    # apply species-specific equations
    # NB: crwidth of trees with DIA < 5 in. (i.e. "saplings") is predicted for
    # DIA = 5 and then sapling crwidth adjustment factors are applied afterward
    for (spcd in unique(tree_list$SPCD)) {
        b <- cw_coef[cw_coef$SPCD == spcd, c("b0", "b1", "b2")]
        if (nrow(b) == 0)
            b <- b_default

        this_subset <- tree_list$SPCD == spcd & tree_list$STATUSCD == 1 &
                       is.na(cw)

        if (length(this_subset) > 0) {
            cw[this_subset] <- b$b0[1] +
                               b$b1[1] * pmax(5, tree_list$DIA[this_subset]) +
                               b$b2[1] * pmax(5, tree_list$DIA[this_subset])^2
        }
    }

    # apply sapling crown width adjustment factors
    saplings <- tree_list$DIA < 5 & tree_list$STATUSCD == 1
    sapling_spp <- unique(tree_list$SPCD[saplings])
    # species-specific adjustment factors if any
    spp_adj <- intersect(sapling_spp, cw_sapling_adj$SPCD)
    # TODO:
    # ...


    return(cw)
}
