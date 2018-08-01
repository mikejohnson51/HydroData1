#' Find USDA NRCS Snotel Stations
#'
#' @description
#' \code{findSnotel} returns a list of \code{Spatial*} Objects cropped to an Area of Interest.\cr\cr
#' To better understand defining an AOI using '\emph{state}', '\emph{county}' and '\emph{clip}' see \code{getAOI} and \code{getClipUnit}.\cr\cr
#' Returned \code{list} can be interactivly explored via \code{\link{explore}} and ID values (\code{ids = TRUE}) allow for SNOTEL data access via \code{getSNOTEL}.\cr\cr
#' All outputs are projected to \code{CRS '+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0+no_defs'} and station data is taken from \href{https://wcc.sc.egov.usda.gov/nwcc/yearcount?network=sntl&counttype=statelist&state=}{NRCS reports}.
#'
#' @param state     Full name(s) or two character abbriviation(s). Not case senstive
#' @param county    County name(s). Requires \code{state} input.
#' @param clip SpatialObject* or list. For details see \code{getClipUnit}
#' @param boundary  If TRUE, the AOI \code{SpatialPolygon(s)} will be joined to returned list
#'
#'  If a user wants greater control over basemap apperance replace TRUE with either:
#' \itemize{
#' \item't':  google terrain basemap
#' \item's':  google sattilite imagery basemap
#' \item'h':  google hybrid basemap
#' \item'r':  google roads basemap
#' }
#'
#' @param ids  If TRUE, returns a list of station IDs in AOI
#' @param save If TRUE, data is written to a HydroData folder in users working directory.
#'
#' @seealso  \code{\link{getAOI}}
#' @seealso  \code{\link{getSnotel}}
#' @seealso  \code{\link{explore}}
#'
#' @family HydroData 'find' functions
#'
#' @return
#' \code{findSnotel} returns a list of minimum length 1:
#'
#' \enumerate{
#' \item 'snotel': A \code{SpatialPointsDataFrame*}\cr
#'
#' Pending parameterization, \code{findSnotel} can also return:
#'
#' \item 'basemap':   A \code{RasterLayer*} basemap if \code{basemap = TRUE}
#' \item 'boundry':   A \code{SpatialPolygon*} of AOI if \code{boundary = TRUE}
#' \item 'fiat':      A \code{SpatialPolygon*} of intersected county boundaries if \code{boundary = TRUE}
#' \item 'ids':       A vector of station IDs if \code{ids = TRUE}
#' }
#'
#' @examples
#' \dontrun{
#' # Find Snotel stations in Nevada
#'
#' nv.snow = findSnotel(state = 'NV', boundary = TRUE, basemap = TRUE)
#'
#' # Static Mapping
#'
#' plot(nv.snow$basemap)
#' plot(nv.snow$boundary, add = TRUE, lwd = 5)
#' plot(nv.snow$snotel, add = TRUE, pch = 8, col = "lightblue")
#'
#' # Generate Interactive Map
#'
#' explore(nv.snow)
#'}
#'
#'
#' @export
#' @author
#' Mike Johnson

findSnotel = function(AOI = NULL, ids = FALSE){

  if(class(AOI) != "list"){AOI = list(AOI = AOI)}

  snotel = HydroData::snotel

  sp = sp::SpatialPointsDataFrame(cbind(snotel$LONG, snotel$LAT), data = as.data.frame(snotel), proj4string = AOI::aoiProj)

  sp = sp[AOI$AOI,]

  if (dim(sp)[1] == 0) { stop("0 stations found in AOI") }

  message(formatC(as.numeric(length(sp)), format="d", big.mark=","), " snotel stations found within AOI")

  AOI[["snotel"]] = sp

  report ="Returned list includes: snotel shapefile"

  AOI = return.what(AOI, type = 'snotel', report, vals = if(ids){"ID"})

  return(AOI)
}
