--[[
Responds to users greeting the bot.
--]]

local ai_hello = {};

local tableUtil = require("riddim/ai_utils/tableutils");

local greetingKeywords = {
	"hello",
	"hi",
	"hey",
	"greetings",
	"yo",
	"hanging",
}

local greetingResponses = {
	"Yo.",
	"Hey.",
	"Hello.",
	"Yo yo.",
}

function ai_hello.Init(_bot, _botName)

	local subTable = {};
	
	table.insert(subTable, { { { _botName, _botName.."!" }, greetingKeywords }, HandleMessage });
	table.insert(subTable, { { greetingKeywords , { _botName, _botName.."!", _botName.."?" } }, HandleMessage });
	
	return subTable;
	
end

function HandleMessage(_message)
		_message:reply(tableUtil.GetRandomEntry(greetingResponses));
		return true;
end

return ai_hello;
