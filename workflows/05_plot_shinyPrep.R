

########################
#### To be replaced by CWL routine
########################

ARC_root="~/sciebo/CEPLAS_DM/CEPLAS_ARCs/ARC0005/"
setwd(paste0(ARC_root, 'workflows/'))

########################

########################
# Prep data for shiny app
########################

library(openxlsx)

expression_data <- read.csv(file = paste0(ARC_root, 'runs/03_kallisto_df.csv'))
available_genes <- unique(expression_data$target_id)

# sleuth_dge <- read.csv(paste0(ARC_root, 'runs/04_sleuth_dge.csv'))

# save(assay_data, expression_data, sleuth_dge, available_genes, file = paste0(ARC_root, 'runs/05_shinyPrep.RData'))
save(expression_data, available_genes, file = paste0(ARC_root, 'runs/05_shinyPrep.RData'))
