local Indicators = {
	ICON_STAR = ICON_LIST[1] .. "16:16:0:0|t",
	ICON_CIRCLE = ICON_LIST[2] .. "16:16:0:0|t",
	ICON_DIAMOND = ICON_LIST[3] .. "16:16:0:0|t",
	ICON_TRIANGLE = ICON_LIST[4] .. "16:16:0:0|t",
	ICON_MOON = ICON_LIST[5] .. "16:16:0:0|t",
	ICON_SQUARE = ICON_LIST[6] .. "16:16:0:0|t",
	ICON_CROSS = ICON_LIST[7] .. "16:16:0:0|t",
	ICON_SKULL = ICON_LIST[8] .. "16:16:0:0|t",
	BLANK = "None",
}
----------------------------------------------------------------
function()
	local dungeonID = 287
	local name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, textureFilename, difficulty, maxPlayers, description, isHoliday, bonusRepAmount, minPlayers, isTimeWalker, name2, minGearLevel, isScalingDungeon, lfgMapID = GetLFGDungeonInfo(dungeonID)
	local vivod =
	"|cff606060name|r".."   "..tostring(name).."|n"..
	"|cff606060typeID|r".."   "..tostring(typeID).."|n"..
	"|cff606060subtypeID|r".."   "..tostring(subtypeID).."|n"..
	"|cff606060minLevel|r".."   "..tostring(minLevel).."|n"..
	"|cff606060maxLevel|r".."   "..tostring(maxLevel).."|n"..
	"|cff606060recLevel|r".."   "..tostring(recLevel).."|n"..
	"|cff606060minRecLevel|r".."   "..tostring(minRecLevel).."|n"..
	"|cff606060maxRecLevel|r".."   "..tostring(maxRecLevel).."|n"..
	"|cff606060expansionLevel|r".."   "..tostring(expansionLevel).."|n"..
	"|cff606060groupID|r".."   "..tostring(groupID).."|n"..
	"|cff606060textureFilename|r".."   "..tostring(textureFilename).."|n"..
	"|cff606060difficulty|r".."   "..tostring(difficulty).."|n"..
	"|cff606060maxPlayers|r".."   "..tostring(maxPlayers).."|n"..
	"|cff606060description|r".."   "..tostring(description).."|n"..
	"|cff606060isHoliday|r".."   "..tostring(isHoliday).."|n"..
	"|cff606060bonusRepAmount|r".."   "..tostring(bonusRepAmount).."|n"..
	"|cff606060minPlayers|r".."   "..tostring(minPlayers).."|n"..
	"|cff606060isTimeWalker|r".."   "..tostring(isTimeWalker).."|n"..
	"|cff606060name2|r".."   "..tostring(name2).."|n"..
	"|cff606060minGearLevel|r".."   "..tostring(minGearLevel).."|n"..
	"|cff606060isScalingDungeon|r".."   "..tostring(isScalingDungeon).."|n"..
	"|cff606060lfgMapID|r".."   "..tostring(lfgMapID)
	return vivod
end
----------------------------------------------------------------
function SI:GetNextDailyResetTime()
  local resetTime = GetQuestResetTime()
  if (
    not resetTime or resetTime <= 0 or -- ticket 43: can fail during startup
    -- also right after a daylight savings rollover, when it returns negative values >.<
    resetTime > 24 * 60 * 60 + 30 -- can also be wrong near reset in an instance
  ) then
    return
  end

  return time() + resetTime
end

SI.GetNextDailySkillResetTime = SI.GetNextDailyResetTime
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------