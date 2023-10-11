INCOMING_SUMMON_CHANGED
----------------------------------------------------------------
function(event, unit)
	if(unit ~= "player" and unit ~= nil) then return end
	local status = C_IncomingSummon.IncomingSummonStatus(WeakAuras.me)

	if(unit == nil) then -- WA Options closed
		aura_env.status = status;
		if(status == 1) then
			-- Potentially move entire aura into its own frame so it may work within Options
			aura_env.printSummon(status);
		end
	end
	if(aura_env.status ~= status and (aura_env.status == 1 or (aura_env.status == 0 and status == 1))) then
		if(aura_env.config["enable" .. status]) then
			aura_env.printSummon(status);
		end
	end
	aura_env.status = status;
end
----------------------------------------------------------------
aura_env.printSummon = function(status)
	local type = "SAY"
	local isInstanceGroup = IsInGroup(LE_PARTY_CATEGORY_INSTANCE)
	if UnitInBattleground("player") then
		type = "INSTANCE_CHAT"
	elseif UnitInRaid("player") then
		type = "RAID"
	elseif UnitInParty("player") then
		if isInstanceGroup then
			type = "INSTANCE_CHAT"
		else
			type = "PARTY"
		end
	end
	local tail = "."
	local summoner = C_SummonInfo.GetSummonConfirmSummoner()
	if(summoner) then
		tail = " " .. summoner .. "."
	end
	SendChatMessage(WeakAuras.me .. " " .. aura_env.config["summon"..status] .. tail, type)
end
----------------------------------------------------------------
Summon Expired: summon0
let their summon expire
----------------------------------------------------------------
Summon Pending: summon1
has received a summon from
----------------------------------------------------------------
Summon Accepted: summon2
has accepted the summon
----------------------------------------------------------------
Summon Declined:summon3
has declined the summon