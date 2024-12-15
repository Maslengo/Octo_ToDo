local GlobalAddonName, E = ... 
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_Talking_Head_Frame
tinsert(E.Modules, function()
	if OctoToDo_DB_Vars.Hide_Talking_Head_Frame then
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
				self:Hide()
				DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Talking Head Frame canceled", E.Addon_Left_Color, E.Addon_Right_Color))
		end)
	end
end)