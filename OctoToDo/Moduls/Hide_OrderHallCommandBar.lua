local GlobalAddonName, E = ... 
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_OrderHallCommandBar

tinsert(E.Modules, function()
	if OctoToDo_DB_Vars.Hide_OrderHallCommandBar then

		local function HandleCommandBar()
				_G.OrderHallCommandBar:UnregisterAllEvents()
				_G.OrderHallCommandBar:SetScript("OnShow", _G.OrderHallCommandBar.Hide)
				_G.OrderHallCommandBar:Hide()
				UIParent:UnregisterEvent("UNIT_AURA") --Only used for OrderHall Bar
				DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("OrderHallCommandBar Hide", E.Addon_Left_Color, E.Addon_Right_Color))
		end

		if _G.OrderHallCommandBar then
			HandleCommandBar()
		elseif IsRetail() then
			local frame = CreateFrame("Frame")
			frame:RegisterEvent("ADDON_LOADED")
			frame:SetScript("OnEvent", function(Frame, event, addon)
				if event == "ADDON_LOADED" and addon == "Blizzard_OrderHallUI" then
					if InCombatLockdown() then
						Frame:RegisterEvent("PLAYER_REGEN_ENABLED")
					else
						HandleCommandBar()
					end
					Frame:UnregisterEvent(event)
				elseif event == "PLAYER_REGEN_ENABLED" then
					HandleCommandBar()
					Frame:UnregisterEvent(event)
				end
			end)
		end



	end
end)