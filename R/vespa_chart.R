#' @title Bar chart of observations per year
#' @description
#' `vespa_data` creates a bar chart of observations per year.
#'
#' @param data A tibble created by the function [vespa_data()]
#'
#' @return A bar chart of observations per year
#' @export
#'
#' @importFrom ggplot2 ggplot geom_bar aes xlab ylab geom_text theme_bw
#' @importFrom rlang .data
#' @importFrom dplyr group_by summarise
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
  vespa_barchart <- data %>%
    group_by(year) %>%
    summarise(observations = n()) %>%
    ggplot2::ggplot(aes(x=.data$year, y = .data$observations)) +
    ggplot2::geom_bar(position = 'dodge', stat='identity') +
    geom_text(aes(label=.data$observations), position=position_dodge(width=0.9), vjust=-0.25)+
    ggplot2::xlab("Year") + ggplot2::ylab("Observations") +
    ggplot2::theme_bw()

  return(vespa_barchart)
}
