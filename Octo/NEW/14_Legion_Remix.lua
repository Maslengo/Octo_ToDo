local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 14
E.OctoTables_DataOtrisovka[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE].icon = E.OctoTable_Expansions[7].icon
E.OctoTables_Vibor[currentSTATE].name = E.OctoTable_Expansions[7].color..E.OctoTable_Expansions[7].name.." (REMIX)|r"
local function localfunc()
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Currencies = {
		3292, -- E.func_IsRemix()
		3268, -- E.func_IsRemix()
		3252, -- E.func_IsRemix()
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Items = {
		254267,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Reputations = {
		1900, --name = "Двор Фарондиса", side = "-", category = "Legion", }, --[faction=1900]
		1883, --name = "Ткачи Снов", side = "-", category = "Legion", }, --[faction=1883]
		1828, --name = "Племена Крутогорья", side = "-", category = "Legion", }, --[faction=1828]
		1948, --name = "Валарьяры", side = "-", category = "Legion", }, --[faction=1948]
		1894, --name = "Стражи", side = "-", category = "Legion", }, --[faction=1894]
		1859, --name = "Помраченные", side = "-", category = "Legion", }, --[faction=1859]
		2170, --name = "Защитники Аргуса", side = "-", category = "Legion", }, --[faction=2170]
		2165, --name = "Армия Света", side = "-", category = "Legion", }, --[faction=2165]
		2045, --name = "Армия погибели Легиона", side = "-", category = "Legion", }, --[faction=2045]
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Additionally = {
	}
end
----------------------------------------------------------------
local function localfunc2()
	local OctoTable_Otrisovka_textCENT = {}
	if Octo_ToDo_DB_Vars.ExpansionToShow[currentSTATE] then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", nil, nil, {}, nil,  false, nil, nil
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
				return iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
tinsert(E.newOTRISOVKA, localfunc)
tinsert(E.newOTRISOVKA2, localfunc2)
