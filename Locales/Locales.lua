local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local DebugLocalization_Key = false
local DebugLocalization_Lang = false
local color_red = E.COLOR_RED or "|cffFF0000"
local curLocaleLang = E.curLocaleLang or "enUS"
local meta_table = {
	__index = function(self, key)
		local translationTable = E.translations[key]
		-- если ключа вообще нет
		if not translationTable then
			if DebugLocalization_Key then
				DEFAULT_CHAT_FRAME:AddMessage(color_red.."No key:|r "..key)
			end
			rawset(self, key, key)
			return key
		end
		-- если ключ есть, но нет перевода
		if not translationTable[curLocaleLang] and DebugLocalization_Lang then
			DEFAULT_CHAT_FRAME:AddMessage(color_red..curLocaleLang..":|r "..key)
		end
		-- возвращаем перевод или сам ключ как fallback
		local translation = translationTable[curLocaleLang] or key
		rawset(self, key, translation)
		return translation
	end
}
setmetatable(L, meta_table)
----------------------------------------------------------------
-- local L = E.L
-- DEFAULT_CHAT_FRAME:AddMessage(L["qwe"])
-- DEFAULT_CHAT_FRAME:AddMessage(L["Weekly Reset"])