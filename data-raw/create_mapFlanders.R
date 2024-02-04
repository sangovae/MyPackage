#' @title Map of Flanders for data visualization
#'
#' @description This code retrieves a map of Flanders from Google,
#' to use as a background for the geographical visualization of the invasion
#' of Asian hornets in Flanders.
#'
#' @format A [ggmap()]

library(ggmap)
mapFlanders <- get_map(location = c(4.23, 51.0950),
                       maptype = "terrain", source = "google", zoom = 8, scale = "auto")

usethis::use_data(mapFlanders, overwrite = TRUE, compress = "xz")
