--[[
Responds to users asking an opinion of the bot.
--]]

local ai_answer = {};

local tableUtil = require("riddim/ai_utils/tableutils");

local subjectKeywords = {
	"you",
	"your",
}

local questionKeywords = {
	"what",
	"whats",
	"what\'s",
	"do",
	"have",
}

local opinionKeywords = {
	"think",
	"think,",
	"think?",
	"opinion",
	"opinion,",
	"opinion?",
}

local yesRepsponses = {
	"Yes.",
	"Yeah.",
	"I like it.",
	"I\'m down.",
}

local noRepsponses = {
	"No.",
	"Nope.",
	"I don't like it.",
	"I\'m out.",
}

function ai_answer.Init(_bot, _botName)

	local subTable = {};
	
	table.insert(subTable, { { { _botName } , questionKeywords, questionKeywords, subjectKeywords, opinionKeywords }, HandleMessage });
	table.insert(subTable, { { questionKeywords, questionKeywords, subjectKeywords, opinionKeywords, { _botName, _botName.."?" } }, HandleMessage });
	table.insert(subTable, { { questionKeywords, subjectKeywords, opinionKeywords, { _botName, _botName.."?" } }, HandleMessage });
	table.insert(subTable, { { { _botName }, questionKeywords, subjectKeywords, opinionKeywords }, HandleMessage });
	table.insert(subTable, { { { _botName } , questionKeywords, questionKeywords, subjectKeywords, opinionKeywords }, HandleMessage });
	
	return subTable;
	
end

function HandleMessage(_message)
		local rand = math.random(1, 100);
		
		if rand >= 50 then
			_message:reply(tableUtil.GetRandomEntry(yesRepsponses));
			return true;
		else
			_message:reply(tableUtil.GetRandomEntry(noRepsponses));
			return true;
		end
end

return ai_answer;
