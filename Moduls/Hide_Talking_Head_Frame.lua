local GlobalAddonName, E = ... 
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_Talking_Head_Frame
tinsert(E.Modules, function()
	if Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame then
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
				self:Hide()
				DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Talking Head Frame canceled", E.Addon_Left_Color, E.Addon_Right_Color))
		end)
	end
end)