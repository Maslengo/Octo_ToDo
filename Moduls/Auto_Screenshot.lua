local GlobalAddonName,  E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName,  "Title")
----------------------------------------------------------------------------------------------------------------------------------
--Auto_Screenshot
tinsert(E.Octo_Globals.modules,  function()
		if Octo_ToDoVars.config.Auto_Screenshot then
			local EventFrame = nil
			local function Octo_OnLoad()
				if not EventFrame then
					EventFrame = CreateFrame("FRAME",  AddonTitle..E.Octo_Func.GenerateUniqueID())
				end
				EventFrame:RegisterEvent("PLAYER_LEVEL_UP")
				EventFrame:RegisterEvent("ACHIEVEMENT_EARNED")
				EventFrame:RegisterEvent("SHOW_LOOT_TOAST_LEGENDARY_LOOTED")
				EventFrame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
				EventFrame:RegisterEvent("NEW_MOUNT_ADDED")
				EventFrame:RegisterEvent("NEW_PET_ADDED")
				EventFrame:RegisterEvent("NEW_TOY_ADDED")
				EventFrame:RegisterEvent("TRADE_ACCEPT_UPDATE")
				-- EventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
			end
			-- print (E.Octo_Globals.Red_Color..CurrentTime.."|r")
			local function Octo_OnEvent(self,  event,  ...)
				local generalDelay = .1
				local achievementDelay = .1
				local legendaryDelay = .1
				local levelUpDelay = .1
				local CurrentTime = date("%m/%d/%y %H:%M:%S")
				-- local CurrentTime = date("%m%d%y_%H%M%S")
				-- CurrentTime = "WoWScrnShot_"..CurrentTime
				if event == "SHOW_LOOT_TOAST_LEGENDARY_LOOTED" then
					print (E.Octo_Func.func_Gradient("Received a legendary item: ",  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color).." "..E.Octo_Globals.Yellow_Color..CurrentTime.."|r")
					C_Timer.After(generalDelay,  function()
							Screenshot()
					end)
				elseif event == "ACHIEVEMENT_EARNED" then
					print (E.Octo_Func.func_Gradient("Earned an achievement: ",  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color).." "..E.Octo_Globals.Yellow_Color..CurrentTime.."|r")
					C_Timer.After(generalDelay,  function()
							Screenshot()
					end)
				elseif event == "PLAYER_LEVEL_UP" then
					print (E.Octo_Func.func_Gradient("Leveled up: ",  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color).." "..E.Octo_Globals.Yellow_Color..CurrentTime.."|r")
					C_Timer.After(generalDelay,  function()
							Screenshot()
					end)
				elseif event == "CHALLENGE_MODE_COMPLETED" then
					print (E.Octo_Func.func_Gradient("Completed M+: ",  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color).." "..E.Octo_Globals.Yellow_Color..CurrentTime.."|r")
					C_Timer.After(generalDelay,  function()
							Screenshot()
					end)
				elseif (event == "NEW_MOUNT_ADDED" or event == "NEW_PET_ADDED" or event == "NEW_TOY_ADDED") then
					if event == "NEW_MOUNT_ADDED" then
						-- local mountName = C_MountJournal.GetMountInfoByID(payload)
						-- print (E.Octo_Func.func_Gradient("Added: "..mountName.." to your mount journal: ",  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color).." "..E.Octo_Globals.Yellow_Color..CurrentTime.."|r")
						print (E.Octo_Func.func_Gradient(CurrentTime,  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color))
						C_Timer.After(generalDelay,  function()
								Screenshot()
						end)
					elseif event == "NEW_PET_ADDED" then
						-- local _,  _,  _,  _,  _,  _,  _,  petName = C_PetJournal.GetPetInfoByPetID(payload)
						-- print (E.Octo_Func.func_Gradient("Added: "..petName.." to your pet journal: ",  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color).." "..E.Octo_Globals.Yellow_Color..CurrentTime.."|r")
						print (E.Octo_Func.func_Gradient(CurrentTime,  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color))
						C_Timer.After(generalDelay,  function()
								Screenshot()
						end)
					elseif event == "NEW_TOY_ADDED" then
						-- local _,  toyName = C_ToyBox.GetToyInfo(payload)
						-- print (E.Octo_Func.func_Gradient("Added: "..toyName.." to your toy box: ",  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color).." "..E.Octo_Globals.Yellow_Color..CurrentTime.."|r")
						print (E.Octo_Func.func_Gradient(CurrentTime,  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color))
						C_Timer.After(generalDelay,  function()
								Screenshot()
						end)
					end
				elseif event == "TRADE_ACCEPT_UPDATE" then
					print (E.Octo_Func.func_Gradient("Completed M+: ",  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color).." "..E.Octo_Globals.Yellow_Color..CurrentTime.."|r")
					C_Timer.After(generalDelay,  function()
							Screenshot()
					end)
				-- elseif event == "PLAYER_STARTED_MOVING" then
				-- 	print (E.Octo_Func.func_Gradient("PLAYER_STARTED_MOVING: ",  E.Octo_Globals.Addon_Left_Color,  E.Octo_Globals.Addon_Right_Color).." "..E.Octo_Globals.Yellow_Color..CurrentTime.."|r")
				-- 	C_Timer.After(generalDelay,  function()
				-- 			Screenshot()
				-- 	end)
				end
			end
			Octo_OnLoad()
			EventFrame:SetScript("OnEvent",  Octo_OnEvent)
		end
end)