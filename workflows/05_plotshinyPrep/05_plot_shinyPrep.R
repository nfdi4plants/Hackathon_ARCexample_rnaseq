
########################
# Prep data for shiny app
########################


install.packages("openxlsx",dependencies=TRUE, lib='./lib',repos='http://cran.rstudio.com/')
library(openxlsx, lib.loc = "./lib")

options <- commandArgs(trailingOnly = TRUE)
wd <- getwd()

expression_data <- read.csv(file = options[1])
available_genes <- unique(expression_data$target_id)

save(expression_data, available_genes, file = paste0(wd, "/05_shinyPrep.RData"))
