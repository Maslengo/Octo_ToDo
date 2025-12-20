local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
----------------------------------------------------------------
function E.func_TextCenter_Chars_nickname(CharInfo)
	local namePart = CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r"
	local levelPart = ""
	local MailPart = ""
	-- and CharInfo.PlayerData.PlayerCanEarnExperience
	if CharInfo.PlayerData.UnitLevel and CharInfo.PlayerData.UnitLevel ~= E.currentMaxLevel then
		levelPart = " "..E.COLOR_YELLOW..CharInfo.PlayerData.UnitLevel.."|r"
	end
	if CharInfo.PlayerData.hasMail then
		MailPart = E.func_texturefromIcon("UI-HUD-Minimap-Mail-Up", 16, 10, true)
	end
	return namePart..levelPart..MailPart
end
function E.func_TextCenter_Chars_server(CharInfo)
	local serverPart = ""
	if not Octo_ToDo_DB_Vars.isOnlyCurrentServer and E.curServerShort ~= CharInfo.PlayerData.curServer then
		serverPart = E.COLOR_SKYBLUE..CharInfo.PlayerData.curServer.."|r"
	end
	return serverPart
end
