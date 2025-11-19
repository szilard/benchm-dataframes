#!/bin/bash

echo "=========================================="
echo "Generating test data..."
echo "=========================================="
Rscript gendata.R
echo ""

echo "=========================================="
echo "Runnning the benchmark..."
echo "=========================================="
echo ""

# R Benchmarks
echo "-------------------- data.table --------------------"
Rscript tools/data_table.R
echo ""

echo "-------------------- dplyr --------------------"
Rscript tools/dplyr.R
echo ""

echo "-------------------- DuckDB --------------------"
python3 tools/duckdb_df.py
echo ""

# Python Benchmarks
echo "-------------------- pandas --------------------"
python3 tools/pandas_df.py
echo ""

echo "-------------------- polars --------------------"
python3 tools/polars_df.py
echo ""
