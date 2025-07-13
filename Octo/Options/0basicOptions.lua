local GlobalAddonName, E = ...
if not E.Enable_Options then return end
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
function E:InitOptions()
	----------------------------------------------------------------
	AceConfigRegistry:RegisterOptionsTable("CreateGeneralOptionsMAIN", E.CreateGeneralOptions())
	-- AceConfigRegistry:RegisterOptionsTable("Addons", E.Addons())
	AceConfigRegistry:RegisterOptionsTable("DevelopingMAIN", E.Developing())
	----------------------------------------------------------------
	local categoryFrame, mainCategoryID = AceConfigDialog:AddToBlizOptions("CreateGeneralOptionsMAIN", E.func_AddonTitle(GlobalAddonName))
	-- AceConfigDialog:AddToBlizOptions("Addons", ADDONS, E.func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("DevelopingMAIN", E.Debug_Color..BINDING_HEADER_DEBUG.."|r", E.func_AddonTitle(GlobalAddonName))
	----------------------------------------------------------------
end