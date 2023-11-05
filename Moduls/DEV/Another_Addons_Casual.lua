local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
-- AnotherAddonsCasual
tinsert(E.Octo_Globals.modules, function()
    if Octo_ToDo_DB_Vars.config.AnotherAddonsCasual then
        -- E.Octo_Func.func_Octo_LoadAddOn("TomTom")
        -- E.Octo_Func.func_Octo_LoadAddOn("AstralKeys")
        -- E.Octo_Func.func_Octo_LoadAddOn("AutoTurnIn")
        E.Octo_Func.func_Octo_LoadAddOn("MountsJournal")
        E.Octo_Func.func_Octo_LoadAddOn("MountsJournal_ElvUI_Skin")
        E.Octo_Func.func_Octo_LoadAddOn("HidingBar")
        E.Octo_Func.func_Octo_LoadAddOn("HidingBar_Options")
        E.Octo_Func.func_Octo_LoadAddOn("Postal")
        -- E.Octo_Func.func_Octo_LoadAddOn("Simulationcraft")
        E.Octo_Func.func_Octo_LoadAddOn("SpeedyAutoLoot")
        E.Octo_Func.func_Octo_LoadAddOn("AdvancedInterfaceOptions")
        E.Octo_Func.func_Octo_LoadAddOn("Pawn")
        E.Octo_Func.func_Octo_LoadAddOn("Rarity")
        E.Octo_Func.func_Octo_LoadAddOn("Rarity_Options")
        E.Octo_Func.func_Octo_LoadAddOn("Plater")
        -- E.Octo_Func.func_Octo_LoadAddOn("ParagonReputation")
        -- E.Octo_Func.func_Octo_LoadAddOn("SavedInstances")
        -- E.Octo_Func.func_Octo_LoadAddOn("TalentTreeTweaks")
    end
end)
