# BLINK-Wrapper

This is a command-line wrapper for running Genome-Wide Association Studies (GWAS) using the **BLINK** method in R. The wrapper is fully containerized using Docker, making it portable and easy to use for any user with basic inputs: a phenotype file and a VCF genotype file.

---

## 🧪 What It Does

- Performs GWAS using the `Blink()` function from the BLINK R package
- Accepts `.txt`, `.vcf`, or `.vcf.gz` formats
- Automatically generates:
  - CSV results (`blink_gwas_results.csv`)
  - RDS file (`blink_full_results.rds`)
  - Manhattan plot (`manhattan_plot.png`)
  - QQ plot (`qq_plot.png`)

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/bdramirez26/BLINK-Wrapper
cd BLINK-Wrapper



