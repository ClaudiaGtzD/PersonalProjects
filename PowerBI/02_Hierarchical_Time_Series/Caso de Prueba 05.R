rm(list=ls())

#####################################################################
#PASO 1. SE INSTALAN LAS LIBRERIAS NECESARIAS.

library(openxlsx, quietly = TRUE)
library(Hmisc, quietly = TRUE)
library(scales)
library(officer)
library(flextable)
library(forecast)
library(datasets)
library(tseries)
library(WriteXLS)
library(stringr)
library(MASS)

#####################################################################
#PASO 2. SE DEFINEN LAS RUTAS DE CATALOGOS Y RESULTADOS.

ruta.1 <- "C:/Users/Claudia/OneDrive/Documentos/FCFM/04_Tetramestre/Modelo de Negocios/BusinessIntelligence/Caso de Prueba 05/"

################################################################################
################################################################################
################################################################################
###############################IPC##############################################
################################################################################
################################################################################
################################################################################

#####################################################################
#PASO 3. LEE INSUMOS PRONOSTICO IPC


datos_cartera <- read.xlsx("C:/Users/Claudia/OneDrive/Documentos/FCFM/04_Tetramestre/Modelo de Negocios/BusinessIntelligence/Caso de Prueba 05/Cartera.xlsx",
                     sheet="Datos", startRow = 1, colNames = TRUE)

datos_S <- read.xlsx("C:/Users/Claudia/OneDrive/Documentos/FCFM/04_Tetramestre/Modelo de Negocios/BusinessIntelligence/Caso de Prueba 05/Cartera.xlsx",
                     sheet="S", startRow = 1, colNames = FALSE)

S <- as.matrix(datos_S)
S

Y_lowest = matrix(0, nrow = 5, ncol = 30)

plot(datos_cartera$BBVA)

ts.BBVA <- ts(datos_cartera$BBVA, frequency = 12, start = c(2004,1))
plot(ts.BBVA)
ARIMA.BBVA <- auto.arima(ts.BBVA,D=1)
summary(ARIMA.BBVA)
plot(ARIMA.BBVA$x, col="Blue")
par(new=TRUE)
plot(ARIMA.BBVA$fitted,col="red") 
title(main="Real vs Forecast")
Forecast.BBVA<- forecast(ARIMA.BBVA, h=30)
Forecast.BBVA
plot(Forecast.BBVA, main="Pronóstico ARIMA para los próximos 30 meses", xlab="Tiempo", ylab="Valor")
Y_lowest[1,] <- Forecast.BBVA$mean

ts.Santander <- ts(datos_cartera$Santander, frequency = 12, start = c(2004,1))
plot(ts.Santander)
ARIMA.Santander <- auto.arima(ts.Santander,D=1)
summary(ARIMA.Santander)
plot(ARIMA.Santander$x, col="Blue")
par(new=TRUE)
plot(ARIMA.Santander$fitted,col="red") 
title(main="Real vs Forecast")
Forecast.Santander<- forecast(ARIMA.Santander, h=30)
Forecast.Santander
plot(Forecast.Santander, main="Pronóstico ARIMA para los próximos 30 meses", xlab="Tiempo", ylab="Valor")
Y_lowest[2,] <- Forecast.Santander$mean


ts.Banorte <- ts(datos_cartera$Banorte, frequency = 12, start = c(2004,1))
plot(ts.Banorte)
ARIMA.Banorte <- auto.arima(ts.Banorte,D=1)
summary(ARIMA.Banorte)
plot(ARIMA.Banorte$x, col="Blue")
par(new=TRUE)
plot(ARIMA.Banorte$fitted,col="red") 
title(main="Real vs Forecast")
Forecast.Banorte<- forecast(ARIMA.Banorte, h=30)
Forecast.Banorte
plot(Forecast.Banorte, main="Pronóstico ARIMA para los próximos 30 meses", xlab="Tiempo", ylab="Valor")
Y_lowest[3,] <- Forecast.Banorte$mean

ts.Banamex <- ts(datos_cartera$Banamex, frequency = 12, start = c(2004,1))
plot(ts.Banamex)
ARIMA.Banamex <- auto.arima(ts.Banamex,D=1)
summary(ARIMA.Banamex)
plot(ARIMA.Banamex$x, col="Blue")
par(new=TRUE)
plot(ARIMA.Banamex$fitted,col="red") 
title(main="Real vs Forecast")
Forecast.Banamex<- forecast(ARIMA.Banamex, h=30)
Forecast.Banamex
plot(Forecast.Banamex, main="Pronóstico ARIMA para los próximos 30 meses", xlab="Tiempo", ylab="Valor")
Y_lowest[4,] <- Forecast.Banamex$mean

