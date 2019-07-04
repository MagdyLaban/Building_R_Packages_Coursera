#' fars_read
#'
#' this function is for reading the a data frame or csv file and return a tibble data frame
#'
#' @param filename it is the path for the csv file or the data you want to read through
#'
#' @importFrom dplyr tbl_df
#' @importFrom readr read_csv
#'
#' @return a tibble data frame that contains the data from \code{filename}
#'
#' @examples
#' \dontrun{
#' df <- fars_read("accident_2015.csv")
#' df <- fars_read( filename = "accident_2015.csv")
#' }
#'
#' @export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}

#' file name with a specific year
#'
#' This function creates a file name for a particular year .
#'
#' @param year it refers to a year which you want to creat file name with.
#' it has to be a number or a string that contain a numer or it will end up with
#' a waring and NA will be the return value from the function .
#'
#' @return it will return a string that represents a file name
#'
#' @examples
#' \dontrun{
#' file_name <- make_filename(2015)
#' file_name <- make_filename("2015")
#' file_name <- make_filename(year = "2015")
#' file_name <- make_filename(year = 2015)
#' }
#'
#' @export
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}

#' read data for specific year
#'
#' this function reads an information about provided list of years through \code{years}
#'
#' @param years represents a vector or a list containing years which should data be
#' extracted from
#'
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#'
#' @return it returns a tibble that contains the month and year that read from
#' different csv files for different values of \code{years}
#' @examples
#' \dontrun{
#' year_month <- fars_read_years(c(2013,2014,2015))
#' }
#'
#' @export
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>%
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}

#' Summarize specific years data
#'
#' This function summarizes the data of the year and provide the number of accidents
#'
#' @inheritParams fars_read_years
#'
#' @importFrom dplyr bind_rows
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom tidyr spread
#' @importFrom magrittr %>%
#'
#' @return a tibble that contains the number of accidents per month and year for
#' several years which are provided through \code{years}
#'
#' @examples
#' \dontrun{
#' accident_num <- fars_summarize_years(2014)
#' }
#'
#' @export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(year, MONTH) %>%
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}
#' map for accidents
#'
#' This function gives a representation on a map for the accidents on a specific state
#' and year
#'
#' @param state.num This is the number of the state and it must be a numerical value
#' or it will end up to an error
#' @param year this is the year when the accidents happened and it must be numerical
#' value
#'
#' @note You should install dplyr , graghics and maps packages
#'
#' @return it returns a graphical representation for the accidents in the \code{state.num}
#' during \code{year}
#'
#' @examples
#' \dontrun{
#' map <- fars_map_state(state.num = 14 ,year = 2015)
#' }
#'
#' @export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
