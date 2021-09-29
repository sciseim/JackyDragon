 #!/usr/bin/env bash
# HTStream_run.sh



CPU=20  # iMac only 2 threads; MacBook Pro 4; 
# now... 

# PE
# INPUTDIRPE=/Volumes/AntUSB/AsperaDownloads/FASTQ/PE/trimmed
INPUTDIRPE=/mnt/home/lizards/Amphibolurus_muricatus/RNAseq/trimmed
TARGETDIRPE=/mnt/home/lizards/Amphibolurus_muricatus/RNAseq/trimmed/PhiXfree
mkdir -p $TARGETDIRPE


# SE
#@ INPUTDIRSE=/Volumes/AntUSB/AsperaDownloads/FASTQ/SE/trimmed
#@ TARGETDIRSE=/Volumes/AntUSB/AsperaDownloads/FASTQ/SE/trimmed/PhiXfree
#@ mkdir -p $TARGETDIRSE




cd $INPUTDIRPE ;
# PE
# mkdir trimmed ;
for left in *_1.fastq.gz ; do
right=`echo  $left | perl -pe 's/\_1.fastq.gz/\_2.fastq.gz/g'` ;  # assign the RIGHT hand read by calling a Perl regex against $i (the LEFT read file name)
# for... fastq.gz..
# left=Human_ovary_PE_female_ERR315380_1.fastq.gz
outputfilename=`echo $left | perl -pe 's/\_1.fastq.gz/_PhiXfree/g'`  ; 
# e.g Human_ovary_PE_female_ERR315380_PhiXfree   
#
hts_Stats -O -L $outputfilename.log -1 $left -2 $right | hts_SeqScreener -S -g -A -L $outputfilename.log --prefix $outputfilename
# e.g. Human_ovary_PE_female_ERR315380_PhiXfree_R1.fastq.gz
# clear ; 
done



# move filtered reads
mv *_PhiXfree* ./PhiXfree/ ;

