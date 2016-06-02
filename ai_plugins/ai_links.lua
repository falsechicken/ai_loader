--[[
Displays links setup in the bot config file.

Example:

ai_links = {
	["github"] = "https://github.com",
	["google"] = "https://google.com"
};
--]]

local ai_links = {};

local BOT;

local tableUtils = require("riddim/ai_utils/tableutils");
local jid_tool = require("riddim/ai_utils/jid_tool");
local textUtils = require("riddim/ai_utils/textutils");

local actionKeywords = {
	"show",
	"display",
	"lookup",
	"get"
};

local nounKeywords = {
	"me",
	"him",
	"her",
	"them",
	"the"
};

local responses = {
	"Got It",
	"Here ya go",
	"Right here bro",
	"Roger that"
};

function ai_links.Init(_bot, _botName)

	local subTable = {};
	
	table.insert(subTable, { { { _botName }, actionKeywords, nounKeywords }, HandleMessage });
	table.insert(subTable, { { actionKeywords, nounKeywords, { _botName, _botName.."?" } }, HandleMessage });
	
	BOT = _bot;
	
	return subTable;
	
end

function HandleMessage(_message)
		
	if BOT.config.ai_links == nil then _message:reply("No links are configured... Sorry."); return false; end
	
	local words = textUtils.Split(_message.body);
		
	for k, word in pairs(words) do
		for title, link in pairs(BOT.config.ai_links) do
			if word == title then
				_message:reply(tableUtils.GetRandomEntry(responses)..": "..link);
				return true;
			end
		end
	end
	
	_message:reply("I do not know what link you want? Sorry.");
	return true;
end

return ai_links;
