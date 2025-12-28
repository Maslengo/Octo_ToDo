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
		-- if there is no key at all
		if not translationTable then
			if DebugLocalization_Key then
				DEFAULT_CHAT_FRAME:AddMessage(color_red.."No key:|r "..key)
			end
			rawset(self, key, key)
			return key
		end
		-- if there is a key, but no translation
		if not translationTable[curLocaleLang] and DebugLocalization_Lang then
			DEFAULT_CHAT_FRAME:AddMessage(color_red..curLocaleLang..":|r "..key)
		end
		-- We return the translation or the key itself as a fallback
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