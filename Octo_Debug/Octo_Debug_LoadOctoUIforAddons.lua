local GlobalAddonName, ns = ...
E = _G.OctoEngine
----------------------------------------------------------------
local Octo_EventFrame_Debug = CreateFrame("FRAME")
Octo_EventFrame_Debug:Hide()
----------------------------------------------------------------
function Octo_EventFrame_Debug:LoadOctoUIforAddons()

	if ElvDB then
		for name, v in next, (ElvDB.profileKeys) do
			Octo_Debug_DB.profileKeys[name] = "OctoUI"
		end
	end

	local AddonsAndDB = {
		{database = AddonCpuUsageDB, profileName = "OctoUI"},
		{database = AddOnSkinsDB, profileName = "OctoUI"},
		{database = Bartender4DB, profileName = "OctoUI"},
		{database = ElvDB, profileName = "OctoUI"},
		{database = ElvPrivateDB, profileName = "PRIVATEPROFILE"},
		{database = MythicDungeonToolsDB, profileName = "OctoUI"},
		{database = OmniCCDB, profileName = "OctoUI"},
		{database = OmniCDDB, profileName = "OctoUI"},
		{database = ParrotDB, profileName = "OctoUI"},
		{database = PlaterDB, profileName = "OctoUI"},
		{database = RareScannerDB, profileName = "OctoUI"},
		{database = RCLootCouncilDB, profileName = "OctoUI"},
		{database = RCLootCouncilLootDB, profileName = "OctoUI"},
		{database = SilverDragon3DB, profileName = "OctoUI"},
		{database = TomTomDB, profileName = "OctoUI"},
		{database = TomTomWaypointsM, profileName = "OctoUI"},
		{database = VMRT, profileName = "OctoUI"},
		{database = WarpDepleteDB, profileName = "OctoUI"},
		{database = GreatVaultList2DB, profileName = "OctoUI"},
		{database = RarityDB, profileName = "OctoUI"},
	}

	for _, v in ipairs(AddonsAndDB) do
		if v.database then
			v.database.profileKeys = v.database.profileKeys or {}
			for name, OctoUI in next, Octo_Debug_DB.profileKeys do
				if v.database == VMRT then
					local nameWithoutSpace = name:gsub(" ", "")
					VMRT.ProfileKeys[nameWithoutSpace] = v.profileName
				else
					v.database.profileKeys[name] = v.profileName
				end
			end
		end
	end

end
----------------------------------------------------------------
local MyEventsTable = {
	"VARIABLES_LOADED",
}
E.func_RegisterMyEventsToFrames(Octo_EventFrame_Debug, MyEventsTable)
function Octo_EventFrame_Debug:VARIABLES_LOADED()
	self:UnregisterEvent("VARIABLES_LOADED")
	self.VARIABLES_LOADED = nil
	self:LoadOctoUIforAddons()
end
----------------------------------------------------------------