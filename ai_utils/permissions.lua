--[[
Permissions
Used for operations dealing with the config permissions table.
--]]

local tableUtils = require("riddim/ai_utils/tableutils");

local permissions = {};

--[[
	Checks if a user has a permission
--]]
function permissions.HasPermission(_JID, _permission, _permissionTable)
	if _permissionTable == nil then return true; end -- No table present defaults to true.
	
	if tableUtils.DoesTableContainKey(_JID, _permissionTable) then
		for k,v in pairs(_permissionTable[_JID]) do
			if v == _permission then return true; end
		end
		
		if _permissionTable["DEFAULT"] == nil then return false; end -- If default permission entry is not in table.
		for k,v in pairs(_permissionTable["DEFAULT"]) do
			if v == _permission then return true; end
		end
		
		return false;	
	else
		return false;
	end
end

return permissions;
