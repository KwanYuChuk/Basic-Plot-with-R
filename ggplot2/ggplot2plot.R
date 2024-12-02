# author: Kwan Yu Chuk

library(ggplot2)

# example 1
# this code is to create a bar chart with legend and annotate
# data were grouped by site and colours were identical
ground <- read.csv("ground.csv", stringsAsFactors = T)
head(ground)

ground_p <- ggplot(ground, aes(x=site, y=count, fill=survey)) + 
  geom_bar(position="dodge", stat="identity", width = 0.7) + 
  labs(y="Number of pigeons per camera per site") + 
  xlab(NULL)+
  
  theme_bw() + 
  theme(legend.position=c(0.05, 0.95),
        legend.justification = c(0, 1),
        legend.text = element_text(size = 20),
        legend.title = element_blank(),
        axis.text.x = element_text(size = 25, hjust = 0.5),
        axis.text.y = element_text(size = 20, hjust = 0.5),
        axis.title.y = element_text(size = 25))
ground_p + annotate('text', x = 2, y = 1500, label = 'Ground', family = 'serif', fontface = 'italic', size = 15)

# example 2
# another way to add annotate
# this function is 'labs()'
ground_p2 <- ggplot(ground, aes(x=site, y=count, fill=survey)) + 
  geom_bar(position="dodge", stat="identity", width = 0.7) + 
  labs(y="Number of pigeons per camera per site") + 
  xlab(NULL)+
  labs(tag="Ground")+
  theme_bw() + 
  theme(legend.position=c(0.05, 0.95),
        legend.justification = c(0, 1),
        legend.text = element_text(size = 20),
        legend.title = element_blank(),
        axis.text.x = element_text(size = 25, hjust = 0.5),
        axis.text.y = element_text(size = 20, hjust = 0.5),
        axis.title.y = element_text(size = 25),
        plot.tag.position = c(0.4, 0.9),
        plot.tag = element_text(size = 30))
ground_p2

