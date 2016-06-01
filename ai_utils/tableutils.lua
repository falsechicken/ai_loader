--[[
TableUtils
Utility functions for working with tables.
--]]


local tableUtils = {};

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

--[[
	Returns true if the given table contains the given entry.
--]]
function tableUtils.DoesTableContainEntry(_entry, _table)
	for k, v in pairs(_table) do
		if v == _entry then
			return true;
		end
	end
	
	return false;
end

--[[
	Recursively print a table to the console.
--]]
function tableUtils.PrintTable (_table, _indent)
	if not _indent then _indent = 0 end
  
		for k, v in pairs(_table) do
			formatting = string.rep("  ", _indent) .. k .. ": ";
			if type(v) == "table" then
				print(formatting);
				tableUtils.PrintTable(v, _indent+1);
			else
				if type(v) ~= "function" then
					print(formatting .. v);
				else
					print(formatting .. "<FUNCTION>");
				end
			end
		end
	end

return tableUtils;
