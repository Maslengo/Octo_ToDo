local GlobalAddonName, ns = ...
E = _G.OctoEngine
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
function EventFrame:OnLoad()
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
		"Rarity",
		"Rarity_Options",
	}
	for _, name in ipairs(addons) do
		E.func_LoadAddOnForced(name)
	end
	C_AddOns.SaveAddOns()
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	E.func_CreateMinimapButton(GlobalAddonName, "LoadAddons", Octo_LoadAddons_DB)
	if not WarmupSV then
		self:OnLoad()
	end
end