#' Tree list for a plot in a loblolly pine plantation
#'
#' An example tree list for an FIA plot in a loblolly pine plantation.
#'
#' @format ## `plantation`
#' A data frame with 91 rows and 13 columns:
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
#' }
#' @source <https://research.fs.usda.gov/programs/nfi>
"plantation"