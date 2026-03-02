#!/usr/bin/env bash

TPR=$(ls $SYSTEM_DIR/*.tpr)
XTC=$(ls $SYSTEM_DIR/*.xtc)
GRO=$(ls $SYSTEM_DIR/*.gro)
TOP=$(ls $SYSTEM_DIR/*.top)
NDX=$(ls $SYSTEM_DIR/*.ndx 2>/dev/null)

mkdir -p "$OUTPUT_DIR/processed"

echo "Removing PBC..."

printf "0\n" | gmx trjconv \
-s "$TPR" \
-f "$XTC" \
-o "$OUTPUT_DIR/processed/nojump.xtc" \
-pbc nojump

echo "Centering..."

printf "1\n0\n" | gmx trjconv \
-s "$TPR" \
-f "$OUTPUT_DIR/processed/nojump.xtc" \
-o "$OUTPUT_DIR/processed/center.xtc" \
-center -pbc mol

echo "Fitting..."

printf "4\n0\n" | gmx trjconv \
-s "$TPR" \
-f "$OUTPUT_DIR/processed/center.xtc" \
-o "$OUTPUT_DIR/processed/processed.xtc" \
-fit rot+trans
