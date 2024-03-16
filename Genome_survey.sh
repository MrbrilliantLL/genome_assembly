micromamba activate genome
genome=''
fq1=''
fq2=''
fq1_quality='quality_'$fq1
fq2_quality='quality_'$fq2
##fastp
fastp -q 20 --thread 16 -i $fq1 -I $fq2 -o $fq1_quality -O $fq2_quality
##jellyfish
zcat quality*.fq.gz | jellyfish count /dev/fd/0 -C -o ${genome}_21mer -m 21 -t 16 -s 10G
jellyfish histo -t 12 -h 3000000 -o ${genome}_21mer.histo ${genome}_21mer

# ##findGSE
# library("findGSE")
# findGSE(histo="${genome}_21mer.histo", sizek=21, outdir="findGSE_21mer")

# ##genomescope2
# genomescope2 -i ${genome}_21mer.histo -o genomeScope2_21mer -k 21 