AI plugin loader/framework for Riddim bots.

To use: Add the ai_loader plugin to your Riddim config then create/edit the options below in said config with a list of plugins to load.

Only tested with Ubuntu Linux.

-- Config Options --

nick = ""; -- Name of the bot.

ai_plugins = {}; -- Table of ai_plugins to load.


-- Table of user permissions used by plug-ins. Example:
permissions = {
  ["user1@example.org"] = {"permission1", "permission2"},
  ["user2@example2.org"] = {"permission3", "permission4", "permission5"}
};

