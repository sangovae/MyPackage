#' @title Map of Flanders for data vizualizaiotn
#'
#' @description This code retrieves a map of Flanders from Google.
#'
#' @format A [ggmap()]


## code to prepare `DATASET` dataset goes here

library(ggmap)
mapFlanders <- get_map(location = c(4.3, 51.0950),  maptype = "terrain", source = "google", zoom = 8, scale = "auto")

usethis::use_data(mapFlanders, overwrite = TRUE, compress = "xz")

load(file = )
