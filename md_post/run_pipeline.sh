#!/usr/bin/env bash
set -eo pipefail

echo "======================================="
echo "     MD-POST Multi-System Pipeline"
echo "======================================="

# ----------------------------
# Activate Conda Environment
# ----------------------------

source ~/miniconda3/etc/profile.d/conda.sh
conda activate md_pipeline
export GMX_MAXBACKUP=-1

echo "Using GROMACS:"
which gmx
gmx --version

INPUT_ROOT="input"
OUTPUT_ROOT="outputs"

mkdir -p "$OUTPUT_ROOT"

SYSTEMS=$(find "$INPUT_ROOT" -mindepth 1 -maxdepth 1 -type d)

if [ -z "$SYSTEMS" ]; then
    echo "❌ No system folders found inside input/"
    exit 1
fi

for SYSTEM in $SYSTEMS; do
    SYSTEM_NAME=$(basename "$SYSTEM")

    echo ""
    echo "Processing system: $SYSTEM_NAME"

    export SYSTEM_DIR="$SYSTEM"
    export OUTPUT_DIR="$OUTPUT_ROOT/$SYSTEM_NAME"

    mkdir -p "$OUTPUT_DIR"

    bash scripts/01_preprocess.sh
    bash scripts/02_basic_analysis.sh
    bash scripts/03_advanced_analysis.sh
done

echo ""
echo "Running comparative statistics..."
Rscript scripts/04_statistics.R

echo "Generating plots..."
python scripts/05_plots.py

echo "Generating report..."
python scripts/report_generator.py

echo ""
echo "Pipeline completed successfully."
