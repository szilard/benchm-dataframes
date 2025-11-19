#!/bin/bash

# R Benchmarks
echo "==================== data.table ===================="
Rscript tools/data_table.R
echo ""

echo "==================== dplyr ===================="
Rscript tools/dplyr.R
echo ""

echo "==================== DuckDB (R) ===================="
Rscript tools/duckdb.R
echo ""

# Python Benchmarks
echo "==================== pandas ===================="
python3 tools/pandas_df.py
echo ""

echo "==================== polars ===================="
python3 tools/polars_df.py
echo ""
