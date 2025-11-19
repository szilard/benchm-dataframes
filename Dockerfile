FROM ubuntu:24.04

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install R, Python and required system dependencies
RUN apt-get update && \
    apt-get install -y \
    r-base \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    build-essential \
    python3 \
    python3-pip \
    apt-transport-https \
    ca-certificates \
    dirmngr \
    curl \
    gnupg \
    wget && \
    rm -rf /var/lib/apt/lists/*

# Install ClickHouse
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL 'https://packages.clickhouse.com/rpm/lts/repodata/repomd.xml.key' \
      | gpg --dearmor -o /etc/apt/keyrings/clickhouse-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/clickhouse-keyring.gpg] https://packages.clickhouse.com/deb stable main" \
      > /etc/apt/sources.list.d/clickhouse.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      clickhouse-server clickhouse-client && \
    rm -rf /var/lib/apt/lists/*    

# Install R packages
RUN Rscript -e 'install.packages(c("data.table","dplyr","readr"), repos="https://cloud.r-project.org")'

# Install Python packages
RUN pip3 install --break-system-packages pandas polars duckdb clickhouse_connect

# Copy benchmark files
WORKDIR /benchmarks
COPY gendata.R .
COPY run_benchmarks.sh .
COPY tools/ tools/

# Make benchmark script executable
RUN chmod +x run_benchmarks.sh && \
    chmod +x tools/clickhouse_load.sh

# Hack to allow starting clickhouse server      
RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo && \
    rm -rf /var/lib/apt/lists/*    

# Start ClickHouse server in the background and run benchmarks
CMD service clickhouse-server start && sleep 5 && ./run_benchmarks.sh
