#!/usr/bin/env bash
# SortMeRNA_run.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# remove ribosomal RNAs
# #########################
# https://github.com/biocore/sortmerna
# SortMeRNA is a local sequence alignment tool for filtering, mapping and clustering.


# Ribosomal RNA removal using SORTMERNA
# see https://github.com/biomendi/TRANSCRIPTOME-ASSEMBLY-PIPELINE/wiki/3.-Ribosomal-RNA-removal-using-SORTMERNA
# -a 8: number of threads to use.
# 
# -m 64000: amount of RAM for loading reads into memory.
CPU=20 # bunsen has 32 cores
MEMORY=164000 
# change to '-m $MEMORY' and '-a $CPU' below

# The folder rRNA_databases/silva_ids_acc_tax.tar.gz contains SILVA taxonomy strings (extracted from XML file generated by ARB) for each of the reference sequences in the representative databases. The format of the files is three tab-separated columns, the first being the reference sequence ID, the second being the accession number and the final column is the taxonomy.

# index the rRNA databases
SORTMERNADIR=/bix/sortmerna-2.1b

# only have to do this once
# $SORTMERNADIR/indexdb_rna --ref \
# $SORTMERNADIR/rRNA_databases/silva-bac-16s-id90.fasta,$SORTMERNADIR/index/silva-bac-16s-db:\
# $SORTMERNADIR/rRNA_databases/silva-bac-23s-id98.fasta,$SORTMERNADIR/index/silva-bac-23s-db:\
# $SORTMERNADIR/rRNA_databases/silva-arc-16s-id95.fasta,$SORTMERNADIR/index/silva-arc-16s-db:\
# $SORTMERNADIR/rRNA_databases/silva-arc-23s-id98.fasta,$SORTMERNADIR/index/silva-arc-23s-db:\
# $SORTMERNADIR/rRNA_databases/silva-euk-18s-id95.fasta,$SORTMERNADIR/index/silva-euk-18s-db:\
# $SORTMERNADIR/rRNA_databases/silva-euk-28s-id98.fasta,$SORTMERNADIR/index/silva-euk-28s:\
# $SORTMERNADIR/rRNA_databases/rfam-5s-database-id98.fasta,$SORTMERNADIR/index/rfam-5s-db:\
# $SORTMERNADIR/rRNA_databases/rfam-5.8s-database-id98.fasta,$SORTMERNADIR/index/rfam-5.8s-db


# Antechinus
INPUTDIRPE=/mnt/home/lizards/Amphibolurus_muricatus/RNAseq/trimmed/PhiXfree 

OUTPUT_DIR=`echo -n "${INPUTDIRPE}/rRNAfree"`
mkdir -p $OUTPUT_DIR

cd $INPUTDIRPE
# gunzip *.gz ; 
# e.g.
# 9-Spleen-ante_PhiXfree_R1.fastq.gz
# 9-Spleen-ante_PhiXfree_R2.fastq.gz
# for FASTQ in *.fastq.gz; do echo $FASTQ && pigz -d $FASTQ ;done



# CCB6RANXX_6_180117_FD02699728_Other_ACAGTG_R_171211_IRADEV_RNA_M001_PhiXfree_R1.fastq
# testing
for left in *_R1.fastq; do
right=`echo  $left | perl -pe 's/\_R1/\_R2/g'` ;  # assign the RIGHT hand read by calling a Perl regex against $i (the LEFT read file name)
# echo $right;
LEFToutputfilename=`echo $left | perl -pe 's/\_PhiXfree_R1.fastq/_R1/g'`  ;
RIGHToutputfilename=`echo $right | perl -pe 's/\_PhiXfree_R2.fastq/_R2/g'`  ;
# echo $LEFToutputfilename ;
# echo $RIGHToutputfilename ;
OUTPUT_PATH_LEFT=`echo -n "${OUTPUT_DIR}/$LEFToutputfilename"`
echo $OUTPUT_PATH_LEFT
OUTPUT_PATH_RIGHT=`echo -n "${OUTPUT_DIR}/$RIGHToutputfilename"`
echo $OUTPUT_PATH_RIGHT

# merge reads
$SORTMERNADIR/scripts/merge-paired-reads.sh $left $right reads_interleaved.fq
# filtered the rRNA from our reads
$SORTMERNADIR/sortmerna --ref \
$SORTMERNADIR/rRNA_databases/silva-bac-16s-id90.fasta,$SORTMERNADIR/index/silva-bac-16s-db:\
$SORTMERNADIR/rRNA_databases/silva-bac-23s-id98.fasta,$SORTMERNADIR/index/silva-bac-23s-db:\
$SORTMERNADIR/rRNA_databases/silva-arc-16s-id95.fasta,$SORTMERNADIR/index/silva-arc-16s-db:\
$SORTMERNADIR/rRNA_databases/silva-arc-23s-id98.fasta,$SORTMERNADIR/index/silva-arc-23s-db:\
$SORTMERNADIR/rRNA_databases/silva-euk-18s-id95.fasta,$SORTMERNADIR/index/silva-euk-18s-db:\
$SORTMERNADIR/rRNA_databases/silva-euk-28s-id98.fasta,$SORTMERNADIR/index/silva-euk-28s:\
$SORTMERNADIR/rRNA_databases/rfam-5s-database-id98.fasta,$SORTMERNADIR/index/rfam-5s-db:\
$SORTMERNADIR/rRNA_databases/rfam-5.8s-database-id98.fasta,$SORTMERNADIR/index/rfam-5.8s-db \
--reads reads_interleaved.fq --num_alignments 1 \
--fastx --aligned reads_rRNA --other reads_non_rRNA --log -a $CPU -m $MEMORY --paired_in -v
# unmerged our filtered file
$SORTMERNADIR/scripts/unmerge-paired-reads.sh reads_non_rRNA.fq $OUTPUT_PATH_LEFT $OUTPUT_PATH_RIGHT
done

# At this point, we obtained two rRNA-free files:
# reads_non_rRNA_1.fq
# reads_non_rRNA_2.fq
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


