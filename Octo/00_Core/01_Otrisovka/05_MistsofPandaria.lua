local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 5
function E:func_Otrisovka_05_MistsofPandaria()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, tooltipLEFT = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[697] then
					textCENT = CharInfo.MASLENGO.CurrencyID[697]
				end
				tooltipLEFT = E.func_tooltipCurrencyAllPlayers("Currency", 697)
				----------------------------------------------------------------
				textLEFT = E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(697)
				iconLEFT = E.func_GetCurrencyIcon(697)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, tooltipLEFT
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, tooltipLEFT = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[776] then
					textCENT = CharInfo.MASLENGO.CurrencyID[776]
				end
				tooltipLEFT = E.func_tooltipCurrencyAllPlayers("Currency", 776)
				----------------------------------------------------------------
				textLEFT = E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(776)
				iconLEFT =E.func_GetCurrencyIcon(776)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, tooltipLEFT
				----------------------------------------------------------------
			end)
		E.func_Universal(OctoTable_Otrisovka, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end