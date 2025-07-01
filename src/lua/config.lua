--[[
Valores de configuracion del servicio
--]]

local utils = require("lua.utils")

-- Direccion del archivo init.lua
local path = os.getenv("PWD")

local config = {

	-- paths
	-- Direccion de la carpeta de sensible
	path_sensible = path .. "/../../../Shared drives/00. Sensible/",
	-- Dirección a la carpeta de la docu de educandos
	path_edu = path .. "/../../../Shared drives/00. Sensible/00-Documentacion-educandos/",
	-- Dirección a la carpeta de logs
	path_logs = path .. "/logs/",

	-- cuentas mail
	mail_secre = "secretaria@scouts217.com",
	mail_1 = "alb.pascau@gmail.com",

	-- otros
	ronda_solar = utils.get_ronda_solar(),

	-- Patrón que siguen los nombres de cada archivo
	patron = "^[a-z][a-zA-Z0-9]*%-[A-Z][a-zA-Z0-9]*%.[a-zA-Z0-9]+$",
}

return config
