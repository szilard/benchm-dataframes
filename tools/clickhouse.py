import clickhouse_connect
import time

# Connect to ClickHouse (assuming local server)
client = clickhouse_connect.get_client(host='localhost', port=8123)

start = time.time()
result = client.query("SELECT x, AVG(y) AS ym FROM d GROUP BY x ORDER BY ym DESC LIMIT 5")
result_df = result.result_set
print(f"{'x':<10} {'ym':<15}")
for row in result_df:
    print(f"{row[0]:<10} {row[1]:<15.6f}")
end = time.time()
print(f"Aggregation time: {end - start:.3f} seconds")
print()

start = time.time()
result = client.query("SELECT COUNT(*) FROM d INNER JOIN dm ON d.x = dm.x")
count = result.result_set[0][0]
print(f"Rows: {count}")
end = time.time()
print(f"Join time: {end - start:.3f} seconds")
print()

