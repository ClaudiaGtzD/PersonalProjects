# Clasificación multietiqueta de géneros de películas a partir de pósteres 🎬

Proyecto académico desarrollado durante la **Maestría en Ciencia de Datos** para explorar si una red neuronal convolucional puede identificar uno o varios géneros de una película utilizando únicamente su póster publicitario.

El problema se aborda como una **clasificación multietiqueta**, ya que una película puede pertenecer simultáneamente a categorías como *Action*, *Adventure* y *Drama*.

## Objetivo

Construir y comparar distintas arquitecturas CNN para predecir 15 géneros cinematográficos a partir de imágenes de pósteres.

## Flujo del proyecto

### 1. Descarga de información

El notebook `1_Descarga de películas omdb.ipynb` consulta la API de OMDb utilizando identificadores de IMDb.

Durante la descarga se conservan registros que cumplen con los siguientes criterios:

- Tipo de contenido: película.
- Año de estreno igual o posterior a 1970.
- Idioma inglés.
- Póster disponible.
- Género válido.
- Exclusión inicial de contenido Adult, Documentary, Short y Biography.

Los registros aceptados se almacenan en `movies.csv`. También se mantiene una lista de identificadores consultados para evitar repetir solicitudes.

### 2. Preprocesamiento

El notebook `2_Preprocesamiento.ipynb`:

- Conserva las columnas `imdbID`, `Genre` y `Poster`.
- Elimina registros duplicados.
- Descarta géneros con poca representación o fuera del alcance del estudio.
- Convierte los géneros a variables binarias mediante codificación multi-hot.
- Descarga los pósteres desde sus URL.
- Redimensiona las imágenes a **250 × 250 píxeles**.
- Elimina registros cuyos pósteres no pudieron descargarse o procesarse.

El conjunto final contiene **47,756 películas** y **15 etiquetas de género**:

`Action`, `Adventure`, `Animation`, `Comedy`, `Crime`, `Drama`, `Family`, `Fantasy`, `Horror`, `Music`, `Mystery`, `Romance`, `Sci-Fi`, `Sport` y `Thriller`.

El archivo generado es `Películas con imagen.csv`.

## Modelos evaluados

Los tres notebooks de modelado utilizan:

- Imágenes RGB de `250 × 250`.
- División de entrenamiento y prueba de 80/20.
- Función de pérdida `binary_crossentropy`.
- Optimizador `Adam`.
- Activación `ReLU` en capas internas.
- Activación `sigmoid` en la salida de 15 neuronas.
- Evaluación con diferentes umbrales de decisión.

### Método 1: CNN base

Archivo: `3_Modelo CNN Método 1.ipynb`

Arquitectura:

- 4 capas convolucionales con 16, 32, 64 y 128 filtros.
- 4 capas de Max Pooling.
- 1 capa Flatten.
- Capas densas de 64 y 128 neuronas.
- Salida multietiqueta de 15 neuronas.
- Datos originales sin balanceo.
- Batch size de 20.
- Máximo de 15 épocas.

### Método 2: CNN con balanceo de clases

Archivo: `3_Modelo CNN Método 2.ipynb`

Utiliza la misma arquitectura base del Método 1, pero crea una muestra balanceada mediante muestreo con reemplazo para aumentar la representación de los géneros minoritarios.

- Conjunto balanceado: **21,730 registros**.
- Batch size de 25.
- Máximo de 15 épocas.
- Genera el archivo `Películas Oversampling.csv`.

### Método 3: CNN con regularización

Archivo: `3_Modelo CNN Método 3.ipynb`

Añade a la arquitectura:

- Batch Normalization.
- Dropout de 0.3.
- Early Stopping.
- Reducción automática del learning rate.
- Limpieza de memoria al finalizar cada época.

Este método utiliza los datos originales sin balanceo. El batch size no se especifica explícitamente, por lo que se utiliza el valor predeterminado de Keras.

## Resultados

La siguiente tabla muestra el mejor **F1-score micro** observado en cada notebook:

| Método | Umbral | Accuracy | Precision micro | Recall micro | F1 micro |
|---|---:|---:|---:|---:|---:|
| Método 1 | 0.10 | 0.026 | 0.274 | 0.500 | 0.354 |
| Método 2 | 0.50 | 0.549 | 0.735 | 0.654 | **0.692** |
| Método 3 | 0.20 | 0.049 | 0.368 | 0.541 | 0.438 |

> En este problema, `accuracy` corresponde a la exactitud estricta del conjunto completo de etiquetas: una predicción solo se considera correcta cuando todas las etiquetas coinciden.

El **Método 2** obtuvo el mejor desempeño general, lo que muestra la relevancia del tratamiento del desbalance de clases en problemas multietiqueta.

## Tecnologías utilizadas

- Python
- Pandas
- NumPy
- Requests
- Pillow
- Matplotlib
- Scikit-learn
- TensorFlow
- Keras
- Google Colab

## Ejecución

Orden recomendado:

1. Ejecutar `1_Descarga de películas omdb.ipynb`.
2. Ejecutar `2_Preprocesamiento.ipynb`.
3. Ejecutar los notebooks de los métodos CNN.
4. Comparar las métricas para los diferentes umbrales.

Los notebooks contienen rutas locales de Windows y Google Drive, por lo que deben adaptarse al entorno donde se ejecuten.

También se requiere una clave de la API de OMDb. Por seguridad, la clave debe cargarse desde una variable de entorno.

## Limitaciones

- El entrenamiento requiere una cantidad considerable de memoria RAM.
- Los resultados dependen del diseño visual y de la calidad de los pósteres.
- Algunos géneros tienen características visuales similares, por ejemplo, Horror y Thriller.
- El muestreo con reemplazo se realiza antes de dividir entrenamiento y prueba; una mejora importante sería separar primero los datos y aplicar el balanceo únicamente al conjunto de entrenamiento.
- Algunos procesos no fijan una semilla aleatoria, por lo que los resultados pueden variar entre ejecuciones.

## Posibles mejoras

- Aplicar transferencia de aprendizaje con modelos como ResNet, EfficientNet o MobileNet.
- Realizar el balanceo únicamente sobre el conjunto de entrenamiento.
- Ajustar un umbral diferente para cada género.
- Utilizar validación estratificada multietiqueta.
- Guardar el mejor modelo y crear una función de inferencia para nuevos pósteres.
- Incorporar información textual, como título, sinopsis o reparto, para construir un modelo multimodal.
- Configurar rutas relativas y un archivo de dependencias para facilitar la reproducción.

## Autora

**Claudia Lissette Gutiérrez Díaz**

Proyecto desarrollado en la Facultad de Ciencias Físico Matemáticas de la Universidad Autónoma de Nuevo León.
