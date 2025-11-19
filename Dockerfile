FROM ubuntu:24.04

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install R and required system dependencies
RUN apt-get update && \
    apt-get install -y \
    r-base \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    build-essential \
    python3 \
    python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install R packages
RUN Rscript -e 'install.packages(c("data.table","dplyr","readr"), repos="https://cloud.r-project.org")'

# Install Python packages
RUN pip3 install --break-system-packages pandas polars duckdb

# Copy benchmark files
WORKDIR /benchmarks
COPY gendata.R .
COPY run_benchmarks.sh .
COPY tools/ tools/

# Make benchmark script executable
RUN chmod +x run_benchmarks.sh

# Run the benchmark
CMD ["./run_benchmarks.sh"]
