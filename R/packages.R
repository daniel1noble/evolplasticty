# Install and load the necessary packages for running some analyses.

source("./R/func.R")

packages <- c("gdata", "plyr", "car", "metafor", "MCMCglmm")
install.pkg(packages)