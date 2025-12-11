
CVar = false, -- CVar настройки

if Octo_DevTool_DB and Octo_DevTool_DB.CVar then
	E.func_LoadCVars()
end

-- if E.func_IsPTR() then
-- print ("SECRET ON")
-- C_Timer.After(0, function()
-- SetCVar("addonChatRestrictionsForced", "1")
-- SetCVar("secretAurasForced", "1")
-- SetCVar("secretCooldownsForced", "1")
-- SetCVar("secretUnitIdentityForced", "1")
-- SetCVar("secretSpellcastsForced", "1")
-- SetCVar("secretUnitPowerForced", "1")
-- SetCVar("secretUnitPowerMaxForced", "1")
-- SetCVar("secretUnitComparisonForced", "1")
-- end)
-- end

function EventFrame:PLAYER_LOGOUT()
	-- if E.func_IsPTR() then
	-- SetCVar("addonChatRestrictionsForced", "0")
	-- SetCVar("secretAurasForced", "0")
	-- SetCVar("secretCooldownsForced", "0")
	-- SetCVar("secretUnitIdentityForced", "0")
	-- SetCVar("secretSpellcastsForced", "0")
	-- SetCVar("secretUnitPowerForced", "0")
	-- SetCVar("secretUnitPowerMaxForced", "0")
	-- SetCVar("secretUnitComparisonForced", "0")
	-- end
end