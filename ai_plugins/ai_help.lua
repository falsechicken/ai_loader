--[[
Responds to users asking the bot for help.
--]]
local ai_help = {};

local tableUtil = require("riddim/ai_utils/tableutils");

local helpResponses = {
	"Don\'t look at me. I\'m just bits.",
	"Oh no no no. I\'m not getting into that..",
	"Listen buddy the last time I tried to help someone I ended up on Sixty Minutes.",
}

local helpKeywords = {
	"help",
	"help!",
	"help.",
}

function ai_help.Init(_bot, _botName)

	local subTable = {};
	
	table.insert(subTable, { { { _botName } , helpKeywords }, HandleMessage });
	table.insert(subTable, { { helpKeywords, { _botName, _botName.."!", _botName.."?" }  }, HandleMessage });
	
	return subTable;
	
end

function HandleMessage(_message)
		_message:reply(tableUtil.GetRandomEntry(helpResponses));
		return true;
end

return ai_help;
