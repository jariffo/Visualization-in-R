library("tidyverse")
github2datos <- read_excel("datos/github2datos.xlsx", col_types = c("numeric", "text", "text"))

github2datos$vinculacion <- as.factor(github2datos$vinculacion)
github2datos_2 <- github2datos %>%
  mutate_if(sapply(vinculacion, is.character), as.factor)

github2datos$vinculacion <- factor(github2datos$vinculacion, 
                                   levels = c("Muy Baja","Baja", "Media", "Alta", "Muy Alta"))

ggplot(github2datos, 
       aes(x = anomes, stratum = vinculacion, alluvium = costumer_id, 
           fill = vinculacion, label = anomes)) + 
  scale_fill_brewer(type = "qual", palette = "Spectral") + 
  geom_flow(stat = "alluvium", lode.guidance = "rightleft", 
            color = "darkgray") + 
  geom_stratum() + 
  theme(legend.position = "bottom") + 
  ggtitle("Nivel of vinculation of our costumers")+
  theme_classic() 
