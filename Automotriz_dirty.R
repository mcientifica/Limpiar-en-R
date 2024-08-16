
# 1 - Parte 1 -------------------------------------------------------------

# Importar librerías

library(dplyr)
library(stringr)
library(tidyr)
library(readr)


# 1. Importar datasets

ventas <- read_csv("../4. Tydir, stringr y forcats/Automotriz_dirty/ventas_dirty.csv")
clientes <- read_csv("../4. Tydir, stringr y forcats/Automotriz_dirty/clientes_dirty.csv")
modelos <- read_csv("../4. Tydir, stringr y forcats/Automotriz_dirty/modelos_dirty.csv")
comisiones <- read_csv("../4. Tydir, stringr y forcats/Automotriz_dirty/comisiones_dirty.csv")


# Limpieza ----------------------------------------------------------------

# ej 1

clientes <- clientes %>% 
  mutate(
    ProvinciaResidencia = str_to_lower(ProvinciaResidencia),
    ProvinciaResidencia = str_replace_all(ProvinciaResidencia, c(
      "á" = "a", 
      "é" = "e", 
      "í" = "i", 
      "ó" = "o", 
      "ú" = "u"
    )),
    ProvinciaResidencia = str_to_title(ProvinciaResidencia)
  ) 


# ej 2

clientes <- clientes %>% 
  mutate(
    Nacionalidad = str_to_lower(Nacionalidad),
    Nacionalidad = str_replace_all(Nacionalidad, c(
      "á" = "a", 
      "é" = "e", 
      "í" = "i", 
      "ó" = "o", 
      "ú" = "u"
    )),
    Nacionalidad = str_replace_all(Nacionalidad, "[:punct:]", ""),
    Nacionalidad = str_to_upper(Nacionalidad)
  )


# ej 3

clientes <- clientes %>% 
  mutate(
    Genero = str_to_upper(Genero)
  )


# ej 4

ventas <- ventas %>% 
  mutate(
    Estado = str_replace_all(Estado, "[:punct:]+", " "),
    Estado = str_to_title(Estado)
  ) 


# ej 5

clientes <- clientes %>% 
  mutate(
    Nacionalidad = str_replace_na(Nacionalidad, "ES")
  )


# ej 6

clientes <- clientes %>% 
  mutate(
    Estudios = factor(
      Estudios,
      levels = c("Universitario", "PreUniversitario", "Secundario", "Primario")
    )
  )


# ej 7

clientes <- clientes %>% 
  mutate(
    TipoCliente = str_replace_all(TipoCliente, "[:punct:]",""),
    TipoCliente = str_replace_all(TipoCliente, " ",""),
    TipoCliente = str_to_lower(TipoCliente),
    TipoCliente = str_replace_all(TipoCliente, "^nuebo$","nuevo"),
    TipoCliente = str_replace_all(TipoCliente, "ú","u"),
    TipoCliente = str_to_title(TipoCliente),
    TipoCliente = str_replace_all(TipoCliente, "Vip","VIP")
  )


# ej 8

comisiones <- comisiones %>% 
  separate_wider_delim(
    cols  = Coche,
    names = c("Marca", "Modelo"),
    delim = " - "
  ) %>% 
  pivot_longer(
    cols = c(3:27),
    names_to = "Year",
    values_to = "Comision"
  ) %>% 
  separate_wider_delim(
    cols = Comision,
    names = c("ComisionVariable", "ComisionFija"),
    delim = "/"
  ) 
comisiones <- comisiones %>% 
  mutate(
    across(c("Year", "ComisionFija", "ComisionVariable"), as.double)
  )


# ej 9

clientes <- clientes %>% 
  mutate(
    Genero = str_replace_na(Genero,"Otro")
  )



# Análisis ----------------------------------------------------------

# ej 1

ventas %>% 
  left_join(modelos, by = "IdModelo") %>% 
  left_join(comisiones, by = c("Modelo", "Marca", "Year")) %>%
  mutate(
    ComisionTotal = ComisionFija + Precio * ComisionVariable
  ) 


# ej 2

ventas %>% 
  left_join(clientes) %>% 
  filter(str_sub(Nombre, 1, 1) %in% c("s","S") & str_sub(Nombre, -1, -1) %in% c("s","S")) %>% 
  left_join(modelos, by = "IdModelo") %>% 
  left_join(comisiones, by = c("Modelo", "Marca", "Year")) %>%
  mutate(
    ComisionTotal = ComisionFija + Precio * ComisionVariable
  ) %>% 
  summarise(
    Total_comision = sum(ComisionTotal)
  )


# ej 3

ventas %>% 
  left_join(modelos, by = "IdModelo") %>% 
  left_join(comisiones, by = c("Modelo", "Marca", "Year")) %>%
  mutate(
    ComisionTotal = ComisionFija + Precio * ComisionVariable
  ) %>% 
  group_by(Marca, Modelo) %>% 
  summarise(ComisionTotal = sum(ComisionTotal)) %>% 
  pivot_wider(
    names_from = Modelo,
    values_from = ComisionTotal
  )


