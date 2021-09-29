#!/usr/bin/env bash
# flexbar_run.sh

# see (v3.4.0)
# https://github.com/seqan/flexbar/wiki/Options

CPU=30  # iMac only 2 threads
# now... 
ADAPTERDIR=/bix
INPUTDIRPE=/mnt/home/lizards/Amphibolurus_muricatus/10X_Genomics
TARGETDIRPE=/mnt/home/lizards/Amphibolurus_muricatus/10X_Genomics/trimmed
mkdir -p $TARGETDIRPE


# run PE and SE separately
# so
# PE = 68/2=34 samples
# SE = 68 samples
# so 


# -ap ON does not work in brew flexbar!
# https://github.com/seqan/flexbar


cd $INPUTDIRPE ;
# PE
# mkdir trimmed ;
for left in *_R1_001.fastq.gz ; do #
 right=`echo  $left | perl -pe 's/\_R1_001/\_R2_001/g'`   ;  # assign the RIGHT hand read by calling a Perl regex against $i (the LEFT read file name)
outputfilename=`echo  $left | perl -pe 's/\_R1_001.fastq.gz//g'`   ;
echo $left
echo $right
echo $outputfilename

# @@@@@@@@@@@@@@@@@@@@@
# TruSeq
# @@@@@@@@@@@@@@@@@@@@@
# v3.0.3
# flexbar --threads $CPU --zip-output GZ --adapter-min-overlap 7 --adapters $ADAPTERDIR/illumina_multiplex.fa --max-uncalled 300 --min-read-length 25 --threads $CPU --reads $INPUTDIRPE/$left --reads2 $INPUTDIRPE/$right --target $TARGETDIRPE/$outputfilename
# v3.4.0
/bix/flexbar-3.4.0-linux/flexbar --threads $CPU --zip-output GZ -aa TruSeq -ap ON --threads $CPU --reads $INPUTDIRPE/$left --reads2 $INPUTDIRPE/$right --target $TARGETDIRPE/$outputfilename
# -aa TruSeq OR (for BGI) --adapters $ADAPTERDIR/BGISEQ500_adapters.fa
# for PE
# flexbar -r r1.fq -p r2.fq -a adapters.fa -ap ON
#
# for SE
# flexbar -r reads.fq -a adapters.fa -ao 3 -ae 0.1

# @@@@@@@@@@@@@@@@@@@@@
# BGISEQ-500
# @@@@@@@@@@@@@@@@@@@@@
# For BGISEQ, specify an adaptor file, for Illumina, just use the recommended arguement!
# flexbar --threads $CPU --zip-output GZ --adapter-min-overlap 7 --adapters $ADAPTERDIR/BGISEQ500_adapters.fa --max-uncalled 300 --min-read-length 25 --threads $CPU --reads $INPUTDIRPE/$left --reads2 $INPUTDIRPE/$right --target $TARGETDIRPE/$outputfilename
# so ...


#
# clear ; 
echo "The value of the variable \"RIGHT\" is now $right ";
echo $right ;
done
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
