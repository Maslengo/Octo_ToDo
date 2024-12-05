function (self, unitId, unitFrame, envTable, modTable)
	if not unitId then return end
	local _, instanceType, difficultyID =  GetInstanceInfo()
	local unitClass = UnitClassification(unitId)
	local UnitIsQuestBoss UnitIsQuestBoss(unitId)

	if (difficultyID == 0 and (unitClass == "elite" or unitClass == "rare" or unitClass == "rareelite"))
	or unitClass == "worldboss"
	or UnitIsBossMob(unitId)
	or UnitIsQuestBoss
	then
		if modTable.changeBarColor then
			Plater.SetNameplateColor(unitFrame, modTable.config.BossColor)
		end
	end
	--get the GUID of the target of the unit
	local targetGUID = UnitGUID(unitId .. "target")
	if (targetGUID) then
		--get the npcID of the target
		local npcID = Plater.GetNpcIDFromGUID(targetGUID)
		local unitName = UnitName(unitId .. "target")
		local unitNameLower = string.lower(unitName)
		--check if the npcID of this unit is in the npc list
		local color = modTable.ListOfNpcs [npcID] or modTable.ListOfNpcs [unitName] or modTable.ListOfNpcs [unitNameLower]
		if color then
			if modTable.changeBarColor then
				Plater.SetNameplateColor(unitFrame, color)
			end
			if modTable.changeBorderColor then
				Plater.SetBorderColor(unitFrame, color)
			end
			unitFrame.attackingSpecificUnitFromMod = true
		elseif unitFrame.attackingSpecificUnitFromMod and modTable.resetColors then
			if modTable.changeBorderColor then
				Plater.SetBorderColor(unitFrame)
			end
			if modTable.changeBarColor then
				Plater.RefreshNameplateColor(unitFrame)
			end
			unitFrame.attackingSpecificUnitFromMod = false
		end
	end
end

