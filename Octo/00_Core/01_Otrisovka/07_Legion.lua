local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 7
function E:func_Otrisovka_07_Legion()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1273)
				myType = {"Currency", 1273}
				----------------------------------------------------------------
				textLEFT = E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1273)
				iconLEFT = E.func_GetCurrencyIcon(1273)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1508)
				myType = {"Currency", 1508}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1508)
				iconLEFT = E.func_GetCurrencyIcon(1508)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1342)
				myType = {"Currency", 1342}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1342)
				iconLEFT = E.func_GetCurrencyIcon(1342)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1220)
				myType = {"Currency", 1220}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1220)
				iconLEFT = E.func_GetCurrencyIcon(1220)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1226)
				myType = {"Currency", 1226}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1226)
				iconLEFT = E.func_GetCurrencyIcon(1226)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1533)
				myType = {"Currency", 1533}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1533)
				iconLEFT = E.func_GetCurrencyIcon(1533)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E.func_textCENT_Currency(CharInfo, 1155)
				myType = {"Currency", 1155}
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1155)
				iconLEFT = E.func_GetCurrencyIcon(1155)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[124124] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[124124]
				end
				myType = {"Item", 124124}
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(124124)
				iconLEFT = E.func_GetItemIconByID(124124)
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