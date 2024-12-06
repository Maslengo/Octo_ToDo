local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
local wipe = false
function E.Items()
	local Items = {
		type = "group",
		childGroups = "tree",
		name = ITEMS,
		args = {
			-------------------------------------------------
			ReloadHeader452 = {
				type = "header",
				name = "",
				order = 2,
			},
			-------------------------------------------------
			Items = {
				type = "toggle",
				name = ITEMS,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Items
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Items = value
				end,
				width = E.FULL_WIDTH/4,
				order = 3,
			},
			ItemsShowAllways = {
				type = "toggle",
				name = BATTLEFIELD_MINIMAP_SHOW_ALWAYS,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.ItemsShowAllways
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.ItemsShowAllways = value
				end,
				width = E.FULL_WIDTH/4,
				order = 4,
			},







			-------------------------------------------------
			ItemsALLTURNON = {
				type = "execute",
				name = ENABLE_ALL_ADDONS,
				func = function()
					for itemID, v in next, (Octo_ToDo_DB_Config.ItemDB) do
						Octo_ToDo_DB_Config.ItemDB[itemID] = true
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 5,
			},
			-------------------------------------------------
			ItemsALLTURNOFF = {
				type = "execute",
				name = "Выключить все",
				func = function()
					for itemID, v in next, (Octo_ToDo_DB_Config.ItemDB) do
						Octo_ToDo_DB_Config.ItemDB[itemID] = false
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 6,
			},
			-------------------------------------------------
			-------------------------------------------------
			ReloadHeader453 = {
				type = "header",
				name = "",
				order = 7,
			},
		},
	}
	if wipe == false then
		wipe = true
		local index = 0
				for itemID, v in next, (Octo_ToDo_DB_Config.ItemDB) do
					index = index + 1
					E.func_TableMerge(Items.args, {
							["addonNameQWE65"..index] = {
								type = "toggle",
								name = E.func_itemTexture(itemID)..E.func_itemName(itemID),
								desc = "",
								get = function()
									return Octo_ToDo_DB_Config.ItemDB[itemID]
								end,
								set = function(_, value)
									Octo_ToDo_DB_Config.ItemDB[itemID] = value
								end,
								width = E.FULL_WIDTH/4, --.9,
								order = 123 + index,
							},
					})
				end
	end
	return Items
end
