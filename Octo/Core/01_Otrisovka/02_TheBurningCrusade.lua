local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 2
function E:func_Otrisovka_02_TheBurningCrusade()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Items(CharInfo, 23572)
				myType = {"Item", 23572}
				----------------------------------------------------------------
				textLEFT = E:func_GetItemNameByID(23572)
				iconLEFT = E:func_GetItemIconByID(23572)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Items(CharInfo, 30183)
				myType = {"Item", 30183}
				----------------------------------------------------------------
				textLEFT = E:func_GetItemNameByID(30183)
				iconLEFT = E:func_GetItemIconByID(30183)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Items(CharInfo, 32428)
				myType = {"Item", 32428}
				----------------------------------------------------------------
				textLEFT = E:func_GetItemNameByID(32428)
				iconLEFT = E:func_GetItemIconByID(32428)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Items(CharInfo, 34664)
				myType = {"Item", 34664}
				----------------------------------------------------------------
				textLEFT = E:func_GetItemNameByID(34664)
				iconLEFT = E:func_GetItemIconByID(34664)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Items(CharInfo, {24581, 24579}) -- HORDE, ALLIANCE
				myType = {"Item", {24581, 24579}}
				----------------------------------------------------------------
				if E.curFaction == "Horde" then
					textLEFT = E:func_GetItemNameByID(24581)
					iconLEFT = E:func_GetItemIconByID(24581)
				else
					textLEFT = E:func_GetItemNameByID(24579)
					iconLEFT = E:func_GetItemIconByID(24579)
				end
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