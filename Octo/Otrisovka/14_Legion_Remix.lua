local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 14
function E.func_Otrisovka_14_Legion_Remix()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
				tooltipKey = "LegionRemixResearch"
				if CharInfo.MASLENGO.LegionRemixData and CharInfo.MASLENGO.LegionRemixData.barValue and CharInfo.MASLENGO.LegionRemixData.barMax then
					local barValue = CharInfo.MASLENGO.LegionRemixData.barValue
					local barMax = CharInfo.MASLENGO.LegionRemixData.barMax
					local new_textCENT = barValue.."/"..barMax
					if CharInfo.MASLENGO.LegionRemixData.TotalInfinityResearchQuests then
						new_textCENT = barValue..E.Blue_Color.."("..CharInfo.MASLENGO.LegionRemixData.TotalInfinityResearchQuests..")|r" .."/"..barMax
					end
					textCENT = new_textCENT
				end
				----------------------------------------------------------------
				textLEFT = L["Infinite Research"]
				colorLEFT = E.OctoTable_Expansions[7].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
				----------------------------------------------------------------
		end)
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[currentSTATE] then
		E.func_Otrisivka_CURRENCIESnITEMS(OctoTable_Otrisovka_textCENT, currentSTATE)
		E.func_Universal(OctoTable_Otrisovka_textCENT, currentSTATE)
		E.func_Otrisovka_REPUTATION(OctoTable_Otrisovka_textCENT, currentSTATE)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end