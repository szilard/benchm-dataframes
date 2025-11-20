library(data.table)
library(ggplot2)

d <- fread("results/results.csv")

ticks <- c(0.2, 0.5, 1, 2, 5, 10, 20)

ggplot(d) + geom_text(aes(x = Aggr, y = Join, label = Tool), size = 6) +
    scale_x_log10(breaks = ticks, labels = ticks, limits = c(min(ticks),max(ticks))) + 
    scale_y_log10(breaks = ticks, labels = ticks, limits = c(min(ticks),max(ticks))) +
    geom_line(data = data.frame(x = ticks, y = ticks), aes(x = x, y = y), 
            linetype = "dashed", color="gray30") +
    coord_equal() +
    theme(axis.text = element_text(size = 14),
          axis.title = element_text(size = 16))

ggsave("results/plot.png", width = 4, height = 4)
