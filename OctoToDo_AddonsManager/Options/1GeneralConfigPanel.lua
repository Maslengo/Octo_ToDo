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
			-- minimaphide = {
			-- 	type = "toggle",
			-- 	name = L["minimaphide"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.minimaphide
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.minimaphide = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 7,
			-- },
			-- hookMenuButton = {
			-- 	type = "toggle",
			-- 	name = L["hookMenuButton"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.hookMenuButton
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.hookMenuButton = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 8,
			-- },
			-- sortingCpu = {
			-- 	type = "toggle",
			-- 	name = L["sortingCpu"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.sortingCpu
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.sortingCpu = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 9,
			-- },
			-- profilingcpuShowCurrent = {
			-- 	type = "toggle",
			-- 	name = L["cpuShowCurrent"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.profilingcpuShowCurrent
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.profilingcpuShowCurrent = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 11,
			-- },
			-- profilingcpuShowEncounter = {
			-- 	type = "toggle",
			-- 	name = L["cpuShowEncounter"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.profilingcpuShowEncounter
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.profilingcpuShowEncounter = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 12,
			-- },
			-- profilingcpuShowPeak = {
			-- 	type = "toggle",
			-- 	name = L["profilingcpuShowPeak"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.profilingcpuShowPeak
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.profilingcpuShowPeak = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 13,
			-- },
			-- profilingcpuShowAverage = {
			-- 	type = "toggle",
			-- 	name = L["profilingcpuShowAverage"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.profilingcpuShowAverage
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.profilingcpuShowAverage = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 14,
			-- },
			-- profilingcpuUpdate = {
			-- 	type = "toggle",
			-- 	name = L["profilingcpuUpdate"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.profilingcpuUpdate
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.profilingcpuUpdate = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 15,
			-- },
			-- localizeCategoryName = {
			-- 	type = "toggle",
			-- 	name = L["localizeCategoryName"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.localizeCategoryName
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.localizeCategoryName = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 16,
			-- },
			-- showVersions = {
			-- 	type = "toggle",
			-- 	name = L["showVersions"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.showVersions
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.showVersions = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 17,
			-- },
			-- autofocusSearch = {
			-- 	type = "toggle",
			-- 	name = L["autofocusSearch"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.autofocusSearch
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.autofocusSearch = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 18,
			-- },
			-- showSecureAddons = {
			-- 	type = "toggle",
			-- 	name = L["showSecureAddons"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.showSecureAddons
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.showSecureAddons = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 19,
			-- },
			-- showTocXCategory = {
			-- 	type = "toggle",
			-- 	name = L["showTocXCategory"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.showTocXCategory
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.showTocXCategory = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 20,
			-- },
			-- showTocCategory = {
			-- 	type = "toggle",
			-- 	name = L["showTocCategory"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.showTocCategory
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.showTocCategory = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 21,
			-- },
			-- showMemoryInBrokerTtp = {
			-- 	type = "toggle",
			-- 	name = L["showMemoryInBrokerTtp"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.showMemoryInBrokerTtp
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.showMemoryInBrokerTtp = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 22,
			-- },
			-- isCategoryFrameVisible = {
			-- 	type = "toggle",
			-- 	name = L["isCategoryFrameVisible"],
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_AddonsManager.config.isCategoryFrameVisible
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_AddonsManager.config.isCategoryFrameVisible = value
			-- 		E.AddonList_Update()
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 23,
			-- },
			-------------------------------------------------
			Header24 = {
				type = "header",
				name = "",
				order = 24,
			},
			-------------------------------------------------
			RESET = {
				type = "execute",
				name = E.Debug_Color..RESET.."|r",
				func = function()
					OctoToDo_AddonsManager.config = {}
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = 25,
			},
			RELOADUI = {
				type = "execute",
				name = E.Debug_Color..RELOADUI.."|r",
				func = function()
					OctoToDo_AddonsManager.config = {}
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
