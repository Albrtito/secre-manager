local lfs = require("lfs")

local utils = {}

-- WARNING: This function is not tested for the varianza
function utils.get_ronda_solar(varianza)
	if varianza == nil then
		varianza = 0
	end
	local ronda_actual = os.date("%Y") - varianza - 1 .. "-" .. (os.date("%Y") - varianza)
	if tonumber(os.date("%m")) >= 9 then
		ronda_actual = os.date("%Y") - varianza .. "-" .. os.date("%Y") - varianza + 1
	end
	return ronda_actual
end

function utils.dump_table(o)
	if type(o) == "table" then
		local s = "{\n"
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. utils.dump_table(v) .. ",\n"
		end
		return s .. "\n} "
	else
		return tostring(o)
	end
end

-- WARNING: Not tested
-- Check if a file or directory exists in this path
function utils.path_exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

-- Función para enumerar todos los ficheros bajo un directorio dado como argumento.
-- @param directory: Directorio a explorar (opcional, por defecto PWD)
-- @param r: Si es true, busca recursivamente en subdirectorios (opcional, por defecto false)
-- @return: Devuelve una tabla con todos los ficheros
function utils.list_files(directory, r)
	if r == nil then
		r = false
	end

	if directory == nil then
		directory = os.getenv("PWD")
	end

	local files = {}

	for filename in lfs.dir(directory) do
		if filename ~= "." and filename ~= ".." and filename:match("^[^.]")  then
			local filepath = directory .. "/" .. filename
			local attr = lfs.attributes(filepath)

			if attr and attr.mode == "file" then
				table.insert(files, filepath)
			elseif attr and attr.mode == "directory" then
				if r then
					-- Recursive call with the same 'r' parameter
					local subdirectory_files = utils.list_files(filepath, r)
					for index, value in ipairs(subdirectory_files) do
						table.insert(files, value)
					end
				else
					-- When not recursive, add directory paths
					table.insert(files, filepath)
				end
			end
		end
	end

	return files
end


-- Función para obtener el nombre de un fichero dado un path completo a el
function utils.get_file_name(file)
	return file:match("[^/]*.[a-z]*$")
end

-- Función para obtener la carpeta en la que se encuentra un archivo
function utils.obtenerCarpeta(path)
	return path:match(".*/(.-)/[^/]*$") or "."
end

return utils
