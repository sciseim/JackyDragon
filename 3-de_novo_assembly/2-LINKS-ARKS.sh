#!/usr/bin/env bash

# //////////////////////////////////////////////////////
# Let us improve the male assembly = BLOOD after supernova
# //////////////////////////////////////////////////////
CPU=80
echo ${CPU}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# ARKS
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
cd /mnt/home/lizards/Amphibolurus_muricatus/assembly_take_two/BLOOD/outs

echo barcoded.fastq.gz > barcoded.fof

perl /bix/arks/bin/calcBarcodeMultiplicities.pl ./barcoded.fof >barcoded_multiplicities.csv

calcBarcodeMultiplicities.pl barcoded.fof > barcoded_multiplicities.csv 

GENOMEFILE=/mnt/home/lizards/Amphibolurus_muricatus/10X_Genomics/trimmed/BLOOD/assembly.pseudohap.fasta

# this is the default
arks -p full -v -f ${GENOMEFILE} -a /mnt/home/lizards/Amphibolurus_muricatus/assembly_take_two/BLOOD/outs/barcoded_multiplicities.csv -c 5 -t ${CPU} -j 0.55 -o 0 -m 50-10000 -k 30 -r 0.05 -e 30000 -z 500 -d 0 -b BLOOD_ARKS_c5_m50-10000_k30_r0.05_e30000_z500 /mnt/home/lizards/Amphibolurus_muricatus/assembly_take_two/BLOOD/outs/barcoded.fastq.gz

python2.7 /bix/arks/Examples/makeTSVfile.py BLOOD_ARKS_c5_m50-10000_k30_r0.05_e30000_z500_original.gv BLOOD_ARKS_c5_m50-10000_k30_r0.05_e30000_z500.tigpair_checkpoint.tsv ${GENOMEFILE}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# LINKS
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
touch empty.fof

LINKS -f ${GENOMEFILE} -s empty.fof -b BLOOD_ARKS_c5_m50-10000_k30_r0.05_e30000_z500 -l 5 -a 0.3 -z 500
