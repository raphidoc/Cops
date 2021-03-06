% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_cops_db.R
\name{generate_cops_db}
\alias{generate_cops_db}
\title{generate_cops_db}
\usage{
generate_cops_db(project, mission = "XXX", boat = c(""))
}
\arguments{
\item{project}{is the project path top level (i.e, where data_synthesis can be found) .}

\item{mission}{is a string for the name of the mission. It will be used for the file names of the output.}

\item{boat}{OPTIONAL: filter the selected boat, column Boat must be present in Cops_Processing_Log}
}
\value{
It returns a list object named COPS.DB containing matrices of
mean and standard deviation
of Kd1p, Kd10p, Kdpd, Rrs, Ed0.0p,  Ed0.f.diff
and vectors for ID, date, lat, lon sunzen and waves

The object COPS.DB is saved in RData format. The data are also saved in ASCII (.csv)
and a report showing the spectrums of the data base is produced.
}
\description{
The AOPs (Kd_s, Rrs) derived from valid profiles are averaged.
IMPORTANT: only the cast selected in select.cops.dat will be average.
The extrapolation method for Rrs (Rrs.0p or Rrs.0p.linear) must be specified in the
third column of the select.cops.dat.
cops_processing_log is used to filter if a Station is kept (T or F).
}
\details{
Generate an AOPs data base derived from COPS light profiles for a list of directories
}
\author{
Simon Bélanger
}
