local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Mail()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local hasMail = HasNewMail()
	if hasMail then
		collectPlayerData.hasMail = hasMail
	else
		collectPlayerData.hasMail = nil
	end
end
----------------------------------------------------------------
function E.Collect_Mail()
	E.func_SpamBlock(Collect_Mail, false)
end