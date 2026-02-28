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

		local raw = translationTable[curLocaleLang] or key
		local translation = E.func_translit(raw)

		if translation == nil or translation == "" then
			translation = raw
		end

		rawset(self, key, translation)
		return translation
	end
}

setmetatable(L, meta_table)



----------------------------------------------------------------
-- local L = E.L
-- DEFAULT_CHAT_FRAME:AddMessage(L["qwe"])
-- DEFAULT_CHAT_FRAME:AddMessage(L["Weekly Reset"])