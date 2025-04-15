local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
local wipe = false
function E.Reputations()
	local Reputations = {
		type = "group",
		childGroups = "tree",
		name = E.White_Color..REPUTATION.."|r",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = 1,
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
				order = 2,
			},
			-------------------------------------------------
			ReputationALLTURNON = {
				type = "execute",
				name = ENABLE_ALL_ADDONS,
				func = function()
						for reputationID, config in next, (OctoToDo_DB_Config.ReputationDB) do
							OctoToDo_DB_Config.ReputationDB[reputationID] = true
						end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 3,
			},
			-------------------------------------------------
			ReputationALLTURNOFF = {
				type = "execute",
				name = "Выключить все",
				func = function()
						for reputationID, config in next, (OctoToDo_DB_Config.ReputationDB) do
							OctoToDo_DB_Config.ReputationDB[reputationID] = false
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 4,
			},
			-------------------------------------------------
		},
	}
	-- if wipe == false then
	-- 	wipe = true
	-- 	local index = 0
	-- 	if OCTO_DB_reputations_test then
	-- 		for reputationHEADER, tbl in next, (OCTO_DB_reputations_test) do
	-- 			index = index + 1
	-- 			E.func_TableMerge(Reputations.args, {
	-- 					["addonNameHEADER5"..index] = {
	-- 						type = "header",
	-- 						name = reputationHEADER,
	-- 						order = 123 + index,
	-- 					},
	-- 			})
	-- 			for reputationID, config in next, (tbl) do
	-- 				index = index + 1
	-- 				E.func_TableMerge(Reputations.args, {
	-- 						["addonNameQWE6"..index] = {
	-- 							type = "toggle",
	-- 							name = E.func_reputationName(reputationID),
	-- 							desc = "\n".."id: |r"..E.Green_Color..tostring(reputationID).."|r",
	-- 							get = function()
	-- 								return OCTO_DB_reputations_test[reputationHEADER][reputationID]
	-- 							end,
	-- 							set = function(_, value)
	-- 								OCTO_DB_reputations_test[reputationHEADER][reputationID] = value
	-- 							end,
	-- 							width = E.FULL_WIDTH/2, --.9,
	-- 							order = 123 + index,
	-- 						},
	-- 				})
	-- 			end
	-- 		end
	-- 	end
	-- end













	if wipe == false then
		wipe = true


	local list = {}
	for reputationID, tbl in next, (E.OctoTable_Reputations) do
		local Header = tostring(tbl.exp)
		list[Header] = list[Header] or {}
		list[Header][reputationID] = list[Header][reputationID] or true
	end

	-- fpde(list)


		local index = 0
			for reputationHEADER, tbl in next, (list) do
				index = index + 1
				E.func_TableMerge(Reputations.args, {
						["addonNameHEADER5"..index] = {
							type = "header",
							name = reputationHEADER,
							order = 5 + index,
						},
				})
				for reputationID, config in next, (tbl) do
					index = index + 1
					E.func_TableMerge(Reputations.args, {
							["addonNameQWE6"..index] = {
								type = "toggle",
								name = E.func_reputationName(reputationID),
								desc = "\n".."id: |r"..E.Green_Color..tostring(reputationID).."|r",
								get = function()
									return OctoToDo_DB_Config.ReputationDB[reputationID]
								end,
								set = function(_, value)
									OctoToDo_DB_Config.ReputationDB[reputationID] = value
								end,
								width = E.FULL_WIDTH/2, --.9,
								order = 5 + index,
							},
					})
				end
			end
	end







	E.func_TableMerge(Reputations.args, {
			["ReloadHeader4second777"..1] = {
				type = "header",
				name = "",
				order = 777 + 1,
			},
	})
	return Reputations
end

