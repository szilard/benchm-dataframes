#!/bin/bash

echo "=========================================="
echo "Generating test data..."
echo "=========================================="
Rscript generate_data.R
echo ""

echo "=========================================="
echo "Runnning the benchmark..."
echo "=========================================="
echo ""

echo "-------------------- data.table --------------------"
Rscript tools/data_table.R
echo ""

echo "-------------------- dplyr --------------------"
Rscript tools/dplyr.R
echo ""

echo "-------------------- DuckDB --------------------"
python3 tools/duckdb_df.py
echo ""

echo "-------------------- pandas --------------------"
python3 tools/pandas_df.py
echo ""

echo "-------------------- polars --------------------"
python3 tools/polars_df.py
echo ""

echo "-------------------- ClickHouse --------------------"
bash tools/clickhouse_load.sh
python3 tools/clickhouse.py
echo ""
