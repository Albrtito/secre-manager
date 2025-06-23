

-- Función para remover tildes y caracteres especiales
local function remover_tildes(texto)
    local tildes = {
        ["á"] = "a",
        ["é"] = "e",
        ["í"] = "i",
        ["ó"] = "o",
        ["ú"] = "u",
        ["Á"] = "A",
        ["É"] = "E",
        ["Í"] = "I",
        ["Ó"] = "O",
        ["Ú"] = "U",
        ["ñ"] = "n",
        ["Ñ"] = "N",
        ["ü"] = "u",
        ["Ü"] = "U",
        ["ç"] = "c",
        ["Ç"] = "C",
    }

    for tilde, sin_tilde in pairs(tildes) do
        texto = string.gsub(texto, tilde, sin_tilde)
    end

    return texto
end

-- Función para verificar si un archivo cumple el formato estándar
local function verificar_formato_estandar(nombre_archivo)
    -- Patrón: nombreDelArchivo-NombreDelEducando.extension
    -- - Sin tildes, sin espacios
    -- - camelCase para nombre del archivo (empieza con minúscula)
    -- - PascalCase para nombre del educando (empieza con mayúscula)
    -- - Un solo guión como separador
    local patron = "^[a-z][a-zA-Z0-9]*%-[A-Z][a-zA-Z0-9]*%.[a-zA-Z0-9]+$"

    if string.match(nombre_archivo, patron) then
        -- Verificar que no tenga tildes
        local sin_tildes = remover_tildes(nombre_archivo)
        if sin_tildes == nombre_archivo then
            return true, "El archivo cumple con el formato estándar"
        else
            return false, "El archivo contiene tildes o caracteres especiales"
        end
    else
        -- Analizar qué específicamente está mal
        local errores = {}

        -- Verificar si tiene la estructura básica nombre-educando.ext
        if not string.match(nombre_archivo, "^.+%-.+%..+$") then
            table.insert(errores, "No tiene la estructura nombre-educando.extension")
        end

        -- Verificar espacios
        if string.match(nombre_archivo, "%s") then
            table.insert(errores, "Contiene espacios")
        end

        -- Verificar múltiples guiones
        local _, count = string.gsub(nombre_archivo, "%-", "")
        if count > 1 then
            table.insert(errores, "Contiene más de un guión")
        elseif count == 0 then
            table.insert(errores, "No contiene el guión separador")
        end

        -- Verificar tildes
        local sin_tildes = remover_tildes(nombre_archivo)
        if sin_tildes ~= nombre_archivo then
            table.insert(errores, "Contiene tildes o caracteres especiales")
        end

        -- Verificar formato camelCase/PascalCase si tiene la estructura básica
        if string.match(nombre_archivo, "^.+%-.+%..+$") and not string.match(nombre_archivo, "%s") then
            local nombre_completo, _ = string.match(nombre_archivo, "^(.+)%.([^%.]+)$")
            if nombre_completo then
                local nombre_arch, nombre_edu = string.match(nombre_completo, "^(.+)%-(.+)$")
                if nombre_arch and nombre_edu then
                    -- Verificar que nombre del archivo empiece con minúscula
                    if not string.match(nombre_arch, "^[a-z]") then
                        table.insert(errores, "El nombre del archivo debe empezar con minúscula (camelCase)")
                    end
                    -- Verificar que nombre del educando empiece con mayúscula
                    if not string.match(nombre_edu, "^[A-Z]") then
                        table.insert(errores, "El nombre del educando debe empezar con mayúscula (PascalCase)")
                    end
                end
            end
        end

        local mensaje_error = "Errores encontrados: " .. table.concat(errores, ", ")
        return false, mensaje_error
    end
end

-- Función para extraer las partes del nombre del archivo
local function extraer_partes_archivo(nombre_archivo)
    local nombre_completo, extension = string.match(nombre_archivo, "^(.+)%.([^%.]+)$")

    if not nombre_completo or not extension then
        return nil, nil, nil, "No se pudo extraer la extensión del archivo"
    end

    local nombre_archivo_parte, nombre_educando = string.match(nombre_completo, "^(.+)%-(.+)$")

    if not nombre_archivo_parte or not nombre_educando then
        return nil, nil, nil, "No se encontró el separador '-' o la estructura es incorrecta"
    end

    return nombre_archivo_parte, nombre_educando, extension, nil
end

-- Función principal para verificar formato
local function verificar_archivo(nombre_archivo)
    local es_valido, mensaje = verificar_formato_estandar(nombre_archivo)

    local resultado = {
        archivo = nombre_archivo,
        es_valido = es_valido,
        mensaje = mensaje,
    }

    -- Si es válido, extraer las partes para mostrar información adicional
    if es_valido then
        local nombre_arch, nombre_edu, ext, error_msg = extraer_partes_archivo(nombre_archivo)
        if not error_msg then
            resultado.nombre_archivo = nombre_arch
            resultado.nombre_educando = nombre_edu
            resultado.extension = ext
        end
    end

    return resultado
end

-- Función para probar múltiples archivos
function probar_archivos(lista_archivos)
    print("=== VERIFICACIÓN DE FORMATO DE ARCHIVOS ===\n")

    for i, archivo in ipairs(lista_archivos) do
        local resultado = verificar_archivo(archivo)

        print("Archivo " .. i .. ": " .. resultado.archivo)
        print("Válido: " .. (resultado.es_valido and "SÍ" or "NO"))
        print("Mensaje: " .. resultado.mensaje)

        if resultado.es_valido and resultado.nombre_archivo then
            print("  - Nombre del archivo: " .. resultado.nombre_archivo)
            print("  - Nombre del educando: " .. resultado.nombre_educando)
            print("  - Extensión: " .. resultado.extension)
        end

        print("---")
    end
end

-- Ejemplos de uso (descomenta para probar)
--[[
local archivos_prueba = {
    "tareaDeMatematicas-JuanPerez.pdf",      -- Válido
    "examen-MariaJose.docx",                 -- Válido
    "Tarea de Matemáticas-Juan.pdf",         -- Inválido: espacios y mayúscula inicial
    "tarea-juan-perez.txt",                  -- Inválido: múltiples guiones
    "proyectoFinal.pdf",                     -- Inválido: sin guión separador
    "informeDeQuímica-AnaLópez.pdf",         -- Inválido: tildes
    "trabajoFinal-ana.pdf"                   -- Inválido: nombre educando no empieza con mayúscula
}

probar_archivos(archivos_prueba)
--]]
