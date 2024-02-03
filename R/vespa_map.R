#' @title Map observations
#' @description
#' `vespa_map` creates a map of observations in Flanders.
#'
#' @param data A tibble created by the function [vespa_data()]
#'
#' @return A map
#' @export
#'
#' @importFrom ggplot2 ggplot geom_sf geom_point aes coord_sf
#' @importFrom dplyr filter
#'
#' @examples
#' # First, create a tibble with observations with the function vespa_data
#' data <- vespa_data(2019,2021)
#' # Then, create a map
#' vespa_map(data)
#'
#' # Customize the map with ggplot2
#' \dontrun{
#' vespa_map(data) +
#' ggtitle("Map of observations of Vespa velutina in Flanders during 2019-2021")}
vespa_map <- function(data) {

  # remove records without coordinates
  dat_geo <- data%>%
    dplyr::filter(!is.na(.data$decimalLongitude))%>%
    dplyr::filter(!is.na(.data$decimalLatitude))

  vespa_map <- ggplot2::ggplot(data = ggplot2::world) +
    ggplot2::geom_sf(fill= "antiquewhite") +
    ggplot2::geom_point(data = dat_geo, ggplot2::aes(x = .data$decimalLongitude, y = .data$decimalLatitude),
               colour = "darkred", size = 0.5) +
    ggplot2::coord_sf(xlim = c(2.5, 6), ylim = c(50.6, 51.5), expand = FALSE) +
    #xlab("Longitude") + ylab("Latitude")
#  theme(panel.grid.major = element_line(color = gray(.5),linetype = "dashed", linewidth = 0.5),
 #       panel.background = element_rect(fill = "aliceblue"))

  return(vespa_map)
}


