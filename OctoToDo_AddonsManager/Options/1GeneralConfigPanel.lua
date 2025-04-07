local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.CreateGeneralOptionsADDONS()
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
			AddonHeight = {
				type = "range",
				name = L["AddonHeight"],
				desc = "OctoToDo_AddonsManager.AddonHeight",
				min = 8,
				max = 32,
				step = 1,
				get = function()
					return OctoToDo_AddonsManager.AddonHeight
				end,
				set = function(_, value)
					OctoToDo_AddonsManager.AddonHeight = value
					E.UpdateDBdata()
					E.AddonList_Update()
				end,
				width = E.FULL_WIDTH/4,
				order = 2,
			},
			-------------------------------------------------
			MainFrameNumLines = {
				type = "range",
				name = L["MainFrameNumLines"],
				desc = "OctoToDo_AddonsManager.MainFrameNumLines",
				min = 1,
				max = C_AddOns.GetNumAddOns() or 1,
				step = 1,
				get = function()
					return OctoToDo_AddonsManager.MainFrameNumLines
				end,
				set = function(_, value)
					OctoToDo_AddonsManager.MainFrameNumLines = value
					E.UpdateDBdata()
					E.AddonList_Update()
				end,
				width = E.FULL_WIDTH/4,
				order = 3,
			},
			-------------------------------------------------
			curWidthTitle = {
				type = "range",
				name = L["curWidthTitle"],
				desc = "OctoToDo_AddonsManager.curWidthTitle",
				min = 400,
				max = 1000,
				step = 1,
				get = function()
					return OctoToDo_AddonsManager.curWidthTitle
				end,
				set = function(_, value)
					OctoToDo_AddonsManager.curWidthTitle = value
					E.UpdateDBdata()
					E.AddonList_Update()
				end,
				width = E.FULL_WIDTH/4,
				order = 4,
			},
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