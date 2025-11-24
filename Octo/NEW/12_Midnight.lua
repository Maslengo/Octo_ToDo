local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Midnight = {}
E.OctoTables_DataOtrisovka.Midnight.Text = {E.OctoTable_Expansions[12].color..E.OctoTable_Expansions[12].name.."|r"}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Midnight.Currencies = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Midnight.Items = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Midnight.Reputations = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Midnight.UniversalQuests = {

}
----------------------------------------------------------------
E.func_TableConcat(E.ALL_Currencies, E.OctoTables_DataOtrisovka.Midnight.Currencies)
E.func_TableConcat(E.ALL_Items, E.OctoTables_DataOtrisovka.Midnight.Items)
E.func_TableConcat(E.ALL_Reputations, E.OctoTables_DataOtrisovka.Midnight.Reputations)
E.func_TableConcat(E.ALL_UniversalQuests, E.OctoTables_DataOtrisovka.Midnight.UniversalQuests)

E.func_TableConcat(E.OctoTables_Vibor, E.OctoTables_DataOtrisovka.Midnight.Text)