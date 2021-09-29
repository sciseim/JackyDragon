#!/usr/bin/env bash
CPU=80

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# ARKS + P_RNA_scaffolder + L_RNA_scaffolder + GapCloser
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
GENOMEDIR=/mnt/home/lizards/Amphibolurus_muricatus/assembly_take_two/BUSCO
cd $GENOMEDIR
GENOMENAME=liver_ARKSk30_PRNA_LRNAP_gapfilled_pseudohap.fa
OUTPUTNAME=liver_ARKSk30_PRNA_LRNAP_gapfilled_BUSCO
#
time docker run -u $(id -u) -v ${GENOMEDIR}:/host_mount -w /host_mount ezlabgva/busco:v5.0.0_cv1 busco -f -i ${GENOMENAME} --lineage_dataset vertebrata_odb10 --out ${OUTPUTNAME} --mode genome --cpu ${CPU}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
