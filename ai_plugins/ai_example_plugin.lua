--[[
Simple Example AI Plug-in.
--]]
local ai_example_plugin = {};

local BOT; -- Place to hold a reference to the Bot. Mostly used for reading config vars.
local botName; -- Place to hold the bot's name. Used for convenience.

local keywords = {
	"hi",
	"hello",
}

function ai_example_plugin.Init(_bot, _botName)

	BOT = _bot; -- Assign the BOT variable to the reference passed in from the loader.
	botName = _botName; -- Assign the bot's name variable to the reference passed in from the loader.
	
	--[[
		Setup the Subscription table. Used when the loader/intent engine scans messages and passes them on to the
		proper plug-in. The system works by breaking up the message into a list of words (Word meaning anything
		seperated by spaces) and checking if those words appear in the order reflected by the subscription table
		entry.
		
		So for example if the message "<botname> test test1 hello test2 test3" was sent it would match the first
		entry in the table below because of the order of the keywords. And if it where reversed and included "hi"
		instead of "hello" the second entry would match ("test test1 hi test2 <botname> test3"). Since in 
		the keywords table we have both "hi" and "hello" and we put the bot name after the keywords.
		
		The last item in the subTable entry is the function to call when the subscription is matched. In this case
		we use the HandleMessage function below for both. 
	--]]
	local subTable = {};
	
	table.insert(subTable, { { { _botName }, keywords }, HandleMessage });
	table.insert(subTable, { { keywords , { _botName } }, HandleMessage });
	
	return subTable;
	
end

function HandleMessage(_message)
		_message:reply("Hello!");
		return true;
end

return ai_example_plugin;
