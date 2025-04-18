local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.Addons()
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local GeneralOptionsADDONS = {
		type = "group",
		childGroups = "tree",
		name = E.func_AddonTitle(GlobalAddonName).." "..E.Gray_Color..E.func_AddonVersion(GlobalAddonName) .. "|r",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-- AddonHeight = {
			-- 	type = "range",
			-- 	name = L["AddonHeight"],
			-- 	desc = "OctoToDo_AddonsManager.AddonHeight",
			-- 	min = 8,
			-- 	max = 32,
			-- 	step = 1,
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.AddonHeight
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.AddonHeight = value
			-- 		E.UpdateDBdata()
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = GetOrder(),
			-- },
			-------------------------------------------------
			-- MainFrameDefaultLines = {
			-- 	type = "range",
			-- 	name = L["MainFrameDefaultLines"],
			-- 	desc = "OctoToDo_AddonsManager.MainFrameDefaultLines",
			-- 	min = 1,
			-- 	max = C_AddOns.GetNumAddOns() or 1,
			-- 	step = 1,
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.MainFrameDefaultLines
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.MainFrameDefaultLines = value
			-- 		E.UpdateDBdata()
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = GetOrder(),
			-- },
			-------------------------------------------------
			-- AddonCentralFrameWeight = {
			-- 	type = "range",
			-- 	name = L["AddonCentralFrameWeight"],
			-- 	desc = "OctoToDo_AddonsManager.AddonCentralFrameWeight",
			-- 	min = 400,
			-- 	max = 1000,
			-- 	step = 1,
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.AddonCentralFrameWeight
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.AddonCentralFrameWeight = value
			-- 		E.UpdateDBdata()
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = GetOrder(),
			-- },
			-------------------------------------------------
			Header5 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			fullName = {
				type = "toggle",
				name = L["fullName"],
				desc = "",
				get = function()
					return OctoToDo_AddonsManager.config.fullName
				end,
				set = function(_, value)
					OctoToDo_AddonsManager.config.fullName = value
					E.AddonList_Update()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			showIcons = {
				type = "toggle",
				name = L["showIcons"],
				desc = "",
				get = function()
					return OctoToDo_AddonsManager.config.showIcons
				end,
				set = function(_, value)
					OctoToDo_AddonsManager.config.showIcons = value
					E.AddonList_Update()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			showVersion = {
				type = "toggle",
				name = L["showVersion"],
				desc = "",
				get = function()
					return OctoToDo_AddonsManager.config.showVersion
				end,
				set = function(_, value)
					OctoToDo_AddonsManager.config.showVersion = value
					E.AddonList_Update()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			defaultAddonList = {
				type = "toggle",
				name = L["defaultAddonList"],
				desc = "",
				get = function()
					return OctoToDo_AddonsManager.config.defaultAddonList
				end,
				set = function(_, value)
					OctoToDo_AddonsManager.config.defaultAddonList = value
					E.CreateMyDataProvider()
					E.AddonList_Update()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			showOnlyLoaded = {
				type = "toggle",
				name = L["showOnlyLoaded"],
				desc = "",
				get = function()
					return OctoToDo_AddonsManager.config.showOnlyLoaded
				end,
				set = function(_, value)
					OctoToDo_AddonsManager.config.showOnlyLoaded = value
					E.CreateMyDataProvider()
					E.AddonList_Update()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},





			-------------------------------------------------
			Header24 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			RESET = {
				type = "execute",
				name = E.Debug_Color..DELETE.." "..ALL.."|r",
				func = function()
					OctoToDo_AddonsManager = {}
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			RELOADUI = {
				type = "execute",
				name = E.Debug_Color..RELOADUI.."|r",
				func = function()
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			-------------------------------------------------
		},
	}
	return GeneralOptionsADDONS
end