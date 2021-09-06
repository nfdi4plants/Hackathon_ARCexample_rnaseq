

########################
#### To be replaced by CWL routine
########################

ARC_root="~/sciebo/CEPLAS_DM/CEPLAS_ARCs/ARC0005/"
setwd(paste0(ARC_root, 'workflows/'))

########################


########################
# Simplify assay data
########################

library(openxlsx)
library(tidyverse)

## read isa.assay wb

isa_assay <- paste0(ARC_root, 'assays/Talinum_RNASeq_minimal/assay.isa.xlsx')

assay_data <- c()
for(sheet in getSheetNames(isa_assay))
{
  current_sheet <- readWorkbook(isa_assay, sheet, startRow = 2,)  
  
  if(sum(c("Source.Name", "Sample.Name") %in% colnames(current_sheet)) == 2){
  
    ## remove empty cols
    current_sheet <- current_sheet[, !apply(current_sheet, 2, function(x){sum(is.na(x)) == nrow(current_sheet)})]  
    
    if(is.null(assay_data)){assay_data <- current_sheet}else{
      
    ## Merge altogether  
      assay_data <- merge(assay_data, current_sheet, "Sample.Name")
      
    }
  }
}



## 

assay_data$sample <- substr(assay_data$Data.File.Name, 1, 6)
assay_data$Group <- cut(as.integer(as.factor(assay_data$`Characteristics.[watering.exposure]`)), breaks = c(0,1.5,3), labels = c("CAM", "reC3"))


## Export 

write.csv(assay_data, paste0(ARC_root, 'runs/02_assay_data.csv'))




