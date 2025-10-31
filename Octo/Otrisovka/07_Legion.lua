local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 7
function E.func_Otrisovka_07_Legion()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		-- table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
		-- 		----------------------------------------------------------------
		-- 		local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
		-- 		----------------------------------------------------------------
		-- 		textCENT = E.func_textCENT_Items(CharInfo, 124124)
		-- 		myType = {"Item", 124124}
		-- 		----------------------------------------------------------------
		-- 		textLEFT = E.func_itemName(124124)
		-- 		colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
		-- 		----------------------------------------------------------------
		-- 		return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
		-- 		----------------------------------------------------------------
		-- end)



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
				textLEFT = "Задачи исследований"
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
				----------------------------------------------------------------
		end)





		E.func_Otrisivka_CURRENCIES(OctoTable_Otrisovka_textCENT, OCTOexpansionID)
		E.func_Universal(OctoTable_Otrisovka_textCENT, OCTOexpansionID)




		if E.func_IsRemix() then


		end

	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end