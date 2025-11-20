library(data.table)
library(ggplot2)

d <- fread("results/results.csv")

ticks <- c(0.2, 0.5, 1, 2, 5, 10, 20)

ggplot(d) + geom_text(aes(x = Aggr, y = Join, label = Tool), size = 2) +
    scale_x_log10(breaks = ticks, labels = ticks, limits = c(min(ticks),max(ticks))) + 
    scale_y_log10(breaks = ticks, labels = ticks, limits = c(min(ticks),max(ticks))) +
    geom_line(data = data.frame(x = ticks, y = ticks), aes(x = x, y = y), 
            linetype = "dashed", color="gray30", size = 0.3) +
    coord_equal() +
    theme(axis.text = element_text(size = 4),
          axis.title = element_text(size = 5),
          panel.grid.major = element_line(linewidth = 0.2),
          panel.grid.minor = element_line(linewidth = 0.1),
          axis.ticks = element_line(linewidth = 0.2))

ggsave("results/plot.png", width = 600, height = 600, units = "px")
