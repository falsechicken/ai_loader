local tableUtils = {}

--[[
	Return a random entry from a table.
--]]
function tableUtils.GetRandomEntry(_table)
	local rand;
	local count = 0;
	
	for _ in pairs(_table) do count = count + 1; end
	
	rand = math.random(1, count);
	
	return _table[rand]; 
end

--[[
	Return the number of elements in a table.
--]]
function tableUtils.GetTableSize(_table)
	local count = 0;
	for _ in pairs(_table) do count = count + 1; end
	return count; 
end

return tableUtils;
