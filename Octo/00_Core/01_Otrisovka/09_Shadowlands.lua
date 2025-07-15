local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 9
function E:func_Otrisovka_09_Shadowlands()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		for kCovenant = 1, 2 do
			for iANIMA = 1, 4 do
				table.insert(OctoTable_Otrisovka, function(CharInfo)
						----------------------------------------------------------------
						local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
						----------------------------------------------------------------
						local color = E.OctoTable_Covenant[iANIMA].color
						-- отриосвка всего по центру
						if CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant] then
							textCENT = color..CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant].."|r"
						end
						if kCovenant == 1 then
							iconLEFT = E.OctoTable_Covenant[iANIMA].icon
							myType = {"Currency_Covenant_Renown", 1813, iANIMA, kCovenant}
						elseif kCovenant == 2 then
							iconLEFT = E.func_GetCurrencyIcon(1813)
							myType = {"Currency_Covenant_Anima", 1813, iANIMA, kCovenant}
							 if iANIMA == CharInfo.MASLENGO.CovenantAndAnima.curCovID then
								if CharInfo.PlayerData.Possible_Anima then
									textCENT = textCENT..E.Blue_Color.." +"..CharInfo.PlayerData.Possible_Anima.."|r"
								end
							-- 	colorCENT = color
							-- else
							-- 	colorCENT = nil
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
						return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
						----------------------------------------------------------------
					end)
			end
		end
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 2009)
				myType = {"Currency", 2009}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(2009)
				iconLEFT = E.func_GetCurrencyIcon(2009)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1906)
				myType = {"Currency", 1906}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1906)
				iconLEFT = E.func_GetCurrencyIcon(1906)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1828)
				myType = {"Currency", 1828}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1828)
				iconLEFT = E.func_GetCurrencyIcon(1828)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1979)
				myType = {"Currency", 1979}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1979)
				iconLEFT = E.func_GetCurrencyIcon(1979)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1931)
				myType = {"Currency", 1931}
				if CharInfo.PlayerData.Possible_CatalogedResearch then
					textCENT = textCENT..E.Purple_Color.." +"..CharInfo.PlayerData.Possible_CatalogedResearch.."|r"
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1931)
				iconLEFT = E.func_GetCurrencyIcon(1931)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1904)
				myType = {"Currency", 1904}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1904)
				iconLEFT = E.func_GetCurrencyIcon(1904)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		E.func_Universal(OctoTable_Otrisovka, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end