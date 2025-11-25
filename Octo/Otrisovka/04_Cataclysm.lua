local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 4
function E.func_Otrisovka_04_Cataclysm()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
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