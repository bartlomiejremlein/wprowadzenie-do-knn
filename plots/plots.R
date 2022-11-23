library(ggpubr)

generate_plot <- function (x, y, title) {
  plot <- ggscatter(
    iris,
    x = x,
    y = y,
    color = "Species",
    xlab = "Długość (cm)",
    ylab = "Szerokość (cm)",
    size = 1,
    palette = c("#00AFBB", "#E7B800", "#FC4E07"),
    title = title
  ) +
    guides(color=guide_legend(title="Gatunek")) + 
    theme(legend.position = "bottom", text = element_text(size = 7), plot.title = element_text(hjust = 0.5))
  return (plot)
}

p1 <- generate_plot(x = "Sepal.Length", y = "Sepal.Width", "Działki kielicha")
p2 <- generate_plot(x = "Petal.Length", y = "Petal.Width", "Kwiaty")

ggarrange(p1,p2, ncol = 2, common.legend = TRUE, legend = "bottom")

ggsave("iris.png", width = 4, height = 2, dpi = 300, bg = "white")

cv <- read_csv("cv.csv")

ggline(cv, x="k", y="accuracy", ylim=c(0.88, 1), 
       font.tickslab = c(10, "plain"),
       xlab="Liczba sąsiadów", ylab="Dokładność (%)") + 
  geom_vline(xintercept =7, linetype = "dashed", color = "#00AFBB") +
  scale_x_discrete(breaks=seq(1, 49, 8)) + 
  scale_y_continuous(labels = scales::label_percent(suffix=NULL, accuracy = 1)) + 
  theme(legend.position = "bottom", 
        text = element_text(size = 9),  
        axis.text.x = element_text(size = 7), 
        axis.text.y = element_text(size = 7), 
        ) 

ggsave("cv.png", width = 3, height = 1.5, dpi=300)

