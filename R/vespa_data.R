#' @title Retrieve occurrences from GBIF of Vespa velutina
#' @description
#' code{vespa_data} retrieves occurrences from the Global Biodiversity Information Facility (GBIF) for
#' a single year or year range of \emph{Vespa velutina} in Flanders.
#' \emph{Vespa velutina} was first observed in 2017 in Flanders.
#' Therefore, your year range should start at least at 2017 or later.
#'
#' @param year1 The 4 digit year, between 2017 and now. A single year or lower number of the year range.
#' @param year2 Optional. 4 digit year, higher number of the year range.
#'
#' @return A [tibble()] with occurrences from GBIF for that year range of Vespa velutina in Flanders
#' @export
#'
#' @importFrom rgbif occ_search
#' @importFrom dplyr mutate
#'
#' @examples
#' vespa_data(2019,2021)

vespa_data <- function(year1, year2 = NULL) {
  if(is.null(year2)) {
    year2 <- year1
  }
  # obtain data from GBIF via rgbif
  dat_gbif <- occ_search(country = 'BE', scientificName = "Vespa velutina", gadmGid = "BEL.2_1",
                         limit = 200000, year = paste0(year1, ", ", year2))
  dat_tbl <- dat_gbif$data

  return(dat_tbl)
}
