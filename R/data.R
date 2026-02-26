#' Regression coefficients for predicting tree crown width
#' 
#' A curated set of linear regression coefficients for predicting crown width
#' from stem diamater of tree species in the conterminous US.
#' 
#' @details
#' The regression equation is of the general form:
#' 
#' ```
#' CRWIDTH = b0 + b1 * DIA + b2 * DIA^2
#' ```
#' 
#' but with a quadratic term not included in all cases. CRWIDTH is the 
#' predicted tree crown diamater in feet, and DIA is FIA stem diameter in
#' inches.
#' 
#' In cases that a species-specific equation was not available in the
#' literature, an equation was assigned from a surrogate species based on
#' subjectively similar tree physiognomy.
#' 
#' @format ## `crwidth_coef`
#' A data frame with 430 rows and 8 columns:
#' \describe{
#'   \item{symbol}{USDA PLANTS Database species symbol}
#'   \item{SPCD}{FIA tree species code}
#'   \item{common_name}{FIA tree species common name}
#'   \item{surrogate}{Common name of surrogate species if applicable}
#'   \item{b0}{Regression b0 coefficient}
#'   \item{b1}{Regression b1 coefficient}
#'   \item{b1}{Regression b2 coefficient}
#'   \item{reference}{Reference for source of the coefficients}
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
#'   \item{PLT_CN}{Plot unique identifier}
#'   \item{SUBP}{Subplot number}
#'   \item{TREE}{Tree number}
#'   \item{AZIMUTH}{Horizontal angle from subplot center to the stem location}
#'   \item{DIST}{Distance in feet from subplot center to the stem location}
#'   \item{STATUSCD}{Tree status code: 1 = live, 2 = standing dead}
#'   \item{SPCD}{FIA tree species code}
#'   \item{SPGRPCD}{FIA tree species group code}
#'   \item{DIA}{Tree diameter at breast height in inches}
#'   \item{HT}{Tree height in feet}
#'   \item{ACTUALHT}{Actual height in ft (ACTUALHT < HT indicates a broken top)}
#'   \item{CCLCD}{Tree crown class code}
#'   \item{TPA_UNADJ}{Trees per acre expansion factor}
#'   \item{CRWIDTH}{Estimated tree crown width in feet}
#' }
#' @source <https://research.fs.usda.gov/programs/nfi>
"plantation"
