
# ==========================================
# LIBRO DE CAMPO - FACTORIAL EN DBCA
# Cultivo: Papa (Solanum tuberosum L.)
# Curso: Programacion y Analisis de Datos
# ==========================================

# 1. Cargar el paquete inti
library(inti)

# 2. Definir los factores experimentales

# Factor A: Variedades de papa
variedad <- c("V1", "V2", "V3")

# Factor B: Dosis de fertilizacion
dosis <- c("D1", "D2")

# 3. Definir el numero de bloques
bloques <- 3

# 4. Crear las combinaciones factoriales
tratamientos <- expand.grid(
  variedad = variedad,
  dosis = dosis
)

# 5. Asignar codigos a los tratamientos
tratamientos$tratamiento <- paste0(
  "T", seq_len(nrow(tratamientos))
)

# 6. Mostrar la tabla de tratamientos
print(tratamientos)

# 7. Calcular el numero de parcelas
n_tratamientos <- nrow(tratamientos)
n_parcelas <- n_tratamientos * bloques

cat("Numero de tratamientos:", n_tratamientos, "\n")
cat("Numero de bloques:", bloques, "\n")
cat("Total de parcelas:", n_parcelas, "\n")


# ==========================================
# 8. GENERAR EL DISEÑO FACTORIAL EN DBCA
# ==========================================

# Definir los factores para inti
factores <- list(
  variedad = c("V1", "V2", "V3"),
  dosis = c("D1", "D2")
)

# Crear el diseño experimental
fb <- design_repblock(
  nfactors = 2,
  factors = factores,
  type = "rcbd",
  rep = 3,
  zigzag = FALSE,
  nrows = 3,
  seed = 123,
  project = "DBCA_PAPA"
)

# Extraer el libro de campo
libro_campo <- fb$fieldbook

# Mostrar el libro de campo
print(libro_campo)

# Abrir la tabla para visualizarla
View(libro_campo)


# ==========================================
# 9. GUARDAR EL LIBRO DE CAMPO
# ==========================================

# Exportar el libro de campo a CSV
write.csv(
  libro_campo,
  file = "Libro_Campo_DBCA_Papa.csv",
  row.names = FALSE
)

# Confirmar que se guardo
file.exists("Libro_Campo_DBCA_Papa.csv")


# ==========================================
# 10. CROQUIS EXPERIMENTAL DEL DBCA
# ==========================================

# Generar el croquis con inti
croquis <- tarpuy_plotdesign(
  data = fb,
  factor = "variedad",
  fill = c("ntreat", "plots")
)

# Mostrar el croquis
print(croquis)


# ==========================================
# 11. GUARDAR EL CROQUIS EXPERIMENTAL
# ==========================================

# Guardar el croquis en formato PNG
ggplot2::ggsave(
  filename = "Croquis_DBCA_Factorial_Papa.png",
  plot = croquis,
  width = 12,
  height = 7,
  dpi = 300,
  bg = "white"
)

# Verificar que la imagen se guardo
file.exists("Croquis_DBCA_Factorial_Papa.png")


# ==========================================
# 12. CREAR EL ARCHIVO README
# ==========================================

readme <- c(
  "# Libro de campo: Diseño factorial en DBCA",
  "",
  "## Descripción",
  "Diseño experimental para evaluar tres variedades",
  "de papa y dos niveles de fertilización, mediante",
  "un Diseño de Bloques Completos al Azar (DBCA).",
  "",
  "## Características del experimento",
  "- Cultivo: Papa (Solanum tuberosum L.)",
  "- Factor A: 3 variedades (V1, V2, V3)",
  "- Factor B: 2 dosis de fertilización (D1, D2)",
  "- Tratamientos: 6",
  "- Bloques: 3",
  "- Parcelas experimentales: 18",
  "",
  "## Herramientas utilizadas",
  "- R y RStudio",
  "- Paquete inti",
  "",
  "## Archivos del proyecto",
  "- 01_diseno_factorial_papa.R: código fuente.",
  "- Libro_Campo_DBCA_Papa.csv: libro de campo.",
  "- Croquis_DBCA_Factorial_Papa.png: croquis.",
  "- DBCA_Factorial_Papa.Rproj: proyecto RStudio.",
  "",
  "## Nota",
  "Ejercicio académico de planificación experimental.",
  "No contiene resultados reales de rendimiento."
)

writeLines(readme, "README.md", useBytes = TRUE)

file.exists("README.md")
