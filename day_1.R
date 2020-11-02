#install.packages("ggplot2")
#install.packages("ggimage")
#install.packages("ggthemes") # Install 
require(magick)
require(ggplot2)
require(ggimage) 

img = "img/iris.jpg"

p <- ggplot(iris) + aes(x = Sepal.Length, y = Sepal.Width, color=Species) + 
  geom_point(size=2.5) +
  theme_classic() +
  labs(title ="Tipos de flores \n según su largo vs ancho",
       subtitle = "",
       caption = "@jariffo", y = "Ancho",
       x = "Largo ", colour = "Tipo de flor") +
  coord_cartesian(xlim =c(4, 8.5), ylim = c(0, 4.5)) +
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#00008B")) +
  theme(legend.position="top", 
        plot.title = element_text(family="Comic Sans MS",
                                  hjust = 0.5, #posicion central
                                  size=rel(1.5), #Tamaño relativo de la letra del título
                                  vjust=1, #Justificación vertical, para separarlo del gráfico
                                  face="bold", #Letra negrilla. Otras posibilidades "plain", "italic", "bold" y "bold.italic"
                                  color="#4B0082", #Color del texto
                                  lineheight=1.5))

ggimage::ggbackground(p, img)


