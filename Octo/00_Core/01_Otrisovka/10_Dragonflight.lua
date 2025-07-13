local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 10
function E:func_Otrisovka_10_Dragonflight()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[209856] then
					textCENT = E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[209856].."|r"
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(209856)
				iconLEFT = E.func_GetItemIconByID(209856)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[207002] then
					textCENT = E.WOW_Rare_Color..CharInfo.MASLENGO.ItemsInBag[207002].."|r"
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(207002)
				iconLEFT = E.func_GetItemIconByID(207002)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[2594] then
					textCENT = CharInfo.MASLENGO.CurrencyID[2594]
				end
				if CharInfo.MASLENGO.ItemsInBag[208945] then
					textCENT = textCENT..E.WOW_WoWToken_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208945].."|r"..E.func_GetItemIconByID(208945)
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(2594)
				iconLEFT = E.func_GetCurrencyIcon(2594)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[210254] then
					textCENT = E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[210254].."|r"
				end
				----------------------------------------------------------------
				textLEFT = E.WOW_Epic_Color..E.func_GetItemNameByID(210254).."|r"
				iconLEFT = E.func_GetItemIconByID(210254)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[2245] then
					textCENT = CharInfo.MASLENGO.CurrencyID[2245]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(2245)
				iconLEFT = E.func_GetCurrencyIcon(2245)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[213089] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[213089]
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(213089)
				iconLEFT = E.func_GetItemIconByID(213089)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[211516] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[211516]
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(211516)
				iconLEFT = E.func_GetItemIconByID(211516)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[211515] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[211515]
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(211515)
				iconLEFT = E.func_GetItemIconByID(211515)
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