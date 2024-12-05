local GlobalAddonName, E = ...
local LibOctopussy = LibStub("LibOctopussy-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
local continue = true
function E:LoadAddons()
	local LoadAddons = {
		type = "group",
		childGroups = "tree",
		name = E.AddonTitle,
		args = {
			-------------------------------------------------
			instructions4 = {
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
				name = "LoadAddons", -- "AUTO "..SELL_ALL_JUNK_ITEMS_EXCLUDE_HEADER, --
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
	-- /dump C_AddOns.DoesAddOnExist("Details")
	-- /dump C_AddOns.GetNumAddOns()
	if continue == true then
		continue = false
		for index, addonName in ipairs(E.OctoTable_LoadAddons) do
			if C_AddOns.DoesAddOnExist(addonName) then
				LibOctopussy:MergeTable(LoadAddons.args, {
						["addonNameQWE"..index] = {
							type = "toggle",
							name = addonName,
							desc = "",
							get = function()
								return Octo_ToDo_DB_Vars.config.Load[addonName]
							end,
							set = function(_, value)
								Octo_ToDo_DB_Vars.config.Load[addonName] = Octo_ToDo_DB_Vars.config.Load[addonName] or value
							end,
							width = E.HALF_WIDTH,
							order = index + 5,
						},
				})
			end
		end
	end
	return LoadAddons
end

