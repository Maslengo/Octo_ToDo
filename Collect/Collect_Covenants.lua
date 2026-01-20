local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Covenants()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local covenantID = C_Covenants.GetActiveCovenantID()
	if covenantID and covenantID > 0 then
		local renownLevel = C_CovenantSanctumUI.GetRenownLevel()
		local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
		local curAnimaAmount = currencyInfo.quantity
		collectPlayerData.SL_covenantID = covenantID
		if covenantID == 1 then -- 1 Kyrian
			collectPlayerData.SL_KYRIAN_Anima = E.func_Save(curAnimaAmount)
			collectPlayerData.SL_KYRIAN_Renown = E.func_Save(renownLevel)
		elseif covenantID == 2 then -- 2 Venthyr
			collectPlayerData.SL_VENTHYR_Anima = E.func_Save(curAnimaAmount)
			collectPlayerData.SL_VENTHYR_Renown = E.func_Save(renownLevel)
		elseif covenantID == 3 then -- 3 NightFae
			collectPlayerData.SL_NIGHTFAE_Anima = E.func_Save(curAnimaAmount)
			collectPlayerData.SL_NIGHTFAE_Renown = E.func_Save(renownLevel)
		elseif covenantID == 4 then -- 4 Necrolord
			collectPlayerData.SL_NECROLORD_Anima = E.func_Save(curAnimaAmount)
			collectPlayerData.SL_NECROLORD_Renown = E.func_Save(renownLevel)
		end
	end
end
----------------------------------------------------------------
function E.Collect_Covenants()
	E.func_SpamBlock(Collect_Covenants, true)
end
----------------------------------------------------------------