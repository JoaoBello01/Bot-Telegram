library(writexl)
library(dplyr)
Despesa <- c("Clube Ifood","Ifood", "Zona Sul", "Metro", "Uber", "Zona Sul", "Cafe e Bar Mm", 
             "Libertadores", "Mania de torta","Xbox game pass", "Spotify", "Corrente",
             "Docura Carioca", "Cafe e Bar Mm","Fluminense Socio")

Preco <- c(4.95, 33.12, 27.55, 6.90, 34.99, 29.83, 18, 130, 19, 29.99, 21.90, 75.83, 5, 20, 160)

Tipo <- c("Alimentação", "Alimentação", "Mercado", "Transporte", "Transporte", "Mercado", 
          "Alimentação", "Fluminense", "Alimentação", "Entretenimento", "Entretenimento", 
          "Cuidado pessoal", "Alimentação", "Alimentação", "Fluminense") 

 Data <- c("12-10-2023", "12-10-2023", "13-10-2023", "14-10-2023", 
                                        "15-10-2023", "15-10-2023", "16-10-2023", "16-10-2023"
                                        ,"16-10-2023", "17-10-2023", "18-10-2023", "17-10-2023", 
                                        "17-10-2023", "17-10-2023", "11-11-2023") 
 
Data<- as.Date(Data, format = "%d-%m-%Y")
 
Parcela_inicial <-c(1,1,1,1,1,1,1,1,1,12,12,1,1,1,2)

Parcela_final <- c(1,1,1,1,1,1,1,1,1,12,12,1,1,1,6)

Renda <- 2246.88
for( i in 1:length(Preco))
{
  Renda[i + 1] <- Renda[i] - Preco[i]
}
Renda <- Renda[-1]
  
Despesas <- tibble(Despesa, Tipo , Preco, Data, Parcela_inicial, Parcela_final, Renda)

 
