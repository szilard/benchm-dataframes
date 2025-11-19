import pandas as pd
import time

start = time.time()
d = pd.read_csv("/tmp/d.csv", header=None, names=["x", "y"])
dm = pd.read_csv("/tmp/dm.csv", header=None, names=["x"])
end = time.time()
print(f"Load time: {end - start:.3f} seconds")


start = time.time()
result = d.groupby("x")["y"].mean().reset_index(name="ym").sort_values("ym", ascending=False).head(5)
print(result)
end = time.time()
print(f"Aggregation time: {end - start:.3f} seconds")


start = time.time()
result = pd.merge(d, dm, on="x", how="inner")
print(f"Rows: {len(result)}")
end = time.time()
print(f"Join time: {end - start:.3f} seconds")

