--[[ 
Módulo principal, desde aquí se hacen las llamadas y se utilizan los valores calculados por el resto de módulos.
--]]
-- Datos importantes
local config = require("lua.config")
-- Servicios de organizacin
local org = require("lua.organizador")
-- Servicios de log (aux)
local log = require("lua.logger")
-- Servicios de generacion de archivos
local gen = require("lua.generador")
-- Utilidades varias 
local utils = require("lua.utils")

-- Inicialización del programa, nuevo log
log.clear()

-- Se comprueba que los paths a la carpeta de sensible y documentación de educandos son válidos
log.log("Checking for path existances")
if utils.path_exists(config.path_sensible) then
    log.log("Path for 00.SENSIBLE checked")
else
    log.log("Path for 00.SENSIBLE NOT found")
end
if utils.path_exists(config.path_edu) then
    log.log("Path for 00.SENSIBLE/DOCU_EDUCANDOS checked")
else
    log.log("Path for 00.SENSIBLE/DOCU_EDUCANDOS NOT found")
end

