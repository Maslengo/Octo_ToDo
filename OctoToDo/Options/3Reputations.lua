local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
local wipe = false
function E.Reputations()
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local Reputations = {
		type = "group",
		childGroups = "tree",
		name = E.White_Color..REPUTATION.."|r",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Reputations = {
				type = "toggle",
				name = REPUTATION,
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.Reputations
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Reputations = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			ReputationALLTURNON = {
				type = "execute",
				name = ENABLE_ALL_ADDONS,
				func = function()
					for index, tbl in ipairs(E.OctoTable_Reputations) do
						for i, v in ipairs(tbl) do
							OctoToDo_DB_Config.ReputationDB[v.id] = true
						end
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ReputationALLTURNOFF = {
				type = "execute",
				name = DISABLE_ALL_ADDONS,
				func = function()
					for index, tbl in ipairs(E.OctoTable_Reputations) do
						for i, v in ipairs(tbl) do
							OctoToDo_DB_Config.ReputationDB[v.id] = false
						end
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
		},
	}
	if wipe == false then
		wipe = true
		local index = 0
		for i, tbl in ipairs(E.OctoTable_Reputations) do
			index = index + 1
			E.func_TableMerge(Reputations.args, {
					["addonNameHEADER5"..index] = {
						type = "header",
						name = tbl.header,
						order = GetOrder(),
					},
			})
			for i, v in ipairs(tbl) do
				index = index + 1
				E.func_TableMerge(Reputations.args, {
						["addonNameQWE6"..index] = {
							type = "toggle",
							name = E.func_reputationName(v.id),
							desc = "\n".."id: |r"..E.Green_Color..tostring(v.id).."|r",
							get = function()
								return OctoToDo_DB_Config.ReputationDB[v.id]
							end,
							set = function(_, value)
								OctoToDo_DB_Config.ReputationDB[v.id] = value
							end,
							width = E.FULL_WIDTH/2, --.9,
							order = GetOrder(),
						},
				})
			end
		end
	end
	E.func_TableMerge(Reputations.args, {
			["ReloadHeader4second777"..1] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
	})
	return Reputations
end