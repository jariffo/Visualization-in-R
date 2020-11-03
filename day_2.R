# Cargamos los paquetes
# install.packages("tidyverse") # metapaquete que contiene otros paquetes en su interior
# install.packages("tidytext") # paquete enfocado en análisis de textos
# install.packages("syuzhet") # paquete enfocado en análisis de textos
# install.packages("pdftools") # para leer archivos en pdf
# install.packages("patchwork") # para componer varios gráficos juntos
#install.packages("wordcloud2") #para hacer el grafico de puntos

# Cargamos las librerías
library(tidytext)
library(syuzhet)
library(pdftools)
library(patchwork)
library(wordcloud2)


stephen <- pdf_text("covey_stephen_-_the_seven_habits_of_highly_effective_people.pdf")
stephen<- paste(stephen, collapse = " ")
stephen <- str_replace_all(stephen, "[:blank:]{2,}", " ")
write_lines(stephen, "stephen.txt")

stephen <- scan("stephen.txt", fileEncoding = "UTF-8", what = "char", sep = "\n")
stephen <- str_remove(stephen, "[']")
stephen_frecuencias <- as_tibble(stephen) %>% 
  unnest_tokens(palabra, value, strip_numeric = TRUE) %>% 
  count(palabra, sort = TRUE)


# Eliminamos las palabras vacias
mis_stopwords <- tibble(palabra = c("seven", "dont", "youre", "third"))
stopwords_es <- read_csv("https://raw.githubusercontent.com/ravikiranj/twitter-sentiment-analyzer/master/data/feature_list/stopwords.txt")
palabrasstephen <- stephen_frecuencias %>% 
  anti_join(stopwords_es, by= c('palabra' = 'a'))  %>% 
  anti_join(mis_stopwords)

# Grafico de columnas de las palabras más comunas
graficostephen <- palabrasstephen%>% 
  top_n(20) %>% 
  ggplot(aes(y = reorder(palabra, n), x = n)) + 
  geom_col(fill = "#00008B") +
  labs(y = NULL, 
       x = "frecuency",
       title = expression(paste("The 20 most frecuent words in:" ,italic("The 7 habits of highly effective people"))),
                          subtitle = 'Stephen Covey' ) +
  theme_classic() 
# Grafico de nubes de las palabras más comunes
wordcloud2(data = palabrasstephen)
