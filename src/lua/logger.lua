
local log = {}

-- NOTE: Esta función, si se usa en otros módulos, debería de estar en utils
-- Get timestamp
local function get_timestamp()
    return os.date("%Y/%m/%d %H:%M:%S")
end

-- Basic log function, timestamp + message
function log.print(message)
    print(get_timestamp() .. " " .. message)
end

-- Log function with file and line information
function log.dprint(message)
    local info = debug.getinfo(2, "Sl")
    local file = info.short_src
    local line = info.currentline
    print(string.format("%s %s:%d %s", get_timestamp(), file, line, message))
end

function log.structured_log(message, ...)
    local args = {...}
    local structured = {
        time = get_timestamp(),
        level = "INFO",
        msg = message
    }
    for i = 1, #args, 2 do
        structured[args[i]] = args[i+1]
    end
    print(string.format('{"time":"%s","level":"%s","msg":"%s"%s}',
        structured.time, structured.level, structured.msg,
        #args > 0 and "," .. table.concat(args, ",") or ""))
end

return log
