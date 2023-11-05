local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
E.Octo_Table.OctoTable_itemID_Ignore_List =
    {
        [49888] = true,
        [49908] = true,
        [49040] = true,
        [77530] = true,
        [81055] = true,
        [109076] = true,
        [111820] = true,
        [154172] = true,
        [154173] = true,
        [154174] = true,
        [154175] = true,
        [154176] = true,
        [154177] = true,
        [166751] = true,
        [167555] = true,
        [180653] = true,
        [188152] = true,
        [191251] = true,
        [193201] = true,
        [203703] = true,
        [204985] = true,
        [205982] = true,
        [207002] = true,
        [208153] = true,
        [204682] = true,
        [205188] = true,
        [191784] = true,
        [77530] = true,
        [201437] = true,
        [208485] = true,
        [206009] = true,
        [206010] = true,
        [206014] = true,
        [206011] = true,
        [206015] = true,
        [206012] = true,
        [206016] = true,
        [206013] = true,
        [206017] = true,
        [206021] = true,
        [205151] = true
    }
-- for i = 1, #E.Octo_Table.OctoTable_itemID_ALL do
--     C_Item.RequestLoadItemDataByID(E.Octo_Table.OctoTable_itemID_ALL[i])
-- end
for itemID, v in pairs(E.Octo_Table.OctoTable_itemID_Ignore_List) do
    C_Item.RequestLoadItemDataByID(itemID)
end
