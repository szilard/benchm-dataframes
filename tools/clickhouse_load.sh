#!/bin/bash

# ClickHouse data loading script

start_time=$(date +%s.%N)

# Drop tables if they exist
clickhouse-client --query "DROP TABLE IF EXISTS d"
clickhouse-client --query "DROP TABLE IF EXISTS dm"

# Create tables
clickhouse-client --query "
    CREATE TABLE d (
        x String,
        y Float64
    ) ENGINE = MergeTree()
    ORDER BY x
"

clickhouse-client --query "
    CREATE TABLE dm (
        x String
    ) ENGINE = MergeTree()
    ORDER BY x
"

# Load data from CSV files
clickhouse-client --query "INSERT INTO d FORMAT CSV" < /tmp/d.csv
clickhouse-client --query "INSERT INTO dm FORMAT CSV" < /tmp/dm.csv

end_time=$(date +%s.%N)
load_time=$(echo "$end_time - $start_time" | bc)

printf "Load time: %.3f seconds\n" $load_time
echo
