

########################
#### To be replaced by CWL routine
########################

ARC_root="~/sciebo/CEPLAS_DM/CEPLAS_ARCs/ARC0005/"
setwd(paste0(ARC_root, 'workflows/'))

########################

########################
# Determine diff. gene expression with sleuth
########################

library(sleuth)

# Load the sleuth object
load(file = paste0(ARC_root, 'runs/03_kallisto_sleuthObject.RData'))


so <- sleuth_fit(so)
so <- sleuth_fit(so, ~Group, 'full')
so <- sleuth_fit(so, ~1, 'reduced')
so <- sleuth_lrt(so, 'reduced', 'full')

sleuth_table <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE)


write.csv(sleuth_table, paste0(ARC_root, 'runs/04_sleuth_dge.csv'), row.names = F)





