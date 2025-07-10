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
Phenotype (.txt)
A tab-delimited file with:

- First column as Taxa (individual IDs)
-  One or more trait columns

Example:
```txt
Taxa	TestPheno
IRIS_313-8285	2.3
IRIS_313-8349	3.1
...
```

Genotype (.vcf or .vcf.gz)
- A valid VCF file with genotypes in GT format (0/0, 0/1, 1/1)
- Chromosome should be numeric


## Output
The following files will be saved to your output directory (e.g. blink_results/):
- blink_gwas_results.csv: Full GWAS results table
- blink_full_results.rds: RDS file for advanced reuse
- manhattan_plot.png: Manhattan plot of -log10(p-values)
- qq_plot.png: QQ plot of observed vs expected p-values

Example Plots
<p align="center"> <img src="results/qq_plot.png" width="400"/> <br><em>QQ plot generated from BLINK results</em> </p> <p align="center"> <img src="results/manhattan_plot.png" width="600"/> <br><em>Manhattan plot generated from BLINK results</em> </p>

