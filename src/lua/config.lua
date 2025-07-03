--[[
Valores de configuracion del servicio
--]]

local utils = require("lua.utils")

-- Direccion del archivo init.lua
local path = os.getenv("PWD")

-- Ensure path ends with a slash and handle the case where we're already in src directory
local function normalize_path(p)
	-- Remove trailing slash if present
	p = p:gsub("/$", "")

	-- If we're in the src directory, go up one level
	if p:match("/src$") then
		p = p:gsub("/src$", "")
	end

	-- Add trailing slash
	return p .. "/"
end

local config = {

	-- paths
	path_sm = normalize_path(path),
	-- Direccion de la carpeta de sensible

	path_sensible = path .. "/../../../Shared drives/00. Sensible/",
	-- Dirección a la carpeta de la docu de educandos
	path_edu = "/Users/tito/Library/CloudStorage/GoogleDrive-secretaria@scouts217.com/Shared drives/00. Sensible/00-DocumentacionEducandos",
	-- Dirección a la carpeta de logs
	path_logs = path .. "/logs/",

	-- cuentas mail
	mail_secre = "secretaria@scouts217.com",
	mail_1 = "alb.pascau@gmail.com",

	-- otros
	ronda_solar = utils.get_ronda_solar(),
    
    -- BUG: Error en el patrón, admite cosa como ACP-ALbertoPAscauSAez.pdf
	-- Patrón que siguen los nombres de cada archivo
	patron = "^[a-zA-Z0-9]*%-[A-Z][a-zA-Z0-9]*%.[a-zA-Z0-9]+$",
}

return config
