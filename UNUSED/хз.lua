local GlobalAddonName, ns = ...
local E = ns.E
вписать во все файлы основного аддона
OctoEngine = E
ns.E = E
	DD_ToDo:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
						левел, нилл, селф,
	end)
ddCloseMenus(передавать левел)
	узнать какое велью
	function E:reloadMenu()
		self.dd:ddCloseMenus(self.level)
		local menu = lsfdd:GetMenu(self.level)
		local value = type(self.value) == "function" and self.value() or self.value
		self.dd:ddToggle(self.level, value, menu.anchorFrame)
	end