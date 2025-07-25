local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 8
function E:func_Otrisovka_08_BattleforAzeroth()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Currency(CharInfo, 1560)
				myType = {"Currency", 1560}
				----------------------------------------------------------------
				textLEFT = E:func_currencyName(1560)
				iconLEFT = E:func_GetCurrencyIcon(1560)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Currency(CharInfo, 1721)
				myType = {"Currency", 1721}
				----------------------------------------------------------------
				textLEFT = E:func_currencyName(1721)
				iconLEFT = E:func_GetCurrencyIcon(1721)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Currency(CharInfo, 1803)
				myType = {"Currency", 1803}
				----------------------------------------------------------------
				textLEFT = E:func_currencyName(1803)
				iconLEFT = E:func_GetCurrencyIcon(1803)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Currency(CharInfo, 1755, 173363)
				myType = {"Currency", 1755}
				----------------------------------------------------------------
				textLEFT = E:func_currencyName(1755)
				iconLEFT = E:func_GetCurrencyIcon(1755)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Currency(CharInfo, 1719)
				myType = {"Currency", 1719}
				----------------------------------------------------------------
				textLEFT = E:func_currencyName(1719)
				iconLEFT = E:func_GetCurrencyIcon(1719)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Currency(CharInfo, 1710)
				myType = {"Currency", 1710}
				----------------------------------------------------------------
				textLEFT = E:func_currencyName(1710)
				iconLEFT = E:func_GetCurrencyIcon(1710)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Currency(CharInfo, 1716)
				textCENT = E:func_textCENT_Currency(CharInfo, 1717)
				myType = {"Currency", {1716, 1717}}
				----------------------------------------------------------------



				if E.curFaction == "Horde" then
					textLEFT = E:func_currencyName(1716)
					iconLEFT = E:func_GetCurrencyIcon(1716)
				else
					textLEFT = E:func_currencyName(1717)
					iconLEFT = E:func_GetCurrencyIcon(1717)
				end





				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Currency(CharInfo, 1718)
				myType = {"Currency", 1718}
				----------------------------------------------------------------
				textLEFT = E:func_currencyName(1718)
				iconLEFT = E:func_GetCurrencyIcon(1718)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[158075] then
					textCENT = E.Orange_Color.."neeed to equip|r"
					if CharInfo.PlayerData.azeriteLVL then
						textCENT = E.Green_Color..CharInfo.PlayerData.azeriteLVL.."|r".."+"..E.Gray_Color..CharInfo.PlayerData.azeriteEXP.."|r"
					end
				else
					textCENT = E.Red_Color.."no neck|r"
				end
				myType = {"Item", 158075}
				----------------------------------------------------------------
				textLEFT = E:func_GetItemNameByID(158075)
				iconLEFT = E:func_GetItemIconByID(158075)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[169223] then
					textCENT = E.Orange_Color.."neeed to equip|r"
					if CharInfo.PlayerData.cloak_lvl and CharInfo.PlayerData.cloak_res then
						textCENT = CharInfo.PlayerData.cloak_lvl.." lvl"
						if CharInfo.PlayerData.cloak_lvl == 15 then
							textCENT = E.Green_Color..textCENT.."|r"
						end
						textCENT = textCENT.."+"..CharInfo.PlayerData.cloak_res
					end
				else
					textCENT = E.Red_Color.."no cloak|r"
				end
				myType = {"Item", 169223}
				----------------------------------------------------------------
				textLEFT = E:func_GetItemNameByID(169223)
				iconLEFT = E:func_GetItemIconByID(169223)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.islandBfA then
					textCENT = CharInfo.MASLENGO.islandBfA
				end
				----------------------------------------------------------------
				local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
				if questID then
					textLEFT = E:func_questName(questID)
				else
					textLEFT = "All_BfA_Island"
				end
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}

				tooltipRIGHT = E:func_tooltipRIGHT_ITEMS(CharInfo, E.OctoTable_itemID_MECHAGON, true)


				textCENT = "МЕХАГОН"
				----------------------------------------------------------------
				textLEFT = "МЕХАГОН"
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		E:func_Universal(OctoTable_Otrisovka, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end