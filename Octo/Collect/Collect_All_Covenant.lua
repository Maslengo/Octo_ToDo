local GlobalAddonName, E = ...

function E.Collect_All_Covenant()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if collectMASLENGO and not InCombatLockdown() then
		local curCovID = C_Covenants.GetActiveCovenantID() or 0
		if curCovID > 0 then
			local curCovLevel = C_CovenantSanctumUI.GetRenownLevel()
			local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
			local curAnimaAmount = currencyInfo.quantity
			-- collectMASLENGO.CovenantAndAnima = collectMASLENGO.CovenantAndAnima or {}
			collectMASLENGO.CovenantAndAnima.curCovID = curCovID
			if curCovLevel ~= 0 then
				collectMASLENGO.CovenantAndAnima[curCovID][1] = curCovLevel
			else
				collectMASLENGO.CovenantAndAnima[curCovID][1] = nil
			end
			if curAnimaAmount ~= 0 then
				collectMASLENGO.CovenantAndAnima[curCovID][2] = curAnimaAmount
			else
				collectMASLENGO.CovenantAndAnima[curCovID][2] = nil
			end
		end
	end
end