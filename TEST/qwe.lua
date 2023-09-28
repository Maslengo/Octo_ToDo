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