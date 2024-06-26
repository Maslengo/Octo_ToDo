local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
-- AnotherAddonsRAID
tinsert(E.Octo_Globals.modules, function()
	if Octo_ToDo_DB_Vars.config.AnotherAddonsRAID then
		E.Octo_Func.func_Octo_LoadAddOn("MountsJournal")
		-- E.Octo_Func.func_Octo_LoadAddOn("MountsJournal_ElvUI_Skin")
		E.Octo_Func.func_Octo_LoadAddOn("AddOnSkins")
		E.Octo_Func.func_Octo_LoadAddOn("BigWigs")
		E.Octo_Func.func_Octo_LoadAddOn("BigWigs_Core")
		E.Octo_Func.func_Octo_LoadAddOn("BigWigs_Plugins")
		E.Octo_Func.func_Octo_LoadAddOn("BigWigs_Options")
		-- E.Octo_Func.func_Octo_LoadAddOn("BigWigs_Aberrus")
		E.Octo_Func.func_Octo_LoadAddOn("BigWigs_Amirdrassil")
		E.Octo_Func.func_Octo_LoadAddOn("Details")
		E.Octo_Func.func_Octo_LoadAddOn("ElvUI_Libraries")
		E.Octo_Func.func_Octo_LoadAddOn("ElvUI")
		E.Octo_Func.func_Octo_LoadAddOn("ElvUI_Options")
		E.Octo_Func.func_Octo_LoadAddOn("OmniCC")
		E.Octo_Func.func_Octo_LoadAddOn("OmniCC_Config")
		-- E.Octo_Func.func_Octo_LoadAddOn("Pawn")
		E.Octo_Func.func_Octo_LoadAddOn("Plater")
		E.Octo_Func.func_Octo_LoadAddOn("SharedMedia")
		E.Octo_Func.func_Octo_LoadAddOn("SharedMedia_Causese")
		E.Octo_Func.func_Octo_LoadAddOn("SharedMedia_Naowh")
		E.Octo_Func.func_Octo_LoadAddOn("WeakAuras")
		E.Octo_Func.func_Octo_LoadAddOn("WeakAurasArchive")
		E.Octo_Func.func_Octo_LoadAddOn("WeakAurasModelPaths")
		E.Octo_Func.func_Octo_LoadAddOn("WeakAurasOptions")
		E.Octo_Func.func_Octo_LoadAddOn("WeakAurasTemplates")
		-- E.Octo_Func.func_Octo_LoadAddOn("WagoAppCompanion")
		-- E.Octo_Func.func_Octo_LoadAddOn("AdvancedInterfaceOptions")
		-- E.Octo_Func.func_Octo_LoadAddOn("Parrot")
		-- E.Octo_Func.func_Octo_LoadAddOn("MRT")
		-- E.Octo_Func.func_Octo_LoadAddOn("ExRT_Reminder")
		E.Octo_Func.func_Octo_LoadAddOn("RCLootCouncil")
		-- E.Octo_Func.func_Octo_LoadAddOn("TrufiGCD")
		-- E.Octo_Func.func_Octo_LoadAddOn("HidingBar")
		-- E.Octo_Func.func_Octo_LoadAddOn("HidingBar_Options")
		-- E.Octo_Func.func_Octo_LoadAddOn("OmniCD")
		-- E.Octo_Func.func_Octo_LoadAddOn("Postal")
		-- E.Octo_Func.func_Octo_LoadAddOn("Simulationcraft")
	end
end)