# ej 4

ventas %>% 
  left_join(clientes, by = "IdCliente") %>% 
  left_join(modelos, by = "IdModelo") %>% 
  group_by(Marca, Genero) %>% 
  summarise(Cantidad = n()) %>% 
  pivot_wider(
    names_from = Genero,
    values_from = Cantidad
  )


# ej 5

ventas %>% 
  left_join(clientes, by = "IdCliente") %>% 
  left_join(modelos, by = "IdModelo") %>% 
  group_by(Marca, Modelo, Genero) %>% 
  summarise(Facturado = sum(Precio)) %>% 
  pivot_wider(
    names_from = Genero,
    values_from = Facturado
  )


# ej 6

clientes %>% 
  separate_wider_delim(
    cols = Nombre,
    names = c("Apellido", "Nombre"),
    delim = ", "
  ) %>% 
  unite(
    "NombreCompleto",
    Nombre,
    Apellido,
    sep = ", "
  )


# ej 7 - se podía interpretar que el nombre era columna Nombre o lo calculado en el ej anterior

ventas %>% 
  left_join(clientes) %>% 
  mutate(
    primera_letra = case_when(
      str_to_lower(str_sub(Nombre, 1, 1)) %in% c("a", "e", "i", "o", "u") ~ "Vocal",
      TRUE ~ "Consonante"
    ) 
  ) %>%
  group_by(primera_letra) %>% 
  summarise(
    Cantidad = n()
  )



# Extras ------------------------------------------------------------------

# me guardo tabla con nombres y apellidos para simplificar
clientes <- clientes %>%
  separate_wider_delim(
    cols  = Nombre, 
    names = c("Nombre", "Apellido"), 
    delim = ", "
  )


# ej 1 --------------------------------------------------------------------

clientes %>% 
  filter(str_detect(Nombre,pattern = "^[Aa]"))


# ej 2 --------------------------------------------------------------------

ventas %>% 
  left_join(clientes) %>% 
  filter(str_detect(Nombre,pattern = "^[Ee]")) %>% 
  summarise(Cantidad = n())


# ej 3 --------------------------------------------------------------------

clientes %>% 
  filter(str_detect(Apellido,pattern = "[:blank:]")) %>%  # si tiene un espacio en blanco es porque tiene 2 o más apellidos
  summarise(Cantidad = n())
  

# ej 4 --------------------------------------------------------------------

clientes %>% 
  filter(str_detect(Nombre,pattern = "[:blank:]") & str_detect(Apellido,pattern = "[:blank:]")) %>% 
  summarise(Cantidad = n())


# ej 5 --------------------------------------------------------------------
clientes %>% 
  mutate(
    Nombre = str_replace(Nombre, "[:blank:]", ""), # elimino espacios en blanco del nombre
    Apellido = str_replace(Apellido, "[:blank:]", ""), # elimino espacios en blanco del apellido
  ) %>% 
  filter(str_length(Nombre) == str_length(Apellido))


# ej 6 --------------------------------------------------------------------

clientes %>% 
  filter(str_detect(Nombre,pattern = "[:punct:]") & str_detect(Apellido,pattern = "[:punct:]")) %>% 
  summarise(Cantidad = n())
  
  
# ej 7 --------------------------------------------------------------------

clientes %>% 
  mutate(
    Vocales = str_count(tolower(Nombre), "[aeiou]") + str_count(tolower(Apellido), "[aeiou]")
  )


# ej 8 --------------------------------------------------------------------
# opcion 1
clientes %>% 
  filter(
    !str_sub(str_to_lower(ProvinciaResidencia), 1, 1) %in% c("a", "e", "i", "o", "u") &
    !str_sub(str_to_lower(ProvinciaResidencia), -1, -1) %in% c("a", "e", "i", "o", "u")
  ) %>% 
  distinct(ProvinciaResidencia)

# opcion 2
clientes %>% 
  filter(
    str_detect(str_to_lower(ProvinciaResidencia), "^[^aeiou](.)+[^aeiou]$") 
  ) %>% 
  distinct(ProvinciaResidencia)


# ej 9 --------------------------------------------------------------------
clientes %>% 
  distinct(ProvinciaResidencia) %>% 
  mutate(
    ProvinciaResidencia_sin_vocales = str_replace(ProvinciaResidencia, "[:blank:]", ""), # elimino espacios en blanco
    Vocales = str_count(tolower(ProvinciaResidencia), "[aeiou]"), # cuento vocales
    Consonantes = str_length(ProvinciaResidencia_sin_vocales) - Vocales # todo lo que no sean vocales, son consonantes
  ) %>% 
  select(ProvinciaResidencia, Vocales, Consonantes) %>% 
  filter(Vocales > Consonantes)
