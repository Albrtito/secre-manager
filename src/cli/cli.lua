-- Librerías externas
local lm = require("lummander")

-- Módulos internos
local utils = require("lua.utils")
local org = require("lua.organizador")
local config = require("lua.config")

local cli = lm.new({
	title = "Secre manager",
	tag = "", -- define command to launch this script at terminal, no se usa actualmente con cli interactiva
	description = "Comandos para la organización de los archivos digitales de secre",
	version = "0.0.1",
	author = "Pascau",
	root_path = os.getenv("PWD") .. "/", -- <string> root_path. Default "". Concat this path to load commands of a subfolder
	theme = "default",
	flag_prevent_help = false, -- prevent show help when :parse() doesn't find a valid command to execute
})

-- Simple echo command
cli:command("echo [text...]", "Print text on screen"):action(function(parsed, command, app)
	-- Handle the text parameter which can be multiple words
	local text = parsed.text
	for index, value in ipairs(text) do
		io.write(value .. " ")
	end
	print("\n")
end)

cli:command("lf [directory]", "Mostrar los archivos de una carpeta y subcarpetas")
	:option("recursive", "r", "Search recursively")
	:action(function(parsed, command, app)
		local r
		if parsed.recursive then
			r = true
		else
			r = false
		end
		if parsed.directory == nil then
			parsed.directory = config.path_edu
        else 
            parsed.directory = config.path_edu .. "/" .. parsed.directory
		end
		local files = utils.list_files(parsed.directory, r)
		for index, value in ipairs(files) do
			print(utils.get_file_name(value))
		end
		print("\n")
	end)

cli
	:command(
		"org [path] [varianza]",
		"organizar los archivos de la carpeta en path, carpeta path por default será la tmp de la ronda actual, varianza altera la ronda actual"
	)
	:action(function(parsed, command, app)
		local out_code
		local out_table
		out_code, out_table = org.organizar_archivos(parsed.path, parsed.varianza)
		if out_code == -1 then
			print("Errores encontrados en el nombre de alguno de los archivos")
		elseif out_code == -2 then
			print("Error en el path, no existe")
			return -1
		end

		for index, value in ipairs(out_table) do
			print(utils.dump_table(value))
		end
	end)

return cli
