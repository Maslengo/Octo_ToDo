local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Mail()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	local hasMail = HasNewMail()
	if hasMail then
		E.pd.hasMail = hasMail
	else
		E.pd.hasMail = nil
	end
end
----------------------------------------------------------------
function E.Collect_Mail()
	E.func_SpamBlock(Collect_Mail, false)
end
----------------------------------------------------------------