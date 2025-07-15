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
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[52078] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[52078]
				end
				myType = {"Item", 52078}
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(52078)
				iconLEFT =E.func_GetItemIconByID(52078)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[69237] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[69237]
				end
				myType = {"Item", 69237}
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(69237)
				iconLEFT =E.func_GetItemIconByID(69237)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
			end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[71998] then
					textCENT = CharInfo.MASLENGO.ItemsInBag[71998]
				end
				myType = {"Item", 71998}
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(71998)
				iconLEFT =E.func_GetItemIconByID(71998)
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