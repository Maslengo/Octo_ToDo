local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
function E:InitOptionsADDONS()
	----------------------------------------------------------------
	AceConfigRegistry:RegisterOptionsTable("CreateGeneralOptionsADDONS", E.CreateGeneralOptionsADDONS())
	AceConfigRegistry:RegisterOptionsTable("DevelopingADDONS", E.DevelopingADDONS())
	----------------------------------------------------------------
	local categoryFrame, mainCategoryID = AceConfigDialog:AddToBlizOptions("CreateGeneralOptionsADDONS", E.func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("DevelopingADDONS", E.Debug_Color..BINDING_HEADER_DEBUG.."|r", E.func_AddonTitle(GlobalAddonName))
	----------------------------------------------------------------
end