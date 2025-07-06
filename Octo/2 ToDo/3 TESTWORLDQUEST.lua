local GlobalAddonName, E = ...
local Octo_EventFrameWQ = CreateFrame("FRAME")
Octo_EventFrameWQ:Hide()


function PrintWorldEvents()
    if not WorldMapFrame:IsShown() then
        print("Откройте карту мира для отображения событий")
        return
    end

    local mapID = WorldMapFrame:GetMapID()
    if not mapID then return end

    local worldQuests = 0
    local rareElites = 0
    local treasures = 0
    local invasions = 0
    local otherEvents = 0

    -- Мировые квесты (актуальный метод)
    if C_QuestLog and C_QuestLog.GetQuestsForPlayerByMapID then
        local quests = C_QuestLog.GetQuestsForPlayerByMapID(mapID)
        if quests then
            for _, quest in ipairs(quests) do
                if quest.isWorldQuest then
                    worldQuests = worldQuests + 1
                    print(format("Мировой квест: %s (уровень %d)", quest.questName, quest.questLevel or 0))
                end
            end
        end
    end

    -- Редкие противники (черей API EncounterJournal)
    -- if C_EncounterJournal then
    --     local vignettes = C_EncounterJournal.GetVignettesForMap(mapID)
    --     if vignettes then
    --         for _, vignetteID in ipairs(vignettes) do
    --             local vignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteID)
    --             if vignetteInfo and vignetteInfo.vignetteID then
    --                 if vignetteInfo.isRare or vignetteInfo.isRareElite then
    --                     rareElites = rareElites + 1
    --                     print(format("Редкий противник: %s", vignetteInfo.name or "Неизвестный редкий"))
    --                 end
    --             end
    --         end
    --     end
    -- end

    -- Сокровища (актуальный метод)
    if C_TreasureMap then
        local treasuresOnMap = C_TreasureMap.GetTreasuresForMap(mapID)
        if treasuresOnMap then
            for _, treasure in ipairs(treasuresOnMap) do
                treasures = treasures + 1
                print(format("Сокровище: %s", treasure.name or "Неизвестное сокровище"))
            end
        end
    end

    -- Вторжения (Legion/BFA и т.д.)
    if C_InvasionInfo then
        local invasionInfo = C_InvasionInfo.GetInvasionForUiMapID(mapID)
        if invasionInfo and invasionInfo.invasionActive then
            invasions = invasions + 1
            print(format("Вторжение: %s (осталось: %s)", invasionInfo.name, invasionInfo.timeRemaining or "N/A"))
        end
    end

    -- Итог
    print("\nИтого на текущей карте:")
    print(format("- Мировых квестов: %d", worldQuests))
    print(format("- Редких противников: %d", rareElites))
    print(format("- Сокровищ: %d", treasures))
    print(format("- Вторжений: %d", invasions))
    print(format("- Других событий: %d", otherEvents))
end

-- Создаем команду для вызова функции
SLASH_PRINTWORLDEVENTS1 = "/wevents"
SlashCmdList["PRINTWORLDEVENTS"] = PrintWorldEvents