local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 3
function E:func_Otrisovka_03_WrathoftheLichKing()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				do
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
					----------------------------------------------------------------
					textCENT = E:func_textCENT_Items(CharInfo, 45087)
					myType = {"Item", 45087}
					----------------------------------------------------------------
					textLEFT = E:func_GetItemNameByID(45087)
					iconLEFT = E:func_GetItemIconByID(45087)
					colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				end
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				do
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
					----------------------------------------------------------------
					textCENT = E:func_textCENT_Items(CharInfo, 47556)
					myType = {"Item", 47556}
					----------------------------------------------------------------
					textLEFT = E:func_GetItemNameByID(47556)
					iconLEFT = E:func_GetItemIconByID(47556)
					colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				end
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				do
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
					----------------------------------------------------------------
					textCENT = E:func_textCENT_Items(CharInfo, 49908)
					myType = {"Item", 49908}
					----------------------------------------------------------------
					textLEFT = E:func_GetItemNameByID(49908)
					iconLEFT = E:func_GetItemIconByID(49908)
					colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				end
				----------------------------------------------------------------
		end)
		E:func_Universal(OctoTable_Otrisovka, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end