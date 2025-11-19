library(duckdb)

con <- dbConnect(duckdb())

system.time({
  dbExecute(con, "CREATE TABLE d AS SELECT * FROM read_csv_auto('/tmp/d.csv', header=false, columns={'column0': 'VARCHAR', 'column1': 'DOUBLE'})")
  dbExecute(con, "ALTER TABLE d RENAME column0 TO x")
  dbExecute(con, "ALTER TABLE d RENAME column1 TO y")
  dbExecute(con, "CREATE TABLE dm AS SELECT * FROM read_csv_auto('/tmp/dm.csv', header=false, columns={'column0': 'VARCHAR'})")
  dbExecute(con, "ALTER TABLE dm RENAME column0 TO x")
})


system.time(
  print(dbGetQuery(con, "SELECT x, AVG(y) AS ym FROM d GROUP BY x ORDER BY ym DESC LIMIT 5"))
)


system.time(
  dbExecute(con, "CREATE INDEX idx_d_x ON d(x)")
)

system.time(
  print(dbGetQuery(con, "SELECT COUNT(*) FROM d INNER JOIN dm ON d.x = dm.x"))
)

system.time(
  print(dbGetQuery(con, "SELECT x, AVG(y) AS ym FROM d GROUP BY x ORDER BY ym DESC LIMIT 5"))
)

dbDisconnect(con, shutdown=TRUE)
