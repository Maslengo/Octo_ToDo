local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
-------------------------------------------------------------------------
function E.func_Options_Achievements(name, savedVars)
	local Achievements = {
		type = "group",
		childGroups = "tab",
		name = name,
		args = {
			-------------------------------------------------
			-- Вкладка: Основные настройки
			-------------------------------------------------
			mainTab = {
				type = "group",
				name = "Настройки",
				order = E.func_GetOrder(),
				args = {
					Config_AchievementShowCompleted = {
						type = "toggle",
						name = "Config_AchievementShowCompleted",
						get = function()
							return Octo_ToDo_DB_Vars.Config_AchievementShowCompleted
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Config_AchievementShowCompleted = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
				}
			},

			-------------------------------------------------
			-- Вкладка: Тестовые элементы
			-------------------------------------------------
			testTab = {
				type = "group",
				name = "Тесты",
				order = E.func_GetOrder(),
				args = {
					["Header1"] = {
						type = "header",
						name = "Типы полей",
						order = E.func_GetOrder(),
					},

					-- Текст (статический)
					testDescription = {
						type = "description",
						name = "Это описательный текст\nМожет быть многострочным",
						fontSize = "medium",
						order = E.func_GetOrder(),
					},

					-- Выпадающий список
					testSelect = {
						type = "select",
						name = "Выберите из списка",
						values = {
							OPTION1 = "Опция 1",
							OPTION2 = "Опция 2",
							OPTION3 = "Опция 3"
						},
						get = function()
							return savedVars.testSelect or "OPTION1"
						end,
						set = function(_, value)
							savedVars.testSelect = value
						end,
						style = "dropdown",
						order = E.func_GetOrder(),
					},

					-- Кнопка с подтверждением
					testDangerButton = {
						type = "execute",
						name = "Опасная кнопка",
						confirm = true,
						confirmText = "Вы уверены?",
						func = function()
							print("Кнопка нажата!")
						end,
						order = E.func_GetOrder(),
					},

					["Header2"] = {
						type = "header",
						name = "Интерактивные элементы",
						order = E.func_GetOrder(),
					},

					-- Слайдер
					testSlider = {
						type = "range",
						name = "Слайдер",
						min = 0,
						max = 100,
						step = 1,
						isPercent = true,
						get = function()
							return savedVars.testSlider or 50
						end,
						set = function(_, value)
							savedVars.testSlider = value
						end,
						order = E.func_GetOrder(),
					},

					-- Поле ввода
					testInput = {
						type = "input",
						name = "Текстовое поле",
						get = function()
							return savedVars.testInput or ""
						end,
						set = function(_, value)
							savedVars.testInput = value
						end,
						width = "full",
						order = E.func_GetOrder(),
					},

					-- Ключбиндинг
					testKeybinding = {
						type = "keybinding",
						name = "Привязка клавиши",
						get = function()
							return savedVars.testKeybinding or ""
						end,
						set = function(_, value)
							savedVars.testKeybinding = value
						end,
						order = E.func_GetOrder(),
					},

					["Header3"] = {
						type = "header",
						name = "Группировка",
						order = E.func_GetOrder(),
					},

					-- Инлайн группа
					testInlineGroup = {
						type = "group",
						name = "Инлайн группа",
						inline = true,
						order = E.func_GetOrder(),
						args = {
							inlineOption1 = {
								type = "toggle",
								name = "Опция 1",
								get = function()
									return savedVars.inlineOption1 or false
								end,
								set = function(_, value)
									savedVars.inlineOption1 = value
								end,
								order = E.func_GetOrder(),
							},
							inlineOption2 = {
								type = "toggle",
								name = "Опция 2",
								get = function()
									return savedVars.inlineOption2 or false
								end,
								set = function(_, value)
									savedVars.inlineOption2 = value
								end,
								order = E.func_GetOrder(),
							},
						}
					},

					["Header4"] = {
						type = "header",
						name = "Динамические значения",
						order = E.func_GetOrder(),
					},

					-- Динамические значения
					testDynamicValues = {
						type = "select",
						name = "Список фракций",
						values = function()
							local factions = {
								[1] = "Альянс",
								[2] = "Орда",
								[3] = "Нейтральные"
							}
							return factions
						end,
						get = function()
							return savedVars.testFaction or 1
						end,
						set = function(_, value)
							savedVars.testFaction = value
						end,
						disabled = function()
							return UnitInBattleground("player") -- отключать на поле боя
						end,
						order = E.func_GetOrder(),
					},

					["Header5"] = {
						type = "header",
						name = "Кастомизация",
						order = E.func_GetOrder(),
					},

					-- Цветные названия
					testColoredOption = {
						type = "toggle",
						name = "|cff00ff00Зеленая|r опция",
						get = function()
							return savedVars.coloredOption or false
						end,
						set = function(_, value)
							savedVars.coloredOption = value
						end,
						descStyle = "inline",
						width = 1.5,
						order = E.func_GetOrder(),
					},

					-- Опция с иконкой
					testIconOption = {
						type = "toggle",
						name = CreateAtlasMarkup("QuestNormal").." С иконкой",
						get = function()
							return savedVars.iconOption or false
						end,
						set = function(_, value)
							savedVars.iconOption = value
						end,
						order = E.func_GetOrder(),
					},

					["Header6"] = {
						type = "header",
						name = "Зависимые опции",
						order = E.func_GetOrder(),
					},

					-- Мастер-переключатель
					testMasterToggle = {
						type = "toggle",
						name = "Включить подопции",
						get = function()
							return savedVars.masterEnabled or false
						end,
						set = function(_, value)
							savedVars.masterEnabled = value
						end,
						order = E.func_GetOrder(),
					},

					-- Зависимая опция
					testDependentOption = {
						type = "toggle",
						name = "Зависимая опция",
						get = function()
							return savedVars.dependentOption or false
						end,
						set = function(_, value)
							savedVars.dependentOption = value
						end,
						disabled = function()
							return not (savedVars.masterEnabled or false)
						end,
						order = E.func_GetOrder(),
					},

					["Header7"] = {
						type = "header",
						name = "Валидация",
						order = E.func_GetOrder(),
					},

					-- Валидируемое поле
					testValidatedInput = {
						type = "input",
						name = "Только цифры",
						get = function()
							return savedVars.validatedInput or ""
						end,
						set = function(_, value)
							savedVars.validatedInput = value
						end,
						validate = function(_, value)
							if value == "" then return true end
							return tonumber(value) and true or "Введите число"
						end,
						order = E.func_GetOrder(),
					},

					["Header8"] = {
						type = "header",
						name = "Кастомный виджет",
						order = E.func_GetOrder(),
					},

					-- Кастомная кнопка
					testCustomWidget = {
						type = "execute",
						name = "Открыть тестовое окно",
						func = function()
							-- Создание тестового окна
							local frame = CreateFrame("Frame", "OctoTestFrame", UIParent, "OctoBackdropTemplate")
							frame:SetSize(300, 200)
							frame:SetPoint("CENTER")

							local text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
							text:SetPoint("CENTER")
							text:SetText("Тестовое окно")

							local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
							closeButton:SetPoint("TOPRIGHT", -5, -5)
							closeButton:SetScript("OnClick", function()
								frame:Hide()
							end)

							frame:Show()
						end,
						order = E.func_GetOrder(),
					},
				}
			},

			-------------------------------------------------
			-- Вкладка: LibSharedMedia
			-------------------------------------------------
			mediaTab = {
				type = "group",
				name = "Медиа",
				order = E.func_GetOrder(),
				args = {
					["Header1"] = {
						type = "header",
						name = "Шрифты и текстуры",
						order = E.func_GetOrder(),
					},

					-- Тестовый выбор шрифта (если LSM загружен)
					testFontSelect = {
						type = "select",
						name = "Шрифт",
						values = function()
							if LibSharedMedia then
								return LibSharedMedia:HashTable("font")
							end
							return { ["Interface\\AddOns\\"..GlobalAddonName.."\\Media\\font.ttf"] = "Дефолтный" }
						end,
						dialogControl = "LSM30_Font",
						get = function()
							return savedVars.testFont or "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\font.ttf"
						end,
						set = function(_, value)
							savedVars.testFont = value
						end,
						order = E.func_GetOrder(),
					},

					-- Тестовый выбор текстуры
					testTextureSelect = {
						type = "select",
						name = "Текстура",
						values = function()
							if LibSharedMedia then
								return LibSharedMedia:HashTable("statusbar")
							end
							return { ["Interface\\TargetingFrame\\UI-StatusBar"] = "Дефолтная" }
						end,
						dialogControl = "LSM30_Statusbar",
						get = function()
							return savedVars.testTexture or "Interface\\TargetingFrame\\UI-StatusBar"
						end,
						set = function(_, value)
							savedVars.testTexture = value
						end,
						order = E.func_GetOrder(),
					},
				}
			},
		}
	}

	return Achievements
end