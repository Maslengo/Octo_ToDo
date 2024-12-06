local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
local continue = true
function E.LoadAddons()
	local LoadAddons = {
		type = "group",
		childGroups = "tree",
		name = ADDONS,
		args = {
			-------------------------------------------------
			LoadAddonsinstructions = {
				type = "description",
				name = "These options allow you to toggle various options.",
				fontSize = "medium",
				order = 1,
			},
			-------------------------------------------------
			ReloadHeader4 = {
				type = "header",
				name = "",
				order = 2,
			},
			-------------------------------------------------
			LoadAddons = {
				type = "toggle",
				name = "Force Load Addons", -- "AUTO "..SELL_ALL_JUNK_ITEMS_EXCLUDE_HEADER, --
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.LoadAddons
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.LoadAddons = value
				end,
				width = E.HALF_WIDTH, -- "full",
				order = 3,
			},
			-------------------------------------------------
			Reload4 = {
				type = "execute",
				name = E.White_Color.."Reload UI".."|r",
				func = function()
					return ReloadUI()
				end,
				width = E.HALF_WIDTH,
				order = 4,
			},
			-------------------------------------------------
			ReloadHeader4second = {
				type = "header",
				name = "",
				order = 5,
			},
			-------------------------------------------------
		},
	}
	-- for index = 1, C_AddOns.GetNumAddOns() do
	--     local name = C_AddOns.GetAddOnInfo(index)
	--     local title = select(2, C_AddOns.GetAddOnInfo(name)) or " "
	--     local notes = select(3, C_AddOns.GetAddOnInfo(name)) or " "
	--     print (index, name, title, notes)
	-- end
	if continue == true then
		continue = false
		for index, addonName in ipairs(E.OctoTable_LoadAddons) do
			-- for index = 1, C_AddOns.GetNumAddOns() do
			-- local addonName = C_AddOns.GetAddOnInfo(index)
			-- -- local title = select(2, C_AddOns.GetAddOnInfo(addonName)) or " "
			-- -- local notes = select(3, C_AddOns.GetAddOnInfo(addonName)) or " "
			if C_AddOns.DoesAddOnExist(addonName) then
				local title = select(2, C_AddOns.GetAddOnInfo(addonName)) or " "
				local notes = select(3, C_AddOns.GetAddOnInfo(addonName)) or " "
				E.MergeTable(LoadAddons.args, {
						["addonNameQWE"..index] = {
							type = "toggle",
							name = title,
							desc = notes,
							get = function()
								return Octo_ToDo_DB_Vars.config.Load[addonName]
							end,
							set = function(_, value)
								Octo_ToDo_DB_Vars.config.Load[addonName] = value
							end,
							width = E.HALF_WIDTH,
							order = 6 + index,
						},
				})
			else
				E.MergeTable(LoadAddons.args, {
						["addonNameQWE"..index] = {
							type = "toggle",
							name = E.Gray_Color..addonName.."|r",
							desc = "",
							get = function()
								return Octo_ToDo_DB_Vars.config.Load[addonName]
							end,
							set = function(_, value)
								Octo_ToDo_DB_Vars.config.Load[addonName] = false
							end,
							width = E.HALF_WIDTH,
							order = 999 + index,
						},
				})
			end
		end
	end
	E.MergeTable(LoadAddons.args, {
			["ReloadHeader4second322"..1] = {
				type = "header",
				name = "",
				order = 322 + 1,
			},
	})
	return LoadAddons
end

