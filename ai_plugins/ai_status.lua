--[[
Prints the git version and various other system stats.
--]]

local ai_status = {};

local tableUtil = require("riddim/ai_utils/tableutils");

local BOT;

local subjectKeywords = {
	"your",

}

local statusKeywords = {
	"status",
	"status?",
}

local questionKeywords = {
	"hows",
	"how\'s",
	"what",
	"whats",
	"what\'s",
}

function ai_status.Init(_bot, _botName)

	BOT = _bot;
	
	local subTable = {};
	
	table.insert(subTable, { { questionKeywords, statusKeywords, { _botName, _botName.."?" } }, HandleMessage });
	table.insert(subTable, { { { _botName }, questionKeywords, statusKeywords }, HandleMessage });
	table.insert(subTable, { { questionKeywords, subjectKeywords, statusKeywords, { _botName, _botName.."?" } }, HandleMessage });
	table.insert(subTable, { { { _botName }, questionKeywords, subjectKeywords, statusKeywords }, HandleMessage });
	
	return subTable;
	
end

function HandleMessage(_message)
	local status = "";
	
	local handle = io.popen("git log --pretty=format:'%h' -n 1");
	local result = handle:read("*a");
	
	status = status.."\n".."Version: "..result;
	
	status = status.."\n";
	
	status = status.."\n".."Riddim Plugins: ";
	
	for position, pluginName in pairs(BOT.config.plugins) do
		status = status..pluginName.." ";
	end
	
	status = status.."\n";
	
	status = status.."\n".."Verse/Stream Plugins: ";
	
	for position, versePluginName in pairs(BOT.config.stream_plugins) do
		status = status..versePluginName.." ";
	end
	
	status = status.."\n";
	
	status = status.."\n".."AI Plugins: ";
	
	for position, aiPluginName in pairs(BOT.config.ai_plugins) do
		status = status..aiPluginName.." ";
	end
	
	status = status.."\n";
	
	handle = io.popen("uptime");
	result = handle:read("*a");
	
	status = status.."\n"..result;
	
	handle = io.popen("free -mh");
    result = handle:read("*a");
	
	status = status.."\n"..result;
	
	_message:reply(status);
		return true;
end

return ai_status;
