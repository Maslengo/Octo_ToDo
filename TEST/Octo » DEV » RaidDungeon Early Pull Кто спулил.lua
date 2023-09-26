ARC_TIMED_WSNPFW, CHAT_MSG_ADDON, PLAYER_ENTERING_WORLD, GROUP_ROSTER_UPDATE, UPDATE_INSTANCE_INFO, ENCOUNTER_START, INSTANCE_ENCOUNTER_ENGAGE_UNIT, UNIT_THREAT_LIST_UPDATE, UNIT_TARGET, CLEU:SPELL_DAMAGE:SPELL_MISSED:SPELL_PERIODIC_DAMAGE:SPELL_PERIODIC_MISSED:SWING_DAMAGE:SWING_MISSED:RANGE_DAMAGE:RANGE_MISSED:SPELL_AURA_APPLIED:SPELL_CAST_SUCCESS:SPELL_SUMMON, EARLY_PULL_PRINT_DETAILS







--[[
Events:
ARC_TIMED_WSNPFW, CHAT_MSG_ADDON, PLAYER_ENTERING_WORLD, GROUP_ROSTER_UPDATE, UPDATE_INSTANCE_INFO, ENCOUNTER_START, INSTANCE_ENCOUNTER_ENGAGE_UNIT, UNIT_THREAT_LIST_UPDATE, UNIT_TARGET, CLEU:SPELL_DAMAGE:SPELL_MISSED:SPELL_PERIODIC_DAMAGE:SPELL_PERIODIC_MISSED:SWING_DAMAGE:SWING_MISSED:RANGE_DAMAGE:RANGE_MISSED:SPELL_AURA_APPLIED:SPELL_CAST_SUCCESS:SPELL_SUMMON, EARLY_PULL_PRINT_DETAILS
]]

local GetTime, UnitGUID, GetUnitName, UnitPlayerControlled, UnitDetailedThreatSituation, bit_band, abs, min, max, strsplit, tonumber, tostring, print =
GetTime, UnitGUID, GetUnitName, UnitPlayerControlled, UnitDetailedThreatSituation, bit.band, abs, min, max, strsplit, tonumber, tostring, print

local kSourceFlagMask = COMBATLOG_OBJECT_CONTROL_MASK
local kSourceFlagFilter = COMBATLOG_OBJECT_CONTROL_PLAYER
local kDestFlagMask = bit.bor(COMBATLOG_OBJECT_CONTROL_MASK, COMBATLOG_OBJECT_REACTION_MASK)
local kDestFlagFilter1 = bit.bor(COMBATLOG_OBJECT_CONTROL_NPC, COMBATLOG_OBJECT_REACTION_HOSTILE)
local kDestFlagFilter2 = bit.bor(COMBATLOG_OBJECT_CONTROL_NPC, COMBATLOG_OBJECT_REACTION_NEUTRAL)
local kNegInfinity = -math.huge

function aura_env:Init()
    self:InitArcEvents()

    for k, v in pairs(self.config) do
        self[k] = v
    end

    self.groupChannelTest = {
        ["PARTY"] = true,
        ["RAID"] = true,
        ["INSTANCE_CHAT"] = true,
    }

    self.combatLog = {pos = 0, maxPos = 1000}
    self.threatLog = {pos = 0, maxPos = 100}
    self.targetLog = {pos = 0, maxPos = 100}
    self.bossLog = {pos = 0, maxPos = 100}
    self.syncLog = {pos = 0, maxPos = 100}

    for i = 1, self.combatLog.maxPos do
        self.combatLog[i] = {time = kNegInfinity, guid = nil, name = nil, event = nil, destGUID = nil, spellID = nil}
    end
    for i = 1, self.threatLog.maxPos do
        self.threatLog[i] = {time = kNegInfinity, threatEntries = {count = 0}}
    end
    for i = 1, self.targetLog.maxPos do
        self.targetLog[i] = {time = kNegInfinity, guid = nil, name = nil}
    end
    for i = 1, self.bossLog.maxPos do
        self.bossLog[i] = {time = kNegInfinity, guid = nil}
    end
    for i = 1, self.syncLog.maxPos do
        self.syncLog[i] = {time = kNegInfinity, message = nil}
    end

    self.unitList = {raid = {}, raidpet = {}, party = {}, partypet = {}, boss = {}, bosstarget = {}}

    for i = 1, 40 do
        self.unitList.raid[i] = "raid"..i
        self.unitList.raidpet[i] = "raidpet"..i
    end
    for i = 1, 4 do
        self.unitList.party[i] = "party"..i
        self.unitList.partypet[i] = "partypet"..i
    end
    for i = 1, 5 do
        self.unitList.boss[i] = "boss"..i
        self.unitList.bosstarget[i] = "boss"..i.."target"
    end

    self.combatLogDamageEventTest = {
        SPELL_DAMAGE = true,
        SPELL_PERIODIC_DAMAGE = true,
        SWING_DAMAGE = true,
        RANGE_DAMAGE = true,
    }
    self.combatLogSwingEventTest = {
        SWING_DAMAGE = true,
        SWING_MISSED = true,
    }

    self.summons = {counter = 0}
    self.summons2 = {counter = 0}

    self.myName = UnitName("player")
    self.myRealm = GetRealmName()

    self:InitSync()

    self:PLAYER_ENTERING_WORLD()
