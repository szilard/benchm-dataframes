library(dplyr)
library(readr)

system.time({
  d <- read_csv("/tmp/d.csv", col_names = FALSE, show_col_types = FALSE)
  dm <- read_csv("/tmp/dm.csv", col_names = FALSE, show_col_types = FALSE)
})
names(d) <- c("x","y")
names(dm) <- "x"


system.time(
  print(d %>% group_by(x) %>% summarise(ym=mean(y)) %>% arrange(desc(ym)) %>% head(5))
)


system.time(
  print(nrow(inner_join(d, dm, by="x")))
)

