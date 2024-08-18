local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
-- HideErrorMessages
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.Hide_Error_Messages then
			local OrigErrHandler = UIErrorsFrame:GetScript("OnEvent")
			UIErrorsFrame:SetScript("OnEvent", function(self, event, id, err, ...)
					if event == "UI_ERROR_MESSAGE" then
						if err == ERR_INV_FULL
						or err == ERR_QUEST_LOG_FULL
						or err == ERR_RAID_GROUP_ONLY
						or err == ERR_PARTY_LFG_BOOT_LIMIT
						or err == ERR_PARTY_LFG_BOOT_DUNGEON_COMPLETE
						or err == ERR_PARTY_LFG_BOOT_IN_COMBAT
						or err == ERR_PARTY_LFG_BOOT_IN_PROGRESS
						or err == ERR_PARTY_LFG_BOOT_LOOT_ROLLS
						or err == ERR_PARTY_LFG_TELEPORT_IN_COMBAT
						or err == ERR_PET_SPELL_DEAD
						or err == ERR_PLAYER_DEAD
						or err == SPELL_FAILED_TARGET_NO_POCKETS
						or err == ERR_ALREADY_PICKPOCKETED
						or err:find(format(ERR_PARTY_LFG_BOOT_NOT_ELIGIBLE_S, ".+"))
						then
							return OrigErrHandler(self, event, id, err, ...)
						end
					elseif event == "UI_INFO_MESSAGE" then
						return OrigErrHandler(self, event, id, err, ...)
					end
			end)
		end
end)

