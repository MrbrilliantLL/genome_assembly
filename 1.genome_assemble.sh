micromamba activate genome
genome=''
hifi=''
fq1=''
fq2=''
fq1_quality='quality_'$fq1
fq2_quality='quality_'$fq2

##fastp
fastp -q 20 --thread 16 -i $fq1 -I $fq2 -o $fq1_quality -O $fq2_quality

##Mabs-hifiasm
singularity exec -B $PWD -B /home/lianglei/data/tools/BUSCO_dataBase:/data ~/data/tools/singua_sif/mabs.sif mabs-hifiasm.py \
    --pacbio_hifi_reads $hifi \
    --short_hi-c_reads_R1 $fq1_quality \
    --short_hi-c_reads_R2 $fq2_quality \
    --additional_hifiasm_parameters [-l 3] \
    --local_busco_dataset /data/eudicots_odb10.2024-01-08.tar.gz \
    --threads 100