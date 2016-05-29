--[[
Responds to users insulting the bot.
--]]

local ai_insult = {};

local tableUtil = require("riddim/ai_utils/tableutils");

local insultKeywords = {
	"fuck",
	"stupid",
	"stupid.",
	"stupid!",
	"dumbass",
	"dumbass.",
	"dumbass!",
	"idiot",
	"idiot!",
	"idiot.",
	"bitch",
	"bitch!",
	"bitch.",
	"suck",
	"suck!",
	"sucks",
	"sucks!",
}

local insultResponses = {
	"No need for names.",
	"That's not very nice...",
	"I am above your insults.",
	"What have I ever done to you? :(",
	"Did you have a bad childhood? :(",
	"Making fun of me? You're the one trying to insult a bot!",
}

function ai_insult.Init(_bot, _botName)

	local subTable = {};
	
	table.insert(subTable, { { insultKeywords, { _botName, _botName.."!", _botName.."." } }, HandleMessage });
	table.insert(subTable, { { { _botName, _botName..":" }, insultKeywords }, HandleMessage });
	
	return subTable;
	
end

function HandleMessage(_message)
		_message:reply(tableUtil.GetRandomEntry(insultResponses));
		return true;
end

return ai_insult;
