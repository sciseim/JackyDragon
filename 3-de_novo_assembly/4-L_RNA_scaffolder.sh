#!/usr/bin/env bash

cd /mnt/home/lizards/Amphibolurus_muricatus/assembly_take_two/L_RNA_scaffolder

# note: blat will take a VERY long time (about a week)
blat -t=dna ./liver_ARKSk30_PRNA.fa -q=rna ./Amphibolurus-muricatus_combined.fasta liver_ARKSk30_PRNA_LRNAP_combined.psl -noHead &

mkdir -p liver_ARKSk30_PRNA_LRNAP_combined

## L_RNA_scaffolder
L_RNA_scaffolder.sh -d ./liver_ARKSk30_PRNA_LRNAP_combined -i liver_ARKSk30_PRNA_LRNAP_combined.psl -o ./liver_ARKSk30_PRNA_LRNAP_combined -j ./liver_ARKSk30_PRNA.fa


