--[[
Responds to Jenkins builds in group chat.
--]]

local ai_jenkins = {};

local tableUtil = require("riddim/ai_utils/tableutils");
local jid_tool = require("riddim/ai_utils/jid_tool");

local RESPONSE_UNLIKELYNESS_SUCCESS = 90;
local RESPONSE_UNLIKELYNESS_FAILURE = 50;

local BOT;

local failedKeywords = {
	"failure",
	"failing",
}

local successResponses = {
	"Yay! :)",
	"I love successful builds.",
	"Hot builds here!",
	"Compiler fresh!",
	"Nice.",
}

local failedResponses = {
	"Ouch...",
	"Well thats not right...",
	"Someone blew a capacitor...",
	"Something is wrong... Are HAL\'s circuits functioning normally?",
	"We need an engineer in here!",
}

function ai_jenkins.Init(_bot, _botName)

	BOT = _bot;
	
	local subTable = {};
	
	table.insert(subTable, { { { "project" }, { "build" }, { "success" } }, HandleMessageSuccess });
	table.insert(subTable, { { { "project" }, { "build" }, failedKeywords }, HandleMessageFailed });
	
	return subTable;
	
end

function HandleMessageSuccess(_message)
	local rand = math.random(1, 100);
	if rand >= RESPONSE_UNLIKELYNESS_SUCCESS then 
		local response = stanza.message({to = jid_tool.GetRoomFromChatJID(_message.sender["jid"]), type = "groupchat" }) -- Only works in MUC rooms...
                  :tag("body"):text(tableUtil.GetRandomEntry(successResponses));
		BOT:send(response);
		return true;
	end
end

function HandleMessageFailed(_message)
	local rand = math.random(1, 100);
	if rand >= RESPONSE_UNLIKELYNESS_FAILURE then 
		local response = stanza.message({to = jid_tool.GetRoomFromChatJID(_message.sender["jid"]), type = "groupchat" }) -- Only works in MUC rooms...
                  :tag("body"):text(tableUtil.GetRandomEntry(failedResponses));
		BOT:send(response);
		return true;
	end
end

return ai_jenkins;
