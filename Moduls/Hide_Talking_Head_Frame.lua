local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
-- TalkingHeadFrame
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.TalkingHeadFrame then
			hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
					self:Hide()
					ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Talking Head Frame canceled", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color))
			end)
		end
end)