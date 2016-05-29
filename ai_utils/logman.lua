--[[
LogMan
Used to print log messages in a standard way.
--]]

local logMan = {};

function logMan.LogMessage(_message, _mode)
	local now = os.date("[%x : %X]");
	if _mode == 0 then print(now.. " DEBUG: ".._message); return; end
	if _mode == 1 then print(now.. " INFO: ".._message); return; end
	if _mode == 2 then print(now.. " WARNING: ".._message); return; end
	if _mode == 3 then print(now.. " ERROR: ".._message); return; end
	print("LogMan: Invalid mode.");
end

return logMan;
