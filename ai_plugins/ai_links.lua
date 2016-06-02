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
	"get",
	"give",
	"hook"
};

local nounKeywords = {
	"me",
	"i",
	"him",
	"her",
	"them",
	"the",
	"man",
	"woman"
};

local linkKeywords = {
	"link",
	"url"
};

local successResponses = {
	"Got It",
	"Here ya go",
	"Right here bro",
	"Roger that"
};

local failResponses = {
	"I do not know what link you want?... Sorry.",
	"Uhm... I am unaware of that link... My bad.",
	"Am I supposed to know where that is?",
	"This is the first I am hearing of this link..."
};

function ai_links.Init(_bot, _botName)

	local subTable = {};
	
	table.insert(subTable, { { { _botName }, actionKeywords, nounKeywords, linkKeywords }, HandleMessage });
	table.insert(subTable, { { { _botName }, linkKeywords, actionKeywords, nounKeywords, }, HandleMessage });
	
	table.insert(subTable, { { actionKeywords, nounKeywords, linkKeywords, { _botName, _botName.."?" } }, HandleMessage });
	table.insert(subTable, { { linkKeywords, actionKeywords, nounKeywords, { _botName, _botName.."?" } }, HandleMessage });
	
	BOT = _bot;
	
	return subTable;
	
end

function HandleMessage(_message)
		
	if BOT.config.ai_links == nil then _message:reply("No links are configured... Sorry."); return false; end
	
	local words = textUtils.Split(_message.body);
		
	for k, word in pairs(words) do
		for title, link in pairs(BOT.config.ai_links) do
			if word == title then
				_message:reply(tableUtils.GetRandomEntry(successResponses)..": "..link);
				return true;
			end
		end
	end
	
	_message:reply(tableUtils.GetRandomEntry(failResponses));
	return false;
end

return ai_links;
