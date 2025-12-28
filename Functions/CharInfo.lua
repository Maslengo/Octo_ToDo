local GlobalAddonName, E = ...
----------------------------------------------------------------
function E.func_CharInfo_NickName(CharInfo, alwaysShowLevel, forceHideLevel, CustomColor, markPlayer)
	if not CharInfo then return "" end
	local pd = CharInfo.PlayerData
	local result = ""
	local color = CustomColor or pd.classColorHex
	local levelColor = CustomColor or E.COLOR_YELLOW
	if markPlayer then
		local curPers = pd.GUID == E.curGUID and E.COLOR_GREEN.."->|r" or ""
		result = curPers..result
	end

	if pd.Name and color then
		result = result .. color..pd.Name.."|r"
	end
	if not forceHideLevel and pd.UnitLevel then
		if alwaysShowLevel or (not alwaysShowLevel and not pd.levelCapped20 and pd.UnitLevel ~= E.currentMaxLevel) then
			result = result.." "..levelColor..pd.UnitLevel.."|r"
		end
	end

	return E.func_translit(result)
end
----------------------------------------------------------------
function E.func_CharInfo_Server(CharInfo, alwaysShowServer, useShortServer, CustomColor)
	if not CharInfo then return "" end
	local pd = CharInfo.PlayerData
	local result = ""
	local curServer = pd.curServer
	local curServerShort = pd.curServerShort
	local color = CustomColor or E.COLOR_SKYBLUE
	if curServer and curServerShort then
		if alwaysShowServer or (not alwaysShowServer and E.curServerShort ~= curServer) then
			local serverName = useShortServer and curServerShort or curServer
			result = result..color..serverName.."|r"
		end
	end
	return E.func_translit(result)
end
----------------------------------------------------------------
function E.func_CharInfo_Guild(CharInfo, showRank)
	if not CharInfo then return "" end
	local pd = CharInfo.PlayerData
	local result = ""
	local guildName = pd.guildName or ""
	local guildRankName = pd.guildRankName or ""
	local guildRankIndex = pd.guildRankIndex or 0

	if guildName ~= "" and guildRankName ~= "" and guildRankIndex > 0 then
		local guildPART = "<"..E.COLOR_GREEN..guildName.."|r>"
		local rankPART = showRank and " ["..E.COLOR_GREEN..guildRankName.."|r]" or ""
		result = result.. guildPART..rankPART
	end

	return E.func_translit(result)
end
----------------------------------------------------------------
function E.func_CharInfo_Mail(CharInfo)
	if not CharInfo then return "" end
	local pd = CharInfo.PlayerData
	local result = ""
	if pd.hasMail then
		result = result..E.func_texturefromIcon("UI-HUD-Minimap-Mail-Up", 16, 10, true)
	end
	return result
end
----------------------------------------------------------------
----------------------------------------------------------------
local NickName = E.func_CharInfo_NickName(CharInfo, alwaysShowLevel, CustomColor)
local Server =   E.func_CharInfo_Server(CharInfo, alwaysShowServer, useShortServer, CustomColor)
local Guild =    E.func_CharInfo_Guild(CharInfo)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------