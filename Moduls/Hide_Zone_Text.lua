local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_Zone_Text
tinsert(E.Modules, function()
		if OctoToDo_DB_Vars.config.Hide_Zone_Text then
			ZoneTextFrame:SetScript("OnShow", ZoneTextFrame.Hide);
			SubZoneTextFrame:SetScript("OnShow", SubZoneTextFrame.Hide);
			PVPArenaTextString:HookScript("OnShow", function(self, ...)
					PVPArenaTextString:Hide()
			end)
			ZoneTextString:HookScript("OnShow", function(self, ...)
					ZoneTextString:Hide()
			end)
			SubZoneTextString:HookScript("OnShow", function(self, ...)
					SubZoneTextString:Hide()
			end)
			hooksecurefunc(EventToastManagerFrame, "Show", function()
					if not EventToastManagerFrame.HideButton:IsShown() then
						if EventToastManagerFrame.currentDisplayingToast then
							if IsInJailersTower() then
								local title = EventToastManagerFrame.currentDisplayingToast.Title:GetText() or nil
								if title and strfind(title, JAILERS_TOWER_SCENARIO_FLOOR) then
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
		end
end)