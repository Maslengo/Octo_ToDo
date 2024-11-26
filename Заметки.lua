/fprint C_BattleNet.GetAccountInfoByGUID(UnitGUID("player"))
/fprint C_BattleNet.GetGameAccountInfoByGUID(UnitGUID("player"))
/fprint C_BattleNet.GetAccountInfoByID(select(3, BNGetInfo()))
/fprint C_BattleNet.GetGameAccountInfoByGUID(UnitGUID("player"))
["Player-1615-0AE9B27E"]
/dump GetPlayerInfoByGUID("Player-1615-0AE9B27E")
/dump GetPlayerInfoByGUID(UnitGUID("player"))
/dump C_BattleNet.GetAccountInfoByGUID("Player-3391-0CF86A39")
/run local _,_,_,n = GetAchievementCriteriaInfo(41038, 1); print(n);
local playerAccountGUID = string.format("BNetAccount-0-%012X", (BNGetNumFriends() + 1));
local isBattleNetGUID = C_AccountInfo.IsGUIDBattleNetAccountType(playerAccountGUID);
local isLocalPlayerGUID = C_AccountInfo.IsGUIDRelatedToLocalAccount(playerAccountGUID);
fprint (playerAccountGUID, isBattleNetGUID, isLocalPlayerGUID);
inChromieTime = C_PlayerInfo.IsPlayerInChromieTime()
canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()
/dump UnitChromieTimeID("player")
https://www.wowhead.com/ru/achievement=40873 Спаситель ящиков
https://www.wowhead.com/ru/achievement=40979 Ни один ящик не пропадет
https://www.wowhead.com/ru/achievement=41013 Улучшенное облачение
https://www.wowhead.com/ru/achievement=41033 Классный стилист
/fprint {Octo_ToDo_DB_Vars, Octo_ToDo_DB_Other}
https://www.wowhead.com/achievement=40870/azeroths-greatest-detective
local AddonName, MDT = ...
local framePools = {}
local nop = function() end
-- we should probably use our own templates for these, but this is a quick fix
local overrides = {
	["MapLinkPinTemplate"] = {
		["SuperTrack_OnShow"] = nop,
		["SuperTrack_OnHide"] = nop,
		["OnSuperTrackingChanged"] = nop,
		["GetSuperTrackData"] = nop,
	}
}
function MDT.CreateFramePool(frametype, parent, template)
	local pool = {
		active = {},
		inactive = {},
		Acquire = function(self)
			local frame = table.remove(self.inactive)
			if not frame then
				frame = CreateFrame(frametype, nil, parent, template)
				local override = overrides[template]
				if override then
					for k, v in next, (override) do
						frame[k] = v
					end
				end
			end
			table.insert(self.active, frame)
			return frame
		end,
		ReleaseAll = function(self)
			for i = #self.active, 1, -1 do
				local frame = table.remove(self.active)
				frame:Hide()
				table.insert(self.inactive, frame)
			end
		end,
	}
	framePools[template] = pool
	return pool
end
function MDT.GetFramePool(template)
	return framePools[template]
end
-- ПОЧИНКА
-- PLAYER_DEAD, UPDATE_INVENTORY_DURABILITY
function()
	local invSlotId, current, maximum;
	for invSlotId = 1, 18 do
		current, maximum = GetInventoryItemDurability(invSlotId)
		if current and maximum then
			if (current/maximum) <= 0.3 then
				return true
			end
		end
	end
	return false
end
