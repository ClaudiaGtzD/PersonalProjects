rm(list=ls())

library(openxlsx, quietly = TRUE)
library(Hmisc, quietly = TRUE)
library(scales)
library(officer)
library(flextable)
library(Distance)
library(cluster)
library(ClusterR)
library(fpc)
library(plotly)
library(scatterplot3d)
library(kohonen)
library(cclust)
set.seed(100)

################################################################################
#STEP 0. UPLOAD DATA BASE AND ROUTES.

ruta.1 <- "C:/Users/Claudia/OneDrive/Documentos/FCFM/04_Tetramestre/Modelo de Negocios/BusinessIntelligence/Caso de Prueba 02/AumentadaPFLD.csv"
BaseAumentada <- read.csv(ruta.1, header=TRUE, sep=",")


################################################################################
#STEP 4. ANALISIS DE COMPONENTES PRINCIPALES

PCA <- prcomp(x = BaseAumentada, center = TRUE, scale. = TRUE)

summary(PCA)

PCs <- data.frame(
  PC1=PCA[["x"]][,1],
  PC2=PCA[["x"]][,2],
  PC3=PCA[["x"]][,3],
  PC29=PCA[["x"]][,29],
  PC30=PCA[["x"]][,30]
)

plot(x = PCs$PC1, y=PCs$PC2)
scatterplot3d(x = PCs$PC1, y=PCs$PC2, z = PCs$PC3)
plot(x = PCs$PC29, y=PCs$PC30)
plot(x = PCs$PC1, y=PCs$PC30)

# Calcular la reconstrucción a partir de las componentes principales
df_pca <- PCA$x
df_reconstructed <- df_pca %*% t(PCA$rotation)
df_reconstructed <- scale(df_reconstructed, center = -BaseAumentada, scale = 1/BaseAumentada)

# Calcular el error de reconstrucción
reconstruction_error <- rowMeans((BaseAumentada - df_reconstructed)^2)


################################################################################
################################################################################
################################################################################
################################################################################
#STEP 5. K MEANS

kMEANS <- kmeans(BaseAumentada, centers = 3, nstart = 20,iter.max = 10)
kMEANS
Clusters<-data.frame(Cluster=kMEANS$cluster)
Centroides<-data.frame(Centroides=kMEANS$centers)


################################################################################
################################################################################
################################################################################
################################################################################
#STEP 6. NEURAL GAS

BaseAumentadaM<-as.matrix(BaseAumentada)

NG=cclust(BaseAumentadaM,centers=3,dist="euclidean", method= "neuralgas")
NG

Centroides<-data.frame(Centroide=NG$centers)
Clusters<-data.frame(Clusters=NG$cluster) 


