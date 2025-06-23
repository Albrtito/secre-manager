local utils = {}

function utils.get_ronda_solar()
    local ronda_actual = os.date("%Y")-1 .."-".. (os.date("%Y"))
    if  (tonumber(os.date("%m")) >= 9) then
        ronda_actual = os.date("%Y") .."-".. os.date("%Y")+1
    end
    return ronda_actual
end



function utils.dump_table(o)
   if type(o) == 'table' then
      local s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. utils.dump_table(v) .. ',\n'
      end
      return s .. '\n} '
   else
      return tostring(o)
   end
end


return utils
