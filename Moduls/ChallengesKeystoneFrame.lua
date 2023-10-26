local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--ChallengesKeystoneFrame
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.ChallengesKeystoneFrame then
			function ChallengesKeystoneFrameOnLoad()
				local EventFrame = nil
				if not EventFrame then
					EventFrame = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID())
					EventFrame:Hide()
				end
				EventFrame:RegisterEvent("CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN")
				EventFrame:RegisterEvent("READY_CHECK")
				-- event CHALLENGE_MODE_KEYSTONE_SLOTTED
				-- C_ChallengeMode.HasSlottedKeystone()
				EventFrame:SetScript("OnEvent", function(...)
						ChallengesKeystoneFrameOnEvent(...)
				end)
			end
			function ChallengesKeystoneFrameOnEvent(self, event, ...)
				if (event == "CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN") and not InCombatLockdown() then
					----------------------------------------------------------------
					--------------------- MyButton_DoReadyCheck --------------------
					----------------------------------------------------------------
					if not MyButton_DoReadyCheck then
						MyButton_DoReadyCheck = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID().."MyButton_DoReadyCheck", ChallengesKeystoneFrame, "UIPanelButtonTemplate")
					end
					MyButton_DoReadyCheck:SetPoint("TOPRIGHT", ChallengesKeystoneFrame, "TOPLEFT", 0, 0)
					MyButton_DoReadyCheck:SetSize(120, 24)
					MyButton_DoReadyCheck:RegisterForClicks("LeftButtonDown", "RightButtonDown")
					MyButton_DoReadyCheck:SetText(READY_CHECK)
					MyButton_DoReadyCheck:SetScript("OnClick", function(self, button)
							DoReadyCheck()
					end)
					----------------------------------------------------------------
					--------------------- MyButton_DoPullTimer ---------------------
					----------------------------------------------------------------
					if not MyButton_DoPullTimer then
						MyButton_DoPullTimer = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID().."MyButton_DoPullTimer", ChallengesKeystoneFrame, "UIPanelButtonTemplate")
					end
					MyButton_DoPullTimer:SetPoint("TOPRIGHT", ChallengesKeystoneFrame, "TOPLEFT", 0, -24)
					MyButton_DoPullTimer:SetSize(120, 24)
					MyButton_DoPullTimer:RegisterForClicks("LeftButtonDown", "RightButtonDown")
					local shortTime = 5
					local longTime = 10
					local autoStart = true
					local cancelIt = true
					local dbmBigwigs = 3
					local breakIt = false
					local noChat = false
					local handled = false
					local iText = PLAYER_COUNTDOWN_BUTTON
					MyButton_DoPullTimer:SetText(iText)
					MyButton_DoPullTimer:SetScript("OnClick", function(self, button)
							if handled == false then
								if cancelIt == true then self:SetText(CANCEL) end
								breakIt = false
								handled = true
								local x = nil
								--Set time based on settings choosen
								if button == 'RightButton' then x = shortTime else x = longTime end
								local cTime = x
								C_Timer.NewTicker(1, function(self)
										if breakIt then
											self:Cancel()
											C_PartyInfo.DoCountdown(0)
											if noChat == false then SendChatMessage("PULL Canceled", "Party") end
											C_ChatInfo.SendAddonMessage("D4", ("PT\t%s\t%d"):format(0, instanceId), IsInGroup(2) and "INSTANCE_CHAT" or "RAID")
										end
										if not UnitInParty("player") then
											self:Cancel()
										elseif x == 0 then
											self:Cancel()
											handled = false
											if noChat == false then SendChatMessage(">>PULL NOW<<", "Party") end
											if autoStart == false then MyButton_DoPullTimer:SetText(iText) end
											if autoStart and nil ~= C_ChallengeMode.GetSlottedKeystoneInfo() then
												C_ChallengeMode.StartChallengeMode()
												ChallengesKeystoneFrame:Hide()
												ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Key started automatically", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color))
											end
										else
											if x == cTime then
												local _, _, _, _, _, _, _, id = GetInstanceInfo()
												local instanceId = tonumber(id) or 0
												if dbmBigwigs == 1 or dbmBigwigs == 3 then C_PartyInfo.DoCountdown(cTime) end
												if dbmBigwigs == 2 or dbmBigwigs == 3 then C_ChatInfo.SendAddonMessage("D4", ("PT\t%s\t%d"):format(cTime, instanceId), IsInGroup(2) and "INSTANCE_CHAT" or "RAID") end
											end
											if breakIt == false then
												if noChat == false then SendChatMessage(format(("PULL in %ds"), x), "Party") end
											end
										end x = x - 1
								end)
							else
								if cancelIt == true then
									self:SetText(iText)
									breakIt = true
									handled = false
								end
							end
					end)
					----------------------------------------------------------------
					local difficultyID = select(3, GetInstanceInfo()) or "|cffFF0000-|r"
					if difficultyID == 23 and ChallengesKeystoneFrame then
						ChallengesKeystoneFrame:SetPoint("CENTER", 400, 0)
						ChallengesKeystoneFrame:SetScale(0.8)
						ChallengesKeystoneFrame:EnableMouse(true)
						ChallengesKeystoneFrame:SetMovable(true)
						ChallengesKeystoneFrame:RegisterForDrag("LeftButton")
						ChallengesKeystoneFrame:SetScript("OnDragStart", ChallengesKeystoneFrame.StartMoving)
						ChallengesKeystoneFrame:SetScript("OnDragStop", function() ChallengesKeystoneFrame:StopMovingOrSizing() end)
					end
					----------------------------------------------------------------
					local difficultyID = select(3, GetInstanceInfo()) or "|cffFF0000-|r"
					local map = C_Map.GetBestMapForUnit("player")
					if difficultyID == 23 then
						for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
								local itemID = C_Container.GetContainerItemID(bag, slot)
								if itemID == 180653 then
									C_Container.UseContainerItem(bag, slot)
								end
							end
						end
					end
					----------------------------------------------------------------
				end -- for event
				if event == "READY_CHECK" then
					----------------------------------------------------------------
					local difficultyID = select(3, GetInstanceInfo()) or "|cffFF0000-|r"
					-- local map = C_Map.GetBestMapForUnit("player")
					if difficultyID == 23 then
						for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									-- KeyLevel
									local hyperlink = containerInfo.hyperlink
									if hyperlink:find("keystone:180653") or hyperlink:find("keystone:138019") or hyperlink:find("keystone:158923") then
										if C_MythicPlus.GetOwnedKeystoneMapID() == select(8,GetInstanceInfo()) then
											ChatFrame1:AddMessage ("Your Key? "..hyperlink)
										end
									end
								end
							end
						end
					end
					----------------------------------------------------------------
				end -- for event
			end
			ChallengesKeystoneFrameOnLoad()
		end
end)
