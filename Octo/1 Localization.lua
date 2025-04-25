local AL3 = LibStub("AceLocale-3.0")
local debug = false
local L = AL3:NewLocale("Octo", "enUS", true, debug)

if L then
	-- General terms
	L["Only Horde"] = true
	L["Only Alliance"] = true
	L["Other"] = true
	L["General"] = true
	L["Total"] = true
	L["About"] = true
	L["Characters"] = true
	L["Turn on"] = true
	L["Turn off"] = true
	L["No quests"] = true
	L["Parts"] = true
	L["Races"] = true
	L["Gift"] = true
	L["Gifts"] = true
	L["Rares"] = true
	L["Portals"] = true
	L["Level"] = true
	L["Head"] = true
	L["Maw"] = true
	L["Bank"] = true
	L["Bags"] = true
	L["Feet"] = true
	L["Legs"] = true
	L["Back"] = true
	L["Chest"] = true
	L["Waist"] = true
	L["Hands"] = true
	L["Wrist"] = true
	L["PvP"] = true
	L["Abandon"] = true

	-- Addon settings
	L["AddonHeight"] = true
	L["AddonLeftFrameWeight"] = true
	L["AddonCentralFrameWeight"] = true
	L["MainFrameDefaultLines"] = true
	L["MaxNumCharacters"] = true
	L["SFDropDownWeight"] = true
	L["fullName"] = true
	L["showIcons"] = true
	L["showIconsQuestionMark"] = true
	L["showVersion"] = true
	L["showIndex"] = true
	L["Width: "] = true
	L["Item level: "] = true

	-- Debug/technical terms
	L["minimaphide"] = true
	L["hookMenuButton"] = true
	L["sortingCpu"] = true
	L["cpuShowCurrent"] = true
	L["cpuShowEncounter"] = true
	L["profilingcpuShowPeak"] = true
	L["profilingcpuShowAverage"] = true
	L["profilingcpuUpdate"] = true
	L["localizeCategoryName"] = true
	L["autofocusSearch"] = true
	L["showSecureAddons"] = true
	L["showTocXCategory"] = true
	L["showTocCategory"] = true
	L["showMemoryInBrokerTtp"] = true
	L["isCategoryFrameVisible"] = true
	L["InDev"] = true

	-- Time formats
	L["time_YEAR"] = "y"
	L["time_DAY"] = "d"
	L["time_HOUR"] = "h"
	L["time_MINUTE"] = "m"
	L["time_SECOND"] = "s"
	L["y. "] = true
	L["d. "] = true
	L["h. "] = true
	L["m. "] = true
	L["s. "] = true

	-- Quests/activities
	L["Abandon All Quests"] = true
	L["Abandon: "] = true
	L["Battle Pet"] = true
	L["Bind Location"] = true
	L["Coins"] = true
	L["Community Feast"] = true
	L["Current Location"] = true
	L["Expire on"] = true
	L["Fyrakk Asssaults"] = true
	L["Grand Hunt"] = true
	L["Keys of Loyalty"] = true
	L["Korthia"] = true
	L["Kyrian"] = true
	L["Last Update"] = true
	L["Necrolord"] = true
	L["Night Fae"] = true
	L["Researchers Under Fire"] = true
	L["Siege on Dragonbane Keep"] = true
	L["The Forbidden Reach"] = true
	L["The Storm's Fury"] = true
	L["Transferable Anima"] = true
	L["Transferable Flakes"] = true
	L["Treasure Goblin"] = true
	L["Venthyr"] = true
	L["Zaralek Cavern"] = true
	L["Zereth Mortis"] = true
	L["Bodyguards"] = true
	L["Mythic Keystone"] = true
	L["Disciple of Fyrakk"] = true
	L["Fighting is Its Own Reward"] = true
	L["World Boss"] = true
	L["World Bosses"] = true
	L["Weekend Event"] = true
	L["A Worthy Ally: Loamm Niffen"] = true
	L["Sniffenseeking"] = true
	L["Sniffenseeking (items)"] = true
	L["TimeRift"] = true
	L["Dreamsurges"] = true
	L["Storm-Bound Chest"] = true
	L["Temporal Acquisitions Specialist"] = true
	L["Dilated Time Capsule"] = true
	L["Dreamsurge Chrysalis"] = true
	L["Dreamsurge Coalescence"] = true
	L["Charred Elemental Remains"] = true
	L["Encapsulated Destiny"] = true
	L["Dreamsurge Investigation"] = true
	L["Shaping the Dreamsurge"] = true
	L["Auto Turn Quests"] = true
	L["Aiding the Accord"] = true
	L["When Time Needs Mending"] = true
	L["Emerald Dream"] = true
	L["The Coalition of Flames"] = true
	L["Enter the Dream"] = true
	L["Druids of the Flame"] = true
	L["Ice and Fire"] = true
	L["Eye of Ysera"] = true
	L["A Dream of Fields and Fire"] = true
	L["New Beginnings"] = true
	L["Catalyst Charges"] = true
	L["Sparks of Life"] = true
	L["Season Maximum"] = true
	L["Can Earned"] = true
	L["The Gilneas Reclamation"] = true
	L["The Big Dig"] = true
	L["Azerothian Archives"] = true
	L["Daily Reset"] = true
	L["Was online"] = true
	L["Weekly Dungeon Quest"] = true
	L["Light/Dark Cycle"] = true
	L["Major Keyflames"] = true
	L["Minor Keyflames"] = true
	L["Another quests"] = true
	L["Shadowmourne"] = true
	L["Green Fire"] = true
	L["Some Wicked Things"] = true
	L["Firelands"] = true
	L["Dawn of the Infinites"] = true
	L["Black Temple"] = true
	L["Ulduar"] = true
	L["Paragon"] = true
	L["Dreamseeds"] = true
	L["Crests"] = true
	L["Sparks"] = true
	L["Flightstones"] = true
	L["Treasures"] = true
	L["Faction Assault"] = true
	L["Legion Invasion"] = true

	-- UI elements
	L["Hide: Boss Banner"] = true
	L["Hide: Covenant"] = true
	L["Hide: Error Messages"] = true
	L["Hide: RaidBossEmoteFrame"] = true
	L["Hide: TalkingHeadFrame"] = true
	L["Hide: Zone Text"] = true
	L["Hide: Azerite Animations"] = true
	L["Hide: Objectives In Instance"] = true

	-- Functions/features
	L["AutoRepair"] = true
	L["InputDelete"] = true
	L["AutoOpen"] = true
	L["AutoGossip"] = true
	L["CinematicCanceler"] = true
	L["ClearChat"] = true
	L["UIErrorsFramePosition"] = true
	L["Functions"] = true
	L["Modules"] = true
	L["DisplaySettings"] = true
	L["Auto_Screenshot"] = true
	L["Additional Buttons"] = true
	L["Optional Reagents"] = true
	L["Trade Goods"] = true
	L["Allied Races"] = true
	L["AutoSellGrey"] = true

	-- Game strings
	L["RESET"] = RESET
	L["Warmode"] = PVP_LABEL_WAR_MODE
	L["OFF"] = LOC_OPTION_OFF
	L["ON"] = PVP_WAR_MODE_ENABLED
	L["PLAYER_DIFFICULTY_TIMEWALKER"] = PLAYER_DIFFICULTY_TIMEWALKER

	-- Messages
	L["Vendored gray items for: "] = true
	L["We need more gold"] = true
	L["You don't have enough money to repair."] = true
	L["Your items have been repaired for: "] = true
	L["Your items have been repaired using guild bank funds for: "] = true

	-- Current date
	L["Current Date"] = true

	-- Filters
	L["Only Current Server"] = true
	L["Only Current BattleTag"] = true
	L["Player level"] = true
	L["Player MAX level"] = true
	L["Only Current Realm"] = true
