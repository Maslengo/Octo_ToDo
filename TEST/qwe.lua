do
	local spellCache = {}
	function macroFrame:getSpellName(spellID, cb)
		if spellCache[spellID] then
			return spellCache[spellID]
		else
			local name = GetSpellInfo(spellID)
			if C_Spell.IsSpellDataCached(spellID) then
				local subText = GetSpellSubtext(spellID)
				if #subText > 0 then
					name = name.."("..subText..")"
				end
				spellCache[spellID] = name
			elseif cb then
				SpellEventListener:AddCallback(spellID, cb)
			end
			return name
		end
	end
end





local itemName = setmetatable({}, {__index = function(self, itemID)
		if C_Item.DoesItemExistByID(itemID) then
			local item = Item:CreateFromItemID(itemID)
			if item:IsItemDataCached() then
				self[itemID] = item:GetItemName()
			else
				item:ContinueOnItemLoad(function()
					self[itemID] = item:GetItemName()
				end)
			end
			return rawget(self, itemID)
		end
	end})








				-- if CharInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count ~= E.Octo_Globals.NONE and ChaHrInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count ~= "0/14" then
				-- vivodCent = vivodCent.."("..CharInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count..")"
				-- end
				-- if CharInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count ~= "0/14" then
				-- tooltip[#tooltip+1] = {" ", " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient(" Azmourne - Scourge:", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76406), CharInfo.OctoTable_QuestID[76406]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76547), CharInfo.OctoTable_QuestID[76547]}
				-- tooltip[#tooltip+1] = {" ", " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient(" A.Z.E.R.O.T.H. - Mecha:", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76521), CharInfo.OctoTable_QuestID[76521]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76404), CharInfo.OctoTable_QuestID[76404]}
				-- tooltip[#tooltip+1] = {" ", " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient(" Azmerloth - Murlocs:", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76548), CharInfo.OctoTable_QuestID[76548]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76379), CharInfo.OctoTable_QuestID[76379]}
				-- tooltip[#tooltip+1] = {" ", " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient(" Azewrath - Fel/Demons:", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76459), CharInfo.OctoTable_QuestID[76459]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76362), CharInfo.OctoTable_QuestID[76362]}
				-- tooltip[#tooltip+1] = {" ", " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient(" Azq'roth - Void/Black Empire:", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76546), CharInfo.OctoTable_QuestID[76546]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76453), CharInfo.OctoTable_QuestID[76453]}
				-- tooltip[#tooltip+1] = {" ", " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient(" Warlands - Alliance/Horde:", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76544), CharInfo.OctoTable_QuestID[76544]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76449), CharInfo.OctoTable_QuestID[76449]}
				-- tooltip[#tooltip+1] = {" ", " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient(" Ulderoth - Titans:", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76351), CharInfo.OctoTable_QuestID[76351]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76533), CharInfo.OctoTable_QuestID[76533]}
				-- end