

########################
#### To be replaced by CWL routine
########################

ARC_root="~/Hackathon_ARCexample_rnaseq/"
setwd(paste0(ARC_root, 'workflows/'))

########################

########################
# Prep data for shiny app
########################

library(openxlsx)

expression_data <- read.csv(file = paste0(ARC_root, 'runs/03_kallisto_df.csv'))
available_genes <- unique(expression_data$target_id)

save(expression_data, available_genes, file = paste0(ARC_root, 'runs/05_shinyPrep.RData'))
