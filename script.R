#PRENDO LIBRERIAS

library(tidyverse)
library(ggforce)
library(googlesheets4)
library(ggthemes)

#LEVANTO DATOS

gs4_deauth()
base <- read_sheet("https://docs.google.com/spreadsheets/d/1TUTag7Majqhn5noRLLMUJ6SFJ0Phwlo-Oc1T59uSZCE/edit#gid=0", skip = 1)
janitor::clean_names(base)


#ORDENO

nuevabase <- base %>% 
  select(Partido,AbortoLegal) %>% 
  group_by(Partido,AbortoLegal) %>% 
  mutate(value = n()) %>% 
  ungroup()


#GRAFICO

nuevabaseparalell <- nuevabase %>% 
  gather_set_data(1:2)

ggplot(nuevabaseparalell,
       aes(x, id = id, split = y, value = value)) +
  geom_parallel_sets(aes(fill = Partido), alpha = 0.5, axis.width = 0.1) +
  geom_parallel_sets_axes(axis.width = 0.1) +
  geom_parallel_sets_labels(colour = 'white') +
  theme_wsj() +
  theme(axis.text.y = element_blank()) +
  labs(title = "Posición frente a la despenalización del aborto", 
       subtitle = "Según partido político", 
       caption = "Datos de Nuevo Congreso 2020")
  
  

