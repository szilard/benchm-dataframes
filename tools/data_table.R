library(data.table)

cat("Load time:\n")
print(system.time({
  d <- fread("/tmp/d.csv")
  dm <- fread("/tmp/dm.csv")
}))
setnames(d, c("x","y"))
setnames(dm, "x")

cat("\nAggregation time:\n")
print(system.time(
  print(head(d[, list(ym=mean(y)), by=x][order(-ym)],5))
))

cat("\nIndexing time:\n")
print(system.time(
  setkey(d, x)
))

cat("\nJoin time:\n")
print(system.time(
  print(nrow(d[dm, nomatch=0]))
))

cat("\nAggregation time (with keys):\n")
print(system.time(
  print(head(d[, list(ym=mean(y)), by=x][order(-ym)],5))
))
