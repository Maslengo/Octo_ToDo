local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------
function func_FieldOfView()
	if Octo_ToDo_DB_Vars.config.FieldOfView then
		function FieldOfView_OnLoad()
			if not FieldOfView_EventFrame then
				FieldOfView_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
				FieldOfView_EventFrame:Hide()
				FieldOfView_EventFrame:RegisterEvent("VARIABLES_LOADED")
				FieldOfView_EventFrame:RegisterEvent("PLAYER_LOGIN")
				FieldOfView_EventFrame:SetScript("OnEvent", function(...)
						FieldOfView_OnEvent(...)
				end)
			end
		end
		function FieldOfView_OnEvent(self, event, ...)
			if event == "VARIABLES_LOADED" and not InCombatLockdown() then
				Octo_ToDo_DB_Vars = Octo_ToDo_DB_Vars or {}
				Octo_ToDo_DB_Vars.config = Octo_ToDo_DB_Vars.config or {}
				if Octo_ToDo_DB_Vars.config.FoV_top == nil then Octo_ToDo_DB_Vars.config.FoV_top = 0 end
				if Octo_ToDo_DB_Vars.config.FoV_bottom == nil then Octo_ToDo_DB_Vars.config.FoV_bottom = 0 end
				if Octo_ToDo_DB_Vars.config.FoV_left == nil then Octo_ToDo_DB_Vars.config.FoV_left = 0 end
				if Octo_ToDo_DB_Vars.config.FoV_right == nil then Octo_ToDo_DB_Vars.config.FoV_right = 0 end
			end
			if event == "PLAYER_LOGIN" and not InCombatLockdown() then
				C_Timer.After(0, function()
					FieldOfView_function()
				end)
			end
		end
		-- local function create_ChatFrame1_background()
		-- 	if LeftChatPanel and Octo_ToDo_DB_Vars.config.FoV_bottom >= 60 then
		-- 		local t = LeftChatPanel:CreateTexture(nil, "BACKGROUND")
		-- 		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\background\\Square_White.tga")
		-- 		t:SetAllPoints()
		-- 		LeftChatPanel.bg = t
		-- 		LeftChatPanel.bg:SetColorTexture(0, 0, 0, 1)
		-- 	end
		-- end
		local function change_worldframe_setpoints(TOP, BOTTOM, LEFT, RIGHT, scale)
			WorldFrame:ClearAllPoints()
			WorldFrame:SetPoint("LEFT", (LEFT/scale), 0)
			WorldFrame:SetPoint("RIGHT", -(RIGHT/scale), 0)
			WorldFrame:SetPoint("TOP", 0, -(TOP/scale))
			WorldFrame:SetPoint("BOTTOM", 0, (BOTTOM/scale))
		end
		function FieldOfView_function()
			local scale = GetPhysicalScreenSize()/WorldFrame:GetWidth() -- 1.4
			if Octo_ToDo_DB_Vars.config.FoV_top and Octo_ToDo_DB_Vars.config.FoV_bottom and Octo_ToDo_DB_Vars.config.FoV_left and Octo_ToDo_DB_Vars.config.FoV_right then
				-- create_ChatFrame1_background()
				-- print (Octo_ToDo_DB_Vars.config.FoV_top, Octo_ToDo_DB_Vars.config.FoV_bottom, Octo_ToDo_DB_Vars.config.FoV_left, Octo_ToDo_DB_Vars.config.FoV_right)
				change_worldframe_setpoints(Octo_ToDo_DB_Vars.config.FoV_top, Octo_ToDo_DB_Vars.config.FoV_bottom, Octo_ToDo_DB_Vars.config.FoV_left, Octo_ToDo_DB_Vars.config.FoV_right, scale)
			end
		end
		FieldOfView_OnLoad()
		FieldOfView_function()
	end
end
tinsert(E.Octo_Globals.modules, func_FieldOfView)
