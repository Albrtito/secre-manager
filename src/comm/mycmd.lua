-- folderpath/mycmd.lua
return {
	schema = "mycmd <req_arg> [opt_arg]", -- Schema to parse. Required
	description = "Command description", -- Command description
	positional_args = { -- Set description or {description, default} for positional arguments
		req_arg = "A description for a required argument",
		opt_arg = { description = "A description for a optional argument", default = "default_positional_option_value" },
	},
	hide = false, -- hide from help command
	main = true, -- do this command default action to CLI if true. Default = nil = false
	action = function(parsed, command, app) -- same command:action(function)
		parsed:print()
		local sufix = ""
		if parsed.yes then
			sufix = " -y"
		end
		os.execute("npm init" .. sufix)
	end,
}
