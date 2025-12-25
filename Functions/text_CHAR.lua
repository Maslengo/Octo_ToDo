local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
function E.func_TextCenter_Chars_nickname(CharInfo)
	local pd = CharInfo.PlayerData
	local namePart = pd.classColorHex..pd.Name.."|r"
	local levelPart = ""
	local MailPart = ""
	-- and pd.PlayerCanEarnExperience
	-- and not pd.levelCapped20
	if not pd.levelCapped20 and pd.UnitLevel and pd.UnitLevel ~= E.currentMaxLevel then --pd.PlayerCanEarnExperience then
		levelPart = " "..E.COLOR_YELLOW..pd.UnitLevel.."|r"
	end
	if pd.hasMail then
		MailPart = E.func_texturefromIcon("UI-HUD-Minimap-Mail-Up", 16, 10, true)
	end
	return namePart..levelPart..MailPart
end
function E.func_TextCenter_Chars_server(CharInfo)
	local pd = CharInfo.PlayerData
	local serverPart = ""
	if not Octo_ToDo_DB_Vars.isOnlyCurrentServer and E.curServerShort ~= pd.curServer then
		serverPart = E.COLOR_SKYBLUE..pd.curServer.."|r"
	end
	return serverPart
end
