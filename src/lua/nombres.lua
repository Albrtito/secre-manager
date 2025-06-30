--[[
Este módulo contiene un diccionario con la letra
que toma cada una de las palabras que debe de tener el nombre
de un archivo. Es decir, si un archivo tiene que llamarse
Autorizacion Campamento de Primavera Año entonces este módulo genera el nombre
del archivo según su lógica interna. Por ejemplo, en el caso anterior podría
ser que convierta Autorizacion en A, Campamento en C, se salte el de, Primavera en P y
el año lo ponga automáticamente.  -> Creación de nombre según lo que tu le digas.

Además de dar los nombres correctos según el estandar definido también se encarga de hacer
una estandarización de todos los archivos para que tengan el mismo formato. Este formato será:

nombreDelArchivo-NombreDelEducando.extension

Cosas importantes:
- Sin tildes
- Sin espacios
- Único espacio por - , diferencia el nombre del archivo del de el educando.
- Formato camelCase
--]]

local nombres = {}

-- Función para saber si un archivo esta o no bien nombrado
function nombres.verificar_nombre(nombre) end

return nombres
