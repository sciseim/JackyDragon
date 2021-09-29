#!/usr/bin/env bash
# ############
# ############
# TRINITY
# ############
# ############
# enter e.g. 'antechinus/liver' or 'antechinus_all_tissues'
ulimit -s unlimited ; # Otherwise it may run out of memory etc!

# assign all left reads and comma delimit them (Trinity now supports this mode. No more time-consuming cat'ing)
# fastq.gz also works
# LEFTREADS=$(ls *_1.fastq.gz)
LEFTREADS=$(ls *_1.fastq)
LEFTREADS=`echo $LEFTREADS | sed 's/ /,/g'`
RIGHTREADS=$(ls *_2.fastq)
RIGHTREADS=`echo $RIGHTREADS | sed 's/ /,/g'`

CPU=36
MEMORY=450G
# change to '--max_memory $MEMORY' and '--CPU $CPU' below
# --max_memory <string>      :suggested max memory to use by Trinity where limiting can be enabled. (jellyfish, sorting, etc)
#                            provided in Gb of RAM, ie.  '--max_memory 10G'
# see https://github.com/trinityrnaseq/trinityrnaseq/wiki/Running-Trinity
Trinity --seqType fq --left $LEFTREADS --right $RIGHTREADS --CPU $CPU --max_memory $MEMORY --full_cleanup ;




