#' @title Map observations
#' @description
#' `vespa_map` creates a map of observations in Flanders.
#'
#' @param data A tibble created by the function [vespa_data()]
#'
#' @return A map
#' @export
#'
#' @importFrom ggmap ggmap
#' @importFrom ggplot2 ggplot geom_point aes scale_x_continuous scale_y_continuous
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
    dplyr::filter(!is.na(decimalLongitude))%>%
    dplyr::filter(!is.na(decimalLatitude))

  vespa_map <- ggmap::ggmap(MyPackage::mapFlanders)+
    ggplot2::geom_point(data = dat_geo,
                        ggplot2::aes(x = decimalLongitude, y = decimalLatitude), size = 1) +
    ggplot2::scale_x_continuous(limits = c(2.5,6), expand = c(0, 0)) +
    ggplot2::scale_y_continuous(limits = c(50.5,51.5), expand = c(0, 0))+
    #scale_color_manual(values = c("salmon", "red","darkred")) #+
  #xlab("Longitude") + ylab("Latitude")


  return(vespa_map)

}


