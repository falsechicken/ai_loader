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
	Returns true if the given table contains the given key.
--]]
function tableUtils.DoesTableContainKey(_key, _table)
	for k, v in pairs(_table) do
		if tostring(k) == tostring(_key) then -- Avoid trying to test a number against a string.
			return true;
		end
	end
	return false;
end

--[[
	Returns true if the given table contains the given value.
--]]
function tableUtils.DoesTableContainValue(_value, _table)
	for k, v in pairs(_table) do
		if v == _value then
			return true;
		end
	end
	
	return false;
end

--[[
	Recursively print a table to the console.
	Uses code from https://gist.github.com/stuby/5445834#file-rprint-lua
--]]
function tableUtils.PrintTable(_table, _limit, _indent) -- recursive Print (structure, limit, indent)
	_limit = (_limit) or 100; _indent = _indent or "";	-- default item limit, indent string
	
	if (_limit<1) then print "ERROR: Item limit reached."; return _limit-1; end
	
	local ts = type(_table);
	
	if (ts ~= "table") then print (_indent,ts,_table); return _limit-1; end
	
	print (_indent,ts);           -- print "table"
	
	for k,v in pairs(_table) do  -- print "[KEY] VALUE"
		_limit = tableUtils.PrintTable(v, _limit, _indent.."\t["..tostring(k).."]");
		if (_limit < 0) then break; end
	end
	
	return _limit
end	

return tableUtils;
