#!/usr/bin/env bash

TPR=$(ls $SYSTEM_DIR/*.tpr)
PROCESSED_XTC="$OUTPUT_DIR/processed/processed.xtc"

mkdir -p $OUTPUT_DIR/{pca,fel,dssa,dccm}

echo "PCA..."

printf "4\n4\n" | gmx covar \
-s "$TPR" \
-f $OUTPUT_DIR/processed/processed.xtc \
-o $OUTPUT_DIR/pca/eigenvalues.xvg \
-v $OUTPUT_DIR/pca/eigenvectors.trr

printf "4\n4\n" | gmx anaeig \
-v $OUTPUT_DIR/pca/eigenvectors.trr \
-s "$TPR" \
-f $OUTPUT_DIR/processed/processed.xtc \
-first 1 -last 2 \
-proj $OUTPUT_DIR/pca/projection.xvg

echo "FEL..."
gmx sham \
-f $OUTPUT_DIR/pca/projection.xvg \
-ls $OUTPUT_DIR/fel/fel.xpm \
-notime

echo "DSSP..."
printf "1\n" | gmx dssp \
-s "$TPR" \
-f $OUTPUT_DIR/processed/processed.xtc \
-o $OUTPUT_DIR/dssa/dssp.dat
