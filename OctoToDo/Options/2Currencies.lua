local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
local wipe = false
function E.Currencies()
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local Currencies = {
		type = "group",
		childGroups = "tree",
		name = E.White_Color..CURRENCY.."|r",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Currency = {
				type = "toggle",
				name = CURRENCY,
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.Currency
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Currency = value
				end,
				width = E.FULL_WIDTH/4, -- 1.8,
				order = GetOrder(),
			},
			-------------------------------------------------
			CurrencyShowAllways = {
				type = "toggle",
				name = BATTLEFIELD_MINIMAP_SHOW_ALWAYS,
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.CurrencyShowAllways
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.CurrencyShowAllways = value
				end,
				width = E.FULL_WIDTH/4, -- 1.8,
				order = GetOrder(),
			},
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
		},
	}
	-- if wipe == false then
	-- 	wipe = true
	-- 	local index = 0
	-- 	if OCTO_DB_currencies_test then
	-- 		for currencyHEADER, tbl in next, (OCTO_DB_currencies_test) do
	-- 			index = index + 1
	-- 			E.func_TableMerge(Currencies.args, {
	-- 					["addonNameHEADER57"..index] = {
	-- 						type = "header",
	-- 						name = currencyHEADER,
	-- 						order = GetOrder(),
	-- 					},
	-- 			})
	-- 			for CurrencyID, config in next, (tbl) do
	-- 				index = index + 1
	-- 				E.func_TableMerge(Currencies.args, {
	-- 						["addonNameQWE7"..index] = {
	-- 							type = "toggle",
	-- 							name = E.func_currencyIcon(CurrencyID)..E.func_currencyName(CurrencyID),
	-- 							desc = "\n".."id: |r"..E.Green_Color..tostring(CurrencyID).."|r",
	-- 							get = function()
	-- 								return OCTO_DB_currencies_test[currencyHEADER][CurrencyID]
	-- 							end,
	-- 							set = function(_, value)
	-- 								OCTO_DB_currencies_test[currencyHEADER][CurrencyID] = value
	-- 							end,
	-- 							width = E.FULL_WIDTH/2,
	-- 							order = GetOrder(),
	-- 						},
	-- 				})
	-- 			end
	-- 		end
	-- 	end
	-- end
	E.func_TableMerge(Currencies.args, {
			["ReloadHeader4second322"..1] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
	})
	return Currencies
end
