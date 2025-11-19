library(data.table)

system.time({
  d <- fread("/tmp/d.csv")
  dm <- fread("/tmp/dm.csv")
})
setnames(d, c("x","y"))
setnames(dm, "x")


system.time(
  print(head(d[, list(ym=mean(y)), by=x][order(-ym)],5))
)


system.time(
  setkey(d, x)
)

system.time(
  print(nrow(d[dm, nomatch=0]))
)

system.time(
  print(head(d[, list(ym=mean(y)), by=x][order(-ym)],5))
)