ts.HSBC <- ts(datos_cartera$HSBC, frequency = 12, start = c(2004,1))
plot(ts.HSBC)
ARIMA.HSBC <- auto.arima(ts.HSBC,D=1)
summary(ARIMA.HSBC)
plot(ARIMA.HSBC$x, col="Blue")
par(new=TRUE)
plot(ARIMA.HSBC$fitted,col="red") 
title(main="Real vs Forecast")
Forecast.HSBC<- forecast(ARIMA.HSBC, h=30)
Forecast.HSBC
plot(Forecast.HSBC, main="Pronóstico ARIMA para los próximos 30 meses", xlab="Tiempo", ylab="Valor")
Y_lowest[5,] <- Forecast.HSBC$mean

Y = S%*%Y_lowest

dim(Y)
S

# Calcular S' y S'S
S_transpose <- t(S)
S_transpose
S_prime_S <- S_transpose %*% S
S_prime_S

# Calcular la inversa de S'S
S_prime_S_inverse <- solve(S_prime_S)
S_prime_S_inverse

# Calcular la expresión jerárquica para cada periodo de pronóstico (30 columnas)
hierarchical_forecast <- S %*% S_prime_S_inverse %*% S_transpose %*% Y

# Mostrar el resultado
T <- t(hierarchical_forecast)
# Crear un archivo Excel y agregar la matriz
wb <- createWorkbook()
addWorksheet(wb, "Sheet1")
writeData(wb, "Sheet1", T)

# Guardar el archivo Excel
saveWorkbook(wb, "C:/Users/Claudia/OneDrive/Documentos/FCFM/04_Tetramestre/Modelo de Negocios/BusinessIntelligence/Caso de Prueba 05/matriz.xlsx", overwrite = TRUE)

#############
## ACTIVOS ##
#############

datos_Activos <- read.xlsx("C:/Users/Claudia/OneDrive/Documentos/FCFM/04_Tetramestre/Modelo de Negocios/BusinessIntelligence/Caso de Prueba 05/Activos.xlsx",
                           sheet="Carga", startRow = 5, colNames = TRUE)

datos_S_Activos <- read.xlsx("C:/Users/Claudia/OneDrive/Documentos/FCFM/04_Tetramestre/Modelo de Negocios/BusinessIntelligence/Caso de Prueba 05/Activos.xlsx",
                     sheet="S", startRow = 1, colNames = FALSE)

S <- as.matrix(datos_S_Activos)
S

Y_lowest = matrix(0, nrow = 10, ncol = 30)

#dato <- datos_Activos$TCACBB
#dato <- datos_Activos$TCACNI
#dato <- datos_Activos$TCACNO
#dato <- datos_Activos$TCAVBB
#dato <- datos_Activos$TCAVNI
#dato <- datos_Activos$TCAVNO
#dato <- datos_Activos$TEBB
#dato <- datos_Activos$TENI
#dato <- datos_Activos$TENO
#dato <- datos_Activos$TENE

ts <- ts(dato, frequency = 4, start = c(1992,12))
plot(ts)
ARIMA <- auto.arima(ts,D=1)
summary(ARIMA)
plot(ARIMA$x, col="Blue")
par(new=TRUE)
plot(ARIMA$fitted,col="red") 
title(main="Real vs Forecast")
Forecast<- forecast(ARIMA, h=30)
Forecast
plot(Forecast, main="Pronóstico ARIMA para los próximos 30 meses", xlab="Tiempo", ylab="Valor")
#Y_lowest[1,] <- Forecast$mean
#Y_lowest[2,] <- Forecast$mean
#Y_lowest[3,] <- Forecast$mean
#Y_lowest[4,] <- Forecast$mean
#Y_lowest[5,] <- Forecast$mean
#Y_lowest[6,] <- Forecast$mean
#Y_lowest[7,] <- Forecast$mean
#Y_lowest[8,] <- Forecast$mean
#Y_lowest[9,] <- Forecast$mean
#Y_lowest[10,] <- Forecast$mean

Y = S%*%Y_lowest

dim(Y)

S

# Calcular S' y S'S
S_transpose <- t(S)
S_transpose
S_prime_S <- S_transpose %*% S
S_prime_S

# Calcular la inversa de S'S
S_prime_S_inverse <- solve(S_prime_S)
S_prime_S_inverse

# Calcular la expresión jerárquica para cada periodo de pronóstico (30 columnas)
hierarchical_forecast <- S %*% S_prime_S_inverse %*% S_transpose %*% Y

# Mostrar el resultado
T <- t(hierarchical_forecast)
# Crear un archivo Excel y agregar la matriz
wb <- createWorkbook()
addWorksheet(wb, "Sheet1")
writeData(wb, "Sheet1", T)

# Guardar el archivo Excel
saveWorkbook(wb, "C:/Users/Claudia/OneDrive/Documentos/FCFM/04_Tetramestre/Modelo de Negocios/BusinessIntelligence/Caso de Prueba 05/activos-forecast.xlsx", overwrite = TRUE)


