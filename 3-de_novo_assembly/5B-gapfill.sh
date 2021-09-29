#!/usr/bin/env bash

# prep.
# cat reads
# prepare input file
# zcat AA069032_Liver1_S3_L001_1.fastq.gz AA069032_Liver1_S3_L002_1.fastq.gz >./LIVER/liver_1.fastq
# zcat AA069032_Liver1_S3_L001_2.fastq.gz AA069032_Liver1_S3_L002_2.fastq.gz >./LIVER/liver_2.fastq
# zcat AA069033_Blood_c2_S2_L001_1.fastq.gz AA069033_Blood_c2_S2_L002_1.fastq.gz >./BLOOD/blood_1.fastq
# zcat AA069033_Blood_c2_S2_L001_2.fastq.gz AA069033_Blood_c2_S2_L002_2.fastq.gz >./BLOOD/blood_2.fastq
# each FASTQ ~150 Gb

# 1.	It is recommended that the reads be corrected ***before*** gap filling, both for the consideration of memory usage and accuracy of gap sequences produced at this stage. 
THREADS=40
READ_LENGTH=150

STARTDIR=//mnt/home/lizards/Amphibolurus_muricatus/assembly_take_two/L_RNA_scaffolder/blood_ARKSk30_PRNA_LRNAP_combined
THEASSEMBLY=L_RNA_scaffolder.fasta
SAMPLEID=blood_ARKSk30_PRNA_LRNAP

GAPFILLEDASSEMBLY=${SAMPLEID}_gapfilled_pseudohap.fa
echo ${GAPFILLEDASSEMBLY}

cd ${STARTDIR}
##Gap filling
echo "Gap filling......" | tee -a log.txt
mkdir 3-gapclosing && cd 3-gapclosing/
#Prepare config file forGapCloser
touch gapcloser.config
echo "[LIB]" >> gapcloser.config
echo "q1=/mnt/home/lizards/Amphibolurus_muricatus/10X_Genomics/trimmed/LIVER/liver_1.fastq" >> gapcloser.config
echo "q2=/mnt/home/lizards/Amphibolurus_muricatus/10X_Genomics/trimmed/LIVER/liver_2.fastq" >> gapcloser.config

#Gap filling with GapCloser
# $DIR_GAPCLOSER/GapCloser -a ../2-scaffolding/BESST_output/pass1/Scaffolds_pass1.fa -b gapcloser.config -o scaffolds.gapcloser.fa -l $READ_LENGTH -t $THREADS
# test -s scaffolds.gapcloser.fa && (echo -e "Gap filling has been finished\n" | tee -a ../log.txt) || (echo "Gap filling with GapCloser failed. Please try other tools for gap filling or use the assemblies generated in previous steps for BUSCO analyses" && exit)

# 10Xgenome is the assembly created by SuperNova. Remember to use a backup FASTA here to avoid mistakes ...
# so ...
GapCloser -a ${STARTDIR}/${THEASSEMBLY} -b gapcloser.config -o ${GAPFILLEDASSEMBLY} -l $READ_LENGTH -t $THREADS

cp ${GAPFILLEDASSEMBLY} /mnt/home/lizards/Amphibolurus_muricatus/assembly_take_two/BUSCO/
