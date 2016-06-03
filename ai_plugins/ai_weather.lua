--[[
Prints the weather/forecast in a given zip code (US only AFAIK).
Requires ai_weather_location variable to be set in bot config.
Also requires the weather-util package to be installed.
--]]

local ai_weather = {};

local tableUtils = require("riddim/ai_utils/tableutils");

local BOT;

local weatherKeywords = {
	"weather",
	"weather?"
}

local forecastKeywords = {
	"forecast",
	"forecast?"
}

local successResponses = {
	"Coming right up.",
	"Here ya go.",
	"Got it.",
	"Gotcha.",
}

function ai_weather.Init(_bot, _botName)

	BOT = _bot;
	
	local subTable = {};
	
	table.insert(subTable, { { { _botName }, weatherKeywords }, HandleWeatherMessage });
	table.insert(subTable, { { weatherKeywords, { _botName, _botName.."?" } }, HandleWeatherMessage });
	
	table.insert(subTable, { { { _botName }, forecastKeywords }, HandleForecastMessage });
	table.insert(subTable, { { forecastKeywords, { _botName, _botName.."?" } }, HandleForecastMessage });
	
	return subTable;
	
end

function HandleWeatherMessage(_message)
	if _message.stanza.attr.type == "groupchat" then return; end
		
	if BOT.config.ai_weather_location ~= nil then
		local handle = io.popen("weather-util "..BOT.config.ai_weather_location);
		local result = "\n"..handle:read("*a");

		_message:reply(tableUtils.GetRandomEntry(successResponses).."\n"..result);
		return true;
	else
		_message:reply("I don't know where you are man...");
		return true;
	end
end

function HandleForecastMessage(_message)
	if _message.stanza.attr.type == "groupchat" then return; end
	
	if BOT.config.ai_weather_location ~= nil then
		local handle = io.popen("weather-util -f "..BOT.config.ai_weather_location);
		local result = "\n"..handle:read("*a");
	
		_message:reply(tableUtils.GetRandomEntry(successResponses).."\n"..result);
		return true;
	else
		_message:reply("I don't know where you are man...");
		return true;
	end
end

return ai_weather;
