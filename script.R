#PRENDO LIBRERIAS

library(tidyverse)
install.packages("ggforce")
library(ggforce)
install.packages("googlesheets4")
library(googlesheets4)
library(ggthemes)
install.packages("janitor")

#LEVANTO DATOS

gs4_deauth()
base <- read_sheet("https://docs.google.com/spreadsheets/d/1TUTag7Majqhn5noRLLMUJ6SFJ0Phwlo-Oc1T59uSZCE/edit#gid=0", skip = 1)
janitor::clean_names(base)


#ORDENO

nuevabase <- base %>% 
  select(Partido,AbortoLegal)

#GRAFICO

gather_set_data(nuevabase, 1:2) %>% 
  ggplot(aes(Partido,AbortoLegal)) +
  geom_parallel_sets(aes(fill = Partido), alpha = 0.5, axis.width = 0.1) +
  geom_parallel_sets_axes(axis.width = 0.1)
  
