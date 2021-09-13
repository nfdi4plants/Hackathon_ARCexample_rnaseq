# ARC mininmal Example RNASeq


## Notes

- CWL not yet implemented 



### isa.assay
- split GEO SWATE templates into four sheets 
    - 1SPL01_plants
    - 2EXT01_RNA
    - 3ASY01_RNASeq
    - 4COM01_RNASeq


### adding raw data via git lfs 

```
git lfs track "*.fastq.gz"
```

add data to assays folder

```
git add assays/Talinum_RNASeq_minimal/dataset/
```