end

-- aura-scoped timer-based events (minified)
function aura_env:InitArcEvents(interval, tolerance)
    local a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F=WeakAuras,C_Timer.After,random,ipairs,pairs,self,{},{},"ArcEventIDs","arcEventID","arcEventNormal","events",{},"ARC_PERIODIC","ARC_TIMED",{},interval,tolerance;for G in("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):gmatch"."do tinsert(g,G)end;function u()for H=1,6 do h[H]=g[c(1,#g)]end;return table.concat(h)end;v=a.GetData(f.id)w=_G[i]or{}_G[i]=w;x=v[j]or u()z=w[x]if z and z~=v.uid then for I=1,99 do y=u()if w[y]==nil then x=y;break end end end;w[x]=v.uid;v[j]=x;f[j]=x;A=n.."_"..x;B=o.."_"..x;f[k]={[A]=n,[B]=o}for I,J in d(v.triggers)do J=J.trigger;if J and J.type=="custom"and J[l]and(J.check~="update"or J.custom_type=="event")then for K,L in e(f[k])do C,D=J[l]:gsub(L.."[%w_]*",K)if C~=J[l]then J[l]=C end;if D>0 then m[L]=true end end end end;t=a.ScanEvents;s=f.region;if m[n]then (s[n]or{}).c=1;r=r or min(1,q)/20;E=function()if p.c then return end;if a.IsPaused()then b(.2+.01*c(),E)else t(A)b(q+(2*c()-1)*r,E)end end;s[n]=p;b(q+(2*c()-1)*r,E)end;if m[o]then F=s[o]or{}s[o]=F;function f:SetArcTimed(M,N)local O,P=F[M]or{c=0}F[M]=O;if O.t~=N then P=O.c+1;O.c=P;O.t=N;if N==nil then return end;b(.01+max(0,N-GetTime()),function()if O.c==P then t(B,M)end end)end end end
end

function aura_env:InitSync()
    self.syncEnabled = false
    if self.syncPriority == 4 then return end -- Isolated

    self.syncPrefix = "EarlyPull"
    self.syncVersion = 1

    local AceComm = LibStub:GetLibrary("AceComm-3.0", true)
    if AceComm then
        AceComm:Embed(self)
        self:RegisterComm(self.syncPrefix, "OnSync")
        self.syncEnabled = true
    end
end

function aura_env:Print(...)
    print("|cff55ffdd"..self.id..":|r", ...)
end

function aura_env:AdvanceLog(log)
    local pos = (log.pos % log.maxPos) + 1
    log.pos = pos
    return log[pos]
end

-- relPos = pos shifted to be time-monotonic and 0-indexed
-- relPos = (pos - 1 - offset) % maxPos
-- pos = 1 + (relPos + offset) % maxPos

-- returns relPos of first entry.time >= time
-- first: relPos of lower search cutoff (inclusive)
local function binarySearchLogTime(log, time, first)
    local offset = log.pos
    local maxPos = log.maxPos
    local floor = floor

    local count = maxPos - first
    local current
    local step

    while count > 0 do
        step = floor(count / 2)
        current = first + step
        if log[1 + (current + offset) % maxPos].time < time then
            first = current + 1
            count = count - (step + 1)
        else
            count = step
        end
    end
    return first
end

local function iterEmpty()
end

-- [1] = tbl, [2] = max
local function iterRange(state, i)
    i = i + 1
    if i <= state[2] then
        return i, state[1][i]
    end
end

-- [1] = tbl, [2] = j, [3] = max1, [4] = min2, [5] = max3
local function iterTwoRanges(state, i)
    i = i + 1
    local j = state[2]
    if i <= state[j] then
        return i, state[1][i]
    elseif j == 3 then
        i = state[4]
        if i <= state[5] then
            state[2] = 5
            return i, state[1][i]
        end
    end
end

function aura_env:IterateLogWindow(log, beginTime, endTime)
    local beginRelPos = binarySearchLogTime(log, beginTime, 0)
    local endRelPos = binarySearchLogTime(log, endTime, beginRelPos)
    assert(beginRelPos <= endRelPos)
    if beginRelPos == endRelPos then
        return iterEmpty
    end
    local offset = log.pos
    local maxPos = log.maxPos
    local beginPos = 1 + (beginRelPos + offset) % maxPos
    local endPos = 1 + (endRelPos - 1 + offset) % maxPos -- now inclusive
    if beginPos <= endPos then
        return iterRange, {log, endPos}, beginPos - 1
    else
        return iterTwoRanges, {log, 3, maxPos, 1, endPos}, beginPos - 1
    end
end

function aura_env:PLAYER_ENTERING_WORLD()
    self:GROUP_ROSTER_UPDATE()
    self:UPDATE_INSTANCE_INFO()
    self:ScanAllBosses()
end

function aura_env:GROUP_ROSTER_UPDATE()
    self.inParty = IsInGroup()
    self.inRaid = IsInRaid()
    self.inInstanceGroup = IsInGroup(LE_PARTY_CATEGORY_INSTANCE)
    self.raidSize = GetNumGroupMembers()
    self.partySize = GetNumSubgroupMembers()
end

function aura_env:UPDATE_INSTANCE_INFO()
    self.instanceID = select(8, GetInstanceInfo())
    self.inInstance = IsInInstance()
end

function aura_env:MaySendPullTimer(sender)
    return (UnitIsGroupLeader(sender) or UnitIsGroupAssistant(sender)
        or ((self.inInstanceGroup or not self.inRaid) and UnitGroupRolesAssigned(sender) == "TANK"))
end

function aura_env:CHAT_MSG_ADDON(prefix, message, channel, sender)
    if prefix ~= "D4" or not self.groupChannelTest[channel] then
        return
    end
    local ty, duration, instanceID, target = strsplit("\t", message)
    if ty ~= "PT" then
        return
    end
    duration = tonumber(duration or 0)
    instanceID = tonumber(instanceID)
    if IsEncounterInProgress()
    or (self.inParty and not self:MaySendPullTimer(sender))
    or (duration > 60 or (duration > 0 and duration < 3) or duration < 0)
    or (instanceID and instanceID ~= self.instanceID) then
        return
    end
    if duration == 0 then
        self.expectedPullTime = nil
    else
        self.expectedPullTime = GetTime() + duration
    end
end

local threatScanUnits = {}

local function addThreatScanUnit(unit)
    local guid = UnitGUID(unit)
    if guid then
        threatScanUnits[guid] = unit
    end
end

function aura_env:ScanThreat(mob)
    wipe(threatScanUnits)
    if self.inRaid then
        local raid = self.unitList.raid
        local raidpet = self.unitList.raidpet
        for i = 1, self.raidSize do
            addThreatScanUnit(raid[i])
            addThreatScanUnit(raidpet[i])
        end
    else
        if self.inParty then
            local party = self.unitList.party
            local partypet = self.unitList.partypet
            for i = 1, self.partySize do
                addThreatScanUnit(party[i])
                addThreatScanUnit(partypet[i])
            end
        end
        addThreatScanUnit("player")
        addThreatScanUnit("pet")
    end
    addThreatScanUnit("target")
    addThreatScanUnit("focus")
    addThreatScanUnit("mouseover")

    local entry = self:AdvanceLog(self.threatLog)
    entry.time = GetTime()
    local threatEntries = entry.threatEntries

    local count = 0
    for guid, unit in pairs(threatScanUnits) do
        if UnitPlayerControlled(unit) then
            local isTanking, state, scaledPercent, rawPercent, threatValue = UnitDetailedThreatSituation(unit, mob)
            if state or threatValue then
                count = count + 1
                local threatEntry = threatEntries[count] or {}
                threatEntries[count] = threatEntry

                threatEntry.guid = guid
                threatEntry.name = GetUnitName(unit, true)
                threatEntry.isTanking = isTanking
                threatEntry.threatValue = threatValue
            end
        end
    end
    threatEntries.count = count
end

function aura_env:UNIT_THREAT_LIST_UPDATE(unit)
    if unit and unit:find("^boss") then
        self:ScanThreat(unit)
    end
end

function aura_env:ScanBoss(unit, targetUnit)
    local bossGUID = UnitGUID(unit)
    if bossGUID then
        local now = GetTime()

        local bossEntry = self:AdvanceLog(self.bossLog)
        bossEntry.time = now
        bossEntry.guid = bossGUID

        local targetGUID = UnitGUID(targetUnit)
        if targetGUID and UnitPlayerControlled(targetUnit) then
            local targetEntry = self:AdvanceLog(self.targetLog)
            targetEntry.time = now
            targetEntry.guid = targetGUID
            targetEntry.name = GetUnitName(targetUnit, true)
        end
    end
end

function aura_env:ScanAllBosses()
    local boss = self.unitList.boss
    local bosstarget = self.unitList.bosstarget
    for i = 1, 5 do
        self:ScanBoss(boss[i], bosstarget[i])
    end
end

function aura_env:UNIT_TARGET(unit)
    if unit and unit:find("^boss") then
        self:ScanBoss(unit, unit.."target")
    end
end

-- already filtered in event list
function aura_env:COMBAT_LOG_EVENT_UNFILTERED(_, event, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, _, spellID, _, _, auraType)
    -- summons are used for tracking pet owners, not pull detection
    if event == "SPELL_SUMMON" then
        if not destGUID then return end
        local summons = self.summons
        summons[destGUID] = sourceName
        local counter = summons.counter + 1
        if counter >= 1000 then
            self.summons = self.summons2
            self.summons2 = summons
            wipe(self.summons)
            self.summons.counter = 0
        else
            summons.counter = counter
        end
        return
    end

    if not (sourceGUID and destGUID)
    or (event == "SPELL_AURA_APPLIED" and auraType ~= "DEBUFF") then
        return
    end

    if bit_band(sourceFlags, kSourceFlagMask) ~= kSourceFlagFilter then
        return
    end

    local destFlagsMasked = bit_band(destFlags, kDestFlagMask)
    if destFlagsMasked ~= kDestFlagFilter1 and destFlagsMasked ~= kDestFlagFilter2 then
        return
    end

    local entry = self:AdvanceLog(self.combatLog)
    entry.time = GetTime()
    entry.guid = sourceGUID
    entry.name = sourceName
    entry.event = event
    entry.destGUID = destGUID
    entry.spellID = spellID  -- n/a for swings, but we'll check that when needed
end

function aura_env:GetGroupChannel()
    if self.inInstanceGroup and self.inInstance then
        return "INSTANCE_CHAT"
    elseif self.inRaid then
        return "RAID"
    elseif self.inParty then
        return "PARTY"
    end
end

function aura_env:GetAnnounceChannel(announceType)
    if announceType == 1 then
        return (self.inInstance and not UnitIsDeadOrGhost("player")) and "SAY" or "PRINT"
    elseif announceType == 2 then
        return self:GetGroupChannel() or "PRINT"
    elseif announceType == 3 then
        return "PRINT"
    end
end

function aura_env:ClassifyPull(pullTimeDiff)
    local announceType, pullDesc
    if not pullTimeDiff then
        announceType = self.announceUntimedPull
        pullDesc = "Boss pulled"
    elseif pullTimeDiff <= -self.pullOnTimeWindow then
        announceType = self.announceEarlyPull
        pullDesc = format("Boss pulled %."..self.pullTimeDiffDecimals.."f seconds early", -pullTimeDiff)
    elseif pullTimeDiff < self.pullOnTimeWindow then
        announceType = self.announceOnTimePull
        pullDesc = "Boss pulled on time"
    else
        announceType = self.announceLatePull
        pullDesc = format("Boss pulled %."..self.pullTimeDiffDecimals.."f seconds late", pullTimeDiff)
    end
    return self:GetAnnounceChannel(announceType), pullDesc
end

function aura_env:GetGroupRank()
    return UnitIsGroupLeader("player") and 2 or UnitIsGroupAssistant("player") and 1 or 0
end

function aura_env:CreateSyncTable(encounterID)
    return {self.syncVersion, encounterID, self.syncPriority, self:GetGroupRank(), self.myName, self.myRealm}
end

function aura_env:SerializeSyncTable(syncTable)
    return table.concat(syncTable, "\t")
end

function aura_env:DeserializeSyncTable(data)
    local syncTable = {strsplit("\t", data)}
    for i = 1, 6 do
        if i <= 4 then
            syncTable[i] = tonumber(syncTable[i])
        end
        if not syncTable[i] then
            return nil
        end
    end
    return syncTable
end

function aura_env:CompareSyncTables(a, b)
    if a[1] < b[1] then return true elseif a[1] > b[1] then return false end
    if a[3] < b[3] then return true elseif a[3] > b[3] then return false end
    if a[4] < b[4] then return true elseif a[4] > b[4] then return false end
    if a[5] > b[5] then return true elseif a[5] < b[5] then return false end
    if a[6] > b[6] then return true elseif a[6] < b[6] then return false end
end

function aura_env:CheckSyncTableEncounter(syncTable, encounterID)
    return syncTable[2] == encounterID
end

function aura_env:IsMySyncTable(syncTable)
    return syncTable[5] == self.myName and syncTable[6] == self.myRealm
end

function aura_env:SendSync(syncTable)
    local channel = self:GetGroupChannel()
    if not channel then return end
    local message = self:SerializeSyncTable(syncTable)
    self:SendCommMessage(self.syncPrefix, message, channel)
end

function aura_env:OnSync(prefix, message, channel, sender)
    if not self.groupChannelTest[channel] then return end
    local entry = self:AdvanceLog(self.syncLog)
    entry.time = GetTime()
    entry.message = message
end

function aura_env:ENCOUNTER_START(encounterID, encounterName)
    if not encounterID then return end -- avoid WA fake events

    local now = GetTime()
    local pullTimeDiff = self.expectedPullTime and (now - self.expectedPullTime)
    if pullTimeDiff and abs(pullTimeDiff) > self.maxPullTimeDiff then
        pullTimeDiff = nil
    end
    self.expectedPullTime = nil

    local announceChannel, pullDesc = self:ClassifyPull(pullTimeDiff)

    if self.syncEnabled and announceChannel and announceChannel ~= "PRINT" then
        local syncTable = self:CreateSyncTable(encounterID)
        self:SendSync(syncTable)
    end

    self.pullContext = {
        pullTime = now,
        pullTimeDiff = pullTimeDiff,
        announceChannel = announceChannel,
        pullDesc = pullDesc,
        encounterID = encounterID,
        encounterName = encounterName,
    }
    self:SetArcTimed("AfterPull", now + self.afterPullDelay)

    self:ScanAllBosses()
end

function aura_env:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
    self:ScanAllBosses()
end

function aura_env:FindPetOwner(guid)
    local summoner = self.summons[guid] or self.summons2[guid]
    if summoner then return summoner end

    if self.inRaid then
        local raid = self.unitList.raid
        local raidpet = self.unitList.raidpet
        for i = 1, self.raidSize do
            if UnitGUID(raidpet[i]) == guid then
                return GetUnitName(raid[i])
            end
        end
    else
        if self.inParty then
            local party = self.unitList.party
            local partypet = self.unitList.partypet
            for i = 1, self.partySize do
                if UnitGUID(partypet[i]) == guid then
                    return GetUnitName(party[i])
                end
            end
        end
        if UnitGUID("pet") == guid then
            return GetUnitName("player")
        end
    end
end

function aura_env:FinalizeCandidate(cand)
    if not cand then return end

    local entry = cand.combatLogEntry
    if entry then
        cand.name = entry.name
        -- don't assign spell blame if low certainty
        if cand.combatLogScore >= self.spellBlameCutoff then
            if self.combatLogSwingEventTest[entry.event] then
                cand.spellID = 6603 -- Auto Attack
            else
                cand.spellID = entry.spellID
            end
        end
    end

    cand.name = (cand.name
        or (cand.threatEntry and cand.threatEntry.name)
        or (cand.targetLogEntry and cand.targetLogEntry.name))

    local guid = cand.guid
    if not guid:find("^Player") then
        cand.petOwner = self:FindPetOwner(guid)
    end
end

function aura_env:GetBlameDesc(bestCand, bestScore, secondScore)
    local blameDesc = " by unknown cause"
    if bestCand then
        local name = bestCand.name or "<Unknown>"
        local spellID = bestCand.spellID
        local petOwner = bestCand.petOwner

        if petOwner then
            blameDesc = " by "..petOwner.."'s pet "..name
        else
            blameDesc = " by "..name
        end

        if spellID then
            blameDesc = blameDesc.." "..(GetSpellLink(spellID) or "<Spell "..spellID..">")
        end

        if bestScore - secondScore < self.lowCertaintyCutoff then
            blameDesc = blameDesc.." (?)"
        end
    end
    return blameDesc
end

function aura_env:AfterPull()
    local ctx = self.pullContext

    local pullTime = ctx.pullTime
    local cwBeginTime = pullTime + self.criticalWindowBegin
    local cwEndTime = pullTime + self.criticalWindowEnd

    local timelinessCenter = pullTime + self.timelinessOffset
    local timelinessDecayRate = self.timelinessDecayRate
    local function getTimelinessPenalty(entry)
        return 1 - timelinessDecayRate * abs(entry.time - timelinessCenter)
    end

    local candidates = {}

    local function getCandidate(guid)
        local cand = candidates[guid] or {guid = guid, combatLogScore = 0, threatScore = 0, targetScore = 0}
        candidates[guid] = cand
        return cand
    end

    -- boss log pass

    local bosses = {}

    for _, entry in self:IterateLogWindow(self.bossLog, cwBeginTime, cwEndTime) do
        bosses[entry.guid] = true
    end

    -- combat log pass

    for _, entry in self:IterateLogWindow(self.combatLog, cwBeginTime, cwEndTime) do
        local score = self.combatLogBaseScore * getTimelinessPenalty(entry)
        if not self.combatLogDamageEventTest[entry.event] then
            score = score * self.combatLogNonDamagePenalty
        end
        if entry.event == "SPELL_CAST_SUCCESS" then
            score = score * self.combatLogSpellCastPenalty
        end
        if not bosses[entry.destGUID] then
            score = score * self.combatLogNonBossTargetPenalty
        end

        local cand = getCandidate(entry.guid)
        if score > cand.combatLogScore then
            cand.combatLogScore = score
            cand.combatLogEntry = entry
        end
    end

    -- threat log pass

    local earliestThreatTable

    for _, entry in self:IterateLogWindow(self.threatLog, cwBeginTime, cwEndTime) do
        local threatEntries = entry.threatEntries
        local count = threatEntries.count
        if count > 0 then
            earliestThreatTable = earliestThreatTable or entry.time

            local highestThreatValue = 0
            for j = 1, count do
                highestThreatValue = max(highestThreatValue, threatEntries[j].threatValue or 0)
            end

            local notEarliestPenalty = (entry.time == earliestThreatTable) and 1 or self.threatLogNotEarliestPenalty
            for j = 1, count do
                local threatEntry = threatEntries[j]

                local score = self.threatLogBaseScore * getTimelinessPenalty(entry) * notEarliestPenalty
                if not threatEntry.isTanking then
                    if threatEntry.threatValue == highestThreatValue then
                        score = score * self.threatLogOffTankPenalty
                    else
                        score = score * self.threatLogNonTankPenalty
                    end
                end

                local cand = getCandidate(threatEntry.guid)
                if score > cand.threatScore then
                    cand.threatScore = score
                    cand.threatEntry = threatEntry
                end
            end
        end
    end

    -- target log pass

    local earliestTarget

    for _, entry in self:IterateLogWindow(self.targetLog, cwBeginTime, cwEndTime) do
        earliestTarget = earliestTarget or entry.time

        local notEarliestPenalty = (entry.time == earliestTarget) and 1 or self.targetLogNotEarliestPenalty

        local score = self.targetLogBaseScore * getTimelinessPenalty(entry) * notEarliestPenalty

        local cand = getCandidate(entry.guid)
        if score > cand.targetScore then
            cand.targetScore = score
            cand.targetLogEntry = entry
        end
    end

    -- candidates comparison

    local bestScore, bestCand = 0, nil
    local secondScore, secondCand = 0, nil

    for _, cand in pairs(candidates) do
        local score = cand.combatLogScore + cand.threatScore + cand.targetScore
        cand.score = score
        if score > bestScore then
            secondScore, secondCand = bestScore, bestCand
            bestScore, bestCand = score, cand
        elseif score > secondScore then
            secondScore, secondCand = score, cand
        end
    end

    self:FinalizeCandidate(bestCand)
    self:FinalizeCandidate(secondCand)

    ctx.bestCand = bestCand
    ctx.secondCand = secondCand

    if self.autoPrintDetails then
        self:EARLY_PULL_PRINT_DETAILS(true)
    end

    -- sync log pass & announce

    local bestSyncTable

    for _, entry in self:IterateLogWindow(self.syncLog, cwBeginTime, cwEndTime) do
        local syncTable = self:DeserializeSyncTable(entry.message)
        if syncTable and self:CheckSyncTableEncounter(syncTable, ctx.encounterID)
        and (not bestSyncTable or self:CompareSyncTables(bestSyncTable, syncTable)) then
            bestSyncTable = syncTable
        end
    end

    if not bestSyncTable or self:IsMySyncTable(bestSyncTable) then
        local blameDesc = self:GetBlameDesc(bestCand, bestScore, secondScore)
        self:Announce(ctx.announceChannel, ctx.pullDesc..blameDesc..".")
    end
end

function aura_env:Announce(announceChannel, message)
    if announceChannel == "PRINT" then
        self:Print(message)
    elseif announceChannel then
        SendChatMessage(message, announceChannel)
    end
end

function aura_env:PrintCandidateDetails(cand, intro)
    self:Print(format("%s%s (spellID=%s petOwner=%s) with score=%.2f (combatLog=%.2f, threat=%.2f, target=%.2f).",
            intro, tostring(cand.name), tostring(cand.spellID), tostring(cand.petOwner),
    cand.score, cand.combatLogScore, cand.threatScore, cand.targetScore))
end

function aura_env:PrintPullDetails()
    local ctx = self.pullContext
    if not ctx then
        self:Print("No pulls have been recorded.")
        return
    end

    self:Print(format("%s (id=%d) pulled %.3fs ago with timing=%s announce=%s.",
            tostring(ctx.encounterName), ctx.encounterID, GetTime() - ctx.pullTime,
            ctx.pullTimeDiff and format("%+.3fs", ctx.pullTimeDiff) or "UNTIMED",
            tostring(ctx.announceChannel)))

    if ctx.bestCand then
        self:PrintCandidateDetails(ctx.bestCand, "Best candidate was ")
        if ctx.secondCand then
            self:PrintCandidateDetails(ctx.secondCand, "Next-best candidate was ")
        end
    else
        self:Print("Did not find any candidates to be blamed for pull.")
    end
end

function aura_env:EARLY_PULL_PRINT_DETAILS(realCheck)
    if realCheck then -- avoid WA fake events
        self:PrintPullDetails()
    end
end

function aura_env:ARC_TIMED(key)
    local handler = self[key]
    if not handler then return end
    handler(self)
end

function aura_env:TSU(allStates, event, ...)
    event = self.arcEventNormal[event] or event

    local handler = self[event]
    if not handler then return end
    handler(self, ...)

    self.changed = true
    allStates[""] = self
    return true
end

aura_env:Init()


