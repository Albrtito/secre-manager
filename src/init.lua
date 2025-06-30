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

log.print("mymessage")




