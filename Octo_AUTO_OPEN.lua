local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
--E.modules = {}
--------------------------------------------------------------------------------
local Octo_AUTO_OPEN = CreateFrame("Frame", AddonTitle)
--local Enable_Module = true
--Octo_AUTO_OPEN:RegisterEvent("PLAYER_ENTERING_WORLD")
Octo_AUTO_OPEN:RegisterEvent("BAG_UPDATE_DELAYED")
Octo_AUTO_OPEN:RegisterEvent("PLAYER_REGEN_ENABLED")
Octo_AUTO_OPEN:RegisterEvent("BAG_UPDATE")
Octo_AUTO_OPEN:RegisterEvent("LOOT_READY")
Octo_AUTO_OPEN:RegisterEvent("PLAYER_STARTED_MOVING")
local isDead = UnitIsDead("PLAYER")
local UnitLevel = UnitLevel("PLAYER")
-- local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local openableIDs = {
    [206039] = true, --Комплект вражды DIABLO 4
    --PARAGON
    [204378] = true,
    --PVP
    [206271] = true,
    --new location
    [205965] = true,
    [205370] = true, --Исследователи под огнем  сумка
    [205367] = true, --Исследователи под огнем 1000 репы
    [205368] = true,
    [202172] = true,
    [205247] = true,
    [204911] = true,
    --[205423] = true,
    [205226] = true,
    [205983] = true,
    [205288] = true,
    [205347] = true,
    --DRAGONFLY
    [132892] = true, --Блескотрон 6000
    [198868] = true, --Маленькая сумка с припасами союза Вальдраккена
    [199192] = true, --Кошелек участника драконьей гонки
    [200069] = true, --Обсидиановый тайник
    [200070] = true, --Обсидиановый сейф
    [203476] = true, --Сундук воинов стихий
    [201754] = true, --Сундук обсидианового главного кузнеца
    [201326] = true, --Драконья сумка сотрудничества (руна?)
    [199341] = true, --Отрыгнутый мешок сокровищ рогоплава
    [198866] = true, --Маленькая сумка с искарскими припасами
    [189765] = true, --Мешок с припасами кентавров Маруук
    [198864] = true, --Крупный мешок с припасами кентавров Маруук
    [199474] = true, --Переполненный мешок с припасами кентавров Маруук
    --PVP
    [201250] = true, --Сейф победоносного соперника
    [201756] = true, --Openworld
    --[199122] = true, --TEST
    [200095] = true, --с пира
    [171305] = true,
    [198863] = true,
    [203222] = true,
    -- Арена мордабой
    [92718] = true,
    --PVP
    [170074] = true,
    [133549] = true, --legion
    --ZM
    [191139] = true, --Дар старейшин Просветленных [190610]
    --[5043] = true, --Коробка с подарком
    [187780] = true, -- Парагон просветленные
    [184635] = true,
    [184642] = true,
    [190178] = true,
    [187574] = true,
    [184638] = true,
    [184634] = true,
    [184636] = true,
    [184630] = true,
    [184640] = true,
    [184641] = true,
    [184633] = true,
    [184631] = true,
    --[168207] = true, --Клетка с награбленной анимой
    --[184662] = true, --Реквизированная клетка с анимой
    --[187351] = true, --Скопление стигии
    [180648] = true, --Припасы Двора Жнецов
    [180649] = true, --Припасы Дикой Охоты
    [181372] = true, --Дар перерожденных
    [181475] = true, --Дар хранителей рощи
    [181476] = true, --Дар Дикой Охоты
    [181556] = true, --Дар Двора
    [181557] = true, --Благосклонность Двора
    [181732] = true, --Дар честолюбивых
    [181733] = true, --Дар верных долгу
    [181741] = true, --Дар идеала
    [183699] = true, --Изысканные ингредиенты
    [183702] = true, --Великолепие природы
    [184395] = true, --Тайник павшего искателя приключений
    [185906] = true, -- wow 17
    [185972] = true, --Тайник мучителя
    [185990] = true, --Трофейный сундук Жнецов
    [185991] = true, --Трофейный сундук Дикой Охоты
    [185992] = true, --Трофейный сундук Неумирающей армии
    [185993] = true, --Трофейный сундук перерожденных
    [186196] = true, --Трофейный сундук Легиона Смерти
    [186650] = true, --Припасы Легиона Смерти
    [186691] = true, --Сумка с золотом
    [186692] = true, --Шлем с золотом
    [186706] = true, --Шляпа с золотом
    [186708] = true, --Стакан для кистей с золотом
    [187028] = true, --Припасы Кодекса архивариуса
    [187029] = true, --Таинственный подарок Ве'нари
    [187278] = true, --Пронзенная когтями шкатулка Верных Утробе
    [187354] = true, --Брошенная сумка брокера
    [187440] = true, --Шлем с плюмажем из перьев
    [187551] = true, --Сундучок с кортийскими припасами
    [37586] = true, --Пригоршня конфет
    --[92794] = true, --Книжечка билетов на аттракцион
    [186533] = true, --Тайник с сокровищами Святилища
    [180646] = true, --Припасы Неумирающей армии
    [186688] = true, --Ведерко с золотом
    [178128] = true, --Сумка с блестяшками
    [140226] = true, --легион
    [140227] = true, --легион
    [144330] = true, --легион
    [144345] = true, --легион
    [153248] = true, --легион
    [140225] = true, --легион
    [140224] = true, --легион
    [140221] = true, --легион
    [140220] = true, --легион
    [180647] = true, --Припасы перерожденных
    [180975] = true,
    [180976] = true,
    [180977] = true,
    [180984] = true,
    [180981] = true,
    [180974] = true,
    [180980] = true,
    [180985] = true,
    [168740] = true, --bleskotron7000
    [185765] = true, --кожа
    [187431] = true, --WEAPON
    [183701] = true, -- kyrian
    [140227] = true, --legion blood
    -- LOVE
    [54537] = true,
    [49909] = true,
    --yarmarka
    [78910] = true,
    [93724] = true,
    [78904] = true,
    [92894] = true,
    --Зима
    [17727] = true,
    [116762] = true,
    [17726] = true,
    [17685] = true,
    [21310] = true,
    [21191] = true,
    [187520] = true,
    [21327] = true,
    [187561] = true,
    [21363] = true,
    --Auto-open many openables, such as TBC/Vanilla clams, crates from fishing, bags from profession dailies.
    --https://wago.io/fcNlEG667
    [37586] = true,
    [20393] = true,
    [34863] = true,
    [33857] = true,
    [33844] = true,
    [35348] = true,
    [35313] = true,
    [46007] = true, -- WOTLK Fishing Daily Bag
    [44113] = true, -- Small Spice Bag (Northrend Cooking Daily)
    [44475] = true, -- Reinforced Crate
    --[5523] = true,  -- Small Barnacled Clam (from: Ashenvale, Azuremyst Isle, Bloodmyst Isle, Darkshore, Redridge Mountains, Silverpine Forest, Westfall)
    [5524] = true,  -- Thick-shelled Clam (from: Blackfathom Depths, Hillsbrad Foothills, Wetlands)
    [7973] = true,  -- Big-mouth Clam (from Azshara, Dustwallow Marsh, Feralas, Stranglethorn Vale, Swamp of Sorrws, Tanaris, Hinterlands)
    [15874] = true, -- Soft-shelled Clam (from: Desolace)
}
local openableIDs70lvl = {}
if UnitLevel >= 60 then
    openableIDs70lvl = {
        [200073] = true, --Вальдраккенские сокровища 3kREP
        [200072] = true, --фиоле Сейф Драконьей Погибели
        [202142] = true, --синий Сейф Драконьей Погибели
        [200468] = true, --фиоле Трофеи великой охоты
        [200513] = true, --синий Трофеи великой охоты
        [200515] = true, --зелен Трофеи великой охоты
        [200516] = true, --белый Трофеи великой охоты
        [202371] = true, --фиоле Сияющий сундук воинов стихий
        [203681] = true, --синий Штормовой сундук воинов стихий
        [204359] = true, -- Кошелек гонщика Запретного края
        [203700] = true, --https://ru.wowhead.com/item=203701 https://ru.wowhead.com/npc=201714
        [202171] = true,
        [203217] = true,
        [203699] = true,
        --[202080] = true, -- Сундук событие выходного с героика
        -- 10.0.7 новый остров
        [203220] = true, --Чудорыба
    }
