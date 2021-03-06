% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utility_data.R
\docType{data}
\name{usgsStations}
\alias{usgsStations}
\title{USGS NWIS station information}
\format{a \code{dataframe} instance, 1 row per station with columns:
\itemize{
\item 'OBJECTID':      A \code{character} Object id in the dataset
\item 'feature_id':    A \code{character} NHD COMID of reach
\item 'site_no':       A \code{character} USGS site number
\item 'site_name':     A \code{character} USGS site name
\item 'da_sqkm':       A \code{numeric}   Area that drains to the location in square kilometers
\item 'lat_reachCent': A \code{numeric}   Latitude of NHD reach center
\item 'lon_reachCent': A \code{numeric}   Longitude of NHD reach center
}}
\source{
Compiled from USGS and NHD datasets
}
\usage{
usgsStations
}
\description{
Dataset containing information about USGS stations in the United States
}
\examples{
\dontrun{
 usgs = HydroData::usgsStations
}
}
\keyword{datasets}
