# Limpiar-en-R
Empresa Automotriz
La empresa NeoCar se dedica a la venta de autos nuevos y de segunda mano. Cuenta con la 
información de la base de clientes, ventas, comisiones y modelos para responder las siguientes 
preguntas. Podrá utilizar cualquier función que se encuentre en dplyr o tidyr. Este es un caso 
de uso más real dado que muchas veces la información no viene en el formato deseado:
Limpiar data
1. En tabla clientes, cambiar la columna Provincia para que no haya provincias iguales 
escritas de forma diferente (ej: con y sin tilde, mayúsculas, caracteres especiales, etc).
2. En tabla clientes, cambiar la columna Nacionalidad para que no haya nacionalidades 
iguales escritas de forma diferente.
3. En tabla clientes, cambiar la columna Genero para que no haya géneros iguales 
escritos de forma diferente.
4. En tabla Ventas, cambiar la columna Estado para que no haya estados iguales escritos 
de forma diferente.
5. En tabla clientes, reemplazar todos los valores faltantes en columna nacionalidad para 
que sean de nacionalidad española (ES).
6. En tabla clientes, convertir columna Estudios en un factor para que el orden sea el 
siguiente: Universitario, Preuniversitario, Secundario, Primario.
7. En tabla clientes, convertir columna TipoCliente en un factor para que el orden sea el 
siguiente: VIP, Nuevo, Comun. Verificar que no haya errores de carga.
8. Transformar la tabla Comisiones para que quede con el siguiente formato de 
columnas:
a. Marca
b. Modelo
c. Year (año de fabricación de vehículo)
d. ComisionVariable
e. ComisionFija
9. En tabla clientes, reemplazar todos los valores faltantes en columna genero para que 
sean “Otro”.
Análisis
1. Agregar una columna a la tabla Ventas que sea la comisión calculada como 
“ComisionFija + Precio * ComisionVariable”.
2. Calcular la comisión generada por Clientes cuyo nombre comience y termine con la 
letra “s”.
3. Armar una tabla con las comisiones que tenga en filas la marca de los vehículos y en 
columnas la comisión generada por Modelo.
4. Armar una tabla que muestre la cantidad de vehículos vendidos. En filas tendrá las 
marcas y en columnas el género.
5. Armar un cuadro que muestre en filas la Marca y el Modelo y en columnas el nivel de 
Estudios alcanzado que muestre el total facturado.
6. Generar una columna que sea Nombre Completo que muestre primero el/los 
nombres, seguido de un espacio, y después el/los apellidos.
7. Agrupar los clientes en función de si su nombre empieza con vocal o no y contar 
cuántos coches compró cada grupo.
Extras
1. Contar las unidades vendidas clientes cuyo apellido empiece con la letra “A”.
2. Contar la cantidad de vehículos Toyota vendidos a clientes cuyo nombre empiece con 
la letra “E”.
3. Contar cuántos clientes VIP tienen 2 o más apellidos.
4. Contar cuántos clientes tienen 2 o más nombres y 2 o más apellidos.
5. Contar cuántos clientes tienen la misma cantidad de caracteres en su nombre y en su 
apellido (no cuentan los espacios entre nombres).
6. Contar cuántos clientes tienen algún carácter especial en su nombre y en su apellido.
7. Generar una columna que cuente la cantidad de vocales que tiene una persona entre 
su nombre y su apellido.
8. Buscar las provincias que comiencen y terminen con consonantes.
9. Buscar las provincias que tengan más vocales que consonantes.
