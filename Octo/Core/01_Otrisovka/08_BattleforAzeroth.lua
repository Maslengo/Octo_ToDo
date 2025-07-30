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
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[158075] then
					textCENT = CharInfo.PlayerData.azeriteLVL and E.Green_Color..CharInfo.PlayerData.azeriteLVL.."|r".."+"..E.Gray_Color..CharInfo.PlayerData.azeriteEXP.."|r" or E.Orange_Color.."in bank|r"
				end
				myType = {"Item", 158075}
				----------------------------------------------------------------
				textLEFT = E:func_GetItemNameByID(158075)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[169223] then
					if CharInfo.PlayerData.cloak_lvl then
						textCENT = E.Cyan_Color..AZERITE_ESSENCE_RANK:format(CharInfo.PlayerData.cloak_lvl).."|r"
					else
						textCENT = E.Orange_Color.."in bank|r"
					end
				end
				myType = {"Item", 169223}
				----------------------------------------------------------------
				textLEFT = E:func_GetItemNameByID(169223)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
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
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				tooltipRIGHT = E:func_tooltipRIGHT_ITEMS(CharInfo, E.OctoTable_itemID_MECHAGON, true)
				textCENT = "МЕХАГОН"
				----------------------------------------------------------------
				textLEFT = "МЕХАГОН"
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		E:funcOtrisivka_CURRENCIES(OctoTable_Otrisovka, OCTOexpansionID)
		E:func_Universal(OctoTable_Otrisovka, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end