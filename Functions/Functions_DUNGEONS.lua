local GlobalAddonName, E = ...
----------------------------------------------------------------
-- 38 ms
----------------------------------------------------------------
local function CountEncounters()
	local i = 1
	while EJ_GetEncounterInfoByIndex(i) do
		i = i + 1
	end
	return i - 1
end
----------------------------------------------------------------
local function CollectDifficulties()
	local diffTable
	for diffID in next, (E.OctoTable_Difficulties) do
		if EJ_IsValidInstanceDifficulty(diffID) then
			EJ_SetDifficulty(diffID)
			local bossCount = CountEncounters()
			if bossCount > 0 then
				diffTable = diffTable or {}
				-- if not diffTable[diffID] then
					diffTable[diffID] = bossCount
				-- end
			end
		end
	end
	return diffTable
end
----------------------------------------------------------------
local function GetEffectiveTier(tier, maxTiers)
	if maxTiers == 11 and tier == maxTiers then
		return tier - 1 -- DRAGONFLIGHT 10.2.7
	end
	return tier
end
----------------------------------------------------------------
local function ShouldSkipTier(tier, maxTiers)
	if maxTiers == 11 then
		return tier == 10 -- RETAIL (TWW, MIDNIGHT)
	end
	return tier == maxTiers
end
----------------------------------------------------------------
function E.func_BUILD_DUNG_DB()
	-- E.func_LoadAddOn("Blizzard_EncounterJournal")
	if E.func_IsAddOnLoaded("Blizzard_EncounterJournal") then
		local EncounterJournal_OnEvent = EncounterJournal_OnEvent
		EncounterJournal:SetScript("OnEvent", function(self, event, ...)
				if event ~= "EJ_LOOT_DATA_RECIEVED" and event ~= "EJ_DIFFICULTY_UPDATE" or self:IsShown() then
					EncounterJournal_OnEvent(self, event, ...)
				end
		end)
	end
	-- if not E.DEBUG then return end
	-- local funcName = "func_BUILD_DUNG_DB"
	-- E.DEBUG_START()
	local backupTier = EJ_GetCurrentTier()
	local backupDifficulty = EJ_GetDifficulty()
	local maxTiers = EJ_GetNumTiers()
	if not maxTiers or maxTiers < 1 then
		return
	end
	local instanceDB = {}
	for tier = 1, maxTiers do
		if not ShouldSkipTier(tier, maxTiers) then
			local effectiveTier = GetEffectiveTier(tier, maxTiers)
			EJ_SelectTier(effectiveTier)
			-- if maxTiers == 11 and tier ~= 10 or tier ~= maxTiers then
			-- EJ_SelectTier(tier)
			-- if maxTiers == 11 and tier == maxTiers then
			--     tier = tier - 1
			-- end
			-- local tierName = EJ_GetTierInfo(tier)
			for pass = 1, 2 do
				local isRaid = (pass == 2)
				-- for _, isRaid in ipairs({false, true}) do
				local index = 1
				local EJ_ID = EJ_GetInstanceByIndex(index, isRaid)
				while EJ_ID do
					EJ_SelectInstance(EJ_ID)
					local _, _, _, _, _, icon, _, _, _, savedInstanceID = EJ_GetInstanceInfo(EJ_ID)
					if savedInstanceID then
						E.SavedInstanceID_to_EJInstance[savedInstanceID] = EJ_ID
						E.EJInstance_to_SavedInstanceID[EJ_ID] = savedInstanceID
						local diffTable = CollectDifficulties()
						if diffTable then
							-- if instanceDB[savedInstanceID] == nil then
							if not instanceDB[savedInstanceID] then
								instanceDB[savedInstanceID] = {
									-- EJ_ID = EJ_ID,
									difficulties = diffTable,
									-- icon = icon,
									isRaid = isRaid,
									-- name = name,
									tier = tier,
								}
							end
						end
					end
					index = index + 1
					EJ_ID = EJ_GetInstanceByIndex(index, isRaid)
				end
			end
		end
	end
	EJ_SetDifficulty(backupDifficulty)
	EJ_SelectTier(backupTier)
	E.Octo_Table_SI_IDS = instanceDB
	-- E.DEBUG_STOP(funcName)
	-- opde(instanceDB)
end
----------------------------------------------------------------
function E.func_SI_to_EJ(id) -- ONLY FOR ICONS (M+0)
	if not id then return 0 end
	local newID = E.SavedInstanceID_to_EJInstance[id] or 0
	return newID
end
----------------------------------------------------------------
-- function E.func_EJ_to_SI(id) -- USELESS
-- 	if not id then return 0 end
-- 	local newID = E.EJInstance_to_SavedInstanceID[id] or 0
-- 	return newID
-- end
----------------------------------------------------------------
function E.func_DungeonOrRaid(SI_ID)
	return E.Octo_Table_SI_IDS[SI_ID] and E.Octo_Table_SI_IDS[SI_ID].isRaid or false
end
----------------------------------------------------------------