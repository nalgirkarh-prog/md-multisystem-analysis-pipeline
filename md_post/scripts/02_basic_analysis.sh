#!/usr/bin/env bash

TPR=$(ls $SYSTEM_DIR/*.tpr)
PROCESSED_XTC="$OUTPUT_DIR/processed/processed.xtc"

mkdir -p "$OUTPUT_DIR/rmsd"
mkdir -p "$OUTPUT_DIR/rmsf"
mkdir -p "$OUTPUT_DIR/sasa"
mkdir -p "$OUTPUT_DIR/hbond"
mkdir -p "$OUTPUT_DIR/rg"

echo "RMSD..."
printf "4\n4\n" | gmx rms \
-s "$TPR" \
-f "$PROCESSED_XTC" \
-o "$OUTPUT_DIR/rmsd/rmsd.xvg"

echo "RMSF..."
printf "4\n" | gmx rmsf \
-s "$TPR" \
-f "$PROCESSED_XTC" \
-o "$OUTPUT_DIR/rmsf/rmsf.xvg"

echo "SASA..."
printf "1\n" | gmx sasa \
-s "$TPR" \
-f "$PROCESSED_XTC" \
-o "$OUTPUT_DIR/sasa/sasa.xvg"

echo "H-bonds..."
printf "1\n11\n" | gmx hbond \
-s "$TPR" \
-f "$PROCESSED_XTC" \
-num "$OUTPUT_DIR/hbond/hbond.xvg"

echo "Radius of Gyration..."
printf "1\n" | gmx gyrate \
-s "$TPR" \
-f "$PROCESSED_XTC" \
-o "$OUTPUT_DIR/rg/rg.xvg"
