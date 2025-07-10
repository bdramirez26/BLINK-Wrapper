# Use the Rocker base image (R + Debian)
FROM rocker/r-base:latest

# Set working directory
WORKDIR /app

# Install system dependencies required for R packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install R packages: remotes, vcfR, and BLINK
RUN R -e "install.packages('remotes', repos = 'https://cloud.r-project.org')" && \
    R -e "install.packages('vcfR', repos = 'https://cloud.r-project.org')" && \
    R -e "remotes::install_github('YaoZhou89/BLINK')"

# Copy your R script into the image
COPY BLINKscript.R .

# Set Rscript as the container entrypoint
ENTRYPOINT ["Rscript", "BLINKscript.R"]
