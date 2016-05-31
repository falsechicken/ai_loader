--[[
JIDTool
Used for operations such as seperating usernames from full JIDs. Needs work.
--]]

local jid_tool = {};

function jid_tool.SeperateFullJID(_fullJID)
	
	local fullJID, resource = _fullJID:match("([^,]+)/([^,]+)"); -- Split JID and Resource
	
	local jid, host = fullJID:match("([^,]+)@([^,]+)");
	
	return jid, host, resource;
	
end

function jid_tool.SeperateFullJIDChat(_fullJID)
	
	local fullJID, jid = _fullJID:match("([^,]+)/([^,]+)"); -- Split JID and full JID.
	
	local room, host = fullJID:match("([^,]+)@([^,]+)"); -- Split room and host.
	
	return jid, host, room;
	
end

function jid_tool.GetRoomFromChatJID(_chatJID)
	
	local room, jid = _chatJID:match("([^,]+)/([^,]+)"); -- Split Room and JID
	
	return room;
	
end

function jid_tool.StripResourceFromJID(_jid)
	local fullJID, resource = _jid:match("([^,]+)/([^,]+)"); -- Split JID and Resource
	
	return fullJID;
end

return jid_tool;
