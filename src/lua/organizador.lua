--[[
Modulo de organizacion de archivos, da el servicio principal de organizar_archivo, verificando su formato y metiéndolo en la carpeta correspondiente de la ronda solar seleccionada
--]]
local utils = require("lua.utils")
local config = require("lua.config")
local logger = require("lua.logger")
local organizador = {}

-- Función para obtener el nombre de un fichero dado un path completo a el
local function get_file_name(file)
	return file:match("[^/]*.[a-z]*$")
end

-- Función para validar el nombre de un archivo según el patron guardado en config
-- @return: -1 en caso de que el nombre no sea válido, 1 en caso de que lo sea
function organizador.validar_nombre(nombre)
	if string.match(nombre, config.patron) then
		logger.log("El archivo " .. nombre .. " cumple el formato estandar")
		return 1
	else
		logger.log("El archivo " .. nombre .. " NO CUMPLE el formato estandar")
		return -1
	end
end

-- WARNING: Sin terminar
-- Servicio de organización de un archivo en las carpetas de la ronda solar seleccionada
-- @param: Path del archivo a organizar
-- @param: Varianza de la ronda solar actual a la que se quiere utilizar (si estamos en 2025 y queremos hace cinco rondas la varianza será 5)
-- @return: Deuelve 0 si todo ha ocurrido correctamente, -1 si hay un error en el nombre del archivo, -2 para otro tipo de errores
function organizador.organizar_archivo(path, varianza)
	-- Verificación de parámetros
	if varianza == nil then
		local ronda_solar = utils.get_ronda_solar()
	else
		local ronda_solar = utils.get_ronda_solar(varianza)
	end

	if not utils.path_exists(path) then
		logger.dlog(path .. " No es un path válido, el archivo no existe en esta dirección")
		return -1
	end

	-- Validacion del nombre del archivo
	local nombre_archivo = get_file_name(path)
	if organizador.validar_nombre(nombre_archivo) ~= 1 then
		logger.dlog(nombre_archivo .. " El nombre del archivo no cumple el formato estandar")
		return -1
	end
end

return organizador
