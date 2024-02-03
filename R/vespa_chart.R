#' @title Bar chart of observations per year
#' @description
#' `vespa_data` creates a bar chart of observations per year.
#'
#' @param data A tibble created by the function [vespa_data()]
#'
#' @return A bar chart of observations per year
#' @export
#'
#' @importFrom ggplot2 ggplot geom_bar aes xlab ylab
#' @importFrom dplyr group_by select
#' @importFrom rlang .data
#'
#' @examples
#' # First, create a tibble with observations with the function vespa_data
#' data <- vespa_data(2019,2021)
#' # Then, create a chart
#' vespa_chart(data)
#'
#' # Customize the chart with ggplot2
#' \dontrun{
#' vespa_chart(data) +
#' ggtitle("Number of observations of Vespa velutina in Flanders during 2019-2021")}

vespa_chart <- function(data) {

  data_minimal <- data %>%
    dplyr::select(.data$year)

  vespa_barchart <- data_minimal %>%
    dplyr::group_by(.data$year) %>%
    ggplot2::ggplot(aes(x=as.factor(.data$year))) +
    ggplot2::geom_bar()
  return(vespa_barchart)
}
