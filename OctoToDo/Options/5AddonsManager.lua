local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.Addons()
	local GeneralOptionsADDONS = {
		type = "group",
		childGroups = "tree",
		name = E.func_AddonTitle(GlobalAddonName).." "..E.Gray_Color..E.func_AddonVersion(GlobalAddonName) .. "|r",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = 1,
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
			-- 	order = 2,
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
			-- 	order = 3,
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
			-- 	order = 4,
			-- },
			-------------------------------------------------
			Header5 = {
				type = "header",
				name = "",
				order = 5,
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
				order = 6,
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
				order = 7,
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
				order = 8,
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
				order = 8,
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
				order = 9,
			},





			-------------------------------------------------
			Header24 = {
				type = "header",
				name = "",
				order = 24,
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
				order = 25,
			},
			RELOADUI = {
				type = "execute",
				name = E.Debug_Color..RELOADUI.."|r",
				func = function()
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = 26,
			},
			-------------------------------------------------
			-------------------------------------------------
		},
	}
	return GeneralOptionsADDONS
end