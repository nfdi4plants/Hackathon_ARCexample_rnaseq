
########################
#### To be replaced by CWL routine
########################

ARC_root=~/Hackathon_ARCexample_rnaseq/
cd $ARC_root'workflows/'

# chmod a+x 01_KallistoQuant.sh
# ./01_KallistoQuant.sh > $ARC_root'runs/01_kallisto.log' 2>&1 &

########################


# Map RNASeq reads via kallisto

## Manual: http://pachterlab.github.io/kallisto/manual.html

kallisto version
kallisto cite

### Build index 

kall_ref=$ARC_root'externals/Talinum.gm.CDS.nt.fa'
kallisto index -i $ARC_root'runs/01_kallisto_index' $kall_ref

### Align reads

ILLUMINASAMPLES=$(ls ${ARC_root}'assays/Talinum_RNASeq_minimal/dataset/'*fastq.gz)

mkdir $ARC_root'/runs/01_kallisto_results/'

for j in $ILLUMINASAMPLES; do

		sampleName=$(echo $j | sed -e 's|.*/||' | cut -c -6)  # cut away path. retain only first six chars of file name
		echo $sampleName
		
		kallisto quant --single -b 100 -t 30 -l 200 -s 20 -i $ARC_root'/runs/01_kallisto_index' -o $ARC_root'/runs/01_kallisto_results/'$sampleName $j

	    echo 'Kallisto done'

done