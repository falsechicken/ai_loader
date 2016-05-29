--[[
Ai Loader Intent Engine
Decides if a set of text matches a plugin.
--]]

local intentEngine = {}

local textUtils = require("riddim/ai_utils/textutils");

--[[
	Returns true if the provided text contains the provided keywords in the proper order.
	Keyword order is defined by the order they are placed in the provided table.
--]]
function intentEngine.DetectIntent(_keyWordTables, _messageBody)

	local keywordsFound = {};
	
	_messageBody = string.lower(_messageBody);
	
	local wordsTable = textUtils.Split(_messageBody);
	
	local currentKeywordNumber = 1;
	
	for wTposition, word in pairs(wordsTable) do
		for kwTSposition, keywordTable in pairs(_keyWordTables) do
			for kwPosition, keyword in pairs(keywordTable) do
				if word == keyword then
					if kwTSposition == currentKeywordNumber then 
						currentKeywordNumber = currentKeywordNumber + 1;
						table.insert(keywordsFound, keyword); 
					end
					break;
				end
			end
		end
	end
	
	local keyWordTableLength;
	local matchedWordsTableLength;
	
	local count = 0;
	for _ in pairs(_keyWordTables) do count = count + 1; end
	keyWordTableLength = count;
	
	count = 0;
	for _ in pairs(keywordsFound) do count = count + 1; end
	matchedWordsTableLength = count;
	
	if matchedWordsTableLength == keyWordTableLength then
		return true; 
	end
	
	return false;
end

return intentEngine;
