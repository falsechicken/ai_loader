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
}

function ai_time.Init(_bot, _botName)

	local subTable = {};
	
	table.insert(subTable, { { { _botName }, questionKeywords, timeKeywords }, HandleMessage });
	table.insert(subTable, { { questionKeywords, timeKeywords, { _botName, _botName.."?" } }, HandleMessage });
	
	return subTable;
	
end

function HandleMessage(_message)
		_message:reply(os.date("[ %x  :  %X ]"));
		return true;
end

return ai_time;
