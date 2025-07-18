local GlobalAddonName, ns = ...
E = _G.OctoEngine
----------------------------------------------------------------
local Octo_EventFrame_LoadAddons = CreateFrame("FRAME")
Octo_EventFrame_LoadAddons:Hide()
----------------------------------------------------------------
function Octo_EventFrame_LoadAddons:OnLoad()
	local addons = {
		"!BugGrabber",
		"BugSack",
		"HidingBar",
		"HidingBar_Options",
		"SpeedyAutoLoot",
		"AddonMrgl",
		"SilverDragon",
		"SilverDragon_History",
		"SilverDragon_Overlay",
		"SilverDragon_RangeExtender",
		"GreatVaultList",
		"MountsJournal",
		"MacroManager",
		"MacroManagerData",
		"AdvancedInterfaceOptions",
	}
	for _, name in ipairs(addons) do
		E:func_LoadAddOnFORCED(name)
	end
	C_AddOns.SaveAddOns()
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_LoadAddons, MyEventsTable)
function Octo_EventFrame_LoadAddons:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		if not WarmupSV then
			self:OnLoad()
		end
	end
end