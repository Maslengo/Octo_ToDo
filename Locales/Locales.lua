local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local DebugLocalization_Key = false
local DebugLocalization_Lang = false
local color_red = E.COLOR_RED or "|cffFF0000"
local curLocaleLang = E.curLocaleLang or "enUS"

-- метатаблица с кешем через rawset
local meta_table = {
	__index = function(self, key)
		local translationTable = E.translations[key]
		if not translationTable then
			if DebugLocalization_Key then
				DEFAULT_CHAT_FRAME:AddMessage(color_red.."No key:|r "..key)
			end
			rawset(self, key, key)
			return key
		end

		if not translationTable[curLocaleLang] and DebugLocalization_Lang then
			DEFAULT_CHAT_FRAME:AddMessage(color_red..curLocaleLang..":|r "..key)
		end

		local translation
		if E.Config_UseTranslit then
			translation = E.func_translit(translationTable[curLocaleLang]) or E.func_translit(key)
		else
			translation = translationTable[curLocaleLang] or key
		end

		rawset(self, key, translation)
		return translation
	end
}

setmetatable(L, meta_table)

-- функция сброса кэша
function E.func_RefreshTranslations()
	for k in pairs(L) do
		rawset(L, k, nil)
	end
end


----------------------------------------------------------------
-- local L = E.L
-- DEFAULT_CHAT_FRAME:AddMessage(L["qwe"])
-- DEFAULT_CHAT_FRAME:AddMessage(L["Weekly Reset"])