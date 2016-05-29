--[[
Replies to users thanking the bot.
--]]

local ai_thank = {};

local tableUtil = require("riddim/ai_utils/tableutils");

local subjectKeywords = {
	"you",
	"you!",
	"you.",
}

local thankKeywords = {
	"thanks",
	"thanks!",
	"thanks.",
	"thank",
	"thankyou",
	"thankyou!",
	"thankyou.",
}

local thankResponses = {
	"No problem!",
	"No problem bro.",
	";)",
	"You know I got you.",
	"You got it.",
	"Np",
}

function ai_thank.Init(_bot, _botName)

	local subTable = {};
	
	table.insert(subTable, { { thankKeywords, { _botName, _botName.."!", _botName.."." } }, HandleMessage });
	table.insert(subTable, { { thankKeywords, subjectKeywords, { _botName, _botName.."!", _botName.."." } }, HandleMessage });
	table.insert(subTable, { { { _botName }, thankKeywords }, HandleMessage });
	
	return subTable;
	
end

function HandleMessage(_message)
		_message:reply(tableUtil.GetRandomEntry(thankResponses));
		return true;
end

return ai_thank;
