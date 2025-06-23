--[[ 
Módulo principal, desde aquí se hacen las llamadas y se utilizan los valores calculados por el resto de módulos.
--]]

-- Datos importantes
local config = require("config")
-- Servicios de organizacin
local org = require("organizador")
-- Servicios de log (aux)
local log = require("logger")
-- Servicios de generacion de archivos
local gen = require("generador")
-- Utilidades varias 
local utils = require("utils")

--print(utils.obt_ronda_solar())

--print("config: " .. utils.dump_table(config))
