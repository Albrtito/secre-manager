--[[
Modulo de organizacion de archivos, da el servicio principal de organizar_archivo, verificando su formato y metiéndolo en la carpeta correspondiente de la ronda solar seleccionada
--]]
local utils = require("lua.utils")
local organizador = {}

-- WARNING: Sin terminar
function organizador.organizar_archivo(path, ronda_solar)
    -- Verificación de parámetros
    if ronda_solar == nil then
        ronda_solar = utils.get_ronda_solar()
    end
    if not utils.path_exists(path) then
        return -1
    end
    -- Validacion del nombre del archivo
end

return organizador
