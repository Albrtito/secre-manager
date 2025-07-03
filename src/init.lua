--[[
Módulo principal, desde aquí se hacen las llamadas y se utilizan los valores calculados por el resto de módulos.
--]]
-- Librerías externas
local lm = require("lummander")
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

local cli = lm.new({
    title = "Secre manager",
    tag = "", -- define command to launch this script at terminal, no se usa actualmente con cli interactiva
    description = "Comandos para la organización de los archivos digitales de secre",
    version = "0.0.1",
    author = "Pascau",
    root_path = "",         -- <string> root_path. Default "". Concat this path to load commands of a subfolder
    theme = "acid",
    flag_prevent_help = false, -- prevent show help when :parse() doesn't find a valid command to execute
})

-- Comandos de la terminal
cli:command("echo <value1>", "Imprimir algo en pantalla"):action(function(parsed, command, app)
    print(parsed.value1)
end)

-- Función de inicio de la terminal. Carga los comandos y empieza el loop infinito para crear una terminal interactiva
local function start_terminal()
    -- Carga de comandos desde la carpeta comm
    local handle = io.popen("pwd")
    local current_dir = handle:read("*a"):gsub("\n", "")
    handle:close()
    cli:commands_dir(current_dir .. "/comm/")
    -- Inicio de la terminal y entrada en el bucle infinito
    print("=== Terminal del servicio digital de secre ===")
    print("Type 'help' for available commands, 'exit' or 'quit' to leave")

    while true do
        io.write("> ")
        io.flush()
        local input = io.read("*line")

        if not input then
            break
        end

        -- Trim whitespace
        input = input:match("^%s*(.-)%s*$")

        -- Check for exit commands
        if input == "exit" or input == "quit" or input == "q" then
            print("Goodbye!")
            break
        end

        -- Skip empty input
        if input == "" then
            goto continue
        end

        -- Split input into arguments
        local args = {}
        for word in input:gmatch("%S+") do
            table.insert(args, word)
        end

        -- Try to parse and execute the command
        local success, err = pcall(function()
            cli:parse(args)
        end)

        if not success then
            print("Error: " .. tostring(err))
        end

        ::continue::
    end
end

local function main()
    start_terminal()
end

main()
