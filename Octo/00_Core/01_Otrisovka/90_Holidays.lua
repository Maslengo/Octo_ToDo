local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
-- table.insert(OctoTable_Otrisovka, function(CharInfo)
-- ----------------------------------------------------------------
-- local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
-- ----------------------------------------------------------------
-- local v = E.Holiday[181]
-- if CharInfo.PlayerData.GUID == E.curGUID then
-- textCENT = E.Holiday_Color..v.startTime.." - "..v.endTime.."|r"
-- end
-- ----------------------------------------------------------------
-- local v = E.Holiday[181]
-- textLEFT = v.invitedBy..E.Holiday_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id: 181|r" or "")
-- iconLEFT = v.iconTexture
-- colorLEFT = E.Holiday_Color
-- ----------------------------------------------------------------
-- return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
-- ----------------------------------------------------------------
-- end)
----------------------------------------------------------------
function E:func_Otrisovka_90_Holidays()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Holidays then
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[181] then
			E.func_Universal_Holiday(OctoTable_Otrisovka, "HolidaysNoblegarden", E.Holiday_Color)
			table.insert(OctoTable_Otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[44791] then
						textCENT = CharInfo.MASLENGO.ItemsInBag[44791]
					end
					----------------------------------------------------------------
					textLEFT = E.func_GetItemNameByID(44791)
					iconLEFT = E.func_GetItemIconByID(44791)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[45072] then
						textCENT = CharInfo.MASLENGO.ItemsInBag[45072]
					end
					----------------------------------------------------------------
					textLEFT = E.func_GetItemNameByID(45072)
					iconLEFT = E.func_GetItemIconByID(45072)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		local TimewalkHolidayTBL = {1265, 1063, 652, 622} -- 1458 Бурные потоки
		for _, HolidayID in ipairs(TimewalkHolidayTBL) do
			if E.ActiveHoliday[HolidayID] then
				E.func_Universal_Holiday(OctoTable_Otrisovka, "HolidaysTimewalk", E.Event_Color)
				table.insert(OctoTable_Otrisovka, function(CharInfo)
						----------------------------------------------------------------
						local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
						----------------------------------------------------------------
						if CharInfo.MASLENGO.CurrencyID[1166] then
							textCENT = CharInfo.MASLENGO.CurrencyID[1166]
						end
						----------------------------------------------------------------
						textLEFT = E.func_currencyName(1166)
						iconLEFT = E.func_GetCurrencyIcon(1166)
						colorLEFT = E.Event_Color
						----------------------------------------------------------------
						return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
						----------------------------------------------------------------
				end)
			end
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[201] then
			E.func_Universal_Holiday(OctoTable_Otrisovka, "HolidaysChildrensWeek", E.Holiday_Color)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[341] then -- СОЛНЦЕВОРОТ
			E.func_Universal_Holiday(OctoTable_Otrisovka, "HolidaysTheSpinnerofSummerTales", E.Holiday_Color)
			table.insert(OctoTable_Otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.LFGInstance[286] and CharInfo.MASLENGO.LFGInstance[286].donetoday then
						textCENT = CharInfo.MASLENGO.LFGInstance[286].donetoday
					end
					----------------------------------------------------------------
					textLEFT = E.func_texturefromIcon(E.Icon_LFG) .. E.func_LFGdungName(286)
					iconLEFT = E.func_GetItemIconByID(23247)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[23247] then
						textCENT = CharInfo.MASLENGO.ItemsInBag[23247]
					end
					----------------------------------------------------------------
					textLEFT = E.func_GetItemNameByID(23247)
					iconLEFT = E.func_GetItemIconByID(23247)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[1691] then -- Алчный посланец
			E.func_Universal_Holiday(OctoTable_Otrisovka, "HolidaysAGreedyEmissary", E.Red_Color)
			table.insert(OctoTable_Otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.CurrencyID[3309] then
						textCENT = CharInfo.MASLENGO.CurrencyID[3309]
					end
					----------------------------------------------------------------
					textLEFT = E.func_currencyName(3309)
					iconLEFT = E.func_GetCurrencyIcon(3309)
					colorLEFT = E.Red_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[479] then -- Ярмарка новолунья
			E.func_Universal_Holiday(OctoTable_Otrisovka, "HolidaysDarkmoonFaire", E.Purple_Color)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		E.func_Universal(OctoTable_Otrisovka, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end