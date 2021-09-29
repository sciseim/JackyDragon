#!/usr/bin/env bash

# //////////////////////////////////////////////////////
# Let us improve male assembly = BLOOD after supernova
# //////////////////////////////////////////////////////
CPU=80
echo ${CPU}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# P_RNA_scaffolder
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
cd /mnt/home/lizards/Amphibolurus_muricatus/assembly_take_two/P_RNA_scaffolder
GENOMEFILE=/mnt/home/lizards/Amphibolurus_muricatus/assembly_take_two/BLOOD/outs/BLOOD_ARKS_c5_m50-10000_k30_r0.05_e30000_z500.scaffolds.fa

hisat2-build ${GENOMEFILE} blood_ARKSk30_hisat

hisat2 -x blood_ARKSk30_hisat -1 LEFT.fastq -2 RIGHT.fastq -k 3 -p 10 --pen-noncansplice 1000000 -S blood_ARKSk30_hisat.sam --threads ${CPU}

P_RNA_scaffolder.sh -d /bix/P_RNA_scaffolder -i blood_ARKSk30_hisat.sam -j ${GENOMEFILE} -F LEFT.fastq -R RIGHT.fastq -o blood_ARKSk30_PRNA -t ${CPU}

