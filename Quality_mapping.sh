genome=''
genome_prefix=''
fq1=''
fq2=''
fq1_quality='quality_'$fq1
fq2_quality='quality_'$fq2

bowtie2-build --threads 30 $genome $genome_prefix
fastp -q 20 --thread 16 -i $fq1 -I $fq2 -o $fq1_quality -O $fq2_quality

for i in `ls *_1.quality.fq.gz`;do prefix=`basename $i _1.quality.fq.gz` && bowtie2 -p 100 -x HHY -1 $i -2 ${prefix}_2.quality.fq.gz --no-unal -S $prefix;done

