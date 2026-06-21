local GlobalAddonName, E = ...
local L = E.L
local addonNAME = E.func_AddonNameForOptions(GlobalAddonName)
----------------------------------------------------------------
local LibStub = LibStub
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibIndentation = LibStub("LibIndentation-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local table_insert = table.insert
----------------------------------------------------------------
-- Настраиваем стиль выпадающего меню --------------------------
----------------------------------------------------------------
function E.func_CreateMenuStyle()
	LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
			local childDropDown = CreateFrame("FRAME", nil, parent, "OctoBackdropTemplate")
			table_insert(E.OctoTable_ColoredFrames, childDropDown)
			childDropDown:SetPoint("TOPLEFT", 8, -2)
			childDropDown:SetPoint("BOTTOMRIGHT", -8, 2)
			return childDropDown
	end)
end
local classColorHexCurrent = E.classColorHexCurrent
if classColorHexCurrent == "|cffffffff" then
	classColorHexCurrent = "|cff" .. "af61ff"
end
----------------------------------------------------------------
-- Общие функции -----------------------------------------------
----------------------------------------------------------------
function E.func_CreateBaseDropDown(frame, buttonName, customName)
	buttonName = buttonName or L["OPTIONS"]
	local DropDown = CreateFrame("BUTTON", customName, frame, "OctoBackdropTemplate")
	table_insert(E.OctoTable_ColoredFrames, DropDown)
	DropDown.ExpandArrow = DropDown:CreateTexture(nil, "ARTWORK")
	DropDown.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DropDown.ExpandArrow:SetPoint("RIGHT", 0, 0)
	DropDown.text = DropDown:CreateFontString()
	DropDown.text:SetFontObject(OctoFont11)
	DropDown.text:SetAllPoints()
	DropDown.text:SetJustifyV("MIDDLE")
	DropDown.text:SetJustifyH("CENTER")
	-- DropDown.text:SetText(buttonName)
	-- local width = math.max(math.ceil(DropDown.text:GetStringWidth())+50, 90)
	-- if width % 2 == 1 then
	--     width = width + 1
	-- end
	DropDown:SetSize(100, 20)
	LibSFDropDown:SetMixin(DropDown)
	DropDown:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 1)
	DropDown:ddSetDisplayMode(GlobalAddonName)
	DropDown:ddSetNoGlobalMouseEvent(true)
	DropDown:ddHideWhenButtonHidden()
	DropDown:RegisterForClicks("LeftButtonUp")
	DropDown:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	DropDown:SetScript("OnMouseDown", function(self)
			self.text:AdjustPointsOffset(1, -1)
	end)
	DropDown:SetScript("OnMouseUp", function(self)
			self.text:SetAllPoints()
			self.text:AdjustPointsOffset(-1, 1)
	end)
	DropDown:HookScript("OnShow", function(self)
			local ddHeight = 20 -- E.GLOBAL_LINE_HEIGHT
			local ddWidth = E.GLOBAL_LINE_WIDTH_LEFT/2
			local width = (E.func_MeasureTextWidth(buttonName, 64) or 100) + E.INDENT_TEXT*2 + E.GLOBAL_LINE_HEIGHT -- E.MIN_COLUMN_WIDTH_LEFT
			-- DropDown:SetSize(E.INDENT_TEXT + (width or 100) + E.INDENT_TEXT + E.GLOBAL_LINE_HEIGHT, E.GLOBAL_LINE_HEIGHT)
			DropDown:SetSize(width, ddHeight)
			DropDown.text:SetText(buttonName)
	end)
	DropDown:ddSetOpenMenuUp(true)
	DropDown:ddSetMenuButtonHeight(E.ddMenuButtonHeight)
	return DropDown
end
----------------------------------------------------------------
-- Вспомогательные функции для меню персонажей -----------------
----------------------------------------------------------------
local function uniqueItems(dataSTR)
	if not dataSTR then return 0 end
	if type(dataSTR) ~= "string" then return 0 end
	local items = {}
	local regionSet = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		if pd and pd[dataSTR] and not regionSet[pd[dataSTR]] then
			regionSet[pd[dataSTR]] = true
			table_insert(items, pd[dataSTR])
		end
	end
	if #items > 0 then
		E.func_SortRecords(items)
	end
	return #items
