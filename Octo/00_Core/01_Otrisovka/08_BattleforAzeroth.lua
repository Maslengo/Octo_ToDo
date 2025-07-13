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
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1560] then
					textCENT = CharInfo.MASLENGO.CurrencyID[1560]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1560)
				iconLEFT = E.func_GetCurrencyIcon(1560)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1721] then
					textCENT = CharInfo.MASLENGO.CurrencyID[1721]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1721)
				iconLEFT = E.func_GetCurrencyIcon(1721)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1803] then
					textCENT = CharInfo.MASLENGO.CurrencyID[1803]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1803)
				iconLEFT = E.func_GetCurrencyIcon(1803)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1755] then
					textCENT = CharInfo.MASLENGO.CurrencyID[1755]
				end
				if CharInfo.MASLENGO.ItemsInBag[173363] then
					textCENT = textCENT.." +"..CharInfo.MASLENGO.ItemsInBag[173363]..E.func_texturefromIcon(E.func_GetItemIconByID(173363))
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1755)
				iconLEFT = E.func_GetCurrencyIcon(1755)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1719] then
					textCENT = CharInfo.MASLENGO.CurrencyID[1719]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1719)
				iconLEFT = E.func_GetCurrencyIcon(1719)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1710] then
					textCENT = CharInfo.MASLENGO.CurrencyID[1710]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1710)
				iconLEFT = E.func_GetCurrencyIcon(1710)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1716] then
					textCENT = CharInfo.MASLENGO.CurrencyID[1716]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1716)
				iconLEFT = E.func_GetCurrencyIcon(1716)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1718]
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1718)
				iconLEFT = E.func_GetCurrencyIcon(1718)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[158075] == nil then
					textCENT = E.Red_Color.."no neck|r"
				else
					textCENT = E.Orange_Color.."neeed to equip|r"
					if CharInfo.PlayerData.azeriteLVL then
						textCENT = E.Green_Color..CharInfo.PlayerData.azeriteLVL.."|r".."+"..E.Gray_Color..CharInfo.PlayerData.azeriteEXP.."|r"
					end
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(158075)
				iconLEFT = E.func_GetItemIconByID(158075)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[169223] == nil then
					textCENT = E.Red_Color.."no cloak|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[169223] then
					textCENT = E.Orange_Color.."neeed to equip|r"
					if CharInfo.PlayerData.cloak_lvl and CharInfo.PlayerData.cloak_res then
						textCENT = CharInfo.PlayerData.cloak_lvl.." lvl"
						if CharInfo.PlayerData.cloak_lvl == 15 then
							textCENT = E.Green_Color..textCENT.."|r"
						end
						textCENT = textCENT.."+"..CharInfo.PlayerData.cloak_res
					end
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(169223)
				iconLEFT = E.func_GetItemIconByID(169223)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.islandBfA then
					textCENT = CharInfo.MASLENGO.islandBfA
				end
				----------------------------------------------------------------
				local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
				if questID then
					textLEFT = E.func_questName(questID)
				else
					textLEFT = "All_BfA_Island"
				end
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(166846))..E.func_GetItemNameByID(166846), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166846])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(169610))..E.func_GetItemNameByID(169610), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[169610])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(166970))..E.func_GetItemNameByID(166970), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166970])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168327))..E.func_GetItemNameByID(168327), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168327])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168832))..E.func_GetItemNameByID(168832), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168832])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(166971))..E.func_GetItemNameByID(166971), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166971])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168946))..E.func_GetItemNameByID(168946), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168946])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168215))..E.func_GetItemNameByID(168215), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168215])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168216))..E.func_GetItemNameByID(168216), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168216])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168217))..E.func_GetItemNameByID(168217), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168217])}
				textCENT = "МЕХАГОН"
				----------------------------------------------------------------
				textLEFT = "МЕХАГОН"
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		E.func_Universal(OctoTable_Otrisovka, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end