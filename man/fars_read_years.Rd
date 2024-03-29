% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_functions.R
\name{fars_read_years}
\alias{fars_read_years}
\title{fars_read_years}
\usage{
fars_read_years(years)
}
\arguments{
\item{years}{represents a vector or a list containing years which should data be
extracted from}
}
\value{
it returns a tibble that contains the month and year that read from
different csv files for different values of \code{years}
}
\description{
this function reads an information about provided list of years through \code{years}
}
\examples{
\dontrun{
year_month <- fars_read_years(c(2013,2014,2015))
}

}