end
----------------------------------------------------------------
-- L["Characters"] ---------------------------------------------
----------------------------------------------------------------
function E.build_characters_menu(providerfunc, DropDown, level)
	if not Octo_ToDo_DB_Levels then return {} end
	----------------------------------------------------------------
	-- 1. Определяем параметры текущего персонажа ---------------------------------
	----------------------------------------------------------------
	local curBT = E.pd.BattleTag
	local curReg = E.pd.REGION_NAME
	local curSrv = E.pd.curServer
	----------------------------------------------------------------
	-- 2. Вспомогательные функции -------------------------------------------------
	----------------------------------------------------------------
	local function hasVisibleChars(node)
		if node.type == "character" then
			return Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].GUIDS[node.guid]
		end
		if node.children then
			for _, child in ipairs(node.children) do
				if hasVisibleChars(child) then
					return true
				end
			end
		end
		return false
	end
	local function text_result(node, text, isCurrent)
		return function()
			if isCurrent then
				return classColorHexCurrent .. text .. "|r"
			elseif not hasVisibleChars(node) then
				return E.COLOR_GRAY .. text .. "|r"
			end
			return text
		end
	end
	----------------------------------------------------------------
	-- 3. Построение дерева (статично) --------------------------------------------
	----------------------------------------------------------------
	local root = {}
	local btagMap = {}
	local regionMap = {}
	local serverMap = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		if pd and pd.GUID then
			local bt  = pd.BattleTag   or E.TEXT_UNKNOWN
			local reg = pd.REGION_NAME or E.TEXT_UNKNOWN
			local srv = pd.curServer   or E.TEXT_UNKNOWN
			if not btagMap[bt] then
				local isCurrent = (bt == curBT)
				local node = { type = "battletag", text = bt, children = {}, sortName = bt }
				node.text = text_result(node, bt, isCurrent)
				table_insert(root, node)
				btagMap[bt] = node
				regionMap[bt] = {}
				serverMap[bt] = {}
			end
			if not regionMap[bt][reg] then
				local isCurrent = (bt == curBT and reg == curReg)
				local node = { type = "region", text = reg, children = {}, sortName = reg }
				node.text = text_result(node, reg, isCurrent)
				table_insert(btagMap[bt].children, node)
				regionMap[bt][reg] = node
				serverMap[bt][reg] = {}
			end
			if not serverMap[bt][reg][srv] then
				local isCurrent = (bt == curBT and reg == curReg and srv == curSrv)
				local node = { type = "server", text = srv, server = srv, region = reg, children = {}, sortName = srv }
				node.text = text_result(node, srv, isCurrent)
				table_insert(regionMap[bt][reg].children, node)
				serverMap[bt][reg][srv] = node
			end
			table_insert(serverMap[bt][reg][srv].children, {
					type = "character",
					guid = GUID,
					data = pd,
			})
		end
	end
	E.func_SortRecords(root, "sortName")
	for _, btagNode in ipairs(root) do
		E.func_SortRecords(btagNode.children, "sortName")
		for _, regionNode in ipairs(btagNode.children) do
			E.func_SortRecords(regionNode.children, "sortName")
		end
	end
	----------------------------------------------------------------
	-- 4. Сортировка персонажей ---------------------------------------------------
	----------------------------------------------------------------
	local function sortCharacterNodes(nodes)
		local chars = {}
		local others = {}
		for _, node in ipairs(nodes) do
			if node.type == "character" then
				table_insert(chars, node)
			else
				table_insert(others, node)
			end
		end
		E.func_SortRecords(chars, function(a, b)
				local aData = a.data
				local bData = b.data
				if aData.curServer ~= bData.curServer then
					return (aData.curServer or "") > (bData.curServer or "")
				elseif aData.UnitLevel ~= bData.UnitLevel then
					return (aData.UnitLevel or 0) > (bData.UnitLevel or 0)
				elseif aData.avgItemLevel ~= bData.avgItemLevel then
					return (aData.avgItemLevel or 0) > (bData.avgItemLevel or 0)
				else
					return (aData.Name or "") < (bData.Name or "")
				end
		end)
		for i = #others, 1, -1 do
			table_insert(chars, 1, others[i])
		end
		return chars
	end
	local visible, hidden, filtered, visible_GUID, hidden_GUID, filtered_GUID
	----------------------------------------------------------------
	-- 5. Рекурсивное построение меню --------------------------------------------
	----------------------------------------------------------------
	local function build_menu_from_nodes(nodes, isRoot)
		while #nodes == 1 and nodes[1].type ~= "character" do
			nodes = nodes[1].children
		end
		if #nodes > 0 and nodes[1].type == "character" then
			nodes = sortCharacterNodes(nodes)
		end
		local list = {}
		local hasVisible = false
		for _, node in ipairs(nodes) do
			if node.type == "character" then
				local pd = node.data
				local GUID = node.guid
				local item = {
					text = function()
						local color = E.COLOR_RED
						if filtered_GUID[GUID] then
							color = E.COLOR_GRAY
						else
							color = pd.classColorHex
						end
						local name = color .. pd.Name .. " " .. E.COLOR_GRAY .. (pd.UnitLevel or 0) .. "|r"
						if node.guid == E.curGUID then
							name = E.COLOR_GREEN .. "->|r " .. name
						end
						return name
					end,
					icon = pd.specIcon or 134400,
					value = node.guid,
					checked = function(btn)
						return Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].GUIDS[btn.value] or false
					end,
					func = function(btn, _, _, checked)
						Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].GUIDS[btn.value] = checked or nil
						E.sound_OnClick()
						providerfunc()
						for i = level, level+3 do DropDown:ddRefresh(i) end
					end,
					keepShownOnClick = true,
					isNotRadio = true,
					-- fontObject = GameTooltipText,
				}
				if node.guid ~= E.curGUID then
					item.remove = function(btn)
						E.func_DELETEPERS(btn.value)
						providerfunc()
						for i = level, level+3 do DropDown:ddRefresh(i) end
					end
					item.removeDoNotHide = true
				end
				table_insert(list, item)
				if Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].GUIDS[GUID] then
					hasVisible = true
				end
			else
				local children, childHasVisible = build_menu_from_nodes(node.children, false)
				if children then
					table_insert(list, {
							text = node.text,
							hasArrowUp = true,
							notCheckable = true,
							keepShownOnClick = true,
							value = children,
							-- fontObject = GameTooltipText,
					})
					if childHasVisible then hasVisible = true end
				end
			end
		end
		if not isRoot and #nodes > 0 and nodes[1].type == "character" then
			return function(self, lvl)
				self:ddAddButton({ list = list, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS }, lvl)
				self:ddAddSeparator(lvl)
				self:ddAddButton({
						text = L["Show All"],
						-- fontObject = GameTooltipText,
						keepShownOnClick = true,
						notCheckable = true,
						func = function()
							for _, node in ipairs(nodes) do
								if node.type == "character" then
									Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].GUIDS[node.guid] = true
								end
							end
							E.sound_OnClick()
							providerfunc()
							for i = level, level+3 do DropDown:ddRefresh(i) end
						end,
				}, lvl)
				self:ddAddButton({
						text = L["Hide All"],
						-- fontObject = GameTooltipText,
						keepShownOnClick = true,
						notCheckable = true,
						func = function()
							for _, node in ipairs(nodes) do
								if node.type == "character" then
									Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].GUIDS[node.guid] = false
								end
							end
							E.sound_OnClick()
							providerfunc()
							for i = level, level+3 do DropDown:ddRefresh(i) end
						end,
				}, lvl)
			end, hasVisible
		else
			return list, hasVisible
		end
	end
	----------------------------------------------------------------
	-- 6. Возвращаем функцию, которая формирует меню с актуальными данными -------
	----------------------------------------------------------------
	return function(self, lvl)
		-- Пересчитываем списки с учётом текущего профиля
		visible, hidden, filtered, visible_GUID, hidden_GUID, filtered_GUID = E.func_SortCharacters()
		local finalMenu = build_menu_from_nodes(root, true)
		local function makeProfileFilterHandler(settingName)
			return function(_, _, _, checked)
				Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER[settingName] = checked
				E.sound_OnClick()
				providerfunc()
				self:ddRefresh(lvl)
			end
		end
		----------------------------------------------------------------
		-- finalMenu ---------------------------------------------------
		----------------------------------------------------------------
		do
			self:ddAddButton({ list = finalMenu, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS }, lvl)
		end
		----------------------------------------------------------------
		-- SEPARATOR ---------------------------------------------------
		----------------------------------------------------------------
		do
			self:ddAddSeparator(lvl)
		end
		----------------------------------------------------------------
		-- L["Show All"] -----------------------------------------------
		----------------------------------------------------------------
		do
			self:ddAddButton({
					text = L["Show All"],
					-- fontObject = GameTooltipText,
					keepShownOnClick = true,
					notCheckable = true,
					func = function()
						for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
							if CharInfo.PlayerData then
								Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].GUIDS[GUID] = true
							end
						end
						E.sound_OnClick()
						providerfunc()
						self:ddRefresh(lvl)
					end,
			}, lvl)
		end
		----------------------------------------------------------------
		-- L["Hide All"] -----------------------------------------------
		----------------------------------------------------------------
		do
			self:ddAddButton({
					text = L["Hide All"],
					-- fontObject = GameTooltipText,
					keepShownOnClick = true,
					notCheckable = true,
					func = function()
						for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
							if CharInfo.PlayerData then
								Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].GUIDS[GUID] = false
							end
						end
						E.sound_OnClick()
						providerfunc()
						self:ddRefresh(lvl)
					end,
			}, lvl)
		end
		----------------------------------------------------------------
		-- SEPARATOR ---------------------------------------------------
		----------------------------------------------------------------
		do
			self:ddAddSeparator(lvl)
		end
		----------------------------------------------------------------
		-- minSlider ---------------------------------------------------
		----------------------------------------------------------------
		do
			if minSlider then
				minSlider:setValue(Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_LEVEL_MIN or 1)
				if minSlider.SetEnabled then
					minSlider:SetEnabled(not E.func_CONFIG_SORTING_CUSTOM())
				else
					minSlider:SetAlpha(E.func_CONFIG_SORTING_CUSTOM() and 0.5 or 1)
					minSlider:EnableMouse(not E.func_CONFIG_SORTING_CUSTOM())
				end
			else
				minSlider = CreateFrame("FRAME", "minSlider", self, "OctoSliderFrameTemplate")
				minSlider:Hide()
				minSlider:setText(L["Min. Level"])
				minSlider:setMinMax(1, 90)
				minSlider:setStep(1)
				minSlider:setMaxLetters(2)
				minSlider:setOnChanged(function(slider, value)
						Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_LEVEL_MIN = math.floor(value)
						E.sound_OnClick()
						providerfunc()
						self:ddRefresh(lvl)
				end)
				minSlider:setValue(Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_LEVEL_MIN or 1)
			end
			self:ddAddButton({ customFrame = minSlider, fixedWidth = true, notCheckable = true }, lvl)
		end
		----------------------------------------------------------------
		-- maxSlider ---------------------------------------------------
		----------------------------------------------------------------
		do
			if maxSlider then
				maxSlider:setValue(Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_LEVEL_MAX or 90)
				if maxSlider.SetEnabled then
					maxSlider:SetEnabled(not E.func_CONFIG_SORTING_CUSTOM())
				else
					maxSlider:SetAlpha(E.func_CONFIG_SORTING_CUSTOM() and 0.5 or 1)
					maxSlider:EnableMouse(not E.func_CONFIG_SORTING_CUSTOM())
				end
			else
				maxSlider = CreateFrame("FRAME", "maxSlider", self, "OctoSliderFrameTemplate")
				maxSlider:Hide()
				maxSlider:setText(L["Max. Level"])
				maxSlider:setMinMax(1, 90)
				maxSlider:setStep(1)
				maxSlider:setMaxLetters(2)
				maxSlider:setOnChanged(function(slider, value)
						Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_LEVEL_MAX = math.floor(value)
						E.sound_OnClick()
						providerfunc()
						self:ddRefresh(lvl)
				end)
				maxSlider:setValue(Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_LEVEL_MAX or 90)
			end
			self:ddAddButton({ customFrame = maxSlider, fixedWidth = true, notCheckable = true }, lvl)
		end
		----------------------------------------------------------------
		-- SEPARATOR ---------------------------------------------------
		----------------------------------------------------------------
		do
			self:ddAddSeparator(lvl)
		end
		----------------------------------------------------------------
		-- L["Only Current BattleTag"] ---------------------------------
		----------------------------------------------------------------
		do
			if uniqueItems("BattleTag") > 1 then
				local info = {
					-- fontObject = GameTooltipText,
					keepShownOnClick = true,
					notCheckable = false,
					isNotRadio = true,
					text = function()
						local label = L["Only Current BattleTag"]
						return E.func_CONFIG_SORTING_CUSTOM()
						and (E.COLOR_GRAY .. label .. "|r") or label
					end,
					-- disabledFont = "Interface\\AddOns\\Octo_SharedMedia\\Media1\\font\\01 Octo (dooztr_0).TTF",
					-- disabledFont = E.Octo_font,
					-- disabledFontObject = GameTooltipText,
					disabled = function()
						return E.func_CONFIG_SORTING_CUSTOM()
					end,
					checked = function()
						return E.func_CONFIG_SHOW_ONLY_CURRENT_BATTLETAG()
					end,
					func = makeProfileFilterHandler("CONFIG_SHOW_ONLY_CURRENT_BATTLETAG")
				}
				self:ddAddButton(info, lvl)
			end
		end
		----------------------------------------------------------------
		-- L["Only Current Region"] ------------------------------------
		----------------------------------------------------------------
		do
			if uniqueItems("REGION_NAME") > 1 then
				local info = {
					-- fontObject = GameTooltipText,
					keepShownOnClick = true,
					notCheckable = false,
					isNotRadio = true,
					text = function()
						local label = L["Only Current Region"]
						return E.func_CONFIG_SORTING_CUSTOM()
						and (E.COLOR_GRAY .. label .. "|r") or label
					end,
					-- disabledFontObject = GameTooltipText,
					disabled = function()
						return E.func_CONFIG_SORTING_CUSTOM()
					end,
					checked = function()
						return E.func_CONFIG_SHOW_ONLY_CURRENT_REGION()
					end,
					func = makeProfileFilterHandler("CONFIG_SHOW_ONLY_CURRENT_REGION")
				}
				self:ddAddButton(info, lvl)
			end
		end
		----------------------------------------------------------------
		-- L["Only Current Server"] ------------------------------------
		----------------------------------------------------------------
		do
			if uniqueItems("curServer") > 1 then
				local info = {
					-- fontObject = GameTooltipText,
					keepShownOnClick = true,
					notCheckable = false,
					isNotRadio = true,
					text = function()
						local label = L["Only Current Server"]
						return E.func_CONFIG_SORTING_CUSTOM()
						and (E.COLOR_GRAY .. label .. "|r") or label
					end,
					-- disabledFontObject = GameTooltipText,
					disabled = function()
						return E.func_CONFIG_SORTING_CUSTOM()
					end,
					checked = function()
						return E.func_CONFIG_SHOW_ONLY_CURRENT_SERVER()
					end,
					func = makeProfileFilterHandler("CONFIG_SHOW_ONLY_CURRENT_SERVER")
				}
				self:ddAddButton(info, lvl)
			end
		end
		----------------------------------------------------------------
		-- L["Only Current Faction"] -----------------------------------
		----------------------------------------------------------------
		do
			if uniqueItems("FACTION") > 1 then
				local info = {
					-- fontObject = GameTooltipText,
					keepShownOnClick = true,
					notCheckable = false,
					isNotRadio = true,
					text = function()
						local label = L["Only Current Faction"]
						return E.func_CONFIG_SORTING_CUSTOM()
						and (E.COLOR_GRAY .. label .. "|r") or label
					end,
					-- disabledFontObject = GameTooltipText,
					disabled = function()
						return E.func_CONFIG_SORTING_CUSTOM()
					end,
					checked = function()
						return E.func_CONFIG_SHOW_ONLY_CURRENT_FACTION()
					end,
					func = makeProfileFilterHandler("CONFIG_SHOW_ONLY_CURRENT_FACTION")
				}
				self:ddAddButton(info, lvl)
			end
		end
		----------------------------------------------------------------
		-- L["Current Character First"] --------------------------------
		----------------------------------------------------------------
		do
			local info = {
				-- fontObject = GameTooltipText,
				keepShownOnClick = true,
				notCheckable = false,
				isNotRadio = true,
				text = function()
					local label = L["Current Character First"]
					return E.func_CONFIG_SORTING_CUSTOM()
					and (E.COLOR_GRAY .. label .. "|r") or label
				end,
				-- disabledFontObject = GameTooltipText,
				disabled = function()
					return E.func_CONFIG_SORTING_CUSTOM()
				end,
				checked = function()
					return E.func_CONFIG_SHOW_ALWAYS_AS_FIRST()
				end,
				func = makeProfileFilterHandler("CONFIG_SHOW_ALWAYS_AS_FIRST")
			}
			self:ddAddButton(info, lvl)
		end
		----------------------------------------------------------------
		-- L["CUSTOM"] -------------------------------------------------
		----------------------------------------------------------------
		do
			local info = {
				-- fontObject = GameTooltipText,
				keepShownOnClick = true,
				notCheckable = false,
				isNotRadio = true,
				text = function()
					local label = L["CUSTOM"]
					return E.func_CONFIG_SORTING_CUSTOM()
					and (E.COLOR_GREEN .. label .. "|r") or label
				end,
				checked = function()
					return E.func_CONFIG_SORTING_CUSTOM()
				end,
				-- свой обработчик вместо makeProfileFilterHandler
				func = function(_, _, _, checked)
					-- Сохраняем настройку
					Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SORTING_CUSTOM = checked
					E.sound_OnClick()
					providerfunc()
					-- Немедленно обновляем слайдеры
					if minSlider then
						-- Значения слайдеров не меняются, просто включаем/выключаем
						if minSlider.SetEnabled then
							minSlider:SetEnabled(not checked)
						else
							minSlider:SetAlpha(checked and 0.5 or 1)
							minSlider:EnableMouse(not checked)
						end
					end
					if maxSlider then
						if maxSlider.SetEnabled then
							maxSlider:SetEnabled(not checked)
						else
							maxSlider:SetAlpha(checked and 0.5 or 1)
							maxSlider:EnableMouse(not checked)
						end
					end
					-- Обновляем меню (галочки, цвет текста и т.д.)
					self:ddRefresh(lvl)
				end,
			}
			self:ddAddButton(info, lvl)
		end
		----------------------------------------------------------------
		-- Профили (подменю) -------------------------------------------
		----------------------------------------------------------------
		do
			local db = Octo_Todo_DB_Profiles.CHARACTERS
			local profiles = db.profiles
			----------------------------------------------------------------
			-- SEPARATOR ---------------------------------------------------
			----------------------------------------------------------------
			self:ddAddSeparator(lvl)
			----------------------------------------------------------------
			-- L["Profiles"] -----------------------------------------------
			----------------------------------------------------------------
			self:ddAddButton({
					text = L["Profiles"],
					-- fontObject = GameTooltipText,
					hasArrowUp = true,
					keepShownOnClick = true,
					notCheckable = true,
					value = function(subself, sublvl)
						local sublist = {}
						local profileNames = {}
						for name in next, (profiles) do
							table_insert(profileNames, name)
						end
						E.func_SortRecords(profileNames)
						for _, profileName in ipairs(profileNames) do
							local info = {
								text = (profileName == E.TEXT_ENG_DEFAULT) and L["DEFAULT"] or profileName,
								-- fontObject = GameTooltipText,
								keepShownOnClick = true,
								notCheckable = false,
								isNotRadio = false,
								value = profileName,
								checked = function()
									return db.CURRENT == profileName
								end,
								func = function(menuButton)
									db.CURRENT = menuButton.value
									E.func_UpdateGlobalNSforProfiles()
									-- Обновить слайдеры
									if minSlider then
										minSlider:setValue(Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_LEVEL_MIN or 1)
										if minSlider.SetEnabled then
											minSlider:SetEnabled(not E.func_CONFIG_SORTING_CUSTOM())
										else
											minSlider:SetAlpha(E.func_CONFIG_SORTING_CUSTOM() and 0.5 or 1)
											minSlider:EnableMouse(not E.func_CONFIG_SORTING_CUSTOM())
										end
									end
									if maxSlider then
										maxSlider:setValue(Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_LEVEL_MAX or 90)
										if maxSlider.SetEnabled then
											maxSlider:SetEnabled(not E.func_CONFIG_SORTING_CUSTOM())
										else
											maxSlider:SetAlpha(E.func_CONFIG_SORTING_CUSTOM() and 0.5 or 1)
											maxSlider:EnableMouse(not E.func_CONFIG_SORTING_CUSTOM())
										end
									end
									E.sound_OnClick()
									if providerfunc then providerfunc() end
									for i = lvl, lvl+3 do self:ddRefresh(i) end
								end,
							}
							if profileName ~= E.TEXT_ENG_DEFAULT then
								info.widgets = {
									{
										icon = "Interface/BUTTONS/UI-GroupLoot-Pass-Up", width = 16, height = 16,
										OnClick = function()
											local function do_remove()
												profiles[profileName] = nil
												if db.CURRENT == profileName then
													db.CURRENT = E.TEXT_ENG_DEFAULT
													E.func_UpdateGlobalNSforProfiles()
												end
												E.func_PrintMessage(L["Profile successfully deleted"])
											end
											StaticPopupDialogs["OCTO_DELETE_PROFILE_CONFIRM"] = {
												text = string.format(L["Delete profile '%s'?"], profileName),
												button1 = L["DELETE"], button2 = L["CANCEL"],
												OnAccept = do_remove, timeout = 0,
												whileDead = true, hideOnEscape = true, preferredIndex = 3,
											}
											StaticPopup_Show("OCTO_DELETE_PROFILE_CONFIRM")
											subself:ddCloseMenus()
										end,
										OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["DELETE"], nil, nil, nil, true) end,
									},
									{
										icon = "Interface\\WorldMap\\GEAR_64GREY", width = 16, height = 16,
										OnClick = function()
											StaticPopupDialogs["OCTO_RENAME_PROFILE_INLINE"] = {
												text = string.format(L["Enter new name for profile '%s':"], profileName),
												button1 = L["Rename"], button2 = L["CANCEL"],
												hasEditBox = true, editBoxWidth = 260, maxLetters = 30,
												OnAccept = function(dialog)
													local newName = dialog.EditBox:GetText():trim()
													if newName and newName ~= "" and newName ~= profileName then
														if profiles[newName] then
															E.func_PrintMessage(L["A profile with the same name exists"])
															return
														end
														profiles[newName] = profiles[profileName]
														profiles[profileName] = nil
														if db.CURRENT == profileName then
															db.CURRENT = newName
															E.func_UpdateGlobalNSforProfiles()
														end
														if providerfunc then providerfunc() end
														E.func_PrintMessage(L["Profile successfully renamed"])
													end
													for i = lvl, lvl+3 do self:ddRefresh(i) end
												end,
												OnShow = function(dialog)
													dialog.EditBox:SetText(profileName)
													dialog.EditBox:SetFocus()
													dialog.EditBox:HighlightText()
												end,
												EditBoxOnEnterPressed = function(editBox)
													local dialog = editBox:GetParent()
													local newName = editBox:GetText():trim()
													if newName and newName ~= "" and newName ~= profileName then
														if profiles[newName] then
															E.func_PrintMessage(L["A profile with the same name exists"])
															return
														end
														profiles[newName] = profiles[profileName]
														profiles[profileName] = nil
														if db.CURRENT == profileName then
															db.CURRENT = newName
															E.func_UpdateGlobalNSforProfiles()
														end
														dialog:Hide()
														if providerfunc then providerfunc() end
														E.func_PrintMessage(L["Profile successfully renamed"])
														for i = lvl, lvl+3 do self:ddRefresh(i) end
													end
												end,
												timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
											}
											StaticPopup_Show("OCTO_RENAME_PROFILE_INLINE")
											subself:ddCloseMenus()
										end,
										OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["Rename"], nil, nil, nil, true) end,
									},
								}
							else -- DEFAULT profile
								info.widgets = {
									{
										icon = "talents-button-undo", width = 16, height = 16,
										OnClick = function()
											profiles[E.TEXT_ENG_DEFAULT] = nil
											E.func_CreateProfile("CHARACTERS", E.TEXT_ENG_DEFAULT)
											if providerfunc then providerfunc() end
											E.func_UpdateGlobals()
											E.func_PrintMessage(L["Profile reset to default"])
											-- subself:ddCloseMenus()
											for i = lvl, lvl + 3 do DropDown:ddRefresh(i) end
											-- DropDown:ddReopenMenu(sublvl)
											DropDown:ddReopenAllMenus(1, sublvl)
										end,
										OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["RESET"], nil, nil, nil, true) end,
									},
								}
							end
							table_insert(sublist, info)
						end
						local function createNewProfile(copyFromCurrent)
							StaticPopupDialogs["OCTO_CREATE_PROFILE"] = {
								text = copyFromCurrent and L["Enter a name for the new profile|n(will be copied from the current one)"] or L["Enter a name for the new profile"],
								button1 = L["NEW"], button2 = L["CANCEL"],
								hasEditBox = true, editBoxWidth = 260, maxLetters = 30,
								OnAccept = function(dialog)
									local pName = dialog.EditBox:GetText():trim()
									if pName and pName ~= "" then
										if profiles[pName] then
											E.func_PrintMessage(L["A profile with the same name exists"])
											return
										end
										if copyFromCurrent and db.CURRENT then
											local src = profiles[db.CURRENT]
											profiles[pName] = src and E.func_CopyTableDeep(src) or {}
										else
											E.func_CreateProfile("CHARACTERS", pName)
										end
										db.CURRENT = pName
										E.func_UpdateGlobalNSforProfiles()
										for i = lvl, lvl+3 do self:ddRefresh(i) end
										if providerfunc then providerfunc() end
										E.func_PrintMessage(L["Profile successfully created"])
									end
								end,
								OnShow = function(dialog) dialog.EditBox:SetText(""); dialog.EditBox:SetFocus() end,
								EditBoxOnEnterPressed = function(editBox)
									local dialog = editBox:GetParent()
									local pName = editBox:GetText():trim()
									if pName and pName ~= "" then
										if profiles[pName] then
											E.func_PrintMessage(L["A profile with the same name exists"])
											return
										end
										if copyFromCurrent and db.CURRENT then
											local src = profiles[db.CURRENT]
											profiles[pName] = src and E.func_CopyTableDeep(src) or {}
										else
											E.func_CreateProfile("CHARACTERS", pName)
										end
										db.CURRENT = pName
										E.func_UpdateGlobalNSforProfiles()
										for i = lvl, lvl+3 do self:ddRefresh(i) end
										dialog:Hide()
										if providerfunc then providerfunc() end
										E.func_PrintMessage(L["Profile successfully created"])
									end
								end,
								timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
							}
							StaticPopup_Show("OCTO_CREATE_PROFILE")
							subself:ddCloseMenus()
						end
						subself:ddAddButton({ list = sublist, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS }, sublvl)
						subself:ddAddSeparator(sublvl)
						subself:ddAddButton({
								text = L["NEW"],
								-- fontObject = GameTooltipText,
								keepShownOnClick = false,
								notCheckable = true,
								func = function() createNewProfile(false) end,
						}, sublvl)
						----------------------------------------------------------------
						----------------------------------------------------------------
						----------------------------------------------------------------
						subself:ddAddButton({
								text = L["Copy current"],
								-- fontObject = GameTooltipText,
								keepShownOnClick = true,
								notCheckable = true,
								disabled = not db.CURRENT or not profiles[db.CURRENT],
								func = function() createNewProfile(true) end,
						}, sublvl)
						----------------------------------------------------------------
					end,
			}, lvl)
		end
		----------------------------------------------------------------
	end
