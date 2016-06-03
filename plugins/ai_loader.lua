-- Licensed Under the GPLv2

local logMan = require("riddim/ai_utils/logman");
local intentEngine = require("riddim/ai_utils/intent_engine");
local tableUtil = require("riddim/ai_utils/tableutils");
local stanzaUtils = require("riddim/ai_utils/stanzautils");

local BOT;
local botName;

local bLoaded = false;

local aiPlugins = {};

local aiPluginSubTable = {};

function riddim.plugins.ai_loader(_bot)
	_bot:hook("message", ai_loader_ProcessMessage);
	_bot:hook("groupchat/joining", function (room) -- Hook group chats.
			room:hook("message", ai_loader_ProcessMessage);
	end);
			
	Init(_bot);
end

function Init(_bot)

	BOT = _bot;
	
	if BOT.config.ai_plugins == nil then 
		logMan.LogMessage("No ai_plugins table found in config. Disabling AI Loader...", 3);
		return;
	end	
		
	if BOT.config.nick == nil then
		logMan.LogMessage("Bot\'s nickname is not found in config. Using Bot instead.", 2);
		botName = "Bot";
	else
		botName = string.lower(BOT.config.nick);
	end
	
	LoadPlugins();
	
	PrintLoadedPlugins();
	
	bLoaded = true;
	
end

function LoadPlugins()
		
	local tmpPlugin;
	
	for position, aiPluginName in pairs(BOT.config.ai_plugins) do
		tmpPlugin = require("riddim/ai_plugins/"..aiPluginName);
		aiPlugins[aiPluginName] = tmpPlugin;
		AddPluginToSigTable(aiPluginName, tmpPlugin.Init(BOT, botName));
	end
end

function ai_loader_ProcessMessage(_message)
	
	if stanzaUtils.IsMessageOld(_message) then return; end -- Avoid processing old messages (Sent while bot is offline).
	
	if _message.body == nil or bLoaded == false then return; end

	local matchingPluginSignatures = GetMatchingSignatures(_message);
	
	if tableUtil.GetTableSize(matchingPluginSignatures) < 1 then return; end
	
	local mostLikelySig = CalculateMostLikelySignature(matchingPluginSignatures);
	
	return GetPluginSignatureFunction(mostLikelySig[1][1], mostLikelySig[1][2])(_message); -- Call proper plugin function and allow plugin to choose return value;
	
end

function GetMatchingSignatures(_message)

	local matchedPluginSigs = {};
	
	for pluginName, signatureTable in pairs(aiPluginSubTable) do
		for position, signature in pairs(signatureTable) do
			if intentEngine.DetectIntent(signature[1], _message.body) then
				if matchedPluginSigs[pluginName] == nil then matchedPluginSigs[pluginName] = {}; end
				table.insert(matchedPluginSigs[pluginName], position);
			end
		end
	end
	
	return matchedPluginSigs;
	
end

function CalculateMostLikelySignature(_matchingPluginSignatures)

	local mostLikelySignature = {};
		
	for pluginName, matchedSigNumberTable in pairs(_matchingPluginSignatures) do
		for position, matchedSigNumber in pairs(matchedSigNumberTable) do
			if mostLikelySignature[1] == nil then mostLikelySignature[1] = { pluginName, matchedSigNumber }; end
			
			if tableUtil.GetTableSize(GetPluginSignature(pluginName, matchedSigNumber)) >
				tableUtil.GetTableSize(GetPluginSignature(mostLikelySignature[1][1], mostLikelySignature[1][2])) then
				
				mostLikelySignature[1] = { pluginName, matchedSigNumber };
			end
		end
	end
	
	return mostLikelySignature;
end

-- SIGNATURE TABLE FUNCTIONS

function AddPluginToSigTable(_pluginName, _sigTable)	
	aiPluginSubTable[_pluginName] = nil;
	aiPluginSubTable[_pluginName] = _sigTable;
end

function RemovePluginFromSigTable(_pluginName)
	aiPluginSubTable[_pluginName] = nil;
end

function GetPluginSigTable(_pluginName)
	return aiPluginSubTable[_pluginName];
end

function GetPluginSignature(_pluginName, _sigPosition)
	return GetPluginSigTable(_pluginName)[_sigPosition][1];
end

function GetPluginSignatureFunction(_pluginName, _sigPosition)
	return GetPluginSigTable(_pluginName)[_sigPosition][2];
end

-- END SIGNATURE TABLE FUNCTIONS

-- MESSAGING FUNCTIONS

function PrintLoadedPlugins()
	print("");
	logMan.LogMessage("## Loaded AI Plug-ins ##", 1);
	for pluginName, v in pairs(aiPlugins) do
		logMan.LogMessage("- "..pluginName, 1);
	end
	logMan.LogMessage("#######################", 1);
end

-- END MESSAGING FUNCTIONS
