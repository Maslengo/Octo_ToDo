local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.TheLastTitan = {}
E.OctoTables_DataOtrisovka.TheLastTitan.Text = {E.OctoTable_Expansions[13].color..E.OctoTable_Expansions[13].name.."|r"}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.TheLastTitan.Currencies = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.TheLastTitan.Items = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.TheLastTitan.Reputations = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.TheLastTitan.UniversalQuests = {

}
----------------------------------------------------------------
E.func_TableConcat(E.ALL_Currencies, E.OctoTables_DataOtrisovka.TheLastTitan.Currencies)
E.func_TableConcat(E.ALL_Items, E.OctoTables_DataOtrisovka.TheLastTitan.Items)
E.func_TableConcat(E.ALL_Reputations, E.OctoTables_DataOtrisovka.TheLastTitan.Reputations)
E.func_TableConcat(E.ALL_UniversalQuests, E.OctoTables_DataOtrisovka.TheLastTitan.UniversalQuests)

E.func_TableConcat(E.OctoTables_Vibor, E.OctoTables_DataOtrisovka.TheLastTitan.Text)