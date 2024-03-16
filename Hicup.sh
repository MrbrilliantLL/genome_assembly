# micromamba activate hicup

fq1=''
fq2=''
quality1=''
quality2=''
genome=''
genome_index=''
# fastp
fastp -q 20 --thread 16 -i $fq1 -I $fq2 -o $quality1 -O $quality2

# bowtie-build
bowtie2-build $genome $genome_index

# prep enzyme cut position 
hicup_digester --genome ${genome_index}_DPNII_digest --re1 ^GATC,DPNII $genome

# hicup
hicup \
     --bowtie2 /data/home/lianglei/tools/envs/hicup/bin/bowtie2 \
     --digest ./${genome_index}_DPNII_digest \
     --index ./$genome_index \
     --outdir /path/to/output/dir  \
     --threads 20 \
    ./$quality1 ./$quality2