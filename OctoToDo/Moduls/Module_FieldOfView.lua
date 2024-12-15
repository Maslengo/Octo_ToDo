local GlobalAddonName, E = ... 
----------------------------------------------------------------
local FieldOfView_EventFrame = nil
function func_FieldOfView()
	if OctoToDo_DB_Vars.FieldOfView == true then
		print ("QWE")
		function FieldOfView_OnLoad()
			print ("FieldOfView_OnLoad")
			if not FieldOfView_EventFrame then
				FieldOfView_EventFrame = CreateFrame("FRAME", E.func_AddonTitle(GlobalAddonName)..E.func_GenerateUniqueID())
				FieldOfView_EventFrame:Hide()
				FieldOfView_EventFrame:RegisterEvent("VARIABLES_LOADED")
				FieldOfView_EventFrame:RegisterEvent("PLAYER_LOGIN")
				FieldOfView_EventFrame:SetScript("OnEvent", function(...)
						FieldOfView_OnEvent(...)
				end)
			end
		end
		function FieldOfView_OnEvent(self, event, ...)
			print ("FieldOfView_OnEvent")
			if event == "VARIABLES_LOADED" and not InCombatLockdown() then
				OctoToDo_DB_Vars = OctoToDo_DB_Vars or {}
				OctoToDo_DB_Vars = OctoToDo_DB_Vars or {}
				if OctoToDo_DB_Vars.FoV_top == nil then OctoToDo_DB_Vars.FoV_top = 0 end
				if OctoToDo_DB_Vars.FoV_bottom == nil then OctoToDo_DB_Vars.FoV_bottom = 0 end
				if OctoToDo_DB_Vars.FoV_left == nil then OctoToDo_DB_Vars.FoV_left = 0 end
				if OctoToDo_DB_Vars.FoV_right == nil then OctoToDo_DB_Vars.FoV_right = 0 end
			end
			if event == "PLAYER_LOGIN" and not InCombatLockdown() then
				C_Timer.After(0, function()
					FieldOfView_function()
				end)
			end
		end
		local function change_worldframe_setpoints(TOP, BOTTOM, LEFT, RIGHT, scale)
			print ("change_worldframe_setpoints")
			WorldFrame:ClearAllPoints()
			WorldFrame:SetPoint("LEFT", (LEFT/scale), 0)
			WorldFrame:SetPoint("RIGHT", -(RIGHT/scale), 0)
			WorldFrame:SetPoint("TOP", 0, -(TOP/scale))
			WorldFrame:SetPoint("BOTTOM", 0, (BOTTOM/scale))
		end
		function FieldOfView_function()
			print ("FieldOfView_function")
			local scale = GetPhysicalScreenSize()/WorldFrame:GetWidth() -- 1.4
			if OctoToDo_DB_Vars.FoV_top and OctoToDo_DB_Vars.FoV_bottom and OctoToDo_DB_Vars.FoV_left and OctoToDo_DB_Vars.FoV_right then
				change_worldframe_setpoints(OctoToDo_DB_Vars.FoV_top, OctoToDo_DB_Vars.FoV_bottom, OctoToDo_DB_Vars.FoV_left, OctoToDo_DB_Vars.FoV_right, scale)
			end
		end
		FieldOfView_OnLoad()
		FieldOfView_function()
	end
end
tinsert(E.Modules, func_FieldOfView)
