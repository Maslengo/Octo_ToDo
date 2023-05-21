local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
E.modules = {}
--------------------------------------------------------------------------------
local AL3 = LibStub("AceLocale-3.0")
local debug = false
local AddonName, engine = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local L = AL3:NewLocale("OctoTODO", "enUS", true, debug)
if L then
	L["Siege on Dragonbane Keep"] = true
	L["Grand Hunt"] = true
	L["Community Feast"] = true
	L["The Storm's Fury"] = true
	L["Fyrakk Asssaults"] = true
	L["Researchers Under Fire"] = true
	L["AddonName"] = AddonTitle
end
L = AL3:NewLocale("OctoTODO", "ruRU")
if L then
	L["Siege on Dragonbane Keep"] = "Осада Драконьей Погибели"
	L["Grand Hunt"] = "Великая охота"
	L["Community Feast"] = "Большое пиршество"
	L["The Storm's Fury"] = "Неистовство бури"
	L["Fyrakk Asssaults"] = "Налет Фиракка"
	L["Researchers Under Fire"] = "Исследователли под огнем" --func_questName(74905)
	--L["AddonName"] = AddonTitle
end