local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--HideZoneText
tinsert(E.Octo_Globals.modules, function()
				if E.Octo_Func.Octo_IsRetail() == true then
		if Octo_ToDo_DB_Vars.config.Hide_Zone_Text then
			ZoneTextFrame:SetScript("OnShow", ZoneTextFrame.Hide);
			SubZoneTextFrame:SetScript("OnShow", SubZoneTextFrame.Hide);
			-- ZoneTextFrame:HookScript("OnShow", function(self, ...)
			-- ZoneTextFrame:UnregisterAllEvents()
			-- ZoneTextFrame:Hide()
			-- end)
			-- SubZoneTextFrame:HookScript("OnShow", function(self, ...)
			-- SubZoneTextFrame:UnregisterAllEvents()
			-- SubZoneTextFrame:Hide()
			-- end)
			PVPArenaTextString:HookScript("OnShow", function(self, ...)
					-- PVPArenaTextString:UnregisterAllEvents()
					PVPArenaTextString:Hide()
			end)
			ZoneTextString:HookScript("OnShow", function(self, ...)
					-- ZoneTextString:UnregisterAllEvents()
					ZoneTextString:Hide()
			end)
			SubZoneTextString:HookScript("OnShow", function(self, ...)
					-- SubZoneTextString:UnregisterAllEvents()
					SubZoneTextString:Hide()
			end)
			-- EventToastManagerFrame:HookScript("OnShow", function(self, ...)
			-- EventToastManagerFrame:UnregisterAllEvents()
			-- EventToastManagerFrame:Hide()
			-- end)
			hooksecurefunc(EventToastManagerFrame, "Show", function()
					if not EventToastManagerFrame.HideButton:IsShown() then
						if EventToastManagerFrame.currentDisplayingToast then
							if IsInJailersTower() then
								-- Show floor summary
								local title = EventToastManagerFrame.currentDisplayingToast.Title:GetText() or nil
								if title and strfind(title, JAILERS_TOWER_SCENARIO_FLOOR) then
									-- Add right-click to close floor summary
									EventToastManagerFrame.currentDisplayingToast:SetScript("OnMouseDown", function(self, btn)
											if btn == "RightButton" then
												EventToastManagerFrame:CloseActiveToasts()
												return
											end
									end)
									return
								end
							end
							EventToastManagerFrame.currentDisplayingToast:OnAnimatedOut()
						end
					end
			end)
			-- func_Octo_LoadAddOn(Blizzard_MajorFactionRenownToast)
			--Blizzard_MajorFactionRenownToast.lua
			-- MajorFactionRenownToast.IconSwirlModelScene:Show()
			-- MajorFactionRenownToast.ToastBG:Show()
			-- MajorFactionRenownToast.RewardDescription:Show()
		end
	end
end)