local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 4
function E:func_Otrisovka_04_Cataclysm()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Items(CharInfo, 52078)
				myType = {"Item", 52078}
				----------------------------------------------------------------
				textLEFT =E:func_GetItemNameByID(52078)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Items(CharInfo, 69237)
				myType = {"Item", 69237}
				----------------------------------------------------------------
				textLEFT =E:func_GetItemNameByID(69237)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Items(CharInfo, 71998)
				myType = {"Item", 71998}
				----------------------------------------------------------------
				textLEFT =E:func_GetItemNameByID(71998)
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