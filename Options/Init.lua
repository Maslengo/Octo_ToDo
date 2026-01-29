local GlobalAddonName, E = ...

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")


local EventFrame = CreateFrame("FRAME")
-------------------------------------------------------------------------
function EventFrame:func_InitOptions()
	if not E.func_Options_MAIN then return end
	local parent = E.func_GetAddOnMetadata(E.MainAddonName, "Title")

	if E.func_Options_MAIN then
		local leftText = E.func_AddonNameForOptionsInit(GlobalAddonName) -- ICON, NAME
		local rightText = E.func_AddonNameForOptionsFunc(GlobalAddonName) -- ICON, NAME, VERSION
		AceConfigRegistry:RegisterOptionsTable(rightText, E.func_Options_MAIN(rightText))
		AceConfigDialog:AddToBlizOptions(rightText, parent)
	end

	if E.func_Options_About then
		local leftText = "About"
		local rightText = "About"
		AceConfigRegistry:RegisterOptionsTable(leftText, E.func_Options_About(rightText))
		AceConfigDialog:AddToBlizOptions(leftText, leftText, parent)
	end

	if E.func_Options_Moduls and Octo_Moduls_DB then
		local leftText = "Moduls"
		local rightText = "Moduls"
		AceConfigRegistry:RegisterOptionsTable(leftText, E.func_Options_Moduls(rightText, Octo_Moduls_DB))
		AceConfigDialog:AddToBlizOptions(leftText, leftText, parent)
	end

	if E.func_Options_DevTool and Octo_DevTool_DB then
		local leftText = "DevTool"
		local rightText = "DevTool"
		AceConfigRegistry:RegisterOptionsTable(leftText, E.func_Options_DevTool(rightText, Octo_DevTool_DB))
		AceConfigDialog:AddToBlizOptions(leftText, leftText, parent)
	end

	if E.func_Options_QuestsChanged and Octo_QuestsChanged_DB then
		local leftText = "QuestsChanged"
		local rightText = "QuestsChanged"
		AceConfigRegistry:RegisterOptionsTable(leftText, E.func_Options_QuestsChanged(rightText, Octo_QuestsChanged_DB))
		AceConfigDialog:AddToBlizOptions(leftText, leftText, parent)
	end

	if E.func_Options_Achievements and Octo_Achievements_DB then
		local leftText = "Achievements"
		local rightText = "Achievements"
		AceConfigRegistry:RegisterOptionsTable(leftText, E.func_Options_Achievements(rightText, Octo_Achievements_DB))
		AceConfigDialog:AddToBlizOptions(leftText, leftText, parent)
	end

	E.SettingsCategoryID = 1
	local MyCategoryName = E.func_AddonNameForOptionsInit(GlobalAddonName)
	for i = 1, 100 do -- ПОФИКСИТЬ
		local cat = Settings.GetCategory(i)
		if cat then
			if cat.name == MyCategoryName then
				E.SettingsCategoryID = cat.ID
			end
		end
	end

end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
function EventFrame:PLAYER_LOGIN()
	self:func_InitOptions()
end
----------------------------------------------------------------