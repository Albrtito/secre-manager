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
-- Servicio de organización de los archivos en las carpetas de la ronda solar seleccionada
-- @param: Path a la carpeta de archivos a seleccionar, si no se inserta nada será la tmp de esta ronda
-- @param: Varianza de la ronda solar actual a la que se quiere utilizar (si estamos en 2025 y queremos hace cinco rondas la varianza será 5)
-- @return: Deuelve 0 si todo ha ocurrido correctamente, -1 si hay un error en el nombre de algún archivo, -2 para otro tipo de errores
-- @return: Devuelve una tabla con el error para cada archivo si lo hubiera
function organizador.organizar_archivos(path, varianza)
	local out_table = {}
	local out_code = 0
	local ronda_solar
	-- Verificación de parámetros
	if varianza == nil then
		ronda_solar = utils.get_ronda_solar()
	else
		ronda_solar = utils.get_ronda_solar(varianza)
	end

	if path == nil then
		path = config.path_edu .. "/" .. ronda_solar .. "/tmp/"
	end

	if not utils.path_exists(path) then
		logger.dlog(path .. " No es un path válido")
		out_code = -2
        return out_code, nil
	end

	-- Ir rotando por todos los archivos de la carpeta
	local archivos = utils.list_files(path, true)
	for index, path_archivo in ipairs(archivos) do
		local nombre_archivo = get_file_name(path_archivo)
		if organizador.validar_nombre(nombre_archivo) ~= 1 then
			logger.dlog(path_archivo .. " El nombre del archivo no cumple el formato estandar")
			out_code = -1
			table.insert(out_table, nombre_archivo .. " ERROR")
		else
			table.insert(out_table, nombre_archivo .. " OK")
		end
	end

	return out_code, out_table
end

return organizador
