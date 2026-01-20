local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local AceGUI = LibStub("AceGUI-3.0")
local function createMyQEWEQ()
	local Type, Version = "OctoMediaFont", 1
	local function constructor()
		local button = LibSFDropDown:CreateMediaFontModernButton(nil)
		button:ddSetMinMenuWidth(nil)
		local widget = {
			-- alignoffset = 30,
			frame = button,
			type = Type,
			value = nil,
			events = {},
			Fire = function(self, event, ...)
				if self.events[event] then
					for _, callback in ipairs(self.events[event]) do
						callback(self, event, ...)
					end
				end
			end,
		}
		button:ddSetOnSelectedFunc(function(value)
				button:ddSetSelectedValue(value)
				widget:Fire("OnEnterPressed", value)
		end)
		local methods = {
			["OnAcquire"] = function(self)
			end,
			["OnRelease"] = function(self)
				self.frame:ClearAllPoints()
				self.frame:Hide()
			end,
			["SetCallback"] = function(self, callbackName, func)
				if callbackName == "OnEnterPressed" then
					-- Регистрируем callback для события
					if not self.events[callbackName] then
						self.events[callbackName] = {}
					end
					table.insert(self.events[callbackName], func)
				end
			end,
			["SetLabel"] = function(self, text)
				-- if self.frame.SetLabel then
				--     self.frame:SetLabel(text)
				-- end
			end,
			["SetText"] = function(self, text)
				if self.frame.SetText then
					self.frame:SetText(text)
				end
				if self.frame.ddSetSelectedValue then
					self.frame:ddSetSelectedValue(text)
				end
			end,
			["Show"] = function(self)
				if self.frame.Show then
					self.frame:Show()
				end
			end,
			["Hide"] = function(self)
				self.frame:Hide()
			end,
		}
		for method, func in pairs(methods) do
			widget[method] = func
		end
		return AceGUI:RegisterAsWidget(widget)
	end
	AceGUI:RegisterWidgetType(Type, constructor, Version)
end
-------------------------------------------------------------------------
function E.func_Options_MAIN(name)
	createMyQEWEQ()
	local width = E.FOURTH_WIDTH
	local Options = {
		type = "group",
		childGroups = "tab",
		name = name,
		args = {
			-------------------------------------------------
			-- Вкладка: Основные настройки
			-------------------------------------------------
			[E.func_AutoKey()] = E.func_01_General(width, GENERAL_LABEL),
			-------------------------------------------------
			-- Вкладка: Цвета
			-------------------------------------------------
			[E.func_AutoKey()] = E.func_02_Colors(width, COLORS_LABEL),
			-------------------------------------------------
			-- Вкладка: Подсказки
			-------------------------------------------------
			-- [E.func_AutoKey()] = E.func_03_Tooltip(width, L["Tooltip"]),  -- HUD_EDIT_MODE_HUD_TOOLTIP_LABEL
			-------------------------------------------------
			-- Вкладка: Отображение персонажей
			-------------------------------------------------
			-- [E.func_AutoKey()] = E.func_04_Characters(width, L["Characters"]),  -- "Фильтр персонажей", -- L["Character Display Settings"]
			-------------------------------------------------
			-- Вкладка: Другое
			-------------------------------------------------
			-- [E.func_AutoKey()] = E.func_05_Other(width, E.COLOR_GRAY..OTHER.."|r"),
		},
	}
	-- Автоматическое добавление NotifyChange ко всем опциям
	local function addAutoNotify(tbl)
		for _, option in pairs(tbl) do
			if type(option) == "table" then
				-- Если есть set функция, оборачиваем её
				if option.set then
					local originalSet = option.set
					option.set = function(...)
						local result = originalSet(...)
						AceConfigRegistry:NotifyChange(GlobalAddonName)
						return result
					end
				end
				-- Рекурсивно для вложенных таблиц
				if option.args then
					addAutoNotify(option.args)
				end
			end
		end
	end
	-- Применяем ко всем опциям
	addAutoNotify(Options.args)
	-------------------------------------------------
	return Options
end