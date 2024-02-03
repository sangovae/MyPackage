#' Vespa invasion visualization
#'
#' @param x
#'
#' @return The output from \code{\link{print}}
#' @export
#'
#' @importFrom rgbif occ_search
#' @importFrom ggplot2 ggplot
#' @importFrom dplyr summarize group_by
#' @importFrom ggmap get_map
#'
#' @examples
#'

# 1. Retrieve occurrences from GBIF for that year range of Vespa velutina in Flanders ####
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
    dplyr::select(species, decimalLongitude, decimalLatitude, countryCode, individualCount,
                  gbifID, family, taxonRank, coordinateUncertaintyInMeters, year, month, day, eventDate,
                  basisOfRecord, institutionCode, datasetName) %>%
    mutate(thedate = as.Date(substr(eventDate, 1, 10)))

  return(dat)
}

# 2. Present the result as a bar chart of observations per year ####
vespa_chart <- function(data) {
  vespa_barchart <- data %>%
    group_by(year) %>%
    # dit is een optelsom van de waargenomen individuen, toch niet optellen?
    # summarize(occurence = sum(ifelse(is.na(individualCount), 1, individualCount))) %>%
    ggplot(aes(x=as.factor(year))) +
    geom_bar() +
    xlab("Year") +
    ylab("Number of observations of Vespa velutina in Flanders")
  # Theme?

  return(vespa_barchart)
}


# 3. Present the result as a bar chart of observations per year ####


vespa_map <- function(data) {

  # remove records without coordinates
  dat_geo <- data%>%
    filter(!is.na(decimalLongitude))%>%
    filter(!is.na(decimalLatitude))

  theme_set(theme_bw())

  vespa_map1 <- ggplot(data = world) +
    geom_sf(fill= "antiquewhite") +
    geom_point(data = dat_geo, aes(x = decimalLongitude, y = decimalLatitude),
               colour = "darkred", size = 0.5) +
    coord_sf(xlim = c(2.5, 6), ylim = c(50.6, 51.5), expand = FALSE) +
    xlab("Longitude") + ylab("Latitude")
   # ggtitle(paste0("Map of observations of Vespa velutina in Flanders in ", year)) +
    theme(panel.grid.major = element_line(color = gray(.5),linetype = "dashed", linewidth = 0.5),
          panel.background = element_rect(fill = "aliceblue"))

  #library(ggmap)
  map <- get_map(location = c(4.3, 51.0950),  maptype = "terrain", source = "google", zoom = 8, scale = "auto")
  #save(map, "mapFlanders.Rdata")
  #load(file = "mapFlanders.Rdata")

  vespa_map2 <- ggmap(map)+
    geom_point(data = dat_geo,
               # size of circle related to individual count per observation
               aes(x = decimalLongitude, y = decimalLatitude, size = individualCount),
               color = "red", size = 1) +
    scale_x_continuous(limits = c(2.5,6), expand = c(0, 0)) +
    scale_y_continuous(limits = c(50.5,51.5), expand = c(0, 0)) +
    xlab("Longitude") + ylab("Latitude")
    # ggtitle(paste0("Map of observations of Vespa velutina in Flanders in ", year))

  return(vespa_map1)
  return(vespa_map2)
}


