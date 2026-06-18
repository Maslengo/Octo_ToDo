local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Covenants()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	local covenantID = C_Covenants.GetActiveCovenantID()
	if covenantID and covenantID > 0 then
		local renownLevel = E.func_GetRenownLevel()
		local currencyInfo = E.func_GetCurrencyInfo(1813)
		local quantity1813 = currencyInfo.quantity
		local AreCallingsUnlocked = E.func_AreCallingsUnlocked()
		E.pd.SL_covenantID = covenantID
		if covenantID == 1 then -- 1 Kyrian
			E.pd.SL_KYRIAN_Anima = E.func_Save(quantity1813)
			E.pd.SL_KYRIAN_Renown = E.func_Save(renownLevel)
			E.pd.SL_KYRIAN_AreCallingsUnlocked = AreCallingsUnlocked
		elseif covenantID == 2 then -- 2 Venthyr
			E.pd.SL_VENTHYR_Anima = E.func_Save(quantity1813)
			E.pd.SL_VENTHYR_Renown = E.func_Save(renownLevel)
			E.pd.SL_VENTHYR_AreCallingsUnlocked = AreCallingsUnlocked
		elseif covenantID == 3 then -- 3 NightFae
			E.pd.SL_NIGHTFAE_Anima = E.func_Save(quantity1813)
			E.pd.SL_NIGHTFAE_Renown = E.func_Save(renownLevel)
			E.pd.SL_NIGHTFAE_AreCallingsUnlocked = AreCallingsUnlocked
		elseif covenantID == 4 then -- 4 Necrolord
			E.pd.SL_NECROLORD_Anima = E.func_Save(quantity1813)
			E.pd.SL_NECROLORD_Renown = E.func_Save(renownLevel)
			E.pd.SL_NECROLORD_AreCallingsUnlocked = AreCallingsUnlocked
		end
	end
end
----------------------------------------------------------------
function E.Collect_Covenants()
	E.func_SpamBlock(Collect_Covenants, true)
end
----------------------------------------------------------------