end
-- local isWorking = false
-- local function OpenableScan()
--     for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
--         for numSlots = C_Container.GetContainerNumSlots(bag),1,-1 do
--             local containerInfo = C_Container.GetContainerItemInfo(bag, numSlots)
--             if containerInfo then
--                 local itemID = containerInfo.itemID
--                 local isLocked = containerInfo.isLocked
--                 local iconFileID = containerInfo.iconFileID
--                 local name, itemLink = GetItemInfo(itemID)
--                 if (openableIDs[itemID] or openableIDs70lvl[itemID]) and not isLocked then
--                     C_Container.UseContainerItem(bag, numSlots)
--                     if iconFileID and itemLink then
--                         print("|cFF00A3FFADDON:|r".." |cFFFF4C4FOpening item:|r |T "..iconFileID..":16:16:::64:64:4:60:4:60|t "..itemLink)
--                     end
--                     isWorking = false
--                     return
--                 end
--             end
--         end
--     end
-- end
-- local openableScanQueued = false
-- Octo_AUTO_OPEN:SetScript("OnEvent", function(self, event, ...)
--     if isWorking or not Enable_Module then return end
--     isWorking = true
--     C_Timer.After(0.1, function()
--         if event == "BAG_UPDATE" then
--             if not InCombatLockdown() and isDead == false then
--                 OpenableScan()
--             else
--                 openableScanQueued = true
--             end
--         elseif event == "PLAYER_REGEN_ENABLED" then
--             if openableScanQueued then
--                 openableScanQueued = false
--                 OpenableScan()
--             end
--         end
--     end)
-- end)
local function OpenableScan()
    for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
        for numSlots = C_Container.GetContainerNumSlots(bag),1,-1 do
            local containerInfo = C_Container.GetContainerItemInfo(bag, numSlots)
            if containerInfo then
                local itemID = containerInfo.itemID
                local isLocked = containerInfo.isLocked
                local iconFileID = containerInfo.iconFileID
                local name, itemLink = GetItemInfo(itemID)
                if (openableIDs[itemID] or openableIDs70lvl[itemID]) and not isLocked then
                    C_Container.UseContainerItem(bag, numSlots)
                    --self:SetAttribute("macrotext", "/use item:"..itemID)
                    if iconFileID and itemLink then
                        print("|cFF00A3FFADDON:|r".." |cFFFF4C4FOpening item:|r |T "..iconFileID..":16:16:::64:64:4:60:4:60|t "..itemLink)
                    end
                end
            end
        end
    end
end
local openableScanQueued = false
Octo_AUTO_OPEN:SetScript("OnEvent", function(self, event, ...)
        C_Timer.After(0.1, function()
                if Octo_ToDo_DragonflyVars.config.AutoOpen then
                    if event == "BAG_UPDATE" then
                        if not InCombatLockdown() and isDead == false  then
                            OpenableScan()
                        else
                            openableScanQueued = true
                        end
                    elseif event == "PLAYER_REGEN_ENABLED" then
                        if openableScanQueued then
                            openableScanQueued = false
                            OpenableScan()
                        end
                    end
                end
        end)
end)

