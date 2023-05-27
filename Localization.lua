local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
--E.modules = {}
--------------------------------------------------------------------------------
local AL3 = LibStub("AceLocale-3.0")
local debug = false
local AddonName, engine = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local L = AL3:NewLocale("OctoTODO", "enUS", true, debug)
if L then
    L["AddonName"] = AddonTitle
    L["RESET"] = RESET

    L["Siege on Dragonbane Keep"] = true
    L["Grand Hunt"] = true
    L["Community Feast"] = true
    L["The Storm's Fury"] = true
    L["Fyrakk Asssaults"] = true
    L["Researchers Under Fire"] = true
    L["Treasure Goblin"] = true
    L["Level"] = true
    L["Battle Pet"] = true

    L["Vendored gray items for: "] = true
    L["You don't have enough money to repair."] = true
    L["Your items have been repaired for: "] = true
    L["Your items have been repaired using guild bank funds for: "] = true



    L["|cFF00A3FFTalking head frame|r |cffFF4C4Fcanceled.|r"] = true
end
L = AL3:NewLocale("OctoTODO", "ruRU")
if L then
    L["Siege on Dragonbane Keep"] = "Осада Драконьей Погибели"
    L["Grand Hunt"] = "Великая охота"
    L["Community Feast"] = "Большое пиршество"
    L["The Storm's Fury"] = "Неистовство бури"
    L["Fyrakk Asssaults"] = "Налет Фиракка"
    L["Researchers Under Fire"] = "Исследователли под огнем" --func_questName(74905)
    L["RESET"] = "Сброс всех данных аддона"
    L["Treasure Goblin"] = "Алчный гоблин"
    L["Level"] = "Уровень"
    L["Battle Pet"] = "Боевой питомец"

    L["Vendored gray items for: "] = "Серые предметы проданы на сумму: "
    L["You don't have enough money to repair."] = "У Вас недостаточно денег для ремонта."
    L["Your items have been repaired for: "] = "Ремонт обошелся в "
    L["Your items have been repaired using guild bank funds for: "] = "Ремонт обошелся гильдии в "
end

