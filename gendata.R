library(data.table)

set.seed(123)
n <- 100e6
m <- 1e6

cat("Data generation and writing time:\n")
system.time({
  d <- data.table(x = sample(m, n, replace = TRUE), y = runif(n))
  dm <- data.table(x = sample(m))
  
  fwrite(d, file = "/tmp/d.csv", col.names = FALSE)
  fwrite(dm, file = "/tmp/dm.csv", col.names = FALSE)
})
