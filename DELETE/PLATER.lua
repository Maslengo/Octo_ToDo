function (self, unitId, unitFrame, envTable)
    local markerToHex = {
        [1] = "ffEAEA0D", -- Yellow 5 Point Star
        [2] = "ffEAB10D", -- Orange Circle
        [3] = "ffCD00FF", -- Purple Diamond
        [4] = "ff06D425", -- Green Triangle
        [5] = "ffB3E3D8", -- Light Blue Moon
        [6] = "ff0CD2EA", -- Blue Square
        [7] = "ffD6210B", -- Red Cross
        [8] = "ffFFFFFF", -- White Skull
    }
    -- Убирает 2ое слово в имени и делает 1ое [b]
    local nameBlacklist = {
        ["the"] = true,
        ["of"] = true,
        ["Tentacle"] = true,
        ["Apprentice"] = true,
        ["Denizen"] = true,
        ["Emissary"] = true,
        ["Howlis"] = true,
        ["Terror"] = true,
        ["Totem"] = true,
        ["Тотем"] = true,
        ["Waycrest"] = true,
        ["Aspect"] = true
    }

    local renameTable = {
        [194317] = "»Бороо«",
        [192333] = "»Вожак«",
        [59553] = "»Королева птиц«",
        [190206] = "»Танцовщица пламени«",
        [76446] = "»Подавитель«",
        [192794] = "»Повелительница зверей«",
        [97068] = "»Дракон«",
        [190207] = "»Пеплоплет«",
        [187969] = "»Демиург«",
        [187160] = "»Ярость«",
        [192796] = "»Трубач«",
        [96664] = "»Резчик рун«",
        [187240] = "»Драконид«",
        [200131] = "»Страж«",
        [196115] = "»Хранитель«",
        [59546] = "»Рыба«",
        [196671] = "»Опустошитель«",
        [188067] = "»Ткач Холода«",
        [196116] = "»Ярость«",
        [194894] = "»Буревестник«",
        [200387] = "»Заразитель«",
        [191164] = "»Хранитель«",
        [191847] = "»Топотун«",
        [195927] = "»Галтмаа«",
        [104270] = "»Голем«",
        [196102] = "»Плеточник«",
        [195928] = "»Даарен«",
        [104247] = "»Чародей«",
        [195929] = "»Тумен«",
        [187897] = "»Драгхар«",
        [195930] = "»Мандакх«",
        [200137] = "»Ткачиха туманов«",
        [95834] = "»Мистик«",
        [95842] = "»Призыватель молний«",
        [59873] = "»Живая вода«",
        [75713] = "»Подчинитель«",
        [197535] = "»Ривати«",
        [101637] = "»Претендентка«",
        [196202] = "»Заклинательница«",
        [59544] = "»Тигр«",
        [186741] = "»Элементаль«",
        [59552] = "»Хозен«",
        [187154] = "»Смотритель«",
        [97197] = "»Очиститель«",
        [197219] = "»Плеточник«",
        [198047] = "»Чаротворица«",
        [77700] = "»Извлекатель«",
        [196044] = "»Учебник«",
        [104274] = "»Баалгар«",
        [196045] = "»Манадемон«",
        [187155] = "»Хранительница«",
        [195265] = "»Аринга«",
        [195696] = "»Громозверь«",
        [194315] = "»Солонго«",
        [105715] = "»Инквизитор«",
        [196576] = "»Скипетр«",
        [104251] = "»Часовой«",
        [179733] = "»Тотем«",
        [178139] = "»Крушитель«",
        [200126] = "»Заклинатель воды«",
        [75459] = "»Летучая мышь«",
        [194316] = "»Зарии«",
        [196203] = "»Целитель«",
        [178141] = "»Лататель«",
        [76104] = "»Паук«",
        [59555] = "»Ша«",
        -- -- Testing
        -- ["Fleshripper Vulture"] = "Shit Bird",
        -- ["Roaming Nibbler"] = "Roaming Saurid",
        -- -- Grand Delusions
        -- ["Thing From Beyond"] = "Ion Hazzikostas",
        -- -- Plaguefall
        -- ["Plagueroc"] = "Plaguecock",
        -- ["Doctor Ickus"] = "Dickus",
        -- -- Sanguine Depths
        -- ["Animated Weapon"] = "Assclapper",
        -- ["Kryxis the Voracious"] = "Steroid Stomper",
        -- ["Frenzied Ghoul"] = "Death",
        -- ["General Kaal"] = "Daddy Kaal",
        -- -- Mists of Tirna Scithe
        -- ["Droman Oulfarran"] = "Simp Tree",
        -- ["Mistcaller"] = "Lady UwU",
        -- ["Tred'ova"] = "Tred'killya",
        -- ["Реликвия Во"] = "Инвиз",
        -- ["Реликвия Урт"] = "КДР",
        -- ["Реликвия Ви"] = "Хаст",
        -- ["Лихувим"] = "БОСС",
    }
    -- local text = unitFrame.healthBar.unitName:GetText()
    local FirstName = {
        [164556] = true, -- Миллхаус Манашторм
        [164555] = true, -- Миллифисент Манашторм
        [164705] = true, -- Моровая слизь(красная)
        [164707] = true, -- Сгусток слизи(синяя)
        [168969] = true, -- Хлещущая слизь(зеленая)
        [164929] = true, -- Жительница Тирна Скитта
        -- RLP
        [188067] = true, -- Ткач Холода Морозной Вспышки -- > Ткач
        [187969] = true, -- Демиург Морозной Вспышки -- >Демиург
        -- [167731] = true, -- Ассистент-расчленитель
        -- [173044] = true, -- Ассистент-сшиватель
    }
    local PlayerLevel = UnitLevel("PLAYER")
    local GameLimitedMode_IsActive = GameLimitedMode_IsActive()
    local GetMaxLevelForLatestExpansion = GetMaxLevelForLatestExpansion()
    local GetRestrictedAccountData_rLevel = select(1, GetRestrictedAccountData()) or 20
    function envTable.namer(unitId, marker, nameColouring, isBoss)
        if unitId then
            local guid = UnitGUID(unitId)
            local name = UnitName(unitId)
            local namePlateUnitLevel = UnitLevel(unitId)
            if namePlateUnitLevel > 1 then
                namePlateUnitLevel = namePlateUnitLevel .. " - "
            else
                namePlateUnitLevel = "*"
            end
            if PlayerLevel >= GetMaxLevelForLatestExpansion or (GameLimitedMode_IsActive == true and PlayerLevel == GetRestrictedAccountData_rLevel) then
                namePlateUnitLevel = ""
            end
            if guid then
                local unit_type = strsplit("-", guid)
                if unit_type == "Creature" or unit_type == "Vehicle" then
                    -- local _, _, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", guid)
                    local a, b, c, d, e, f = strsplit(" ", name, 5)
                    a = strsplit("-", name, 5) or a
                    local unitName
                    if nameBlacklist[b] then
                        unitName = name ~= nil and (a or b or c or d or e or f) or nil
                    elseif not FirstName[unitFrame.namePlateNpcId] then
                        unitName = name ~= nil and (f or e or d or c or b or a) or nil
                    else
                        unitName = name ~= nil and (a) or nil
                    end
                    if unitId and marker == nil and nameColouring then
                        marker = 8
                    end
                    if unitName == nil then
                        unitName = name
                    end
                    if renameTable[unitFrame.namePlateNpcId] then
                        unitName = renameTable[unitFrame.namePlateNpcId]
                    end
                    if unitId and marker and nameColouring then
                        unitFrame.healthBar.unitName:SetText(WrapTextInColorCode(namePlateUnitLevel..unitName, markerToHex[marker]))
                    elseif unitId then
                        unitFrame.healthBar.unitName:SetText(namePlateUnitLevel..unitName)
                    end
                    -- elseif unit_type == "Player" then
                    -- local _, server_id, player_id = strsplit("-", guid)
                    -- print(player_id)
                end
            end
        end
    end
end

