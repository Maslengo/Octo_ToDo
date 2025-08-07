local GlobalAddonName, E = ...


function E.Collect_All_Mail()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end

	local hasMail = HasNewMail()
	if hasMail then
		collectPlayerData.hasMail = hasMail
	else
		collectPlayerData.hasMail = nil
	end
end