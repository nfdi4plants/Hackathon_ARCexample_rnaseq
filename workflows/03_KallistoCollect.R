

########################
#### To be replaced by CWL routine
########################

ARC_root="~/Hackathon_ARCexample_rnaseq/"
setwd(paste0(ARC_root, 'workflows/'))

########################

########################
# Collect kallisto data
########################


# ### sleuth installation
# 
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install()
# BiocManager::install("devtools")    # only if devtools not yet installed
# BiocManager::install("pachterlab/sleuth")

library(sleuth)
library(tidyverse)
library(jsonlite)
library(openxlsx)

## read experimental metadata from isa.assay wb

isa_assay <- paste0(ARC_root, 'assays/Talinum_RNASeq_minimal/assay.isa.xlsx')

assay_data <- merge(readWorkbook(isa_assay, "1SPL01_plants", startRow = 2), 
                    readWorkbook(isa_assay, "3ASY01_RNASeq", startRow = 2), 
                    by = "Sample.Name"
                    )

## remove empty cols
assay_data <- assay_data[, !apply(assay_data, 2, function(x){sum(is.na(x)) == nrow(assay_data)})]  

# Pointer to kallisto results folder
base_dir <- paste0(ARC_root, '/runs/01_kallisto_results/')

# A list of paths to the kallisto results indexed by the sample IDs is collated with
kal_dirs <- dir(base_dir, full.names = T) ## Sleuth requires full paths

s2c <- assay_data[order(assay_data$Sample.Name), c('Sample.Name', "Characteristics.[Photosynthesis.mode]")]
# For kallisto / sleuth: 's2c' (sample_to_covariates) must contain a column named 'sample'
colnames(s2c) <- c("sample", "Photosynthesis.mode")

s2c$path <- kal_dirs
s2c <- s2c[order(s2c$sample), ]

# Build a sleuth object
so <- sleuth_prep(s2c, ~Photosynthesis.mode)
save(so, file = paste0(ARC_root, 'runs/03_kallisto_sleuthObject.RData'))

# Extract expression tables

## as data.frame
expression_data <- kallisto_table(so)
write.csv(expression_data, paste0(ARC_root, 'runs/03_kallisto_df.csv'), row.names = F)

## as tpm matrix (gene x sample)
tpm_table <- pivot_wider(expression_data, id_cols = target_id, names_from = sample, values_from = tpm)
write.csv(tpm_table, paste0(ARC_root, 'runs/03_kallisto_tpmMatrix.csv'), row.names = F)


# Summarize mapping stats

mapping_stats <- c()
for(i in dir(kal_dirs, pattern = '.json', full.names = T))
{
  id <- unlist(strsplit(i, split = '/'))
  
  z <- data.frame(ID = id[length(id) - 1], read_json(i, simplifyVector = T))
  mapping_stats <- rbind(mapping_stats, z)
}

write.csv(mapping_stats, paste0(ARC_root, 'runs/03_kallisto_mappingStats.csv'), row.names = F)





