
library(readxl)
library(dplyr)
library(ggplot2)

setwd("/Users/wisle/Materias do 4 periodo/Mineracao de texto/Minereção De Texto - Jesmmer em R/Trabalho/")
# vamos coletar os dados 

# vamos manipular os dados agora 

dados_covid_2020_1_semestre <- read.csv2("HIST_PAINEL_COVIDBR_2020_Parte1_03out2023.csv")
dados_covid_2020_2_semestre <-read.csv2("HIST_PAINEL_COVIDBR_2020_Parte2_03out2023.csv")

dados_covid_2020 <-bind_rows(dados_covid_2020_1_semestre,dados_covid_2020_2_semestre)

# colocando os dados que estão fazio como NA para facilitar a analise dos dados
dados_covid_2020$municipio[dados_covid_2020$municipio == ""] <- NA

dados_covid_2020$nomeRegiaoSaude[dados_covid_2020$nomeRegiaoSaude == ""] <- NA

dados_covid_2020$estado[dados_covid_2020$estado == ""] <- NA
#pegando os dados so do Brasil 
covid.Brasil <- filter(dados_covid_2020, is.na(municipio) & is.na(codmun) & is.na(estado))


head(covid.Brasil)


#Mostrando os dados dos estados do Brasil


# pegando os dados de todos os estados 
covid.estados <- filter(dados_covid_2020, is.na(municipio) & is.na(codmun) & !is.na(estado))
head(covid.estados)


# Acre
covid_ac_2020 <- filter(covid.estados, estado == "AC")
head(covid_ac_2020)
# Selecionamos os dados que queriamos para nosso grafico
covid_ac_casos <- covid_ac_2020 %>%
  select(data, casosAcumulado)
  

  ggplot(data = covid_ac_casos, aes(x = data, y = casosAcumulado, group = 1)) +
    geom_line() +
    labs(title = "Casos De Covid no AC", x = "Data", y = "Numero de Casos")