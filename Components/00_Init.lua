local GlobalAddonName, E = ...
----------------------------------------------------------------
E.dataDisplayOrder = {
	"AdditionallyTOP",
	"Currencies",
	"Items",
	"RaidsOrDungeons",
	"AdditionallyCENTER",
	"Quests",
	"UniversalQuests",
	"Reputations",
	"AdditionallyBOTTOM",
	"Maps",
}
E.dataDisplayOrder2 = {
	["Currencies"] = "number",
	["Items"] = "number",
	["Reputations"] = "number",
	["RaidsOrDungeons"] = "number",
	["Quests"] = "number",
	["Maps"] = "number",

	["AdditionallyCENTER"] = "string",
	["AdditionallyTOP"] = "string",
	["UniversalQuests"] = "string",
	["AdditionallyBOTTOM"] = "string",
}


function E.func_SetType(old_id, dataType)
	local id = old_id
	local tblTYPE = E.dataDisplayOrder2[dataType]
	if tblTYPE == "number" then
		id = tonumber(old_id)
	elseif tblTYPE == "string" then
		id = tostring(old_id)
	end
	return id
end