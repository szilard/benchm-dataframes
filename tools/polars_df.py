import polars as pl
import time

start = time.time()
d = pl.read_csv("/tmp/d.csv", has_header=False, new_columns=["x", "y"])
dm = pl.read_csv("/tmp/dm.csv", has_header=False, new_columns=["x"])
end = time.time()
print(f"Load time: {end - start:.3f} seconds")
print()

start = time.time()
result = d.group_by("x").agg(pl.col("y").mean().alias("ym")).sort("ym", descending=True).head(5)
print(result)
end = time.time()
print(f"Aggregation time: {end - start:.3f} seconds")
print()

start = time.time()
result = d.join(dm, on="x", how="inner")
print(f"Rows: {len(result)}")
end = time.time()
print(f"Join time: {end - start:.3f} seconds")
print()
