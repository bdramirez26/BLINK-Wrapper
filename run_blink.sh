#!/bin/bash

# run_blink.sh - Command-line wrapper for BLINK GWAS analysis in R

R_SCRIPT="BLINKscript.R"
OUTPUT_DIR="blink_results"

# Usage
if [ "$#" -lt 2 ]; then
  echo "Usage: ./run_blink.sh <phenotype_file> <vcf_file>"
  echo "  <phenotype_file> : Path to phenotype data (e.g., test-pheno.txt)"
  echo "  <vcf_file>       : Path to VCF file (e.g., test-150.vcf.gz)"
  exit 1
fi

PHENO_FILE="$1"
VCF_FILE="$2"

# Checks
[ -f "$R_SCRIPT" ] || { echo "Error: R script '$R_SCRIPT' not found."; exit 1; }
[ -f "$PHENO_FILE" ] || { echo "Error: Phenotype file '$PHENO_FILE' not found."; exit 1; }
[ -f "$VCF_FILE" ] || { echo "Error: VCF file '$VCF_FILE' not found."; exit 1; }

mkdir -p "$OUTPUT_DIR"

echo "--- Running BLINK ---"
echo "Phenotype : $PHENO_FILE"
echo "VCF       : $VCF_FILE"
echo "Output    : $OUTPUT_DIR"

# Run R script
Rscript --vanilla "$R_SCRIPT" "$PHENO_FILE" "$VCF_FILE" "$OUTPUT_DIR"

if [ $? -eq 0 ]; then
  echo "--- BLINK completed successfully ---"
  echo "Results saved in '$OUTPUT_DIR'"
else
  echo "--- Error: BLINK failed ---"
  echo "Check R script output for details."
fi
