# AI Loader

### AI Plug-in Loader/Framework For Riddim Bots.

To use: Add the ai_loader plug-in to your Riddim config then create/edit the options below in said config with a list of plug-ins to load.

Only tested with Ubuntu Linux.

### -- Installation Instructions --

1. Install the proper packages (Ubuntu): `sudo apt-get install lua5.1 lua-expat lua-filesystem lua-bitop lua-sec lua-zlib mercurial`

2. Follow the tutorial here to get the basic bot up and running: http://www.thiessen.im/2010/10/riddim-a-neat-little-xmpp-bot-written-in-lua/
    - Before squishing verse modify the verse/squishy file to include the following utils from Prosody:

    `Module "util.datamanager" "util/datamanager.lua"`  
    `Module "util.envload" "util/envload.lua"`  
    `Module "util.serialization" "util/serialization.lua"`  

3. Copy the ai_loader folders to your riddim folder.
    

4. Modify the Riddim config file to include the following options:
	- Add ai_loader to your list of riddim plug-ins.

### -- Config Options --

`nick = ""; -- Name of the bot.`

`ai_plugins = {}; -- Table of ai_plugins to load.`

`-- Table of user permissions used by plug-ins. Example:  `
`permissions = {  `
`  ["user1@example.org"] = {"permission1", "permission2"},   `
`  ["user2@example2.org"] = {"permission3", "permission4", "permission5"}`  
`};`  
