local GlobalAddonName, E = ...
if not E.Enable_Moduls then return end



tinsert(E.Modules, function()
	if not Octo_ToDo_DB_Vars.StaticPopup1Button1 then return end

	local function AcceptPopup()
		if StaticPopup1Button1 then
			StaticPopup1Button1:Click()
		end
	end

	local eventFrame = CreateFrame("Frame")
	eventFrame:RegisterEvent("EQUIP_BIND_CONFIRM")
	eventFrame:RegisterEvent("EQUIP_BIND_REFUNDABLE_CONFIRM")
	-- eventFrame:RegisterEvent("VOID_DEPOSIT_WARNING")
	eventFrame:RegisterEvent("USE_NO_REFUND_CONFIRM")
	eventFrame:RegisterEvent("EQUIP_BIND_TRADEABLE_CONFIRM")

	-- eventFrame:SetScript("OnEvent", function()
	-- 	C_Timer.After(0, AcceptPopup)
	-- end)
end)