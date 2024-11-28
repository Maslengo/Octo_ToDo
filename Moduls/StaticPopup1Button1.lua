local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- StaticPopup1Button1
tinsert(E.Modules, function()
		if Octo_ToDo_DB_Vars.config.StaticPopup1Button1 then
			----------------------------------------------------------------------------------------------------------------------------------
			----------------------------------------------------------------------------------------------------------------------------------
			local EventFrame_SPB = nil
			local function accept()
				if StaticPopup1Button1 then
					StaticPopup1Button1:Click()
				end
			end
			local function Octo_OnEvent(self, event, ...)
				C_Timer.After(0, function()
						accept()
				end)
			end
			function Octo_OnLoad()
				if not EventFrame_SPB then
					EventFrame_SPB = CreateFrame("FRAME", E.func_GenerateUniqueID())
				end
				EventFrame_SPB:RegisterEvent("EQUIP_BIND_CONFIRM")
				EventFrame_SPB:RegisterEvent("EQUIP_BIND_REFUNDABLE_CONFIRM")
				EventFrame_SPB:RegisterEvent("VOID_DEPOSIT_WARNING")
				EventFrame_SPB:RegisterEvent("USE_NO_REFUND_CONFIRM")
				EventFrame_SPB:RegisterEvent("EQUIP_BIND_TRADEABLE_CONFIRM")
				EventFrame_SPB:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")


				-- EventFrame_SPB:RegisterEvent("CONVERT_TO_BIND_TO_ACCOUNT_CONFIRM") --sequre
				-- EventFrame_SPB:RegisterEvent("SPELL_CONFIRMATION_PROMPT") --block
			end
			Octo_OnLoad()
			do
				EventFrame_SPB:HookScript("OnEvent", Octo_OnEvent)
			end
			-- /run local function accept() StaticPopup1Button1:Click() end
			-- StaticPopupDialogs["BID_AUCTION"].OnShow=accept
			-- StaticPopupDialogs["BUYOUT_AUCTION"].OnShow=accept
		end
end)