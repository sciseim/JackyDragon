#!/usr/bin/env bash

# go to each directory and run Trinity = X-run-Trinity-2018.sh
STARTINGDIR=/mnt/home/lizards/Amphibolurus_muricatus/RNAseq/trimmed/PhiXfree/rRNAfree
TRINITYSCRIPT=/mnt/home/lizards/Amphibolurus_muricatus/RNAseq/trimmed/PhiXfree/rRNAfree/run-Trinity-merge_many_tissues.sh


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# combined = x Gb
TISSUE=COMBINED
#
#
WORKINGDIR=`echo -n "${STARTINGDIR}/$TISSUE"`
cd $WORKINGDIR ;
bash ${TRINITYSCRIPT}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# SPLEEN = x Gb
TISSUE=BRAIN
#
#
WORKINGDIR=`echo -n "${STARTINGDIR}/$TISSUE"`
cd $WORKINGDIR ;
bash ${TRINITYSCRIPT}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# PROSTATE = x Gb
TISSUE=TESTIS
#
#
WORKINGDIR=`echo -n "${STARTINGDIR}/$TISSUE"`
cd $WORKINGDIR ;
bash ${TRINITYSCRIPT}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CEREBRUM = x Gb
TISSUE=OVARY 
#
#
WORKINGDIR=`echo -n "${STARTINGDIR}/$TISSUE"`
cd $WORKINGDIR ;
bash ${TRINITYSCRIPT}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STERNAL GLAND = x Gb
TISSUE=FEMALE_BRAIN
#
#
WORKINGDIR=`echo -n "${STARTINGDIR}/$TISSUE"`
cd $WORKINGDIR ;
bash ${TRINITYSCRIPT}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STERNAL GLAND = x Gb
TISSUE=MALE_BRAIN
#
#
WORKINGDIR=`echo -n "${STARTINGDIR}/$TISSUE"`
cd $WORKINGDIR ;
bash ${TRINITYSCRIPT}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