end
----------------------------------------------------------------
-- L["EXPANSION_FILTER_TEXT"] ----------------------------------
----------------------------------------------------------------
function E.build_expansion_menu(providerfunc, DropDown, level)
	----------------------------------------------------------------
	local db = Octo_Todo_DB_Profiles and Octo_Todo_DB_Profiles.KEYS
	local profiles = db and db.profiles
	if not profiles then
		E.init_Octo_Todo_DB_Profiles()
	end
	if not profiles then return {} end
	----------------------------------------------------------------
	-- Динамическое получение таблицы дополнений текущего профиля
	----------------------------------------------------------------
	local function GetCurrentExpansionTBL()
		return E.func_GetData_profileKeys("ExpansionToShow")
	end
	local commonIconInfo = { tSizeX = E.ddMenuButtonHeight * 2, tSizeY = E.ddMenuButtonHeight }
	local list = {}
	local function func_Myfunc(menuButton, pd, _, checked)
		GetCurrentExpansionTBL()[menuButton.value] = checked or nil
		E.sound_OnClick()
		providerfunc()
		DropDown:ddRefresh(level)
	end
	local function func_checked(menuButton)
		return GetCurrentExpansionTBL()[menuButton.value]
	end
	for expansionID, v in next, (E.OctoTables_Vibor) do
		local info = {}
		info.text = v.name
		-- info.fontObject = GameTooltipText
		info.value = expansionID
		info.icon = v.icon
		info.iconInfo = commonIconInfo
		info.keepShownOnClick = true
		info.notCheckable = false
		info.isNotRadio = true
		info.func = func_Myfunc
		info.checked = func_checked
		info.widgets = {
			{
				icon = "interface/worldmap/worldmappartyicon",
				width = 16, height = 16,
				OnClick = function(widget)
					local tbl = GetCurrentExpansionTBL()
					E.sound_OnClick()
					for eid in next, (E.OctoTables_Vibor) do
						tbl[eid] = false
					end
					tbl[expansionID] = true
					providerfunc()
					DropDown:ddRefresh(level)
				end,
				OnTooltipShow = function(btn, tooltip)
					tooltip:AddLine(L["Select only this expansion"])
				end,
			}
		}
		table_insert(list, info)
	end
	return function(self, lvl)
		----------------------------------------------------------------
		-- Список дополнений -------------------------------------------
		----------------------------------------------------------------
		do
			self:ddAddButton({
					list = list,
					listMaxSize = E.LIST_MAX_SIZE,
					autoFocus = E.AUTO_FOCUS
			}, lvl)
		end
		----------------------------------------------------------------
		-- SEPARATOR ---------------------------------------------------
		----------------------------------------------------------------
		self:ddAddSeparator(lvl)
		----------------------------------------------------------------
		-- Show All ----------------------------------------------------
		----------------------------------------------------------------
		self:ddAddButton({
				text = L["Show All"],
				-- fontObject = GameTooltipText,
				keepShownOnClick = true,
				notCheckable = true,
				func = function()
					local tbl = GetCurrentExpansionTBL()
					for eid in next, (E.OctoTables_Vibor) do
						tbl[eid] = true
					end
					E.sound_OnClick()
					providerfunc()
					self:ddRefresh(lvl)
				end,
		}, lvl)
		----------------------------------------------------------------
		-- Hide All ----------------------------------------------------
		----------------------------------------------------------------
		self:ddAddButton({
				text = L["Hide All"],
				-- fontObject = GameTooltipText,
				keepShownOnClick = true,
				notCheckable = true,
				func = function()
					local tbl = GetCurrentExpansionTBL()
					for eid in next, (E.OctoTables_Vibor) do
						tbl[eid] = false
					end
					E.sound_OnClick()
					providerfunc()
					self:ddRefresh(lvl)
				end,
		}, lvl)
		----------------------------------------------------------------
		-- SEPARATOR ---------------------------------------------------
		----------------------------------------------------------------
		self:ddAddSeparator(lvl)
		----------------------------------------------------------------
		-- Подменю профилей --------------------------------------------
		----------------------------------------------------------------
		self:ddAddButton({
				text = L["Profiles"],
				-- fontObject = GameTooltipText,
				hasArrowUp = true,
				keepShownOnClick = true,
				notCheckable = true,
				value = function(subself, sublvl)
					local sublist = {}
					local profileNames = {}
					for name in next, (profiles) do
						table_insert(profileNames, name)
					end
					E.func_SortRecords(profileNames)
					for _, profileName in ipairs(profileNames) do
						local info = {
							text = (profileName == E.TEXT_ENG_DEFAULT) and L["DEFAULT"] or profileName,
							-- fontObject = GameTooltipText,
							keepShownOnClick = true,
							notCheckable = false,
							isNotRadio = false,
							value = profileName,
							checked = function()
								return db.CURRENT == profileName
							end,
							func = function(menuButton)
								db.CURRENT = menuButton.value
								E.func_UpdateGlobalNSforProfiles()   -- <-- добавить
								E.sound_OnClick()
								if providerfunc then providerfunc() end
								-- Обновляем меню Expansion (родительский уровень)
								for i = lvl, lvl+3 do self:ddRefresh(i) end
							end,
						}
						if profileName ~= E.TEXT_ENG_DEFAULT then
							info.widgets = {
								{
									icon = "Interface/BUTTONS/UI-GroupLoot-Pass-Up", width = 16, height = 16,
									OnClick = function()
										local function do_remove()
											profiles[profileName] = nil
											if db.CURRENT == profileName then
												db.CURRENT = E.TEXT_ENG_DEFAULT
											end
											if providerfunc then providerfunc() end
											E.func_PrintMessage(L["Profile successfully deleted"])
										end
										StaticPopupDialogs["OCTO_DELETE_PROFILE_CONFIRM"] = {
											text = string.format(L["Delete profile '%s'?"], profileName),
											button1 = L["DELETE"], button2 = L["CANCEL"],
											OnAccept = do_remove, timeout = 0,
											whileDead = true, hideOnEscape = true, preferredIndex = 3,
										}
										StaticPopup_Show("OCTO_DELETE_PROFILE_CONFIRM")
										subself:ddCloseMenus()
									end,
									OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["DELETE"], nil, nil, nil, true) end,
								},
								{
									icon = "Interface\\WorldMap\\GEAR_64GREY", width = 16, height = 16,
									OnClick = function()
										StaticPopupDialogs["OCTO_RENAME_PROFILE_INLINE"] = {
											text = string.format(L["Enter new name for profile '%s':"], profileName),
											button1 = L["Rename"], button2 = L["CANCEL"],
											hasEditBox = true, editBoxWidth = 260, maxLetters = 30,
											OnAccept = function(dialog)
												local newName = dialog.EditBox:GetText():trim()
												if newName and newName ~= "" and newName ~= profileName then
													if profiles[newName] then
														E.func_PrintMessage(L["A profile with the same name exists"])
														return
													end
													profiles[newName] = profiles[profileName]
													profiles[profileName] = nil
													if db.CURRENT == profileName then
														db.CURRENT = newName
													end
													if providerfunc then providerfunc() end
													E.func_PrintMessage(L["Profile successfully renamed"])
												end
											end,
											OnShow = function(dialog)
												dialog.EditBox:SetText(profileName)
												dialog.EditBox:SetFocus()
												dialog.EditBox:HighlightText()
											end,
											EditBoxOnEnterPressed = function(editBox)
												local dialog = editBox:GetParent()
												local newName = editBox:GetText():trim()
												if newName and newName ~= "" and newName ~= profileName then
													if profiles[newName] then
														E.func_PrintMessage(L["A profile with the same name exists"])
														return
													end
													profiles[newName] = profiles[profileName]
													profiles[profileName] = nil
													if db.CURRENT == profileName then
														db.CURRENT = newName
													end
													dialog:Hide()
													if providerfunc then providerfunc() end
													E.func_PrintMessage(L["Profile successfully renamed"])
												end
											end,
											timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
										}
										StaticPopup_Show("OCTO_RENAME_PROFILE_INLINE")
										subself:ddCloseMenus()
									end,
									OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["Rename"], nil, nil, nil, true) end,
								},
							}
						elseif profileName == E.TEXT_ENG_DEFAULT then
							info.widgets = {
								{
									icon = "talents-button-undo", width = 16, height = 16,
									OnClick = function()
										profiles[E.TEXT_ENG_DEFAULT] = nil
										E.func_CreateProfile("KEYS", E.TEXT_ENG_DEFAULT)
										if providerfunc then providerfunc() end
										E.func_UpdateGlobals()
										E.func_PrintMessage(L["Profile reset to default"])
										-- subself:ddCloseMenus()
										for i = lvl, lvl + 3 do DropDown:ddRefresh(i) end
										-- DropDown:ddReopenMenu(sublvl)
										DropDown:ddReopenAllMenus(1, sublvl)
									end,
									OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["RESET"], nil, nil, nil, true) end,
								},
							}
						end
						table_insert(sublist, info)
					end
					local function createNewProfile(copyFromCurrent)
						StaticPopupDialogs["OCTO_CREATE_PROFILE"] = {
							text = copyFromCurrent and L["Enter a name for the new profile|n(will be copied from the current one)"] or L["Enter a name for the new profile"],
							button1 = L["NEW"], button2 = L["CANCEL"],
							hasEditBox = true, editBoxWidth = 260, maxLetters = 30,
							OnAccept = function(dialog)
								local pName = dialog.EditBox:GetText():trim()
								if pName and pName ~= "" then
									if profiles[pName] then
										E.func_PrintMessage(L["A profile with the same name exists"])
										return
									end
									if copyFromCurrent and db.CURRENT then
										local src = profiles[db.CURRENT]
										profiles[pName] = src and E.func_CopyTableDeep(src) or {}
									else
										E.func_CreateProfile("KEYS", pName)
									end
									db.CURRENT = pName
									if providerfunc then
										providerfunc()
									end
								end
							end,
							OnShow = function(dialog) dialog.EditBox:SetText(""); dialog.EditBox:SetFocus() end,
							EditBoxOnEnterPressed = function(editBox)
								local dialog = editBox:GetParent()
								local pName = editBox:GetText():trim()
								if pName and pName ~= "" then
									if profiles[pName] then
										E.func_PrintMessage(L["A profile with the same name exists"])
										return
									end
									if copyFromCurrent and db.CURRENT then
										local src = profiles[db.CURRENT]
										profiles[pName] = src and E.func_CopyTableDeep(src) or {}
									else
										E.func_CreateProfile("KEYS", pName)
									end
									db.CURRENT = pName
									dialog:Hide()
									if providerfunc then providerfunc() end
									E.func_PrintMessage(L["Profile successfully created"])
								end
							end,
							timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
						}
						StaticPopup_Show("OCTO_CREATE_PROFILE")
						subself:ddCloseMenus()
					end
					subself:ddAddButton({ list = sublist, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS }, sublvl)
					subself:ddAddSeparator(sublvl)
					subself:ddAddButton({
							text = L["NEW"],
							-- fontObject = GameTooltipText,
							keepShownOnClick = false,
							notCheckable = true,
							func = function() createNewProfile(false) end,
					}, sublvl)
					subself:ddAddButton({
							text = L["Copy current"],
							-- fontObject = GameTooltipText,
							keepShownOnClick = true,
							notCheckable = true,
							disabled = not db.CURRENT or not profiles[db.CURRENT],
							func = function() createNewProfile(true) end,
					}, sublvl)
				end,
		}, lvl)
		----------------------------------------------------------------
	end
