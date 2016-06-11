local ai_issues = {};

local textUtils = require("riddim/ai_utils/textutils");

local BOT;

local loader;

local keywords = {
	"issue:"
}

function ai_issues.Init(_bot, _botName, _loader)

	local subTable = {};
	
	table.insert(subTable, { { keywords }, ShowIssueLink });
	
	BOT = _bot;
	
	loader = _loader;
	
	return subTable;
	
end

function ShowIssueLink(_message)
	messageBody = string.lower(_message.body);
	
	local wordsTable = textUtils.Split(messageBody);
	
	local issueNumber = "0";
	
	local position = 0;
	for k, word in pairs(wordsTable) do
		if word == "issue:" then issueNumber = wordsTable[k+1]; break; end
	end
	
	if BOT.config.ai_issue_url == nil then _message:reply("No issue url defined in config."); return; end
	
	_message:reply(BOT.config.ai_issue_url..issueNumber);
	
end

return ai_issues;
