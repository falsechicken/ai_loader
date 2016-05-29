local jid_tool = {};

function jid_tool.SeperateFullJID(_fullJID)
	
	local fullJID, resource = _fullJID:match("([^,]+)/([^,]+)"); -- Split JID and Resource
	
	local jid, host = fullJID:match("([^,]+)@([^,]+)");
	
	return jid, host, resource;
	
end

function jid_tool.SeperateFullJIDChat(_fullJID)
	
	local fullJID, jid = _fullJID:match("([^,]+)/([^,]+)"); -- Split JID and Resource
	
	local room, host = fullJID:match("([^,]+)@([^,]+)");
	
	return jid, host, room;
	
end

function jid_tool.GetRoomFromChatJID(_chatJID)
	
	local room, jid = _chatJID:match("([^,]+)/([^,]+)"); -- Split JID and Resource
	
	return room;
	
end

return jid_tool;
