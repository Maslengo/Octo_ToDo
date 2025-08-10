local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_Otrisovka_90_Holidays()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Holidays then
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[181] then
			E:func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysNoblegarden")
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[44791] then
						textCENT = CharInfo.MASLENGO.ItemsInBag[44791]
					end
					----------------------------------------------------------------
					textLEFT = E:func_itemName(44791)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[45072] then
						textCENT = CharInfo.MASLENGO.ItemsInBag[45072]
					end
					----------------------------------------------------------------
					textLEFT = E:func_itemName(45072)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		-- 1583 EU classic
		-- 1508 US classic
		-- 1458 Бурные потоки
		-- local TimewalkHolidayTBL = {1583, 1265, 1063, 652, 622, 1508, 1667}
		-- for _, HolidayID in ipairs(TimewalkHolidayTBL) do
		--     if E.ActiveHoliday[HolidayID] then
		local joinable, timewalkDungeonName = E:func_joinableDung()
		if joinable then
			E:func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysTimewalk", E.Event_Color)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
					----------------------------------------------------------------
					textCENT = E:func_textCENT_Currency(CharInfo, 1166)
					myType = {"Currency", 1166}
					----------------------------------------------------------------
					textLEFT = timewalkDungeonName .. E:func_currencyName(1166)
					colorLEFT = E.Event_Color
					----------------------------------------------------------------
					return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
					----------------------------------------------------------------
			end)
		end
		--     end
		-- end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		-- if E.ActiveHoliday[201] then
		--     E:func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysChildrensWeek")
		-- end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[341] then -- СОЛНЦЕВОРОТ
			E:func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysTheSpinnerofSummerTales")
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.LFGInstance[286] and CharInfo.MASLENGO.LFGInstance[286].donetoday then
						textCENT = CharInfo.MASLENGO.LFGInstance[286].donetoday
					end
					----------------------------------------------------------------
					textLEFT = E:func_texturefromIcon(E:func_GetItemIconByID(23247))..E:func_texturefromIcon(E.Icon_LFG) .. E:func_LFGdungName(286)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[23247] then
						textCENT = CharInfo.MASLENGO.ItemsInBag[23247]
					end
					----------------------------------------------------------------
					textLEFT = E:func_itemName(23247)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[1691] then -- Алчный посланец
			E:func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysAGreedyEmissary", E.Red_Color)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
					----------------------------------------------------------------
					textCENT = E:func_textCENT_Currency(CharInfo, 3309)
					myType = {"Currency", 3309}
					----------------------------------------------------------------
					textLEFT = E:func_currencyName(3309)
					colorLEFT = E.Red_Color
					----------------------------------------------------------------
					return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[479] then -- Ярмарка новолунья
			E:func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysDarkmoonFaire", E.Purple_Color)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		E:funcOtrisivka_CURRENCIES(OctoTable_Otrisovka_textCENT)
		E:func_Universal(OctoTable_Otrisovka_textCENT)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end