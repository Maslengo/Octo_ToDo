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
				if CharInfo.MASLENGO.ItemsInBag[23572] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[23572]
				end
				myType = {"Item", 23572}
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(23572)
				iconLEFT = E.func_GetItemIconByID(23572)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[30183] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[30183]
				end
				myType = {"Item", 30183}
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(30183)
				iconLEFT = E.func_GetItemIconByID(30183)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[32428] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[32428]
				end
				myType = {"Item", 32428}
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(32428)
				iconLEFT = E.func_GetItemIconByID(32428)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[34664] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[34664]
				end
				myType = {"Item", 34664}
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(34664)
				iconLEFT = E.func_GetItemIconByID(34664)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[24581] then -- HORDE
					textCENT = CharInfo.MASLENGO.ItemsInBag[24581]
				end
				-- myType[#myType+1] = {" ", " "}
				if CharInfo.MASLENGO.ItemsInBag[24579] then -- ALLIANCE
					textCENT = CharInfo.MASLENGO.ItemsInBag[24579]
				end
				myType = {"Item", {24581, 24579}}
				----------------------------------------------------------------
				if E.curFaction == "Horde" then
					textLEFT = E.func_GetItemNameByID(24581)
					iconLEFT = E.func_GetItemIconByID(24581)
				else
					textLEFT = E.func_GetItemNameByID(24579)
					iconLEFT = E.func_GetItemIconByID(24579)
				end
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