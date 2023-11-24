library(writexl)
library(readxl)
library(dplyr)
library(telegram.bot)

Despesas <- read_excel("C:/Users/joaoba/Desktop/Despesas.xlsx")

start <- function(bot, update) {
  bot$sendMessage(
    chat_id = update$message$chat$id,
    text = sprintf("Oi %s!\nColoque o pagamento da seguinte maneira: 
\nNome (O estabelecimento onde foi comprado o produto)
\nTipo (Qual o tipo de produto foi comprado, é dividido em Alimentação, Mercado, Transporte, Entretenimento, Cuidado pessoal, Fluminense, Conta)
\nPreço (O quanto foi pago pelo produto) 
\nData (Quando foi feita a compra, o formato é dia-mes-ano)
\nParcela inicial (Qual a parcela foi paga dessa compra, caso seja algo não parcelado, então será a parcela 1) 
\nParcela_final (Qual é a parcela final dessa compra, caso seja algo não parcelado, então será a parcela 1)
\nLembre-se, os valores serão divididos por vírgula, NÃO ESQUEÇA.", update$message$from$first_name)
  )
}

updater <- Updater("token") + CommandHandler("start", start)

updater$start_polling()

bot <- Bot(token = "token")


# Get updates
updates <- bot$getUpdates()

gasto <- NULL

for(i in 1:length(updates))
{
  gasto <- updates[[i]][["message"]][["text"]]
  
  gasto <- strsplit(gasto[1], split = ",")
  gasto <- gasto[[1]]
  gasto <- as.data.frame((t(gasto)))
  gasto[[3]] <- as.numeric(gasto[[3]])
  gasto[[7]] <- Despesas$Renda[nrow(Despesas)] - gasto[[3]]
  colnames(gasto) <- colnames(Despesas)
  Despesas <- bind_rows(Despesas,gasto)
}

Despesas$Data<- as.Date(Despesas$Data, format = "%d-%m-%Y")

write_xlsx(Despesas, "Despesas.xlsx")
