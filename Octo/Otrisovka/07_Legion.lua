local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 7
function E.func_Otrisovka_07_Legion()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[currentSTATE] then
		-- table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
		-- 		----------------------------------------------------------------
		-- 		local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
		-- 		----------------------------------------------------------------
		-- 		textCENT = E.func_textCENT_Items(CharInfo, 124124)
		-- 		myType = {"Item", 124124}
		-- 		----------------------------------------------------------------
		-- 		textLEFT = E.func_itemName(124124)
		-- 		colorLEFT = E.OctoTable_Expansions[currentSTATE].color
		-- 		----------------------------------------------------------------
		-- 		return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
		-- 		----------------------------------------------------------------
		-- end)
		E.func_Otrisivka_CURRENCIESnITEMS(OctoTable_Otrisovka_textCENT, currentSTATE)
		E.func_Universal(OctoTable_Otrisovka_textCENT, currentSTATE)
		E.func_Otrisovka_REPUTATION(OctoTable_Otrisovka_textCENT, currentSTATE)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end