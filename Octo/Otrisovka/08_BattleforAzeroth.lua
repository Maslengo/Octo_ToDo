local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 8
function E.func_Otrisovka_08_BattleforAzeroth()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[currentSTATE] then
		if Octo_ToDo_DB_Vars.Items then
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[158075] then
						textCENT = CharInfo.PlayerData.azeriteLVL and E.Green_Color..CharInfo.PlayerData.azeriteLVL.."|r".."+"..E.Gray_Color..CharInfo.PlayerData.azeriteEXP.."|r" or E.Orange_Color.."in bank|r"
					end
					myType = {"Item", 158075}
					----------------------------------------------------------------
					textLEFT = E.func_itemName(158075)
					colorLEFT = E.OctoTable_Expansions[currentSTATE].color
					----------------------------------------------------------------
					return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
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
					textLEFT = E.func_itemName(169223)
					colorLEFT = E.OctoTable_Expansions[currentSTATE].color
					----------------------------------------------------------------
					return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
					tooltipKey = "BfA_mechagonItems"
					textCENT = E.Gray_Color..ITEMS.."|r"
					----------------------------------------------------------------
					textLEFT = "МЕХАГОН"
					colorLEFT = E.OctoTable_Expansions[currentSTATE].color
					----------------------------------------------------------------
					return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
					----------------------------------------------------------------
			end)
		end
		E.func_Otrisivka_CURRENCIESnITEMS(OctoTable_Otrisovka_textCENT, currentSTATE)
		E.func_Universal(OctoTable_Otrisovka_textCENT, currentSTATE)
		E.func_Otrisovka_REPUTATION(OctoTable_Otrisovka_textCENT, currentSTATE)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end