--[[
StanzaUtils
Provides needed functions for dealing with stanzas.
--]]

local stanzaUtils = {};

--[[
	Returns true if a message has the delay tag (Meaning it was sent while bot was offline.)
--]]
function stanzaUtils.IsMessageOld(_message)
	for k,v in pairs(_message.stanza.tags) do
		if _message.stanza.tags[k].name == "delay" then return true; end
	end
	
	return false;
end

--[[
	Returns true if the message is a group chat (MUC) message.
--]]
function stanzaUtils.IsGroupChat(_message)
	if _message.stanza.attr.type == "groupchat" then return true; end
	return false;
end

--[[
	Returns true if the message is a regular chat message (Not MUC).
--]]
function stanzaUtils.IsChat(_message)
	if _message.stanza.attr.type == "chat" then return true; end
	return false;
end

return stanzaUtils;
