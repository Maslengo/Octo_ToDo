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
			ReloadHeader4 = {
				type = "header",
				name = "",
				order = 2,
			},
			-------------------------------------------------
			Currency = {
				type = "toggle",
				name = CURRENCY,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Currency
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Currency = value
				end,
				width = E.FULL_WIDTH/4, -- 1.8,
				order = 3,
			},
			-------------------------------------------------
			CurrencyShowAllways = {
				type = "toggle",
				name = BATTLEFIELD_MINIMAP_SHOW_ALWAYS,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.CurrencyShowAllways
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.CurrencyShowAllways = value
				end,
				width = E.FULL_WIDTH/4, -- 1.8,
				order = 4,
			},
			-------------------------------------------------
			CurrencyALLTURNON = {
				type = "execute",
				name = ENABLE_ALL_ADDONS,

				-- image = "Interface\\Transmogrify\\Transmogrify",
				-- imageCoords = {0, 0, 0, 0},
				-- imageWidth = 22,
				-- imageHeight = 22,

				func = function()
					for currencyHEADER, tbl in next, (OCTO_DB_currencies_test) do
						for CurrencyID, config in next, (tbl) do
							OCTO_DB_currencies_test[currencyHEADER][CurrencyID] = true
						end
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 5,
			},
			-------------------------------------------------
			CurrencyALLTURNOFF = {
				type = "execute",
				name = "Выключить все",
				func = function()
					for currencyHEADER, tbl in next, (OCTO_DB_currencies_test) do
						for CurrencyID, config in next, (tbl) do
							OCTO_DB_currencies_test[currencyHEADER][CurrencyID] = false
						end
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 6,
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
				E.func_TableMerge(Currencies.args, {
						["addonNameHEADER57"..index] = {
							type = "header",
							name = currencyHEADER,
							order = 123 + index,
						},
				})
				for CurrencyID, config in next, (tbl) do
					index = index + 1
					E.func_TableMerge(Currencies.args, {
							["addonNameQWE7"..index] = {
								type = "toggle",
								name = E.func_currencyIcon(CurrencyID)..E.func_currencyName(CurrencyID),
								desc = "\n".."id: |r"..E.Green_Color..tostring(CurrencyID).."|r",
								get = function()
									return OCTO_DB_currencies_test[currencyHEADER][CurrencyID]
								end,
								set = function(_, value)
									OCTO_DB_currencies_test[currencyHEADER][CurrencyID] = value
								end,
								width = E.FULL_WIDTH/2,
								order = 123 + index,
							},
					})
				end
			end
		end
	end
	E.func_TableMerge(Currencies.args, {
			["ReloadHeader4second322"..1] = {
				type = "header",
				name = "",
				order = 322 + 1,
			},
	})
	return Currencies
end
