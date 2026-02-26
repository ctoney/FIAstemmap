#' Regression coefficients for predicting tree crown width
#'
#' A curated set of linear regression coefficients for predicting crown width
#' from stem diameter of tree species in the conterminous US.
#'
#' @details
#' The regression equation is of the general form:
#'
#' ```
#' CRWIDTH = b0 + b1 * DIA + b2 * DIA^2
#' ```
#'
#' A quadratic term is not included in all cases. `CRWIDTH` is the
#' predicted tree crown diameter in feet, and `DIA` is FIA stem diameter in
#' inches.
#'
#' In cases that a species-specific equation was not available in the
#' literature, a surrogate species was assigned subjectively based on similar
#' tree physiognomy.
#'
#' @format ## `crwidth_coef`
#' A data frame with 430 rows and 8 columns:
#' \describe{
#'   \item{\code{symbol}}{\code{\link{character}},
#'     USDA PLANTS Database species symbol}
#'   \item{\code{SPCD}}{\code{\link{integer}}, FIA tree species code}
#'   \item{\code{common_name}}{\code{\link{character}},
#'     FIA tree species common name}
#'   \item{\code{surrogate}}{\code{\link{character}},
#'     Common name of surrogate species if applicable}
#'   \item{\code{b0}}{\code{\link{numeric}}, Regression b0 coefficient}
#'   \item{\code{b1}}{\code{\link{numeric}}, Regression b1 coefficient}
#'   \item{\code{b1}}{\code{\link{numeric}}, Regression b2 coefficient}
#'   \item{\code{reference}}{\code{\link{character}},
#'     Literature source of the species coefficients (see References)}
#' }
#' @references
#' Bechtold, W.A. 2003. Crown-Diameter Prediction Models for 87 Species of
#' Stand-Grown Trees in the Eastern United States. _Southern Journal of Applied
#' Forestry_, Vol. 27, No. 4, 269-278.
#'
#' Bechtold, W.A. 2004. Largest-Crown-Width Prediction Models for 53 Species in
#' the Western United States. _Western Journal of Applied Forestry_, Vol. 19,
#' No. 4, 245-251.
#'
#' Gill, S.J., G.S. Biging, E.C. Murphy. 2000. Modeling conifer tree crown
#' radius and estimating canopy cover. _Forest Ecology and Management_, 126,
#' 405-416.
"crwidth_coef"


#' Tree list for a plot in a loblolly pine plantation
#'
#' An example tree list for an FIA plot in a loblolly pine plantation.
#'
#' @format ## `plantation`
#' A data frame with 91 rows and 14 columns:
#' \describe{
#'   \item{\code{PLT_CN}}{\code{\link{character}}, Plot unique identifier}
#'   \item{\code{SUBP}}{\code{\link{integer}}, Subplot number}
#'   \item{\code{TREE}}{\code{\link{integer}}, Tree number}
#'   \item{\code{AZIMUTH}}{\code{\link{integer}},
#'     Horizontal angle from subplot center to the stem location}
#'   \item{\code{DIST}}{\code{\link{numeric}},
#'     Distance in feet from subplot center to the stem location}
#'   \item{\code{STATUSCD}}{\code{\link{integer}},
#'     Tree status code: 1 = live, 2 = standing dead}
#'   \item{\code{SPCD}}{\code{\link{integer}}, FIA tree species code}
#'   \item{\code{SPGRPCD}}{\code{\link{integer}}, FIA tree species group code}
#'   \item{\code{DIA}}{\code{\link{numeric}},
#'     Tree diameter at breast height in inches}
#'   \item{\code{HT}}{\code{\link{integer}}, Tree height in feet}
#'   \item{\code{ACTUALHT}}{\code{\link{integer}},
#'     Actual height in ft (ACTUALHT < HT indicates a broken top)}
#'   \item{\code{CCLCD}}{\code{\link{integer}}, Tree crown class code}
#'   \item{\code{TPA_UNADJ}}{\code{\link{numeric}},
#'     Trees per acre expansion factor}
#'   \item{\code{CRWIDTH}}{\code{\link{numeric}},
#'     Estimated tree crown width in feet}
#' }
#' @source <https://research.fs.usda.gov/programs/nfi>
"plantation"
