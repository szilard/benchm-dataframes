library(dplyr)
library(readr)

cat("Load time:\n")
print(system.time({
  d <- read_csv("/tmp/d.csv", col_names = FALSE, show_col_types = FALSE)
  dm <- read_csv("/tmp/dm.csv", col_names = FALSE, show_col_types = FALSE)
}))
names(d) <- c("x","y")
names(dm) <- "x"

cat("\nAggregation time:\n")
print(system.time(
  print(d %>% group_by(x) %>% summarise(ym=mean(y)) %>% arrange(desc(ym)) %>% head(5))
))

cat("\nJoin time:\n")
print(system.time(
  print(nrow(inner_join(d, dm, by="x")))
))
