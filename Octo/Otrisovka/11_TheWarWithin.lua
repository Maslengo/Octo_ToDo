local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 11
function E:func_Otrisovka_11_TheWarWithin()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------
				local Enum_Activities_table = {}
				for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
					Enum_Activities_table[#Enum_Activities_table+1] = i
				end
				table.sort(Enum_Activities_table)
				for j = 1, #Enum_Activities_table do
					local i = Enum_Activities_table[j]
					if CharInfo.MASLENGO.GreatVault[i] and CharInfo.MASLENGO.GreatVault[i].type ~= "" then
						-- CharInfo.MASLENGO.GreatVault[i] = CharInfo.MASLENGO.GreatVault[i] or {}
						if CharInfo.MASLENGO.GreatVault[i].progress and CharInfo.MASLENGO.GreatVault[i].threshold then
							if CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING then
								tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.MASLENGO.GreatVault[i].type, CharInfo.MASLENGO.GreatVault[i].progress.."/"..CharInfo.MASLENGO.GreatVault[i].threshold.." "..E:func_RIOColor(CharInfo.PlayerData.RIO_Score)..CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING.."|r"}
							elseif CharInfo.MASLENGO.GreatVault[i].progress then
								tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.MASLENGO.GreatVault[i].type, CharInfo.MASLENGO.GreatVault[i].progress.."/"..CharInfo.MASLENGO.GreatVault[i].threshold}
							end
						end
					end
				end
				if CharInfo.PlayerData.HasAvailableRewards then
					textCENT = E.Blue_Color..">"..REWARD.."<|r"
				end
				textLEFT = E.Blue_Color..RATED_PVP_WEEKLY_VAULT.."|r"-- DELVES_GREAT_VAULT_LABEL
				-- iconLEFT = "greatVault-whole-normal"
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				-- CreateAtlasMarkup("greatVault-whole-normal", 20, 20)..
				-- greatVault-handles-dis
				-- greatVault-centerPlate-dis
				-- greatVault-whole-normal
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.PlayerData.CurrentKeyName then
					tooltipRIGHT[#tooltipRIGHT+1] = {E:func_RIOColor(CharInfo.PlayerData.RIO_Score)..CharInfo.PlayerData.CurrentKeyLevel.." "..CharInfo.PlayerData.CurrentKeyName.."|r", ""}
				end
				if CharInfo.PlayerData.RIO_Score and CharInfo.PlayerData.RIO_weeklyBest then
					tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
					tooltipRIGHT[#tooltipRIGHT+1] = {"Weekly Best:", E:func_RIOColor(CharInfo.PlayerData.RIO_Score)..CharInfo.PlayerData.RIO_weeklyBest.."|r"}
					tooltipRIGHT[#tooltipRIGHT+1] = {"RIO Score:", E:func_RIOColor(CharInfo.PlayerData.RIO_Score)..CharInfo.PlayerData.RIO_Score.."|r"}
				end
				if CharInfo.PlayerData.CurrentKey then
					textCENT = E:func_RIOColor(CharInfo.PlayerData.RIO_Score)..CharInfo.PlayerData.CurrentKey.."|r"
				end
				----------------------------------------------------------------
				textLEFT = E.WOW_Epic_Color..L["Mythic Keystone"].."|r"
				-- iconLEFT = 4352494
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		if Octo_ToDo_DB_Vars.Currencies then
			for _, CurrencyID in ipairs(E.OctoTable_Catalysts) do
				table.insert(OctoTable_Otrisovka, function(CharInfo)
						----------------------------------------------------------------
						local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
						----------------------------------------------------------------
						textCENT = E:func_textCENT_Currency(CharInfo, CurrencyID)
						myType = {"Currency", CurrencyID}
						----------------------------------------------------------------
						textLEFT = E:func_currencyName(CurrencyID)
						colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
						----------------------------------------------------------------
						return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
						----------------------------------------------------------------
				end)
			end
		end
		----------------------------------------------------------------
		E:funcOtrisivka_CURRENCIES(OctoTable_Otrisovka, OCTOexpansionID)
		E:func_Universal(OctoTable_Otrisovka, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end