# 🌾 BLINK Wrapper for GWAS

A lightweight command-line wrapper for performing Genome-Wide Association Studies (GWAS) using the [`BLINK`](https://github.com/YaoZhou89/BLINK) R package. It runs BLINK on phenotype and genotype data, and automatically generates GWAS results along with Manhattan and QQ plots.

---

##  Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/bdramirez26/BLINK-Wrapper
cd BLINK-Wrapper
```

### 2. Build the Docker Image

Make sure you're inside the BLINK-Wrapper directory (where the Dockerfile is located).

Intel/AMD Users
```bash
docker build -t blink-wrapper .
```

Apple Silicon Users
```bash
docker build --platform linux/amd64 -t blink-wrapper .
```

### 3. Run the Analysis
```bash
docker run --rm \
  --platform linux/amd64 \
  -v "$(pwd)":/app \
  blink-wrapper \
  data/test-pheno.txt \
  data/test-150.vcf.gz \
  blink_results
```
This runs the analysis using test data provided in the data/ folder and stores results in blink_results/.

## Input Format
