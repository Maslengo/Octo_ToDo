local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Items_MythicKeystone()
	if not E:func_CanCollectData() then return end
	local isMythicPlusActive = E.func_IsMythicPlusActive()
	if not isMythicPlusActive then return end
	-- local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local OwnedKeystoneLevel = E.func_GetOwnedKeystoneLevel() -- 20
	local OwnedKeystoneChallengeMapID = E.func_GetOwnedKeystoneChallengeMapID() -- 542
	collectPlayerData.OwnedKeystoneLevel = E.func_Save(OwnedKeystoneLevel)
	collectPlayerData.OwnedKeystoneChallengeMapID = E.func_Save(OwnedKeystoneChallengeMapID)
	-- 180653 НОВЫЙ КЛЮЧ
	-- 138019 СТАРЫЕ КЛЮЧИ
	-- 158923 СТАРЫЕ КЛЮЧИ
	-- 151086 СТАРЫЕ КЛЮЧИ
end
----------------------------------------------------------------
function E.Collect_Items_MythicKeystone()
	E.func_SpamBlock(Collect_Items_MythicKeystone, false)
end
----------------------------------------------------------------