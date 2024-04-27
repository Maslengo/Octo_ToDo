local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
-- StaticPopup1Button1
tinsert(E.Octo_Globals.modules, function()
	if Octo_ToDo_DB_Vars.config.StaticPopup1Button1 then
		----------------------------------------------------------------------------------------------------------------------------------
		----------------------------------------------------------------------------------------------------------------------------------
		local function accept()
			if StaticPopup1Button1 then StaticPopup1Button1:Click() end
		end
		function Octo_OnLoad()
			local EventFrame_SPB = nil
			if not EventFrame_SPB then
				EventFrame_SPB = CreateFrame("FRAME", AddonTitle .. E.Octo_Func.GenerateUniqueID())
			end
			EventFrame_SPB:RegisterEvent("EQUIP_BIND_CONFIRM")
			EventFrame_SPB:RegisterEvent("EQUIP_BIND_REFUNDABLE_CONFIRM")
			EventFrame_SPB:RegisterEvent("VOID_DEPOSIT_WARNING")
			EventFrame_SPB:RegisterEvent("USE_NO_REFUND_CONFIRM")
			-- EventFrame_SPB:RegisterEvent("SPELL_CONFIRMATION_PROMPT") --block
			EventFrame_SPB:SetScript("OnEvent", function(...)
				Octo_OnEvent(...)
			end)
		end
		function Octo_OnEvent(self, event, ...)
			if (event == "EQUIP_BIND_CONFIRM" or event == "EQUIP_BIND_REFUNDABLE_CONFIRM" or event == "VOID_DEPOSIT_WARNING" or event == "USE_NO_REFUND_CONFIRM" ) and not InCombatLockdown() then
				C_Timer.After(0, function()
					accept()
				end)
			end
		end
		Octo_OnLoad()
		-- /run local function accept() StaticPopup1Button1:Click() end
		-- StaticPopupDialogs["BID_AUCTION"].OnShow=accept
		-- StaticPopupDialogs["BUYOUT_AUCTION"].OnShow=accept
	end
end)
