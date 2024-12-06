local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
local wipe = false
function E.Currencies()
	local Currencies = {
		type = "group",
		childGroups = "tree",
		name = CURRENCY,
		args = {
			-------------------------------------------------
			Currenciesinstructions = {
				type = "description",
				name = "These options allow you to toggle various options.",
				fontSize = "medium",
				order = 1,
			},
			-------------------------------------------------
			ReloadHeader4 = {
				type = "header",
				name = "",
				order = 1,
			},
			-------------------------------------------------
			Currencies = {
				type = "toggle",
				name = "Force Load Addons",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Currency
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Currency = value
				end,
				width = E.HALF_WIDTH,
				order = 2,
			},
			-------------------------------------------------
		},
	}
	if wipe == false then
		wipe = true
		local index = 0
		if OCTO_DB_currencies_test then
			for currencyHEADER, tbl in next, (OCTO_DB_currencies_test) do
				index = index + 1
				E.MergeTable(Currencies.args, {
						["addonNameHEADER57"..index] = {
							type = "header",
							name = currencyHEADER,
							order = 123 + index,
						},
				})
				for currencyID, config in next, (tbl) do
					index = index + 1
					E.MergeTable(Currencies.args, {
							["addonNameQWE7"..index] = {
								type = "toggle",
								name = E.func_currencyName(currencyID),
								desc = "",
								get = function()
									return OCTO_DB_currencies_test[currencyHEADER][currencyID]
								end,
								set = function(_, value)
									OCTO_DB_currencies_test[currencyHEADER][currencyID] = value
								end,
								width = .9,
								order = 123 + index,
							},
					})
				end
			end
		end
	end
	E.MergeTable(Currencies.args, {
			["ReloadHeader4second322"..1] = {
				type = "header",
				name = "",
				order = 322 + 1,
			},
	})
	return Currencies
end
