#!/usr/bin/env bash

# //////////////////////////////////////////////////////
# Jellyfish + GenomeScope
# //////////////////////////////////////////////////////
CPU=80
KMER=31
# KMER=21 # run through a range of k-mers outputs
# KMER=17 underestimates. 15 does not converge

# download GenomeScope from GitHub https://github.com/schatzlab/genomescope
# or upload jellyfish histogram files to their web site (very slow from China)
# http://genomescope.org/

# -s value below means that we are assigning 100 Gb of RAM

# used PE trimmed reads
cd /mnt/home/lizards/Amphibolurus_muricatus/10X_Genomics/trimmed/GenomeScope

time jellyfish count -C -m ${KMER} -s 100000000000 -t ${CPU} /mnt/home/lizards/Amphibolurus_muricatus/10X_Genomics/trimmed/LIVER/*.fastq -o liver_reads_${KMER}.jf
jellyfish histo -t ${CPU} liver_reads_${KMER}.jf > reads_liver_${KMER}.histo
time jellyfish count -C -m ${KMER} -s 100000000000 -t ${CPU} /mnt/home/lizards/Amphibolurus_muricatus/10X_Genomics/trimmed/BLOOD/*.fastq  -o blood_reads_${KMER}.jf
jellyfish histo -t ${CPU} blood_reads_${KMER}.jf > reads_blood_${KMER}.histo

READLENGTH=150 # here: 10X Genomics PE reads

TISSUE=blood
HISTOGRAMFILE=reads_${TISSUE}_${KMER}.histo # e.g. reads_blood_21.histo
echo ${HISTOGRAMFILE}

MAXKMER=10000
OUTPUTDIR=${TISSUE}_${KMER}_${MAXKMER}
time Rscript ../genomescope-master/genomescope.R ${HISTOGRAMFILE} ${KMER} ${READLENGTH} ${OUTPUTDIR} ${MAXKMER}
# ~~~~
MAXKMER=1000
OUTPUTDIR=${TISSUE}_${KMER}_${MAXKMER}
time Rscript ../genomescope-master/genomescope.R ${HISTOGRAMFILE} ${KMER} ${READLENGTH} ${OUTPUTDIR} ${MAXKMER}
# ~~~~
MAXKMER=500
OUTPUTDIR=${TISSUE}_${KMER}_${MAXKMER}
time Rscript ../genomescope-master/genomescope.R ${HISTOGRAMFILE} ${KMER} ${READLENGTH} ${OUTPUTDIR} ${MAXKMER}
#
MAXKMER=300
OUTPUTDIR=${TISSUE}_${KMER}_${MAXKMER}
time Rscript ../genomescope-master/genomescope.R ${HISTOGRAMFILE} ${KMER} ${READLENGTH} ${OUTPUTDIR} ${MAXKMER}
#
MAXKMER=100
OUTPUTDIR=${TISSUE}_${KMER}_${MAXKMER}
time Rscript ../genomescope-master/genomescope.R ${HISTOGRAMFILE} ${KMER} ${READLENGTH} ${OUTPUTDIR} ${MAXKMER}
#
MAXKMER=50
OUTPUTDIR=${TISSUE}_${KMER}_${MAXKMER}
time Rscript ../genomescope-master/genomescope.R ${HISTOGRAMFILE} ${KMER} ${READLENGTH} ${OUTPUTDIR} ${MAXKMER}

