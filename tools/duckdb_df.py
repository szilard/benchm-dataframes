import duckdb
import time

con = duckdb.connect()

start = time.time()
con.execute("CREATE TABLE d AS SELECT * FROM read_csv_auto('/tmp/d.csv', header=false, columns={'column0': 'VARCHAR', 'column1': 'DOUBLE'})")
con.execute("ALTER TABLE d RENAME column0 TO x")
con.execute("ALTER TABLE d RENAME column1 TO y")
con.execute("CREATE TABLE dm AS SELECT * FROM read_csv_auto('/tmp/dm.csv', header=false, columns={'column0': 'VARCHAR'})")
con.execute("ALTER TABLE dm RENAME column0 TO x")
end = time.time()
print(f"Load time: {end - start:.3f} seconds")


start = time.time()
result = con.execute("SELECT x, AVG(y) AS ym FROM d GROUP BY x ORDER BY ym DESC LIMIT 5").fetchdf()
print(result)
end = time.time()
print(f"Aggregation time: {end - start:.3f} seconds")


start = time.time()
con.execute("CREATE INDEX idx_d_x ON d(x)")
end = time.time()
print(f"Indexing time: {end - start:.3f} seconds")

start = time.time()
result = con.execute("SELECT COUNT(*) FROM d INNER JOIN dm ON d.x = dm.x").fetchdf()
print(f"Rows: {result.iloc[0, 0]}")
end = time.time()
print(f"Join time: {end - start:.3f} seconds")

start = time.time()
result = con.execute("SELECT x, AVG(y) AS ym FROM d GROUP BY x ORDER BY ym DESC LIMIT 5").fetchdf()
print(result)
end = time.time()
print(f"Aggregation time (2nd): {end - start:.3f} seconds")

con.close()
