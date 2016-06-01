--[[
Prints the current system time.
--]]

local ai_time = {};

local timeKeywords = {
	"time",
	"time?",
}

local questionKeywords = {
	"what",
	"whats",
	"what\'s"
}

function ai_time.Init(_bot, _botName)

	local subTable = {};
	
	table.insert(subTable, { { { _botName }, questionKeywords, timeKeywords }, HandleMessage });
	table.insert(subTable, { { questionKeywords, timeKeywords, { _botName, _botName.."?" } }, HandleMessage });
	
	return subTable;
	
end

function HandleMessage(_message)
		_message:reply("It is "..os.date("%X").. " on "..os.date("%x"));
		return true;
end

return ai_time;
