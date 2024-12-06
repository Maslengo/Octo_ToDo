local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
local wipe = false
function E.Reputations()
	local Reputations = {
		type = "group",
		childGroups = "tree",
		name = REPUTATION,
		args = {
			-------------------------------------------------
			Reputationsinstructions = {
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
			Reputations = {
				type = "toggle",
				name = REPUTATION,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Reputations
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Reputations = value
				end,
				width = 1.8,
				order = 3,
			},
			-------------------------------------------------
		},
	}
	if wipe == false then
		wipe = true
		local index = 0
		if OCTO_DB_reputations_test then
			for reputationHEADER, tbl in next, (OCTO_DB_reputations_test) do
				index = index + 1
				E.MergeTable(Reputations.args, {
						["addonNameHEADER5"..index] = {
							type = "header",
							name = E.func_reputationName(reputationHEADER),
							order = 123 + index,
						},
				})
				for reputationID, config in next, (tbl) do
					index = index + 1
					E.MergeTable(Reputations.args, {
							["addonNameQWE6"..index] = {
								type = "toggle",
								name = E.func_reputationName(reputationID),
								desc = "",
								get = function()
									return OCTO_DB_reputations_test[reputationHEADER][reputationID]
								end,
								set = function(_, value)
									OCTO_DB_reputations_test[reputationHEADER][reputationID] = value
								end,
								width = E.FULL_WIDTH/4, --.9,
								order = 123 + index,
							},
					})
				end
			end
		end
	end
	E.MergeTable(Reputations.args, {
			["ReloadHeader4second322"..1] = {
				type = "header",
				name = "",
				order = 322 + 1,
			},
	})
	return Reputations
end
