#!/usr/bin/env bash

ASSEMBLYDIR=/WORKDIR/lizards/Amphibolurus_muricatus/assembly
cd ${ASSEMBLYDIR}

# run name (used to name output folder)
run_id="Amphibolurus_muricatus_LIVER"

supernova_out_dir=${ASSEMBLYDIR}/${run_id}
echo ${supernova_out_dir}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# run supernova
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# system load settings (leave extra room for memory)
threads=28
mem=$(echo "$threads * 30" | bc)
# will ask for ~840 Gb RAM

# MAX_READS=2140000000 #for supernova 2.1.1
# MAX_READS=1200000000 #for supernova <= 2.1.0
# MAX_READS=750000000 # recommended by Arthur
  MAX_READS=1200784214 # 
# The --sample argument must be specified if multiple samples were demultiplexed in a run folder.  Options:
supernova run --sample AA069032_Liver1 --id ${run_id} --fastqs=/WORKDIR/lizards/Amphibolurus_muricatus/10X_Genomics/LIVER --description="Full Assembly" --maxreads=${MAX_READS} --localmem ${mem} --localcores ${threads}

