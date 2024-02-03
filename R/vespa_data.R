#' @title Retrieve occurrences from GBIF of Vespa velutina
#' @description
#' code{vespa_data} retrieves occurrences from the Global Biodiversity Information Facility (GBIF) for
#' a single year or year range of Vespa velutina in Flanders.
#'
#'
#' @param year1 The 4 digit year. A single year or lower number of the year range.
#' @param year2 Optional. 4 digit year, higher number of the year range.
#'
#' @return A \code{\link{tibble}} with occurrences from GBIF for that year range of Vespa velutina in Flanders
#' @export
#'
#' @importFrom rgbif occ_search
#' @importFrom dplyr mutate
#' @importFrom rlang .data
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

  # select columns of interest
  dat <- dat_tbl %>%
    dplyr::select(.data$species, .data$decimalLongitude, .data$decimalLatitude, .data$countryCode, .data$individualCount,
                  .data$gbifID, .data$family, .data$taxonRank, .data$coordinateUncertaintyInMeters, .data$year, .data$month, .data$day, .data$eventDate,
                  .data$basisOfRecord, .data$institutionCode, .data$datasetName) %>%
    mutate(thedate = as.Date(substr(.data$eventDate, 1, 10)))

  return(dat)
}
