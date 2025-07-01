local config = require("lua.config")

local log = {}

-- NOTE: Esta función, si se usa en otros módulos, debería de estar en utils
-- Get timestamp
local function get_timestamp()
	return os.date("%Y/%m/%d %H:%M:%S")
end

-- All logging goes into a file specified in the config
local function write_log(message)
	local file = assert(io.open(config.path_logs .. "log.txt", "a"))
	file:write(message .. "\n")
	file:close()
end

-- Clear a log file. If no file, clear the default log
function log.clear(file)
	if file == nil then
		file = config.path_logs .. "log.txt"
	end
	local file = assert(io.open(file, "w+"))
	file:close()
end

-- Basic log function, timestamp + message
function log.log(message)
	write_log(get_timestamp() .. " " .. message)
end

-- Log function with file and line information
function log.dlog(message)
	local info = debug.getinfo(2, "Sl")
	local file = info.short_src
	local line = info.currentline
	write_log(string.format("%s %s:%d %s", get_timestamp(), file, line, message))
end

-- Log into a dict type structure
function log.structured_log(message, ...)
	local args = { ... }
	local structured = {
		time = get_timestamp(),
		level = "INFO",
		msg = message,
	}
	for i = 1, #args, 2 do
		structured[args[i]] = args[i + 1]
	end
	write_log(
		string.format(
			'{"time":"%s","level":"%s","msg":"%s"%s}',
			structured.time,
			structured.level,
			structured.msg,
			#args > 0 and "," .. table.concat(args, ",") or ""
		)
	)
end

return log