end

-- Russian localization
L = AL3:NewLocale("Octo", "ruRU")
if L then
	-- General terms
	L["Only Horde"] = "Только Орда"
	L["Only Alliance"] = "Только Альянс"
	L["Other"] = "Другое"
	L["General"] = "Общие"
	L["Total"] = "Всего"
	L["About"] = "Об аддоне"
	L["Characters"] = "Персонажи"
	L["Turn on"] = "Включить"
	L["Turn off"] = "Выключить"
	L["No quests"] = "Нет квестов"
	L["Parts"] = "Детали"
	L["Races"] = "Рассовые"
	L["Gift"] = "Подарок"
	L["Gifts"] = "Подарки"
	L["Rares"] = "Рарки"
	L["Portals"] = "Порталы"
	L["Level"] = "Уровень"
	L["Head"] = "Голова"
	L["Maw"] = "Утроба"
	L["Bank"] = "Банк"
	L["Bags"] = "Сумки"
	L["Feet"] = "Ступни"
	L["Legs"] = "Ноги"
	L["Back"] = "Спина"
	L["Chest"] = "Грудь"
	L["Waist"] = "Пояс"
	L["Hands"] = "Кисти рук"
	L["Wrist"] = "Запястья"
	L["PvP"] = "PvP"
	L["Abandon"] = "Отменено: "

	-- Addon settings
	L["AddonHeight"] = "Высота строк"
	L["AddonLeftFrameWeight"] = "Ширина левого"
	L["AddonCentralFrameWeight"] = "Ширина строк"
	L["MainFrameDefaultLines"] = "Количество строк"
	L["MaxNumCharacters"] = "Количество персонажей"
	L["SFDropDownWeight"] = "SFDropDownWeight"
	L["fullName"] = "Полное название"
	L["showIcons"] = "Показывать иконку"
	L["showIconsQuestionMark"] = "Показывать иконку со знаком вопроса"
	L["showVersion"] = "Показывать версию"
	L["showIndex"] = "Показывать индекс"
	L["Width: "] = "Ширина: "
	L["Item level: "] = "Уровень предметов: "

	-- Debug/technical terms
	L["minimaphide"] = "|cffFF4C4Fminimaphide|r"
	L["hookMenuButton"] = "|cffFF4C4FhookMenuButton|r"
	L["sortingCpu"] = "|cffFF4C4FsortingCpu|r"
	L["cpuShowCurrent"] = "|cffFF4C4FcpuShowCurrent|r"
	L["cpuShowEncounter"] = "|cffFF4C4FcpuShowEncounter|r"
	L["profilingcpuShowPeak"] = "|cffFF4C4FprofilingcpuShowPeak|r"
	L["profilingcpuShowAverage"] = "|cffFF4C4FprofilingcpuShowAverage|r"
	L["profilingcpuUpdate"] = "|cffFF4C4FprofilingcpuUpdate|r"
	L["localizeCategoryName"] = "|cffFF4C4FlocalizeCategoryName|r"
	L["autofocusSearch"] = "|cffFF4C4FautofocusSearch|r"
	L["showSecureAddons"] = "|cffFF4C4FshowSecureAddons|r"
	L["showTocXCategory"] = "|cffFF4C4FshowTocXCategory|r"
	L["showTocCategory"] = "|cffFF4C4FshowTocCategory|r"
	L["showMemoryInBrokerTtp"] = "|cffFF4C4FshowMemoryInBrokerTtp|r"
	L["isCategoryFrameVisible"] = "|cffFF4C4FisCategoryFrameVisible|r"
	L["InDev"] = "|cffFF4C4FВ разработке|r"

	-- Time formats
	L["time_YEAR"] = "г"
	L["time_DAY"] = "д"
	L["time_HOUR"] = "ч"
	L["time_MINUTE"] = "м"
	L["time_SECOND"] = "с"
	L["y. "] = "г. "
	L["d. "] = "д. "
	L["h. "] = "ч. "
	L["m. "] = "м. "
	L["s. "] = "с. "

	-- Quests/activities
	L["Abandon All Quests"] = "Отменить все задания"
	L["Abandon: "] = "Отменено: "
	L["Battle Pet"] = "Боевой питомец"
	L["Bind Location"] = "Место привязки"
	L["Coins"] = "Монетки"
	L["Community Feast"] = "Большое пиршество"
	L["Current Location"] = "Текущее местоположение"
	L["Expire on"] = "Истекает"
	L["Fyrakk Asssaults"] = "Налет Фиракка (Локалка)"
	L["Grand Hunt"] = "Великая охота"
	L["Keys of Loyalty"] = "Ключи преданности"
	L["Korthia"] = "Кортия"
	L["Kyrian"] = "Кирии"
	L["Last Update"] = "Последнее Обновление"
	L["Necrolord"] = "Некролорды"
	L["Night Fae"] = "Ночной народец"
	L["Researchers Under Fire"] = "Исследователли под огнем"
	L["Siege on Dragonbane Keep"] = "Осада Драконьей Погибели"
	L["The Forbidden Reach"] = "Запретный край"
	L["The Storm's Fury"] = "Неистовство бури"
	L["Transferable Anima"] = "Переносимая анима"
	L["Transferable Flakes"] = "Переносимая стружка"
	L["Treasure Goblin"] = "Алчный гоблин"
	L["Venthyr"] = "Вентиры"
	L["Zaralek Cavern"] = "Пещера Заралек"
	L["Zereth Mortis"] = "Зерет Мортис"
	L["Bodyguards"] = "Телохранители"
	L["Mythic Keystone"] = "Эпохальный ключ"
	L["Disciple of Fyrakk"] = "Ученик Фиракка"
	L["Fighting is Its Own Reward"] = "Славный бой – это уже награда"
	L["World Boss"] = "Мировой босс"
	L["World Bosses"] = "Мировые боcсы"
	L["Weekend Event"] = "Событие выходного дня"
	L["A Worthy Ally: Loamm Niffen"] = "Достойный союзник: лоаммские ниффы"
	L["Sniffenseeking"] = "Нюхорысканье"
	L["Sniffenseeking (items)"] = "Нюхорысканье ("..ITEMS..")"
	L["TimeRift"] = "Портал времени"
	L["Dreamsurges"] = "Прилив Снов"
	L["Storm-Bound Chest"] = "Запечатанный бурей сундук"
	L["Temporal Acquisitions Specialist"] = "Темпоральный специалист по снабжению"
	L["Dilated Time Capsule"] = "Капсула растянутого времени"
	L["Dreamsurge Chrysalis"] = "Хризалида Дикого Сна"
	L["Dreamsurge Coalescence"] = "Слияние Прилива Снов"
	L["Charred Elemental Remains"] = "Обугленные останки элементалей"
	L["Encapsulated Destiny"] = "Инкапсулированная судьба"
	L["Dreamsurge Investigation"] = "Исследование Прилива Снов"
	L["Shaping the Dreamsurge"] = "Укрощение Прилива Снов"
	L["Auto Turn Quests"] = "Автопринятие заданий"
	L["Aiding the Accord"] = "Помощь союзу"
	L["When Time Needs Mending"] = "Исцелить само время"
	L["Emerald Dream"] = "Изумрудный Сон"
	L["The Coalition of Flames"] = "Союз пламени"
	L["Enter the Dream"] = "Погружение в сон"
	L["Druids of the Flame"] = "Друиды пламени"
	L["Ice and Fire"] = "Лед и огонь"
	L["Eye of Ysera"] = "Око Изеры"
	L["A Dream of Fields and Fire"] = "Сон о полях в огне"
	L["New Beginnings"] = "Новое начало"
	L["Catalyst Charges"] = "Заряды Катализатора"
	L["Sparks of Life"] = "Искры жизни"
	L["Season Maximum"] = "Максимум за сезон"
	L["Can Earned"] = "Можно получить"
	L["The Gilneas Reclamation"] = "Возвращение Гилнеаса"
	L["The Big Dig"] = "Большие раскопки"
	L["Azerothian Archives"] = "Азеротские архивы"
	L["Daily Reset"] = "Ежедневный сброс"
	L["Was online"] = "Был в сети"
	L["Weekly Dungeon Quest"] = "Еженедельное задание подземелья"
	L["Light/Dark Cycle"] = "Лайт/Дарк цикл"
	L["Major Keyflames"] = "Основные огни"
	L["Minor Keyflames"] = "Второстепенные огни"
	L["Another quests"] = "Другие задания"
	L["Shadowmourne"] = "Темная Скорбь"
	L["Green Fire"] = "Зелёный Огонь"
	L["Some Wicked Things"] = "Некоторые неприятные вещи (10.1.5)"
	L["Firelands"] = "Огненные Просторы"
	L["Dawn of the Infinites"] = "Рассвет Бесконечности"
	L["Black Temple"] = "Чёрный Храм"
	L["Ulduar"] = "Ульдуар"
	L["Paragon"] = "Парагон"
	L["Dreamseeds"] = "Семена"
	L["Crests"] = "Гребни"
	L["Sparks"] = "Искры"
	L["Flightstones"] = "Драконьи камни"
	L["Treasures"] = "Сундуки"
	L["Faction Assault"] = "Вторжение Фракций"
	L["Legion Invasion"] = "Вторжение Легиона"

	-- UI elements
	L["Hide: Boss Banner"] = "Скрытие баннера босса"
	L["Hide: Covenant"] = "Скрытие ковенанта"
	L["Hide: Error Messages"] = "Скрытие текста ошибок"
	L["Hide: RaidBossEmoteFrame"] = "Скрытие эмоций босса"
	L["Hide: TalkingHeadFrame"] = "Скрытие говорящей головы"
	L["Hide: Zone Text"] = "Скрытие текста зон"
	L["Hide: Azerite Animations"] = "Скрытие анимации Азерита"
	L["Hide: Objectives In Instance"] = "Скрытие заданий в подземельях"

	-- Functions/features
	L["AutoRepair"] = "Автопочинка"
	L["InputDelete"] = "Автозаполнение 'УДАЛИТЬ'"
	L["AutoOpen"] = "Автооткрытие предметов"
	L["AutoGossip"] = "Авторазговор с НПЦ"
	L["CinematicCanceler"] = "Автопропуск видео"
	L["ClearChat"] = "Чистка чата при заходе в игру"
	L["UIErrorsFramePosition"] = "Смена позиции фрейма ошибок"
	L["Functions"] = "Функции"
	L["Modules"] = "Модули"
	L["DisplaySettings"] = "Настройки отображения"
	L["Auto_Screenshot"] = "Автоскриншот"
	L["Additional Buttons"] = "Дополнительные кнопки"
	L["Optional Reagents"] = "Дополнительные реагенты"
	L["Trade Goods"] = "Хозяйственные товары"
	L["Allied Races"] = "Союзные расы"
	L["AutoSellGrey"] = "Автопродажа серого хлама"

	-- Game strings
	L["RESET"] = "Сброс всех данных аддона"
	L["Warmode"] = PVP_LABEL_WAR_MODE
	L["OFF"] = LOC_OPTION_OFF
	L["ON"] = PVP_WAR_MODE_ENABLED
	L["PLAYER_DIFFICULTY_TIMEWALKER"] = PLAYER_DIFFICULTY_TIMEWALKER

	-- Messages
	L["Vendored gray items for: "] = "Серые предметы проданы на сумму: "
	L["We need more gold"] = "Нужно больше золота!"
	L["You don't have enough money to repair."] = "У Вас недостаточно денег для ремонта."
	L["Your items have been repaired for: "] = "Ремонт обошелся в "
	L["Your items have been repaired using guild bank funds for: "] = "Ремонт обошелся гильдии в "

	-- Current date
	L["Current Date"] = "Текущая дата"

	-- Filters
	L["Only Current Server"] = "Только текущий сервер"
	L["Only Current BattleTag"] = "Только текущий BattleTag"
	L["Player level"] = "Мин. уровень"
	L["Player MAX level"] = "Макс. уровень"
	L["Only Current Realm"] = "Только текущий сервер"
end