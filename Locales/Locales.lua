local GlobalAddonName, E = ...
E.L = {}
local L = E.L
local LibTranslit = LibStub("LibTranslit-1.0")
----------------------------------------------------------------
local DebugLocalization_Key = false
local DebugLocalization_Lang = false
local color_red = E.COLOR_RED or "|cffFF0000"
local curLocaleLang = GetLocale() or "enUS"
----------------------------------------------------------------
function E.func_translit(text)
	if not Octo_DevTool_DB or not Octo_DevTool_DB.CONFIG_DEBUG_TRANSLIT then
		return text
	end
	if type(text) ~= "string" or text == "" then
		return text
	end
	if not text:find("[А-Яа-яЁё]") then
		return text
	end
	local result = LibTranslit:Transliterate(text)
	if not result or result == "" then
		return text
	end
	return result
end
----------------------------------------------------------------
local meta_t = {
	__index = function(self, key)
		local translationTable = E.translations[key]
		if not translationTable then
			if DebugLocalization_Key then
				DEFAULT_CHAT_FRAME:AddMessage(color_red.."No key:|r "..key)
			end
			rawset(self, key, key)
			return key
		end
		local raw
		if type(translationTable) == "string" then
			raw = translationTable
		elseif type(translationTable) == "table" then
			if not translationTable[curLocaleLang] and DebugLocalization_Lang then
				DEFAULT_CHAT_FRAME:AddMessage(color_red..curLocaleLang..":|r "..key)
			end
			raw = translationTable[curLocaleLang] or key
		else
			raw = tostring(translationTable)
		end
		local translation = E.func_translit(raw)
		if not translation or translation == "" then
			translation = raw
		end
		rawset(self, key, translation)
		return translation
	end
}
----------------------------------------------------------------
setmetatable(L, meta_t)
----------------------------------------------------------------