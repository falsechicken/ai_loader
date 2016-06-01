--[[
Permissions
Used for operations dealing with the config permissions/admin table.
--]]

local tableUtils = require("riddim/ai_utils/tableutils");

local permissions = {};

--[[
	Checks if a user has a permission
--]]
function permissions.HasPermission(_JID, _permission, _permissionTable)
	if tableUtils.DoesTableContainKey(_JID, _permissionTable) then
		for k,v in pairs(_permissionTable[_JID]) do
			if v == _permission then return true; end
		end
		
		return false;	
	else
		return false;
	end
end

return permissions;
