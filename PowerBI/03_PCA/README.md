# Detección de anomalías para prevención de lavado de dinero 🔎

Proyecto académico desarrollado durante la **Maestría en Ciencia de Datos** para explorar transacciones financieras e identificar **anomalías, inconsistencias y patrones atípicos** mediante técnicas de aprendizaje no supervisado.

El proyecto combina el análisis realizado en **R** mediante **Principal Component Analysis (PCA), K-Means y Neural Gas** con un dashboard desarrollado en **Power BI**, permitiendo explorar los resultados y analizar las características asociadas a los comportamientos detectados.

## Objetivo

Analizar el comportamiento de las transacciones mediante técnicas de reducción de dimensionalidad y clustering para identificar estructuras, agrupaciones y observaciones atípicas que puedan servir como apoyo en procesos de prevención de lavado de dinero.

---

# Dashboard

## Detección de lavado de dinero

<p align="center">
  <img src="Detección de lavado de dinero.PNG" width="900">
</p>

La vista permite explorar visualmente las **anomalías e inconsistencias** identificadas y analizar qué características presentan una mayor importancia dentro de cada grupo.

---

## Análisis de características importantes

<p align="center">
  <img src="Análisis de Características Importantes.PNG" width="900">
</p>

Esta vista presenta una descripción general de las transacciones analizadas y permite explorar la distribución de diferentes características de las operaciones.

Entre los indicadores principales se observan:

* **27,751 transacciones analizadas.**
* **2,360 observaciones clasificadas como anomalías o inconsistencias.**

También se muestran características relacionadas con el perfil de las operaciones, como nacionalidad, municipio de residencia, tiempo de relación comercial, condición de persona políticamente expuesta, actividad económica e instrumento monetario.

---

## Problema de análisis

Las instituciones financieras manejan grandes volúmenes de transacciones con múltiples características asociadas a clientes, productos y operaciones.

El proyecto busca explorar:

* ¿Existen observaciones con comportamientos diferentes al resto de las transacciones?
* ¿Qué características tienen mayor importancia dentro de las anomalías?
* ¿Qué variables destacan en las inconsistencias detectadas?

---

## Flujo del proyecto

### 1. Preparación de datos

La información se prepara para su análisis y las variables son utilizadas como entrada para los modelos de aprendizaje no supervisado.

Para el análisis mediante PCA se realiza el centrado y escalado de los datos con el objetivo de evitar que las diferencias de escala entre variables dominen el análisis.

### 2. Principal Component Analysis (PCA)

Se aplica **Principal Component Analysis (PCA)** para transformar las variables originales en un nuevo conjunto de componentes principales.

```r
PCA <- prcomp(
    x = BaseAumentada,
    center = TRUE,
    scale. = TRUE
)
```

A partir del modelo se obtienen diferentes componentes principales que permiten representar las observaciones en un espacio de menor dimensionalidad y explorar visualmente su estructura.


### 3. Clustering con K-Means

Como parte del análisis no supervisado se utiliza **K-Means** para segmentar las observaciones.

```r
kMEANS <- kmeans(
    BaseAumentada,
    centers = 3,
    nstart = 20,
    iter.max = 10
)
```

El modelo divide las observaciones en **tres clusters**, permitiendo analizar grupos con características similares.

### 4. Neural Gas

El análisis se complementa utilizando el algoritmo **Neural Gas**, también configurado para generar tres agrupaciones utilizando distancia euclidiana.

```r
NG <- cclust(
    BaseAumentadaM,
    centers = 3,
    dist = "euclidean",
    method = "neuralgas"
)
```

### 5. Visualización en Power BI

Los resultados del análisis se integraron en **Power BI** mediante dos vistas principales.

#### Detección de lavado de dinero

Incluye:

* Visualización de anomalías.
* Visualización de inconsistencias.
* Importancia de características en las anomalías.
* Importancia de características en las inconsistencias.

#### Análisis de características importantes

Incluye:

* Total de transacciones analizadas.
* Total de anomalías e inconsistencias.
* Características relevantes del perfil analizado.
* Distribución por municipio de operación.
* Sentido de operatividad.
* Canal de transacción.
* Divisa.
* Fuente de ingresos.
* Tipo de operación.
* Edad.
* Segmento.
* Tipo de producto.
* Tipo de subproducto.

---

## Principales resultados

El análisis permitió identificar **2,360 anomalías e inconsistencias dentro de 27,751 transacciones**, equivalentes aproximadamente al **8.5 % de las observaciones analizadas**.

En las **anomalías**, las características que muestran mayor importancia son:

1. Nacionalidad.
2. Municipio de residencia.
3. Tiempo de relación.
4. Municipio de operación.
5. Persona políticamente expuesta.

En las **inconsistencias**, destacan principalmente:

1. Edad.
2. Operabilidad.
3. Actividad.
4. Fuente de ingresos.
5. Producto.

Estos resultados permiten identificar variables relevantes para la exploración de patrones atípicos y priorizar observaciones que podrían requerir un análisis adicional.

> **Nota:** las anomalías identificadas representan patrones estadísticos inusuales dentro de los datos y no implican, por sí mismas, la existencia de operaciones de lavado de dinero.

---

## Tecnologías utilizadas

* **R**
* **Principal Component Analysis (PCA)**
* **K-Means**
* **Power BI**

---


## Autora

**Claudia Lissette Gutiérrez Díaz**

Proyecto desarrollado durante la **Maestría en Ciencia de Datos** en la Facultad de Ciencias Físico Matemáticas de la Universidad Autónoma de Nuevo León.
