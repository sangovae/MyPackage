dat_gbif <- occ_search(country = 'BE', scientificName = "Vespa velutina", gadmGid = "BEL.2_1",
                       limit = 200000, year = "2019, 2021")
vespadata_2019_2021 <- dat_gbif$data

usethis::use_data(vespadata_2019_2021, overwrite = TRUE, compress = "xz")
