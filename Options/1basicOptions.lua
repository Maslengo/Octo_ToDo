local GlobalAddonName, E = ...
local LibOctopussy = LibStub("LibOctopussy-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
-- OctoSaved = {}
-- local DBVersion = 3
-- Saved settings
-- local DefaultSettings = {
--     AccountVars = {}, -- account-wide cvars to be re-applied on login, [cvar] = value
--     CharVars = {}, -- (todo) character-specific cvar settings? [charName-realm] = { [cvar] = value }
--     EnforceSettings = false, -- true to load cvars from our saved variables every time we log in
--     -- this will override anything that sets a cvar outside of this E
--     CustomVars = {}, -- custom options for missing/removed cvars
--     ModifiedCVars = {}, -- [cvar:lower()] = 'last E to modify it'
--     DBVersion = DBVersion, -- Database version for wiping out incompatible data
-- }
-- local AddonLoaded, VariablesLoaded = false, false
-- function E:VARIABLES_LOADED()
-- 	VariablesLoaded = true
-- 	if AddonLoaded then
-- 		-- LibOctopussy:MergeTable(OctoSaved, DefaultSettings)
-- 		self:ADDON_LOADED(GlobalAddonName)
-- 	end
-- end
function E:ADDON_LOADED(E_name)
	if E_name == GlobalAddonName then
		E:Init()
	end
end
function E:Init() -- Runs after our saved variables are loaded and cvars have been loaded
	-- if OctoSaved.DBVersion ~= DBVersion then
	-- -- Wipe out previous settings if database versions don't match
	-- OctoSaved["DBVersion"] = DBVersion
	-- OctoSaved["AccountVars"] = {}
	-- end
	-- LibOctopussy:MergeTable(OctoSaved, DefaultSettings) -- Repair database if keys are missing
	--Register our options with the Blizzard Addon Options panel
	AceConfigRegistry:RegisterOptionsTable("CreateGeneralOptions", E:CreateGeneralOptions())
	AceConfigRegistry:RegisterOptionsTable("CreateDevelopmentOptions", E:CreateDevelopmentOptions())
	-- AceConfigRegistry:RegisterOptionsTable("Octo_Chat", E:CreateChatOptions())
	-- AceConfigRegistry:RegisterOptionsTable("Octo_Combat", E:CreateCombatOptions())
	-- AceConfigRegistry:RegisterOptionsTable("Octo_FloatingCombatText", E:CreateFloatingCombatTextOptions())
	-- AceConfigRegistry:RegisterOptionsTable("Octo_StatusText", E:CreateStatusTextOptions())
	-- AceConfigRegistry:RegisterOptionsTable("Octo_Nameplate", E:CreateNameplateOptions())
	-- AceConfigRegistry:RegisterOptionsTable("Octo_cVar", E:CreateCVarOptions())
	local categoryFrame, mainCategoryID = AceConfigDialog:AddToBlizOptions("CreateGeneralOptions", E.AddonTitle)
	AceConfigDialog:AddToBlizOptions("CreateDevelopmentOptions", "Developing", E.AddonTitle)
	-- AceConfigDialog:AddToBlizOptions("Octo_Chat", "Chat", "Octo")
	-- AceConfigDialog:AddToBlizOptions("Octo_Combat", "Combat", "Octo")
	-- AceConfigDialog:AddToBlizOptions("Octo_FloatingCombatText", "Floating Combat Text", "Octo")
	-- AceConfigDialog:AddToBlizOptions("Octo_StatusText", "Status Text", "Octo")
	-- AceConfigDialog:AddToBlizOptions("Octo_Nameplate", "Nameplates", "Octo")
	-- local cVarFrame, cVarCategoryID = AceConfigDialog:AddToBlizOptions("Octo_cVar", "CVar Browser", "Octo")
	-- Inject our custom cVar browser into the panel created by Ace3
	-- E:PopulateCVarPanel(cVarFrame)
	-------------------------------------------------------------------------
	-------------------------------------------------------------------------
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------


