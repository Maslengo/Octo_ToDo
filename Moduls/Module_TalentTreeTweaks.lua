local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------
function func_TalentTreeTweaks()
	if Octo_ToDo_DB_Vars.config.TalentTreeTweaks then
		if Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Alpha then
			-- if not IsAddOnLoaded("TalentTreeViewer") then
			-- 	LoadAddOn("TalentTreeViewer")
			-- end
			if not IsAddOnLoaded("Blizzard_ClassTalentUI") then
				LoadAddOn("Blizzard_ClassTalentUI")
			end
			local function TrySetAlpha(frame, value)
				if frame and frame.SetAlpha and frame.GetAlpha then
					frame:SetAlpha(value)
				end
			end
			local function TrySetScale(frame, value)
				if frame then
					frame:SetScale(value)
				end
			end
			local function UpdateBackground(value, config)
				if config == "TalentTreeTweaks_Alpha" then
					if ClassTalentFrame then
						TrySetAlpha(ClassTalentFrame.TalentsTab.Background, value)
						TrySetAlpha(ClassTalentFrame.TalentsTab.BlackBG, value)
						TrySetAlpha(ClassTalentFrame.Center, value) -- ElvUI background
						TrySetAlpha(ClassTalentFrameBg, value)
					end
					if TalentViewer and TalentViewer.GetTalentFrame and TalentViewer:GetTalentFrame() then
						local talentViewerFrame = TalentViewer:GetTalentFrame()
						TrySetAlpha(talentViewerFrame.Background, value)
						TrySetAlpha(talentViewerFrame.BlackBG, value)
						TrySetAlpha(TalentViewer_DFBg, value)
					end
					if TalentLoadoutManager then
						if TalentLoadoutManager.SideBarModule and TalentLoadoutManager.SideBarModule.SideBar then
							local sideBar = TalentLoadoutManager.SideBarModule.SideBar
							TrySetAlpha(sideBar.Background, value)
						end
						if TalentLoadoutManager.TTVSideBarModule and TalentLoadoutManager.TTVSideBarModule.SideBar then
							local sideBar = TalentLoadoutManager.TTVSideBarModule.SideBar
							TrySetAlpha(sideBar.Background, value)
						end
					end
				end
				if config == "TalentTreeTweaks_Scale" then
					if ClassTalentFrame then
						TrySetScale(ClassTalentFrame, value)
						-- TrySetScale(ClassTalentFrame.TalentsTab.Background, value)
						-- TrySetScale(ClassTalentFrame.TalentsTab.BlackBG, value)
						-- TrySetScale(ClassTalentFrame.Center, value) -- ElvUI background
						-- TrySetScale(ClassTalentFrameBg, value)
					end
				end
			end
			local function CreateSlider(talentFrame, config, text, minValue, maxValue, steps, xOffset, yOffset)
				slider = CreateFrame("Slider", nil, talentFrame, "MinimalSliderWithSteppersTemplate")
				slider:OnLoad()
				slider:SetScale(E.Octo_Globals.slider_scale)
				slider:SetFrameStrata("HIGH")
				slider:SetPoint("TOP", talentFrame, "TOP", xOffset or 0, yOffset or 0)
				formatters = {
					[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
						return text
					end,
					[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
						return E.Octo_Globals.Green_Color..tonumber(string.format("%.3f", value)).."|r"
					end,
				}
				slider:Init(Octo_ToDo_DB_Vars.config[config], minValue, maxValue, steps, formatters)
				slider:SetWidth(200)
				slider:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
						Octo_ToDo_DB_Vars.config[config] = value
						UpdateBackground(value, config)
				end)
			end
			if ClassTalentFrame then
				C_Timer.After(.1, function()
					----------------------------------------------------------------
					ClassTalentFrame:EnableMouse(true)
					ClassTalentFrame:SetMovable(true)
					ClassTalentFrame:RegisterForDrag("LeftButton")
					ClassTalentFrame:SetScript("OnDragStart", ClassTalentFrame.StartMoving)
					ClassTalentFrame:SetScript("OnDragStop", function() ClassTalentFrame:StopMovingOrSizing() end)
					UpdateBackground(Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Scale, "TalentTreeTweaks_Scale")
					UpdateBackground(Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Alpha, "TalentTreeTweaks_Alpha")
					----------------------------------------------------------------
					CreateSlider(ClassTalentFrame, "TalentTreeTweaks_Scale", "Scale", .5, 1, 10, 130, 30)
					CreateSlider(ClassTalentFrame, "TalentTreeTweaks_Alpha", "Alpha", 0, 1, 10, -130, 30)
					----------------------------------------------------------------
				end)
			end
		end
	end
end
tinsert(E.Octo_Globals.modules, func_TalentTreeTweaks)