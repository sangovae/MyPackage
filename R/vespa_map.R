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
#' @importFrom ggplot2 ggplot geom_point aes scale_x_continuous scale_y_continuous xlab ylab scale_color_manual theme theme_bw element_blank element_text guides guide_legend
#' @importFrom dplyr filter arrange
#' @importFrom rlang .data
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

  vespa_map <- ggmap::ggmap(MyPackage::mapFlanders)+
    ggplot2::geom_point(data = dat_geo %>% dplyr::arrange(.data$year),
                        ggplot2::aes(x = .data$decimalLongitude, y = .data$decimalLatitude, col = as.factor(.data$year)), size = 1) +
    ggplot2::scale_x_continuous(limits = c(2.5,6), breaks = seq(2.5, 6, 0.25), expand = c(0, 0)) +
    ggplot2::scale_y_continuous(limits = c(50.5,51.5), breaks = seq(50.5,51.5, 0.25),expand = c(0, 0))+
    ggplot2::xlab("Longitude") + ggplot2::ylab("Latitude") +
    ggplot2::scale_color_manual(values = rev(c("#710000", "#9C0000", "#C90000", "#E60026", "#F5505B", "#FE7F85", "#FFA8AB", "#FECFD1"))) +
    ggplot2::theme_bw() +
    ggplot2::theme(legend.position = 'bottom',
                   legend.title = ggplot2::element_blank(),
                   legend.text = ggplot2::element_text(size=10)) +
    ggplot2::guides(colour = ggplot2::guide_legend(override.aes = list(size=5)))

  return(vespa_map)
}

