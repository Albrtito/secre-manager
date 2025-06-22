-- Valores de configuracion del servicio
-- Direccion del archivo init.lua
local path = os.getenv("PWD")

local config = {


    -- paths
    -- Direccion de la carpeta de sensible
    path_sensible = path .. "/../../../Shared drives/00. Sensible/",
    -- Dirección a la carpeta de la docu de educandos
    path_edu = path .. "/../../../Shared drives/00. Sensible/00-Documentacion-educandos/",

    -- cuentas mail
    mail_secre = "secretaria@scouts217.com",
    mail_1 = "alb.pascau@gmail.com",

}

return config
