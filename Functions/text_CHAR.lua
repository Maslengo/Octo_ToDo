local GlobalAddonName, E = ...
local L = E.L



function E.func_TextCenter_Chars_nickname(CharInfo, alwaysShowLevel)
	local pd = CharInfo.PlayerData
	local result = ""
	if pd.Name and pd.classColorHex then
		result = result .. pd.classColorHex..pd.Name.."|r"
	end
	if pd.UnitLevel then
		if alwaysShowLevel or (not alwaysShowLevel and not pd.levelCapped20 and pd.UnitLevel ~= E.currentMaxLevel) then
			result = result.." "..E.COLOR_YELLOW..pd.UnitLevel.."|r"
		end
	end
	if pd.hasMail then
		result = result..E.func_texturefromIcon("UI-HUD-Minimap-Mail-Up", 16, 10, true)
	end
	return E.func_translit(result)
end

function E.func_TextCenter_Chars_server(CharInfo, alwaysShowServer)
	local pd = CharInfo.PlayerData
	local result = ""
	if pd.curServer then
		if alwaysShowServer or (not alwaysShowServer and not Octo_ToDo_DB_Vars.isOnlyCurrentServer and E.curServerShort ~= pd.curServer) then
			result = result..E.COLOR_SKYBLUE..pd.curServer.."|r"
		end
	end
	return E.func_translit(result)
end