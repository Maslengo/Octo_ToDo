local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
BINDING_HEADER_ZoneAbilityBinding = "Octo_ToDo_ZoneAbilityBinding"
_G["BINDING_NAME_".."CLICK myZA1:LeftButton"] = "Zone Ability Button 1"
_G["BINDING_NAME_".."CLICK myZA2:LeftButton"] = "Zone Ability Button 2"
_G["BINDING_NAME_".."CLICK myZA3:LeftButton"] = "Zone Ability Button 3"
local WaitingToUpdate = {}
local theSpell = {}

function CedUpdateZA()
	theSpell = {}
	local count = 0
	local z = C_ZoneAbility.GetActiveAbilities()
	for i, zA in ipairs(z) do
		count = count + 1
		if not theSpell[count] then
			theSpell[count] = zA.spellID
		end
	end
end
if not InCombatLockdown() then
	local ZAcount = 3
	local ZAindex = 1
	for i = 1, ZAcount do
		if i > 1 then
			ZAindex = i
		end
		local b = _G["myZA"..ZAindex] or CreateFrame("button", "myZA"..ZAindex, nil, "SecureActionButtonTemplate")
		b:RegisterEvent("SPELLS_CHANGED")
		b:RegisterEvent("PLAYER_REGEN_ENABLED")
		b:RegisterEvent("PLAYER_ENTERING_WORLD")
		b:SetAttribute("type", "spell")
		b:SetAttribute("ZAindex", i)
		b:SetAttribute("spell", theSpell[i])
		b:SetScript("OnEvent",
			function(self, event, isInitialLogin, isReloadingUi)
				if event == "SPELLS_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
					if InCombatLockdown() then
						WaitingToUpdate[self:GetAttribute("ZAindex")] = true
					else
						CedUpdateZA()
						self:SetAttribute("spell", theSpell[self:GetAttribute("ZAindex")])
					end
				else
					if WaitingToUpdate[self:GetAttribute("ZAindex")] then
						if not InCombatLockdown() then
							CedUpdateZA()
							self:SetAttribute("spell", theSpell[self:GetAttribute("ZAindex")])
							WaitingToUpdate[self:GetAttribute("ZAindex")] = false
						end
					end
				end
			end)
	end
end

