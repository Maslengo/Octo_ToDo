local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 11
function E:func_Otrisovka_11_TheWarWithin()
	local OctoTable_Otrisovka_textLEFT = {}
	local OctoTable_Otrisovka_textCENT = {}
	local OctoTable_Otrisovka_tooltipCENT = {}
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
				----------------------------------------------------------------
				tooltipKey = "TWW_GreatVault"

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
				return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
				----------------------------------------------------------------
				tooltipKey = "TWW_CurrentKey"

				if CharInfo.PlayerData.CurrentKey then
					textCENT = CharInfo.PlayerData.CurrentKey
				end
				----------------------------------------------------------------
				textLEFT = E.WOW_Epic_Color..L["Mythic Keystone"].."|r"
				-- iconLEFT = 4352494
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
				----------------------------------------------------------------
		end)
		if Octo_ToDo_DB_Vars.Currencies then
			for _, CurrencyID in ipairs(E.OctoTable_Catalysts) do
				table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
						----------------------------------------------------------------
						local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
						----------------------------------------------------------------
						textCENT = E:func_textCENT_Currency(CharInfo, CurrencyID)
						myType = {"Currency", CurrencyID}
						----------------------------------------------------------------
						textLEFT = E:func_currencyName(CurrencyID)
						colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
						----------------------------------------------------------------
						return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
						----------------------------------------------------------------
				end)
			end
		end
		----------------------------------------------------------------
		E:funcOtrisivka_CURRENCIES(OctoTable_Otrisovka_textCENT, OCTOexpansionID)
		E:func_Universal(OctoTable_Otrisovka_textCENT, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end