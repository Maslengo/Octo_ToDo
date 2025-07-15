local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 6
function E:func_Otrisovka_06_WarlordsofDraenor()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1129)
				myType = {"Currency", 1129}
				----------------------------------------------------------------
				textLEFT = E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1129)
				iconLEFT = E.func_GetCurrencyIcon(1129)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 994)
				myType = {"Currency", 994}
				----------------------------------------------------------------
				textLEFT = E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(994)
				iconLEFT = E.func_GetCurrencyIcon(994)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 823)
				myType = {"Currency", 823}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(823)
				iconLEFT = E.func_GetCurrencyIcon(823)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1101)
				myType = {"Currency", 1101}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1101)
				iconLEFT = E.func_GetCurrencyIcon(1101)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 824)
				myType = {"Currency", 824}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(824)
				iconLEFT = E.func_GetCurrencyIcon(824)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.OctoTable_QuestID[38242] then
					textCENT = CharInfo.MASLENGO.OctoTable_QuestID[38242] and E.DONE
				end
				if CharInfo.MASLENGO.ItemsInBag[122457] then
					textCENT = textCENT.."+"..CharInfo.MASLENGO.ItemsInBag[122457]..E.func_GetItemIconByID(122457)
				end
				myType = {"Item", 122457}
				----------------------------------------------------------------
				textLEFT = E.func_questName(38242).." (ап пета)"
				iconLEFT = E.func_GetItemIconByID(122457)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.OctoTable_QuestID[39246] then
					textCENT = CharInfo.MASLENGO.OctoTable_QuestID[39246] and E.DONE
				end
				----------------------------------------------------------------
				textLEFT = E.func_questName(39246)
				iconLEFT = E.func_GetItemIconByID(127267)
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