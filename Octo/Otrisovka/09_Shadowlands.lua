local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 9
function E:func_Otrisovka_09_Shadowlands()
	local OctoTable_Otrisovka_textLEFT = {}
	local OctoTable_Otrisovka_textCENT = {}
	local OctoTable_Otrisovka_tooltipCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		for kCovenant = 1, 2 do
			for iANIMA = 1, 4 do
				table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
						----------------------------------------------------------------
						local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
						----------------------------------------------------------------
						local color = E.OctoTable_Covenant[iANIMA].color
						-- отриосвка всего по центру
						if CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant] then
							textCENT = color..CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant].."|r"
						end
						if kCovenant == 1 then
							-- iconLEFT = E.OctoTable_Covenant[iANIMA].icon
							myType = {"Currency_Covenant_Renown", 1813, iANIMA, kCovenant}
						elseif kCovenant == 2 then
							-- iconLEFT = E:func_GetCurrencyIcon(1813)
							myType = {"Currency_Covenant_Anima", 1813, iANIMA, kCovenant}
							if iANIMA == CharInfo.MASLENGO.CovenantAndAnima.curCovID then
								if CharInfo.PlayerData.Possible_Anima then
									textCENT = textCENT..E.Blue_Color.." +"..CharInfo.PlayerData.Possible_Anima.."|r"
								end
							end
						end
						if iANIMA == CharInfo.MASLENGO.CovenantAndAnima.curCovID then
							colorCENT = color
						else
							colorCENT = nil
						end
						----------------------------------------------------------------
						vivodLeft = color..E.OctoTable_Covenant[iANIMA].name.."|r"
						----------------------------------------------------------------
						textLEFT = vivodLeft
						colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
						----------------------------------------------------------------
						return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
						----------------------------------------------------------------
				end)
			end
		end
		E:funcOtrisivka_CURRENCIES(OctoTable_Otrisovka_textCENT, OCTOexpansionID)
		E:func_Universal(OctoTable_Otrisovka_textCENT, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end