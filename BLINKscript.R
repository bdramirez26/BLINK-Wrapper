print("Hello from BLINK Wrapper!")

# --- Get Command-Line Arguments ---
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 3) stop("Usage: Rscript script.R <phenotype> <vcf> <output_dir>")
pheno_file_path <- args[1]
vcf_file_path <- args[2]
output_directory <- args[3]

# --- Load Required Packages ---
options(repos = c(CRAN = "https://cloud.r-project.org"))
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
if (!requireNamespace("vcfR", quietly = TRUE)) install.packages("vcfR")
if (!requireNamespace("qqman", quietly = TRUE)) install.packages("qqman")
if (!requireNamespace("BLINK", quietly = TRUE)) remotes::install_github("YaoZhou89/BLINK")

library(vcfR)
library(BLINK)
library(qqman)

# Load GAPIT functions (required internally by BLINK)
source("https://raw.githubusercontent.com/jiabowang/GAPIT/refs/heads/master/gapit_functions.txt", encoding = "UTF-8")

# --- Load Phenotype Data ---
phenotype_data <- read.table(pheno_file_path, header = TRUE, sep = "\t", skip = 2)
colnames(phenotype_data)[1] <- "Taxa"
phenotype_data_for_BLINK <- phenotype_data

# --- Load Genotype Data ---
vcf_data <- read.vcfR(vcf_file_path, verbose = FALSE)
genotype_matrix_numeric <- extract.gt(vcf_data, element = "GT", as.numeric = TRUE)
genotype_data_for_BLINK <- t(genotype_matrix_numeric)

# --- Prepare Map Data ---
map_data_row <- as.data.frame(vcf_data@fix)
map_data_GM <- data.frame(
  SNP = map_data_row$ID,
  Chromosome = map_data_row$CHROM,
  Position = as.numeric(map_data_row$POS),
  stringsAsFactors = FALSE
)

# --- Run BLINK Analysis ---
cat("--- Running BLINK ---\n")
blink_results <- Blink(
  Y = phenotype_data_for_BLINK,
  GD = genotype_data_for_BLINK,
  GM = map_data_GM,
  threshold = 0.05 / nrow(map_data_GM)
)

cat("Top 10 most significant SNPs:\n")
print(head(blink_results$GWAS[order(blink_results$GWAS$P.value), ], 10))

# --- Save Results ---
if (!dir.exists(output_directory)) dir.create(output_directory, recursive = TRUE)
write.csv(blink_results$GWAS, file = file.path(output_directory, "blink_gwas_results.csv"), row.names = FALSE)
saveRDS(blink_results, file = file.path(output_directory, "blink_full_results.rds"))
cat("Results saved in:", output_directory, "\n")

# --- Generate Plots ---
gwas_df <- blink_results$GWAS
gwas_df$Chromosome <- as.numeric(as.character(gwas_df$Chromosome))

# Manhattan plot
png(file.path(output_directory, "manhattan_plot.png"), width = 1000, height = 600)
manhattan(gwas_df, chr = "Chromosome", bp = "Position", p = "P.value", snp = "SNP",
          main = "BLINK Manhattan Plot", col = c("dodgerblue3", "firebrick3"))
dev.off()

# QQ plot
png(file.path(output_directory, "qq_plot.png"), width = 800, height = 600)
qq(gwas_df$P.value, main = "BLINK QQ Plot")
dev.off()

cat("QQ plot and Manhattan plot saved.\n")
cat("--- BLINK Wrapper finished ---\n")