end
----------------------------------------------------------------
-- L["SETTINGS"] -----------------------------------------------
----------------------------------------------------------------
function E.build_color_profiles_menu(providerfunc, DropDown, level)
	local db = Octo_Todo_DB_Profiles and Octo_Todo_DB_Profiles.SETTINGS
	local profilesALL = E.func_GetProfile_SETTINGS_ALL()
	----------------------------------------------------------------
	-- Единая функция для тоглов / цвета / тогл+цвет ----------------
	----------------------------------------------------------------
	local function addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
		local info = {}
		info.text = name
		-- info.fontObject = GameTooltipText
		info.keepShownOnClick = true
		if variableKey then
			info.isNotRadio = true
			info.checked = function()
				return variableTbl[variableKey] or false
			end
			info.func = function(_, _, _, checked)
				variableTbl[variableKey] = checked or false
				E.sound_OnClick()
				providerfunc()
				subself:ddRefresh(sublvl)
			end
		else
			info.notCheckable = true
		end
		local hasDefault = type(defaultTbl) == "table"
		if hasDefault then
			info.widgets = {{
					icon = "talents-button-undo",
					width = 16,
					height = 16,
					OnClick = function()
						if variableKey then
							variableTbl[variableKey] = defaultTbl[variableKey]
						end
						if variableKey_r and variableKey_g and variableKey_b then
							variableTbl[variableKey_r] = defaultTbl[variableKey_r]
							variableTbl[variableKey_g] = defaultTbl[variableKey_g]
							variableTbl[variableKey_b] = defaultTbl[variableKey_b]
							if variableKey_a then
								variableTbl[variableKey_a] = defaultTbl[variableKey_a]
							end
						end
						providerfunc()
						E.func_UpdateGlobals()
						-- for i = level, level + 3 do
						--     DropDown:ddRefresh(i)
						-- end
						-- DropDown:ddReopenMenu(sublvl)
						DropDown:ddReopenAllMenus(1, sublvl)
					end,
					-- OnClick = function()
					--     local dialogName = "OCTO_RESET_DEFAULT_" .. (variableKey or "color")
					--     StaticPopupDialogs[dialogName] = {
					--         text = L["Are you sure you want to reset to default?"] or "Reset to default?",
					--         button1 = YES,
					--         button2 = NO,
					--         OnAccept = function()
					--             if variableKey then
					--                 variableTbl[variableKey] = defaultTbl[variableKey]
					--             end
					--             if variableKey_r and variableKey_g and variableKey_b then
					--                 variableTbl[variableKey_r] = defaultTbl[variableKey_r]
					--                 variableTbl[variableKey_g] = defaultTbl[variableKey_g]
					--                 variableTbl[variableKey_b] = defaultTbl[variableKey_b]
					--                 if variableKey_a then
					--                     variableTbl[variableKey_a] = defaultTbl[variableKey_a]
					--                 end
					--             end
					--             providerfunc()
					--             E.func_UpdateGlobals()
					--             for i = level, level + 3 do
					--                 DropDown:ddRefresh(i)
					--             end
					--         end,
					--         timeout = 0,
					--         whileDead = true,
					--         hideOnEscape = true,
					--         preferredIndex = 3,
					--     }
					--     StaticPopup_Show(dialogName)
					--     subself:ddCloseMenus()
					-- end,
					OnTooltipShow = function(_, tooltipFrame)
						tooltipFrame:AddLine(L["Reset to default"] or "Reset to default")
					end,
			}}
		end
		if variableKey_r and variableKey_g and variableKey_b then
			local oldR = variableTbl[variableKey_r]
			local oldG = variableTbl[variableKey_g]
			local oldB = variableTbl[variableKey_b]
			local oldA = variableKey_a and variableTbl[variableKey_a]
			local hasAlpha = variableKey_a ~= nil
			local function Refresh()
				providerfunc()
				for i = level, level + 3 do
					DropDown:ddRefresh(i)
				end
			end
			local function ApplyColor()
				local r, g, b = ColorPickerFrame:GetColorRGB()
				variableTbl[variableKey_r] = r
				variableTbl[variableKey_g] = g
				variableTbl[variableKey_b] = b
				if hasAlpha then
					variableTbl[variableKey_a] = ColorPickerFrame:GetColorAlpha()
				end
				Refresh()
			end
			info.hasColorSwatch = true
			info.r = oldR
			info.g = oldG
			info.b = oldB
			if hasAlpha then
				info.hasOpacity = true
				info.opacity = oldA
				info.opacityFunc = ApplyColor
			end
			info.swatchFunc = ApplyColor
			info.cancelFunc = function()
				variableTbl[variableKey_r] = oldR
				variableTbl[variableKey_g] = oldG
				variableTbl[variableKey_b] = oldB
				if hasAlpha then
					variableTbl[variableKey_a] = oldA
				end
				Refresh()
			end
		end
		subself:ddAddButton(info, sublvl)
	end
	-- Функция для радио-кнопок (выбор одного значения из группы)
	local function addToggleButtonClosureSIMPLE(subself, sublvl, name, variableTbl, variableKey, btnValue, defaultTbl)
		local info = {}
		info.text = name
		info.keepShownOnClick = true
		info.notCheckable = false
		info.isNotRadio = false
		info.value = btnValue
		info.checked = function(btn)
			return variableTbl[variableKey] == btn.value
		end
		info.func = function(btn, _, _, checked)
			variableTbl[variableKey] = btn.value
			providerfunc()
			subself:ddRefresh(sublvl)
			DropDown:ddRefresh(level)
		end
		-- Виджет сброса к дефолтному значению
		if type(defaultTbl) == "table" then
			info.widgets = {{
					icon = "talents-button-undo",
					width = 16, height = 16,
					OnClick = function()
						variableTbl[variableKey] = defaultTbl[variableKey]
						providerfunc()
						E.func_UpdateGlobals()
						DropDown:ddReopenAllMenus(1, sublvl)
					end,
					OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["Reset to default"] or "Reset to default") end,
			}}
		end
		subself:ddAddButton(info, sublvl)
	end
	-- Функция для радио-кнопки, которая при значении 0 показывает цветовой квадрат
	local function addRadioWithColor(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a, btnValue)
		local info = {}
		info.text = name
		info.keepShownOnClick = true
		info.notCheckable = false
		info.isNotRadio = false
		info.value = btnValue
		info.checked = function(btn)
			return variableTbl[variableKey] == btnValue
		end
		info.func = function(btn, _, _, checked)
			variableTbl[variableKey] = btnValue
			providerfunc()
			subself:ddRefresh(sublvl)
			DropDown:ddRefresh(level)
		end
		-- Цветовой квадрат для CUSTOM (btnValue == 0)
		if btnValue == 0 and variableKey_r and variableKey_g and variableKey_b then
			local oldR = variableTbl[variableKey_r]
			local oldG = variableTbl[variableKey_g]
			local oldB = variableTbl[variableKey_b]
			local oldA = variableKey_a and variableTbl[variableKey_a]
			local hasAlpha = variableKey_a ~= nil
			local function Refresh()
				providerfunc()
				subself:ddRefresh(sublvl)
				DropDown:ddRefresh(level)
			end
			local function ApplyColor()
				local r, g, b = ColorPickerFrame:GetColorRGB()
				variableTbl[variableKey_r] = r
				variableTbl[variableKey_g] = g
				variableTbl[variableKey_b] = b
				if hasAlpha then variableTbl[variableKey_a] = ColorPickerFrame:GetColorAlpha() end
				Refresh()
			end
			info.hasColorSwatch = true
			info.r = oldR
			info.g = oldG
			info.b = oldB
			info.hasOpacity = hasAlpha
			info.opacity = oldA
			info.swatchFunc = ApplyColor
			if hasAlpha then info.opacityFunc = ApplyColor end
			info.cancelFunc = function()
				variableTbl[variableKey_r] = oldR
				variableTbl[variableKey_g] = oldG
				variableTbl[variableKey_b] = oldB
				if hasAlpha then variableTbl[variableKey_a] = oldA end
				Refresh()
			end
		end
		-- Виджет сброса
		if type(defaultTbl) == "table" then
			info.widgets = {{
					icon = "talents-button-undo",
					width = 16, height = 16,
					OnClick = function()
						-- сброс основного ключа
						variableTbl[variableKey] = defaultTbl[variableKey]
						-- сброс цветовых ключей, если они есть
						if variableKey_r then variableTbl[variableKey_r] = defaultTbl[variableKey_r] end
						if variableKey_g then variableTbl[variableKey_g] = defaultTbl[variableKey_g] end
						if variableKey_b then variableTbl[variableKey_b] = defaultTbl[variableKey_b] end
						if variableKey_a then variableTbl[variableKey_a] = defaultTbl[variableKey_a] end
						providerfunc()
						E.func_UpdateGlobals()
						DropDown:ddReopenAllMenus(1, sublvl)
					end,
					OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["Reset to default"] or "Reset to default") end,
			}}
		end
		subself:ddAddButton(info, sublvl)
	end
	-- Слайдер
	local function addSlider_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, minValue, maxValue, step, variable) -- variable больше не нужен, но оставим для обратной совместимости
		local slider = E.SLIDER_CHACHE[variableKey]
		if not slider then
			slider = CreateFrame("FRAME", nil, subself, "OctoSliderFrameTemplate")
			E.SLIDER_CHACHE[variableKey] = slider
		end
		slider:setText(name)
		slider:setMinMax(minValue, maxValue)
		slider:setStep(step)
		local currentValue = variableTbl[variableKey] or (defaultTbl and defaultTbl[variableKey]) or minValue
		slider:setValue(currentValue)
		slider:setOnChanged(function(sldr, value)
				local newValue = math.floor(value / step + 0.5) * step
				if newValue ~= (variableTbl[variableKey] or minValue) then  -- сравниваем с актуальным значением в таблице
					variableTbl[variableKey] = newValue
					E.sound_OnClick()
					providerfunc()
					E.func_UpdateFont()
					subself:ddRefresh(sublvl)
				end
		end)
		local info = {}
		info.customFrame = slider
		info.fixedWidth = true
		info.notCheckable = true
		if type(defaultTbl) == "table" then
			info.widgets = {{
					icon = "talents-button-undo",
					width = 16, height = 16,
					OnClick = function()
						local dialogName = "OCTO_RESET_ADDON_" .. variableKey
						StaticPopupDialogs[dialogName] = {
							text = L["Are you sure you want to reset to default?"] or "Reset to default?",
							button1 = YES, button2 = NO,
							OnAccept = function()
								variableTbl[variableKey] = defaultTbl[variableKey]
								providerfunc()
								E.func_UpdateGlobals()
								subself:ddRefresh(sublvl)
							end,
							timeout = 0,
							whileDead = true,
							hideOnEscape = true,
							preferredIndex = 3,
						}
						StaticPopup_Show(dialogName)
						subself:ddCloseMenus()
					end,
					OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["Reset to default"] or "Reset to default") end,
			}}
		end
		subself:ddAddButton(info, sublvl)
	end
	-- Выпадающий список
	local function addDropdown_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, values)
		local info = {}
		info.text = name
		-- info.fontObject = GameTooltipText
		info.hasArrowUp = true
		info.keepShownOnClick = true
		info.notCheckable = true
		info.value = function(subself, sublvl)
			local list = {}
			for _, v in ipairs(values) do
				local subInfo = {}
				subInfo.text = v.text
				-- subInfo.fontObject = GameTooltipText
				if variableKey == "Config_FontStyle" then
					subInfo.font = v.path
				end
				subInfo.keepShownOnClick = true
				subInfo.notCheckable = false
				subInfo.isNotRadio = false
				subInfo.value = v.value
				subInfo.checked = function()
					return variableTbl[variableKey] == v.value
				end
				subInfo.func = function()
					variableTbl[variableKey] = v.value
					E.sound_OnClick()
					providerfunc()
					E.func_UpdateFont()
					subself:ddRefresh(sublvl)
				end
				table_insert(list, subInfo)
			end
			subself:ddAddButton({ list = list, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS }, sublvl)
		end
		local hasDefault = type(defaultTbl) == "table"
		if hasDefault then
			info.widgets = {{
					icon = "talents-button-undo",
					width = 16,
					height = 16,
					OnClick = function()
						variableTbl[variableKey] = defaultTbl[variableKey]
						providerfunc()
						E.func_UpdateGlobals()
						subself:ddRefresh(sublvl)
						DropDown:ddReopenAllMenus(1, sublvl)
					end,
					-- OnClick = function()
					--     local dialogName = "OCTO_RESET_ADDON_" .. variableKey
					--     StaticPopupDialogs[dialogName] = {
					--         text = L["Are you sure you want to reset to default?"] or "Reset to default?",
					--         button1 = YES, button2 = NO,
					--         OnAccept = function()
					--             variableTbl[variableKey] = defaultTbl[variableKey]
					--             providerfunc()
					--             E.func_UpdateGlobals()
					--             subself:ddRefresh(sublvl)
					--         end,
					--         timeout = 0,
					--         whileDead = true,
					--         hideOnEscape = true,
					--         preferredIndex = 3,
					--     }
					--     StaticPopup_Show(dialogName)
					--     subself:ddCloseMenus()
					-- end,
					OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["Reset to default"] or "Reset to default") end,
			}}
		end
		subself:ddAddButton(info, sublvl)
	end
	----------------------------------------------------------------
	return function(self, lvl)
		----------------------------------------------------------------
		-- L["MAIN"] ---------------------------------------------------
		----------------------------------------------------------------
		do
			local list = {}
			list.text =  L["PRIMARY"]
			-- list.fontObject = GameTooltipText
			list.hasArrowUp = true
			list.keepShownOnClick = true
			list.notCheckable = true
			list.value = function(subself, sublvl)
				----------------------------------------------------------------
				-- L["Font"] ---------------------------------------------------
				----------------------------------------------------------------
				do
					local fontValues = {}
					for _, fontName in ipairs(LibSharedMedia:List("font")) do
						local path = LibSharedMedia:Fetch("font", fontName)
						if path then
							table_insert(fontValues, {value = fontName, text = fontName, path = path})
						end
					end
					local name = L["Font"]
					local variableKey = "Config_FontStyle"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT().FontOption[E.curLocaleLang]
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE.FontOption[E.curLocaleLang]
					local values = fontValues
					addDropdown_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, values)
				end
				----------------------------------------------------------------
				-- Font Size
				----------------------------------------------------------------
				do
					local name = L["FONT_SIZE"]
					local variable = E.func_GenerateID() -- UNIQUE ID
					local variableKey = "Config_FontSize"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT().FontOption[E.curLocaleLang]
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE.FontOption[E.curLocaleLang]
					local tooltip = nil
					local minValue = 8
					local maxValue = 32
					local step = 1
					addSlider_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, minValue, maxValue, step, variable)
				end
				----------------------------------------------------------------
				-- Font Flags
				----------------------------------------------------------------
				do
					local name = L["Font Outline"]
					local variableKey = "Config_FontFlags"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT().FontOption[E.curLocaleLang]
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE.FontOption[E.curLocaleLang]
					local values = {
						{value = "", text = NPC_NAMES_DROPDOWN_NONE},
						{value = "MONOCHROME", text = "MONOCHROME"},
						{value = "OUTLINE", text = "OUTLINE"},
						{value = "THICKOUTLINE", text = "THICKOUTLINE"},
						{value = "MONOCHROME, OUTLINE", text = "MONOCHROME, OUTLINE"},
						{value = "MONOCHROME, THICKOUTLINE", text = "MONOCHROME, THICKOUTLINE"},
					}
					addDropdown_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, values)
				end
				----------------------------------------------------------------
				-- SEPARATOR
				----------------------------------------------------------------
				do
					subself:ddAddSeparator(sublvl)
				end
				----------------------------------------------------------------
				-- Number Format
				----------------------------------------------------------------
				do
					local name = L["Number Format"]
					local variableKey = "Config_numberFormatMode"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local values = {
						{value = 1, text = L["Universal"]},
						{value = 2, text = L["Localized"]},
						{value = 3, text = L["With separators"]},
						{value = 4, text = L["Full"]},
						{value = 5, text = "Blizzard"},
						{value = 6, text = L["Clean"]},
					}
					addDropdown_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, values)
				end
				----------------------------------------------------------------
				-- Line Height
				----------------------------------------------------------------
				do
					local name = E.COLOR_RED .. ">|r" .. L["Line Height"] .. E.COLOR_RED .. "<|r"
					local variable = E.func_GenerateID() -- UNIQUE ID
					local variableKey = "Config_ADDON_HEIGHT"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local minValue = 10
					local maxValue = 40
					local step = 1
					addSlider_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, minValue, maxValue, step, variable)
				end
				----------------------------------------------------------------
				-- Clamped To Screen
				----------------------------------------------------------------
				do
					local name = L["Clamped To Screen"]
					local variableKey = "Config_ClampedToScreen"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Save Position
				----------------------------------------------------------------
				do
					local name = L["Save Position"]
					local variableKey = "CONFIG_SAVE_POSITION"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- SEPARATOR
				----------------------------------------------------------------
				do
					subself:ddAddSeparator(sublvl)
				end
				----------------------------------------------------------------
				-- Show on hover
				----------------------------------------------------------------
				do
					local name = L["Show on hover"]
					local variableKey = "CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = L["Show frame automatically when mouse is over the minimap button"]
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Hide Delay
				----------------------------------------------------------------
				do
					local name = L["Hide Delay (sec.)"]
					local variable = E.func_GenerateID() -- UNIQUE ID
					local variableKey = "CONFIG_HOVER_SHOW_DURATION"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local minValue = 0
					local maxValue = 10
					if E.DEBUG then maxValue = 100 end
					local step = 1
					addSlider_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, minValue, maxValue, step, variable)
				end
				----------------------------------------------------------------
				-- Alpha on hover
				----------------------------------------------------------------
				do
					local name = L["Alpha"] .. " %"
					local variable = E.func_GenerateID() -- UNIQUE ID
					local variableKey = "CONFIG_FRAME_ALPHA_ON_HOVER"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local minValue = 50
					local maxValue = 100
					local step = 1
					addSlider_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, minValue, maxValue, step, variable)
				end
				----------------------------------------------------------------
			end
			self:ddAddButton(list, lvl)
		end
		----------------------------------------------------------------
		-- L["CURRENCY"] -----------------------------------------------
		----------------------------------------------------------------
		do
			local list = {}
			list.text = L["CURRENCY"]
			-- list.fontObject = GameTooltipText
			list.hasArrowUp = true
			list.keepShownOnClick = true
			list.notCheckable = true
			list.value = function(subself, sublvl)
				----------------------------------------------------------------
				-- Иконки ------------------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["Icons"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Иконка -------------------------------------------------------
				----------------------------------------------------------------
				do
					local name = E.func_texturefromIcon(E.func_GetIcon("currency", 1166)) .. L["Icon"]
					local variableKey = "CONFIG_CURRENCY_ICON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Иконка отряда -----------------------------------------------
				----------------------------------------------------------------
				do
					local name = E.func_texturefromIcon(E.ATLAS_ACCOUNT_WIDE) .. L["Warband icon"]
					local variableKey = "CONFIG_CURRENCY_WARBAND_ICON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Цвета -------------------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["COLORS"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Цвет по качеству --------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Color by quality"]
					local variableKey = "CONFIG_CURRENCY_COLOREDNAME"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Другое ------------------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["OTHER"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Прогресс (в скобках) -------------------------------- ЦВЕТ --
				----------------------------------------------------------------
				do
					local name = L["Show progress (in parentheses)"]
					local variableKey = "CONFIG_CURRENCY_SHOW_BRACKETS"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = L["Shows earned amount in () if currency has weekly/seasonal cap"]
					local variableKey_r = "CONFIG_CURRENCY_COLOR_BRACKETS_R"
					local variableKey_g = "CONFIG_CURRENCY_COLOR_BRACKETS_G"
					local variableKey_b = "CONFIG_CURRENCY_COLOR_BRACKETS_B"
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Доступный лимит ------------------------------------- ЦВЕТ --
				----------------------------------------------------------------
				do
					local name = L["Show earnable amount"]
					local variableKey = "CONFIG_CURRENCY_SHOW_REMAINING"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = L["Shows remaining amount if currency has weekly/seasonal cap"]
					local variableKey_r = "CONFIG_CURRENCY_COLOR_REMAINING_R"
					local variableKey_g = "CONFIG_CURRENCY_COLOR_REMAINING_G"
					local variableKey_b = "CONFIG_CURRENCY_COLOR_REMAINING_B"
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Тултип ------------------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["Tooltip"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Средства передвижения* --------------------------------------
				----------------------------------------------------------------
				do
					local name = L["ACCESSIBILITY_MOUNT_LABEL"] .. E.COLOR_RED .. "*|r"
					local variableKey = "Config_MountsInTooltip"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
			end
			self:ddAddButton(list, lvl)
		end
		----------------------------------------------------------------
		-- L["ITEMS"] -----------------------------------------------
		----------------------------------------------------------------
		do
			local list = {}
			list.text = L["ITEMS"]
			-- list.fontObject = GameTooltipText
			list.hasArrowUp = true
			list.keepShownOnClick = true
			list.notCheckable = true
			list.value = function(subself, sublvl)
				----------------------------------------------------------------
				-- HEADER - Иконки ---------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["Icons"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Иконка -------------------------------------------------------
				----------------------------------------------------------------
				do
					local name = E.func_texturefromIcon(E.func_GetIcon("item", 36942)) .. L["Icon"]
					local variableKey = "CONFIG_ITEMS_ICON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- HEADER - Цвета ----------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["COLORS"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Цвет по качеству --------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Color by quality"]
					local variableKey = "CONFIG_ITEMS_COLOREDNAME"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
			end
			self:ddAddButton(list, lvl)
		end
		----------------------------------------------------------------
		-- L["REPUTATION"] -----------------------------------------------
		----------------------------------------------------------------
		do
			local list = {}
			list.text = L["REPUTATION"]
			-- list.fontObject = GameTooltipText
			list.hasArrowUp = true
			list.keepShownOnClick = true
			list.notCheckable = true
			list.value = function(subself, sublvl)
				----------------------------------------------------------------
				-- HEADER - Иконки ---------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["Icons"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Иконка ------------------------------------------------------
				----------------------------------------------------------------
				do
					local name = E.func_texturefromIcon(E.func_GetIcon("item", 36942)) .. L["Icon"]
					local variableKey = "CONFIG_REPUTATION_ICON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Доп. Иконка -------------------------------------------------
				----------------------------------------------------------------
				do
					local name = E.func_texturefromIcon("MajorFactions_Icons_Valdrakken512")..L["Extra icon"]
					local variableKey = "CONFIG_REPUTATION_EXTRA_ICON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Иконка фракции ---------------------------------------------
				----------------------------------------------------------------
				do
					local name = E.func_texturefromIcon(E.ICON_CURRENT_FACTION)..L["Faction icon"]
					local variableKey = "CONFIG_REPUTATION_FACTION_ICON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Иконка отряда -----------------------------------------------
				----------------------------------------------------------------
				do
					local name = E.func_texturefromIcon(E.ATLAS_ACCOUNT_WIDE) .. L["Warband icon"]
					local variableKey = "CONFIG_REPUTATION_WARBAND_ICON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- HEADER - PARAGON --------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["PARAGON"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Значение ----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Value"]
					local variableKey = "CONFIG_REPUTATION_VALUE_PARAGON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Процент -----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Percentage"]
					local variableKey = "CONFIG_REPUTATION_PERCENTAGE_PARAGON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Реакция -----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Reaction"]
					local variableKey = "CONFIG_REPUTATION_REACTION_PARAGON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Репутация ---------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Standings"]
					local variableKey = "CONFIG_REPUTATION_STANDINGS_PARAGON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Цвет PARAGON (чистый цвет) ----------------------------------
				----------------------------------------------------------------
				do
					local name = L["COLOR"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_PARAGON_COLOR_R"
					local variableKey_g = "CONFIG_REPUTATION_PARAGON_COLOR_G"
					local variableKey_b = "CONFIG_REPUTATION_PARAGON_COLOR_B"
					local variableKey_a = "CONFIG_REPUTATION_PARAGON_COLOR_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- HEADER - MAJOR/RENOWN ---------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["MAJOR"] .. "/" .. L["RENOWN"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Значение ----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Value"]
					local variableKey = "CONFIG_REPUTATION_VALUE_MAJOR"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Процент -----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Percentage"]
					local variableKey = "CONFIG_REPUTATION_PERCENTAGE_MAJOR"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Реакция -----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Reaction"]
					local variableKey = "CONFIG_REPUTATION_REACTION_MAJOR"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Репутация ---------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Standings"]
					local variableKey = "CONFIG_REPUTATION_STANDINGS_MAJOR"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Цвет MAJOR (чистый цвет) ------------------------------------
				----------------------------------------------------------------
				do
					local name = L["COLOR"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_MAJOR_COLOR_R"
					local variableKey_g = "CONFIG_REPUTATION_MAJOR_COLOR_G"
					local variableKey_b = "CONFIG_REPUTATION_MAJOR_COLOR_B"
					local variableKey_a = "CONFIG_REPUTATION_MAJOR_COLOR_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- HEADER - FRIEND ---------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["FRIEND"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Значение ----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Value"]
					local variableKey = "CONFIG_REPUTATION_VALUE_FRIEND"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Процент -----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Percentage"]
					local variableKey = "CONFIG_REPUTATION_PERCENTAGE_FRIEND"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Реакция -----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Reaction"]
					local variableKey = "CONFIG_REPUTATION_REACTION_FRIEND"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Репутация ---------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Standings"]
					local variableKey = "CONFIG_REPUTATION_STANDINGS_FRIEND"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Цвет FRIEND (чистый цвет) -----------------------------------
				----------------------------------------------------------------
				do
					local name = L["COLOR"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_FRIEND_COLOR_R"
					local variableKey_g = "CONFIG_REPUTATION_FRIEND_COLOR_G"
					local variableKey_b = "CONFIG_REPUTATION_FRIEND_COLOR_B"
					local variableKey_a = "CONFIG_REPUTATION_FRIEND_COLOR_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- HEADER - SIMPLE ---------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["SIMPLE"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Значение ----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Value"]
					local variableKey = "CONFIG_REPUTATION_VALUE_SIMPLE"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Процент -----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Percentage"]
					local variableKey = "CONFIG_REPUTATION_PERCENTAGE_SIMPLE"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Реакция -----------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Reaction"]
					local variableKey = "CONFIG_REPUTATION_REACTION_SIMPLE"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Репутация ---------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Standings"]
					local variableKey = "CONFIG_REPUTATION_STANDINGS_SIMPLE"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Цвета Simple (8 штук, чистый цвет) --------------------------
				----------------------------------------------------------------
				do
					local name = L["FACTION_STANDING_LABEL8"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_SIMPLE_COLOR_8_R"
					local variableKey_g = "CONFIG_REPUTATION_SIMPLE_COLOR_8_G"
					local variableKey_b = "CONFIG_REPUTATION_SIMPLE_COLOR_8_B"
					local variableKey_a = "CONFIG_REPUTATION_SIMPLE_COLOR_8_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				do
					local name = L["FACTION_STANDING_LABEL7"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_SIMPLE_COLOR_7_R"
					local variableKey_g = "CONFIG_REPUTATION_SIMPLE_COLOR_7_G"
					local variableKey_b = "CONFIG_REPUTATION_SIMPLE_COLOR_7_B"
					local variableKey_a = "CONFIG_REPUTATION_SIMPLE_COLOR_7_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				do
					local name = L["FACTION_STANDING_LABEL6"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_SIMPLE_COLOR_6_R"
					local variableKey_g = "CONFIG_REPUTATION_SIMPLE_COLOR_6_G"
					local variableKey_b = "CONFIG_REPUTATION_SIMPLE_COLOR_6_B"
					local variableKey_a = "CONFIG_REPUTATION_SIMPLE_COLOR_6_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				do
					local name = L["FACTION_STANDING_LABEL5"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_SIMPLE_COLOR_5_R"
					local variableKey_g = "CONFIG_REPUTATION_SIMPLE_COLOR_5_G"
					local variableKey_b = "CONFIG_REPUTATION_SIMPLE_COLOR_5_B"
					local variableKey_a = "CONFIG_REPUTATION_SIMPLE_COLOR_5_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				do
					local name = L["FACTION_STANDING_LABEL4"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_SIMPLE_COLOR_4_R"
					local variableKey_g = "CONFIG_REPUTATION_SIMPLE_COLOR_4_G"
					local variableKey_b = "CONFIG_REPUTATION_SIMPLE_COLOR_4_B"
					local variableKey_a = "CONFIG_REPUTATION_SIMPLE_COLOR_4_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				do
					local name = L["FACTION_STANDING_LABEL3"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_SIMPLE_COLOR_3_R"
					local variableKey_g = "CONFIG_REPUTATION_SIMPLE_COLOR_3_G"
					local variableKey_b = "CONFIG_REPUTATION_SIMPLE_COLOR_3_B"
					local variableKey_a = "CONFIG_REPUTATION_SIMPLE_COLOR_3_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				do
					local name = L["FACTION_STANDING_LABEL2"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_SIMPLE_COLOR_2_R"
					local variableKey_g = "CONFIG_REPUTATION_SIMPLE_COLOR_2_G"
					local variableKey_b = "CONFIG_REPUTATION_SIMPLE_COLOR_2_B"
					local variableKey_a = "CONFIG_REPUTATION_SIMPLE_COLOR_2_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				do
					local name = L["FACTION_STANDING_LABEL1"]
					local variableKey = nil
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = "CONFIG_REPUTATION_SIMPLE_COLOR_1_R"
					local variableKey_g = "CONFIG_REPUTATION_SIMPLE_COLOR_1_G"
					local variableKey_b = "CONFIG_REPUTATION_SIMPLE_COLOR_1_B"
					local variableKey_a = "CONFIG_REPUTATION_SIMPLE_COLOR_1_A"
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
			end
			self:ddAddButton(list, lvl)
		end
		----------------------------------------------------------------
		-- L["RAIDS"] -------------------------------------------------
		----------------------------------------------------------------
		do
			local list = {}
			list.text = L["RAIDS"]
			-- list.fontObject = GameTooltipText
			list.hasArrowUp = true
			list.keepShownOnClick = true
			list.notCheckable = true
			list.value = function(subself, sublvl)
				----------------------------------------------------------------
				-- HEADER - Иконки ---------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["Icons"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Иконка рейда ------------------------------------------------
				----------------------------------------------------------------
				do
					local name = E.func_texturefromIcon(E.ICON_FIRSTRAID) .. L["Icon"]
					local variableKey = "CONFIG_RAIDS_ICON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Доп. иконка рейда -------------------------------------------
				----------------------------------------------------------------
				do
					local name = E.func_texturefromIcon(E.ATLAS_RAID) .. L["Extra icon"]
					local variableKey = "CONFIG_RAIDS_EXTRA_ICON"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = nil
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- HEADER - Тултип ---------------------------------------------
				----------------------------------------------------------------
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.notCheckable = true
					info.isTitle = true
					info.text = E.COLOR_GRAY .. L["Tooltip"] .. "|r"
					subself:ddAddButton(info, sublvl)
				end
				----------------------------------------------------------------
				-- Все сложности -----------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["All Difficulties"]
					local variableKey = "CONFIG_RAIDS_DIFFICULTIES_ALL"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = L["Shows all raid difficulties in the tooltip"]
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
				-- Аббревиатуры ------------------------------------------------
				----------------------------------------------------------------
				do
					local name = L["Abbreviation"]
					local variableKey = "CONFIG_RAIDS_DIFFICULTIES_ABBREVIATIONS"
					local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
					local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
					local tooltip = L["Use English abbreviations for raid and dungeon difficulties instead of full names"]
					local variableKey_r = nil
					local variableKey_g = nil
					local variableKey_b = nil
					local variableKey_a = nil
					addToggleButton_NEW(subself, sublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
				end
				----------------------------------------------------------------
			end
			self:ddAddButton(list, lvl)
		end
		----------------------------------------------------------------
		-- L["COLORS"] -------------------------------------------------
		----------------------------------------------------------------
		do
			self:ddAddButton({
					text = L["COLORS"],
					-- fontObject = GameTooltipText,
					hasArrowUp = true,
					keepShownOnClick = true,
					notCheckable = true,
					value = function(subself, sublvl)
						----------------------------------------------------------------
						-- "Основной цвет" ---------------------------------------------
						----------------------------------------------------------------
						do
							local list = {}
							list.text = L["Main Frame Color"]
							-- list.fontObject = GameTooltipText
							list.hasArrowUp = true
							list.keepShownOnClick = true
							list.notCheckable = true
							list.value = function(subsubself, subsublvl)
								----------------------------------------------------------------
								-- Main Frame Color
								----------------------------------------------------------------
								do
									local name = L["Main Frame Color"]
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_MAIN_MainFrame_r"
									local variableKey_g = "ConfigColor_MAIN_MainFrame_g"
									local variableKey_b = "ConfigColor_MAIN_MainFrame_b"
									local variableKey_a = "ConfigColor_MAIN_MainFrame_a"
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
								-- Tooltip Color
								----------------------------------------------------------------
								do
									local name = L["Tooltip Color"]
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_TOOLTIP_TooltipFrame_r"
									local variableKey_g = "ConfigColor_TOOLTIP_TooltipFrame_g"
									local variableKey_b = "ConfigColor_TOOLTIP_TooltipFrame_b"
									local variableKey_a = "ConfigColor_TOOLTIP_TooltipFrame_a"
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
								-- Border Color
								----------------------------------------------------------------
								do
									local name = L["Border Color"]
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_MAIN_Border_r"
									local variableKey_g = "ConfigColor_MAIN_Border_g"
									local variableKey_b = "ConfigColor_MAIN_Border_b"
									local variableKey_a = "ConfigColor_MAIN_Border_a"
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
							end
							subself:ddAddButton(list, sublvl)
						end
						----------------------------------------------------------------
						-- "Заголовок" -------------------------------------------------
						----------------------------------------------------------------
						do
							local list = {}
							list.text = L["Header Color"]
							-- list.fontObject = GameTooltipText
							list.hasArrowUp = true
							list.keepShownOnClick = true
							list.notCheckable = true
							list.value = function(subsubself, subsublvl)
								----------------------------------------------------------------
								-- CUSTOM
								----------------------------------------------------------------
								do
									local name = L["CUSTOM"]
									local variableKey = "ConfigColor_CharHeader_TYPE"
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_CharHeader_r"
									local variableKey_g = "ConfigColor_CharHeader_g"
									local variableKey_b = "ConfigColor_CharHeader_b"
									local variableKey_a = "ConfigColor_CharHeader_a"
									local btnValue = 0
									addRadioWithColor(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a, btnValue)
								end
								----------------------------------------------------------------
								-- By Faction
								----------------------------------------------------------------
								do
									addToggleButtonClosureSIMPLE(subsubself, subsublvl, L["By Faction"], E.func_GetProfile_SETTINGS_CURRENT(), "ConfigColor_CharHeader_TYPE", 1, E.DEFAULT_SETTINGS_FORPROFILE)
								end
								----------------------------------------------------------------
								-- By Class
								----------------------------------------------------------------
								do
									addToggleButtonClosureSIMPLE(subsubself, subsublvl, L["By Class"], E.func_GetProfile_SETTINGS_CURRENT(), "ConfigColor_CharHeader_TYPE", 2, E.DEFAULT_SETTINGS_FORPROFILE)
								end
								----------------------------------------------------------------
								-- SLIDER
								----------------------------------------------------------------
								do
									-- /dump E.func_GetProfile_SETTINGS_CURRENT().ConfigColor_CharHeader_a
									local name = L["Alpha"] .. " %"
									local variable = E.func_GenerateID() -- UNIQUE ID
									local variableKey = "ConfigColor_CharHeader_a"
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local minValue = 0
									local maxValue = 1
									local step = .1
									addSlider_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, minValue, maxValue, step, variable)
								end
								----------------------------------------------------------------
							end
							subself:ddAddButton(list, sublvl)
						end
						----------------------------------------------------------------
						-- "Цвет подсветки персонажа" ----------------------------------
						----------------------------------------------------------------
						do
							local list = {}
							list.text = L["Character Highlight Color"]
							-- list.fontObject = GameTooltipText
							list.hasArrowUp = true
							list.keepShownOnClick = true
							list.notCheckable = true
							list.value = function(subsubself, subsublvl)
								----------------------------------------------------------------
								-- CUSTOM
								----------------------------------------------------------------
								do
									local name = L["CUSTOM"]
									local variableKey = "ConfigColor_CharLines_TYPE"
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_CharLines_r"
									local variableKey_g = "ConfigColor_CharLines_g"
									local variableKey_b = "ConfigColor_CharLines_b"
									local variableKey_a = "ConfigColor_CharLines_a"
									local btnValue = 0
									addRadioWithColor(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a, btnValue)
								end
								----------------------------------------------------------------
								-- By Faction
								----------------------------------------------------------------
								do
									addToggleButtonClosureSIMPLE(subsubself, subsublvl, L["By Faction"], E.func_GetProfile_SETTINGS_CURRENT(), "ConfigColor_CharLines_TYPE", 1, E.DEFAULT_SETTINGS_FORPROFILE)
								end
								----------------------------------------------------------------
								-- By Class
								----------------------------------------------------------------
								do
									addToggleButtonClosureSIMPLE(subsubself, subsublvl, L["By Class"], E.func_GetProfile_SETTINGS_CURRENT(), "ConfigColor_CharLines_TYPE", 2, E.DEFAULT_SETTINGS_FORPROFILE)
								end
								----------------------------------------------------------------
								-- SLIDER
								----------------------------------------------------------------
								do
									-- /dump E.func_GetProfile_SETTINGS_CURRENT().ConfigColor_CharLines_a
									local name = L["Alpha"] .. " %"
									local variable = E.func_GenerateID() -- UNIQUE ID
									local variableKey = "ConfigColor_CharLines_a"
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local minValue = 0
									local maxValue = 1
									local step = .1
									addSlider_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, minValue, maxValue, step, variable)
									-- local info = {}
									-- info.text = function()
									--     local a = E.func_GetProfile_SETTINGS_CURRENT()["ConfigColor_CharLines_a"] or 0.2
									--     return L["CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL"] .. ": " .. string.format("%.2f", a)
									-- end
									-- -- info.fontObject = GameTooltipText
									-- info.disabled = true
									-- info.notCheckable = true
									-- info.keepShownOnClick = true
									-- subsubself:ddAddButton(info, subsublvl)
								end
								----------------------------------------------------------------
							end
							subself:ddAddButton(list, sublvl)
						end
						----------------------------------------------------------------
						-- "Цвет подсветки строки" -------------------------------------
						----------------------------------------------------------------
						do
							local list = {}
							list.text = L["Row Highlight Color"]
							-- list.fontObject = GameTooltipText
							list.hasArrowUp = true
							list.keepShownOnClick = true
							list.notCheckable = true
							list.value = function(subsubself, subsublvl)
								----------------------------------------------------------------
								-- CUSTOM
								----------------------------------------------------------------
								do
									local name = L["CUSTOM"]
									local variableKey = "ConfigColor_Highlight_TYPE"
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_Highlight_r"
									local variableKey_g = "ConfigColor_Highlight_g"
									local variableKey_b = "ConfigColor_Highlight_b"
									local variableKey_a = "ConfigColor_Highlight_a"
									local btnValue = 0
									addRadioWithColor(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a, btnValue)
								end
								----------------------------------------------------------------
								-- By Faction
								----------------------------------------------------------------
								do
									addToggleButtonClosureSIMPLE(subsubself, subsublvl, L["By Faction"], E.func_GetProfile_SETTINGS_CURRENT(), "ConfigColor_Highlight_TYPE", 1, E.DEFAULT_SETTINGS_FORPROFILE)
								end
								----------------------------------------------------------------
								-- By Class
								----------------------------------------------------------------
								do
									addToggleButtonClosureSIMPLE(subsubself, subsublvl, L["By Class"], E.func_GetProfile_SETTINGS_CURRENT(), "ConfigColor_Highlight_TYPE", 2, E.DEFAULT_SETTINGS_FORPROFILE)
								end
								----------------------------------------------------------------
								-- SLIDER
								----------------------------------------------------------------
								do
									-- /dump E.func_GetProfile_SETTINGS_CURRENT().ConfigColor_Highlight_a
									local name = L["Alpha"] .. " %"
									local variable = E.func_GenerateID() -- UNIQUE ID
									local variableKey = "ConfigColor_Highlight_a"
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local minValue = 0
									local maxValue = 1
									local step = .1
									addSlider_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, minValue, maxValue, step, variable)
									-- local info = {}
									-- info.text = function()
									--     local a = E.func_GetProfile_SETTINGS_CURRENT()["ConfigColor_Highlight_a"] or 0.2
									--     return L["CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL"] .. ": " .. string.format("%.2f", a)
									-- end
									-- -- info.fontObject = GameTooltipText
									-- info.disabled = true
									-- info.notCheckable = true
									-- info.keepShownOnClick = true
									-- subsubself:ddAddButton(info, subsublvl)
								end
								----------------------------------------------------------------
								-- SEPARATOR
								----------------------------------------------------------------
								do
									subsubself:ddAddSeparator(subsublvl)
								end
								----------------------------------------------------------------
								-- Smooth Animation
								----------------------------------------------------------------
								do
									local name = L["Smooth Animation"]
									local variableKey = "ConfigColor_ENABLE_HIGHLIGHT_ANIMATION"
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = nil
									local variableKey_g = nil
									local variableKey_b = nil
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
							end
							subself:ddAddButton(list, sublvl)
						end
						----------------------------------------------------------------
						-- "Чередование цветов" ----------------------------------------
						----------------------------------------------------------------
						do
							local list = {}
							list.text = L["Alternating Colors"]
							-- list.fontObject = GameTooltipText
							list.hasArrowUp = true
							list.keepShownOnClick = true
							list.notCheckable = true
							list.value = function(subsubself, subsublvl)
								local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
								local values = {}
								for _, v in ipairs(E.ZEBRA_MODE) do
									table_insert(values, {
											text = v.text,
											-- fontObject = GameTooltipText,
											keepShownOnClick = true,
											notCheckable = false,
											isNotRadio = false,
											value = v.value,
											checked = function() return settingsProfile["CONFIG_ZEBRA_MODE"] == v.value end,
											func = function(btn)
												settingsProfile["CONFIG_ZEBRA_MODE"] = btn.value
												providerfunc()
												subsubself:ddRefresh(subsublvl)
												DropDown:ddRefresh(level)
											end,
									})
								end
								subsubself:ddAddButton({ list = values, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS }, subsublvl)
								----------------------------------------------------------------
								-- COLOR
								----------------------------------------------------------------
								do
									local name = L["COLOR"]
									local variableKey = nil
									local variableTbl = settingsProfile
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_ZEBRA_RGBA_r"
									local variableKey_g = "ConfigColor_ZEBRA_RGBA_g"
									local variableKey_b = "ConfigColor_ZEBRA_RGBA_b"
									local variableKey_a = "ConfigColor_ZEBRA_RGBA_a"
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
							end
							subself:ddAddButton(list, sublvl)
						end
						----------------------------------------------------------------
						-- "Градиент" --------------------------------------------------
						----------------------------------------------------------------
						do
							local list = {}
							list.text = L["Gradient"]
							-- list.fontObject = GameTooltipText
							list.hasArrowUp = true
							list.keepShownOnClick = true
							list.notCheckable = true
							list.value = function(subsubself, subsublvl)
								----------------------------------------------------------------
								-- Gradient toggle
								----------------------------------------------------------------
								do
									local name = L["Gradient"]
									local variableKey = "ConfigColor_TOOLTIP_usegradient"
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = nil
									local variableKey_g = nil
									local variableKey_b = nil
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
								-- max
								----------------------------------------------------------------
								do
									local name = "max"
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_TOOLTIP_max_RGBA_r"
									local variableKey_g = "ConfigColor_TOOLTIP_max_RGBA_g"
									local variableKey_b = "ConfigColor_TOOLTIP_max_RGBA_b"
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
								-- mid
								----------------------------------------------------------------
								do
									local name = "mid"
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_TOOLTIP_mid_RGBA_r"
									local variableKey_g = "ConfigColor_TOOLTIP_mid_RGBA_g"
									local variableKey_b = "ConfigColor_TOOLTIP_mid_RGBA_b"
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
								-- min
								----------------------------------------------------------------
								do
									local name = "min"
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_TOOLTIP_min_RGBA_r"
									local variableKey_g = "ConfigColor_TOOLTIP_min_RGBA_g"
									local variableKey_b = "ConfigColor_TOOLTIP_min_RGBA_b"
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
							end
							subself:ddAddButton(list, sublvl)
						end
						----------------------------------------------------------------
						-- "Фракция" ---------------------------------------------------
						----------------------------------------------------------------
						do
							local list = {}
							list.text = FACTION
							-- list.fontObject = GameTooltipText
							list.hasArrowUp = true
							list.keepShownOnClick = true
							list.notCheckable = true
							list.value = function(subsubself, subsublvl)
								----------------------------------------------------------------
								-- HORDE
								----------------------------------------------------------------
								do
									local name = L["FACTION_HORDE"]
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_faction_Horde_r"
									local variableKey_g = "ConfigColor_faction_Horde_g"
									local variableKey_b = "ConfigColor_faction_Horde_b"
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
								-- ALLIANCE
								----------------------------------------------------------------
								do
									local name = L["FACTION_ALLIANCE"]
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_faction_Alliance_r"
									local variableKey_g = "ConfigColor_faction_Alliance_g"
									local variableKey_b = "ConfigColor_faction_Alliance_b"
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
								-- NEUTRAL
								----------------------------------------------------------------
								do
									local name = L["FACTION_NEUTRAL"]
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_faction_Neutral_r"
									local variableKey_g = "ConfigColor_faction_Neutral_g"
									local variableKey_b = "ConfigColor_faction_Neutral_b"
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
							end
							subself:ddAddButton(list, sublvl)
						end
						----------------------------------------------------------------
						-- "Обитель ковенанта" -----------------------------------------
						----------------------------------------------------------------
						do
							local list = {}
							list.text = L["GARRISON_TYPE_9_0_LANDING_PAGE_TITLE"]
							-- list.fontObject = GameTooltipText
							list.hasArrowUp = true
							list.keepShownOnClick = true
							list.notCheckable = true
							list.value = function(subsubself, subsublvl)
								----------------------------------------------------------------
								-- KYRIAN
								----------------------------------------------------------------
								do
									local name = E.func_GetName("covenant", 1)
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_KYRIAN_r"
									local variableKey_g = "ConfigColor_KYRIAN_g"
									local variableKey_b = "ConfigColor_KYRIAN_b"
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
								-- VENTHYR
								----------------------------------------------------------------
								do
									local name = E.func_GetName("covenant", 2)
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_VENTHYR_r"
									local variableKey_g = "ConfigColor_VENTHYR_g"
									local variableKey_b = "ConfigColor_VENTHYR_b"
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
								-- NIGHTFAE
								----------------------------------------------------------------
								do
									local name = E.func_GetName("covenant", 3)
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_NIGHTFAE_r"
									local variableKey_g = "ConfigColor_NIGHTFAE_g"
									local variableKey_b = "ConfigColor_NIGHTFAE_b"
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
								-- NECROLORD
								----------------------------------------------------------------
								do
									local name = E.func_GetName("covenant", 4)
									local variableKey = nil
									local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
									local defaultTbl = E.DEFAULT_SETTINGS_FORPROFILE
									local tooltip = nil
									local variableKey_r = "ConfigColor_NECROLORD_r"
									local variableKey_g = "ConfigColor_NECROLORD_g"
									local variableKey_b = "ConfigColor_NECROLORD_b"
									local variableKey_a = nil
									addToggleButton_NEW(subsubself, subsublvl, variableKey, variableTbl, name, defaultTbl, tooltip, variableKey_r, variableKey_g, variableKey_b, variableKey_a)
								end
								----------------------------------------------------------------
							end
							subself:ddAddButton(list, sublvl)
						end
						----------------------------------------------------------------
					end,
			}, lvl)
		end
		----------------------------------------------------------------
		-- SEPARATOR ---------------------------------------------------
		----------------------------------------------------------------
		do
			self:ddAddSeparator(lvl)
		end
		----------------------------------------------------------------
		-- L["Profiles"] -----------------------------------------------
		----------------------------------------------------------------
		do
			self:ddAddButton({
					text = L["Profiles"],
					-- fontObject = GameTooltipText,
					hasArrowUp = true,
					keepShownOnClick = true,
					notCheckable = true,
					value = function(subself, sublvl)
						local sublist = {}
						local profileNames = {}
						for name in next, (profilesALL) do
							table_insert(profileNames, name)
						end
						E.func_SortRecords(profileNames)
						for _, profileName in ipairs(profileNames) do
							local info = {}
							info.text = (profileName == E.TEXT_ENG_DEFAULT) and L["DEFAULT"] or profileName
							-- info.fontObject = GameTooltipText
							info.keepShownOnClick = true
							info.notCheckable = false
							info.isNotRadio = false
							info.value = profileName
							info.checked = function()
								return db.CURRENT == profileName
							end
							info.func = function(menuButton)
								db.CURRENT = menuButton.value
								E.func_UpdateGlobalNSforProfiles()
								E.sound_OnClick()
								if providerfunc then providerfunc() end
								for i = level, level+3 do DropDown:ddRefresh(i) end
							end
							if profileName ~= E.TEXT_ENG_DEFAULT then
								info.widgets = {
									{
										icon = "Interface/BUTTONS/UI-GroupLoot-Pass-Up",
										width = 16, height = 16,
										OnClick = function()
											local function do_remove()
												profilesALL[profileName] = nil
												if db.CURRENT == profileName then
													db.CURRENT = E.TEXT_ENG_DEFAULT
												end
												if providerfunc then providerfunc() end
												E.func_PrintMessage(L["Profile successfully deleted"])
											end
											StaticPopupDialogs["OCTO_DELETE_PROFILE_CONFIRM"] = {
												text = string.format(L["Delete profile '%s'?"], profileName),
												button1 = L["DELETE"], button2 = L["CANCEL"],
												OnAccept = do_remove, timeout = 0,
												whileDead = true, hideOnEscape = true, preferredIndex = 3,
											}
											StaticPopup_Show("OCTO_DELETE_PROFILE_CONFIRM")
											subself:ddCloseMenus()
										end,
										OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["DELETE"], nil, nil, nil, true) end,
									},
									{
										icon = "Interface\\WorldMap\\GEAR_64GREY",
										width = 16,
										height = 16,
										OnClick = function()
											StaticPopupDialogs["OCTO_RENAME_PROFILE_INLINE"] = {
												text = string.format(L["Enter new name for profile '%s':"], profileName),
												button1 = L["Rename"], button2 = L["CANCEL"],
												hasEditBox = true, editBoxWidth = 260, maxLetters = 30,
												OnAccept = function(dialog)
													local newName = dialog.EditBox:GetText():trim()
													if newName and newName ~= "" and newName ~= profileName then
														if profilesALL[newName] then
															E.func_PrintMessage(L["A profile with the same name exists"])
															return
														end
														profilesALL[newName] = profilesALL[profileName]
														profilesALL[profileName] = nil
														if db.CURRENT == profileName then
															db.CURRENT = newName
														end
														if providerfunc then providerfunc() end
														E.func_PrintMessage(L["Profile successfully renamed"])
													end
												end,
												OnShow = function(dialog)
													dialog.EditBox:SetText(profileName)
													dialog.EditBox:SetFocus()
													dialog.EditBox:HighlightText()
												end,
												EditBoxOnEnterPressed = function(editBox)
													local dialog = editBox:GetParent()
													local newName = editBox:GetText():trim()
													if newName and newName ~= "" and newName ~= profileName then
														if profilesALL[newName] then
															E.func_PrintMessage(L["A profile with the same name exists"])
															return
														end
														profilesALL[newName] = profilesALL[profileName]
														profilesALL[profileName] = nil
														if db.CURRENT == profileName then
															db.CURRENT = newName
														end
														dialog:Hide()
														if providerfunc then providerfunc() end
														E.func_PrintMessage(L["Profile successfully renamed"])
													end
												end,
												timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
											}
											StaticPopup_Show("OCTO_RENAME_PROFILE_INLINE")
											subself:ddCloseMenus()
										end,
										OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["Rename"], nil, nil, nil, true) end,
									},
								}
							else
								info.widgets = {
									{
										icon = "talents-button-undo", width = 16, height = 16,
										OnClick = function()
											profilesALL[E.TEXT_ENG_DEFAULT] = nil
											E.func_CreateProfile("SETTINGS", E.TEXT_ENG_DEFAULT)
											if providerfunc then providerfunc() end
											E.func_UpdateGlobals()
											E.func_PrintMessage(L["Profile reset to default"])
											-- subself:ddCloseMenus()
											for i = lvl, lvl + 3 do DropDown:ddRefresh(i) end
											-- DropDown:ddReopenMenu(sublvl)
											DropDown:ddReopenAllMenus(1, sublvl)
										end,
										OnTooltipShow = function(btn, tooltip) tooltip:AddLine(L["RESET"], nil, nil, nil, true) end,
									},
								}
							end
							table_insert(sublist, info)
						end
						local function createNewProfile(copyFromCurrent)
							StaticPopupDialogs["OCTO_CREATE_PROFILE"] = {
								text = copyFromCurrent and L["Enter a name for the new profile|n(will be copied from the current one)"] or L["Enter a name for the new profile"],
								button1 = L["NEW"], button2 = L["CANCEL"],
								hasEditBox = true, editBoxWidth = 260, maxLetters = 30,
								OnAccept = function(dialog)
									local pName = dialog.EditBox:GetText():trim()
									if pName and pName ~= "" then
										if profilesALL[pName] then
											E.func_PrintMessage(L["A profile with the same name exists"])
											return
										end
										if copyFromCurrent and db.CURRENT then
											local src = profilesALL[db.CURRENT]
											profilesALL[pName] = src and E.func_CopyTableDeep(src) or {}
										else
											E.func_CreateProfile("SETTINGS", pName)
										end
										db.CURRENT = pName
										if providerfunc then providerfunc() end
										E.func_PrintMessage(L["Profile successfully created"])
									end
								end,
								OnShow = function(dialog) dialog.EditBox:SetText(""); dialog.EditBox:SetFocus() end,
								EditBoxOnEnterPressed = function(editBox)
									local dialog = editBox:GetParent()
									local pName = editBox:GetText():trim()
									if pName and pName ~= "" then
										if profilesALL[pName] then
											E.func_PrintMessage(L["A profile with the same name exists"])
											return
										end
										if copyFromCurrent and db.CURRENT then
											local src = profilesALL[db.CURRENT]
											profilesALL[pName] = src and E.func_CopyTableDeep(src) or {}
										else
											E.func_CreateProfile("SETTINGS", pName)
										end
										db.CURRENT = pName
										dialog:Hide()
										if providerfunc then providerfunc() end
										E.func_PrintMessage(L["Profile successfully created"])
									end
								end,
								timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
							}
							StaticPopup_Show("OCTO_CREATE_PROFILE")
							subself:ddCloseMenus()
						end
						subself:ddAddButton({ list = sublist, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS }, sublvl)
						----------------------------------------------------------------
						-- SEPARATOR
						----------------------------------------------------------------
						do
							subself:ddAddSeparator(sublvl)
						end
						----------------------------------------------------------------
						-- NEW
						----------------------------------------------------------------
						do
							local info = {}
							info.text = L["NEW"]
							-- info.fontObject = GameTooltipText
							info.keepShownOnClick = false
							info.notCheckable = true
							info.func = function() createNewProfile(false) end
							subself:ddAddButton(info, sublvl)
						end
						----------------------------------------------------------------
						-- Copy current
						----------------------------------------------------------------
						do
							local info = {}
							info.text = L["Copy current"]
							-- info.fontObject = GameTooltipText
							info.keepShownOnClick = true
							info.notCheckable = true
							info.disabled = not db.CURRENT or not profilesALL[db.CURRENT]
							info.func = function() createNewProfile(true) end
							subself:ddAddButton(info, sublvl)
						end
						----------------------------------------------------------------
					end,
			}, lvl)
		end
		----------------------------------------------------------------
	end
end
----------------------------------------------------------------
-- Основная функция меню ToDo ----------------------------------
----------------------------------------------------------------
function E.func_Create_DDframe_ToDo(frame, providerfunc, buttonName)
	if type(frame) == "string" then
		frame = E[frame]
	end
	local customName = "func_Create_DDframe_ToDo"
	local DropDown = E.func_CreateBaseDropDown(frame, buttonName, customName)
	DropDown:ddSetInitFunc(function(self, level, value)
			if not value then
				-- строим пункты корневого меню
				local list = {}
				local CountCharacters = E.func_CountCharacters()
				----------------------------------------------------------------
				----------------------------------------------------------------
				----------------------------------------------------------------
				do
					if CountCharacters > 1 then
						table_insert(list, {
								text = classColorHexCurrent .. L["Characters"] .. "|r",
								-- fontObject = GameTooltipText,
								hasArrowUp = true,
								keepShownOnClick = true,
								notCheckable = true,
								value = E.build_characters_menu(providerfunc, self, level + 1)
						})
					end
				end
				----------------------------------------------------------------
				----------------------------------------------------------------
				----------------------------------------------------------------
				do
					table_insert(list, {
							text = L["EXPANSION_FILTER_TEXT"],
							-- fontObject = GameTooltipText,
							hasArrowUp = true,
							keepShownOnClick = true,
							notCheckable = true,
							value = E.build_expansion_menu(providerfunc, self, level + 1)
					})
				end
				----------------------------------------------------------------
				----------------------------------------------------------------
				----------------------------------------------------------------
				do
					table_insert(list, {
							text = L["OTHER"], --  addonNAME or GlobalAddonName,
							-- fontObject = GameTooltipText,
							hasArrowUp = true,
							keepShownOnClick = true,
							notCheckable = true,
							value = E.build_color_profiles_menu(E.func_UpdateGlobals, self, level + 1)
					})
				end
				----------------------------------------------------------------
				----------------------------------------------------------------
				----------------------------------------------------------------
				do
					self:ddAddButton({list = list, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS}, level)
				end
				----------------------------------------------------------------
				----------------------------------------------------------------
				----------------------------------------------------------------
			else
				if type(value) == "function" then
					value(self, level)  -- функция добавляет скролл и фиксированные кнопки
				else
					local info = {list = value, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS}
					self:ddAddButton(info, level)
				end
			end
	end)
	return DropDown
end
----------------------------------------------------------------
-- Меню Achievements -------------------------------------------
----------------------------------------------------------------
function E.func_Create_DDframe_Achievements(frame, providerfunc, buttonName)
	local DropDown = E.func_CreateBaseDropDown(frame, buttonName)
	local function selectFunctionAchievementToShow(menuButton, _, arg2, checked)
		Octo_Achievements_DB.Config_Achievements.AchievementToShow[menuButton.value] = checked or nil
		if arg2 == 2 then
			DropDown:ddRefresh(arg2-1)
		end
		E.sound_OnClick()
		providerfunc()
	end
	local function TEST_FUNC(menuButton, arg1)
		local categories = GetCategoryList()
		local cID = menuButton.value
		for i = 1, #categories do
			local categoryID = categories[i]
			local _, parentCategoryID = GetCategoryInfo(categoryID)
			if arg1 and cID == parentCategoryID and Octo_Achievements_DB.Config_Achievements.AchievementToShow[categoryID] then
				return E.func_Gradient(arg1.name) .. arg1.output
			end
		end
		return arg1.name .. arg1.output
	end
	DropDown:ddSetInitFunc(function(self, level, value)
			local list = {}
			local categories = GetCategoryList()
			for i = 1, #categories do
				local info = {}
				-- info.fontObject = GameTooltipText
				local categoryID = categories[i]
				local name, parentCategoryID = GetCategoryInfo(categoryID)
				local total, completed = GetCategoryNumAchievements(categoryID, true)
				local output = " (" .. completed .. "/" .. total .. ")"
				if total == completed then
					output = " " .. E.DONE
				else
					if completed == 0 then
						output = E.COLOR_RED .. output .. "|r"
					else
						output = E.COLOR_YELLOW .. output .. "|r"
					end
				end
				if parentCategoryID == value or parentCategoryID == -1 and not value then
					info.hasArrowUp = parentCategoryID == -1 and categoryID ~= 92
					info.keepShownOnClick = true
					info.notCheckable = false
					info.isNotRadio = true
					if parentCategoryID == -1 then
						info.text = TEST_FUNC
					else
						info.text = name .. output
					end
					info.arg1 = {name = name, output = output}
					info.arg2 = level
					info.value = categoryID
					info.checked = Octo_Achievements_DB.Config_Achievements.AchievementToShow[categoryID]
					info.func = selectFunctionAchievementToShow
					tinsert(list, info)
				end
			end
			self:ddAddButton({list = list, listMaxSize = E.LIST_MAX_SIZE}, level)
			if level == 1 then
				self:ddAddSeparator(level)
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.keepShownOnClick = true
					info.notCheckable = false
					info.isNotRadio = true
					info.text = L["COMBAT_LOG_MENU_EVERYTHING"]
					info.hasArrowUp = nil
					info.checked = Octo_Achievements_DB.CONFIG_ACHIEVEMENT_SHOW_COMPLETED
					info.func = function(_, _, _, checked)
						Octo_Achievements_DB.CONFIG_ACHIEVEMENT_SHOW_COMPLETED = checked
						E.sound_OnClick()
						providerfunc()
					end
					self:ddAddButton(info, level)
				end
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.text = L["RESET"]
					info.keepShownOnClick = false
					info.notCheckable = true
					info.func = function(_, _, _, checked)
						Octo_Achievements_DB.Config_Achievements.AchievementToShow = {[92] = true}
						E.sound_OnClick()
						providerfunc()
					end
					self:ddAddButton(info, level)
				end
			end
	end)
	return DropDown
end
----------------------------------------------------------------
-- Меню QuestsChanged ------------------------------------------
----------------------------------------------------------------
function E.func_Create_DDframe_QuestsChanged(frame, providerfunc, buttonName)
	local DropDown = E.func_CreateBaseDropDown(frame, buttonName)
	DropDown:ddSetInitFunc(function(self, level, value)
			if level == 1 then
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.keepShownOnClick = true
					info.notCheckable = false
					info.isNotRadio = true
					info.text = L["QC_Quests"]
					info.checked = E.func_GetProfile_SETTINGS_CURRENT().QC_Quests
					info.func = function(_, _, _, checked)
						E.func_GetProfile_SETTINGS_CURRENT().QC_Quests = checked
						E.sound_OnClick()
						providerfunc()
					end
					self:ddAddButton(info, level)
				end
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.keepShownOnClick = true
					info.notCheckable = false
					info.isNotRadio = true
					info.text = L["QC_Vignettes"]
					info.checked = E.func_GetProfile_SETTINGS_CURRENT().QC_Vignettes
					info.func = function(_, _, _, checked)
						E.func_GetProfile_SETTINGS_CURRENT().QC_Vignettes = checked
						E.sound_OnClick()
						providerfunc()
					end
					self:ddAddButton(info, level)
				end
				self:ddAddSeparator(level)
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.keepShownOnClick = false
					info.notCheckable = true
					info.text = L["wipe QC_Quests"]
					info.func = function(_, _, _, checked)
						wipe(Octo_QuestsChanged_DB.QC_Quests)
						E.sound_OnClick()
						providerfunc()
					end
					self:ddAddButton(info, level)
				end
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.keepShownOnClick = false
					info.notCheckable = true
					info.text = L["wipe QC_Vignettes"]
					info.func = function(_, _, _, checked)
						wipe(Octo_QuestsChanged_DB.QC_Vignettes)
						E.sound_OnClick()
						providerfunc()
					end
					self:ddAddButton(info, level)
				end
			end
	end)
	return DropDown
end
----------------------------------------------------------------
-- Меню editFrame ----------------------------------------------
----------------------------------------------------------------
function E.func_Create_DDframe_editFrame(frame, providerfunc, buttonName)
	local DropDown = E.func_CreateBaseDropDown(frame, buttonName)
	local editBox = E.editBox:GetEditBox()
	local handlerCache = setmetatable({}, { __mode = "kv" })
	local function makeThemeHandler(themeName)
		return function(btn)
			Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_EDITORTHEME = themeName
			LibIndentation.enable(editBox, E.func_createColorScheme(themeName or "Twilight"), Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_TABSPACES)
			editBox:SetText(editBox:GetText():trim())
			LibIndentation.indentEditbox(editBox)
			DropDown:ddRefresh(1)
		end
	end
	local function makeTabSizeHandler(tabSize)
		return function(btn)
			Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_TABSPACES = tabSize
			LibIndentation.enable(editBox, E.func_createColorScheme(Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_EDITORTHEME or "Twilight"), tabSize)
			editBox:SetText(editBox:GetText():trim())
			LibIndentation.indentEditbox(editBox)
			DropDown:ddRefresh(2)
		end
	end
	local function makeFontSizeHandler(fontSize)
		return function(btn)
			Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_FONTSIZE = fontSize
			editBox:SetFont(E.Octo_font, fontSize, "")
			DropDown:ddRefresh(2)
		end
	end
	DropDown:ddSetInitFunc(function(dd, level, value)
			if level == 1 then
				for name in next, E.editorThemes do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.keepShownOnClick = true
					local cacheKey = "theme_" .. name
					if not handlerCache[cacheKey] then
						handlerCache[cacheKey] = makeThemeHandler(name)
					end
					info.text = name
					info.value = name
					info.checked = function(btn)
						return Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_EDITORTHEME == name
					end
					info.func = handlerCache[cacheKey]
					dd:ddAddButton(info, level)
				end
				dd:ddAddSeparator(level)
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.keepShownOnClick = true
					info.notCheckable = true
					info.hasArrowUp = true
					info.text = L["Tab Size"]
					info.value = "tab"
					dd:ddAddButton(info, level)
				end
				do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.keepShownOnClick = true
					info.notCheckable = true
					info.hasArrowUp = true
					info.text = L["FONT_SIZE"]
					info.value = "font"
					dd:ddAddButton(info, level)
				end
			elseif value == "tab" then
				for _, v in ipairs({0, 2, 3, 4}) do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.keepShownOnClick = true
					local cacheKey = "tab_" .. v
					if not handlerCache[cacheKey] then
						handlerCache[cacheKey] = makeTabSizeHandler(v)
					end
					info.text = v
					info.value = v
					info.checked = function(btn)
						return btn.value == Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_TABSPACES
					end
					info.func = handlerCache[cacheKey]
					dd:ddAddButton(info, level)
				end
			elseif value == "font" then
				for i = 10, 16 do
					local info = {}
					-- info.fontObject = GameTooltipText
					info.keepShownOnClick = true
					local cacheKey = "font_" .. i
					if not handlerCache[cacheKey] then
						handlerCache[cacheKey] = makeFontSizeHandler(i)
					end
					info.text = i
					info.value = i
					info.checked = function(btn)
						return btn.value == Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_FONTSIZE
					end
					info.func = handlerCache[cacheKey]
					dd:ddAddButton(info, level)
				end
			end
	end)
	return DropDown
end
----------------------------------------------------------------
-- Меню в опциях слева
----------------------------------------------------------------
local function func_GetAvailableOptions_LEFT()
	local _, _, _, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
	local sort_order = CharacterProfile_SORTING and CharacterProfile_SORTING.sort_order
	if not sort_order then
		return
	end
	local uses = {}
	for _, key in ipairs(sort_order) do
		uses[key] = uses[key] or true
	end
	local available = {}
	for vars, opt in next, (E.SORT_OPTIONS) do
		if not uses[vars] then
			table_insert(available, {vars = vars, displayName = opt.name})
		end
	end
	E.func_SortRecords(available, {"displayName"})
	return available
end
function E.func_Create_DDframe_Options_LEFT(frame, providerfunc, buttonName)
	local DropDown = E.func_CreateBaseDropDown(frame, L["ADD"])
	DropDown:ddSetInitFunc(function(self, level, value)
			local menu = LibSFDropDown:GetMenu(level)
			if menu then
				menu.numButtons = 0
				menu.height = 0
				menu.width = 0
				wipe(menu.searchFrames)
			end
			local available = func_GetAvailableOptions_LEFT()
			if #available == 0 then
				local info = {
					text = E.NONE,
					notCheckable = true,
					disabled = true,
					-- fontObject = GameTooltipText,
				}
				self:ddAddButton(info, level)
			else
				local buttonList = {}
				for _, opt in ipairs(available) do
					table_insert(buttonList, {
							text = opt.displayName,
							value = opt.vars,
							func = function()
								local _, _, _, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
								if not CharacterProfile_SORTING then return end
								table_insert(CharacterProfile_SORTING.sort_order, opt.vars)
								CharacterProfile_SORTING.sort_order_ACTIVED[opt.vars] = true
								E.func_CreateDataProvider_SORTUI()
							end,
							notCheckable = true,
							-- fontObject = GameTooltipText,
					})
				end
				self:ddAddButton({ list = buttonList, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS})
			end
	end)
	return DropDown
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Create_DDframe_Options_RIGHT(frame, providerfunc, buttonName)
	local DropDown = E.func_CreateBaseDropDown(frame, buttonName)
	DropDown:ddSetInitFunc(function(self, level, value)
			if not value then
				value = E.build_characters_menu(providerfunc, DropDown, level)
			end
			if type(value) == "function" then
				value(self, level)   -- функция сама добавит список и кнопки
			else
				local info = {list = value, listMaxSize = E.LIST_MAX_SIZE, autoFocus = E.AUTO_FOCUS}
				self:ddAddButton(info, level)
			end
	end)
	return DropDown
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------