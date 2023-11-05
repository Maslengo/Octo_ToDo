local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
E.Octo_Table.OctoTable_Portals_MoP = {
    131232, -- MoP: Scholomance
    131231, -- MoP: Scarlet Halls
    131229, -- MoP: Scarlet Monastery
    131228, -- MoP: Siege of Niuzao
    131222, -- MoP: Mogu'shan Palace
    131225, -- MoP: Gate of the Setting Sun
    131205, -- MoP: Shado-Pan Monastery
    131205, -- MoP: Stormstout Brewery
    131204 -- MoP: Temple of the Jade Serpent
}
E.Octo_Table.OctoTable_Portals_WoD = {
    159902, -- WoD: Upper Blackrock Spire
    159901, -- WoD: The Everbloom
    159900, -- WoD: Grimrail Depot
    159899, -- WoD: Shadowmoon Burial Grounds
    159898, -- WoD: Skyreach
    159897, -- WoD: Auchindoun
    159896, -- WoD: Iron Docks
    159895 -- WoD: Bloodmaul Slag Mines
}
E.Octo_Table.OctoTable_Portals_Legion = {
    393764, -- Legion: Halls of Valor
    393766, -- Legion: Court of Stars
    373262 -- Legion: Return to Karazhan
}
E.Octo_Table.OctoTable_Portals_BfA = {
    373274 -- BfA: Operation: Mechagon
}
E.Octo_Table.OctoTable_Portals_SL = {
    367416, -- SL: Taza'vesh, the Veiled Market
    354469, -- SL: Sanguine Depths
    354465, -- SL: Halls of Atonement
    354463, -- SL: Plaguefall
    354467, -- SL: Theater of Pain
    354468, -- SL: De Other Side
    354464, -- SL: Mists of Tirna Scithe
    354466, -- SL: Spires of Ascension
    354462 -- SL: Necrotic Wake
}
E.Octo_Table.OctoTable_Portals_DF = {
    393279, -- DF: The Azure Vault
    393273, -- DF: Algeth'ar Academy
    393262, -- DF: The Nokhud Offensive.
    393256, -- DF: Ruby Life Pools
    393267, -- DF: Brackenhide Hollow
    410071, -- DF: Freehold
    393283, -- DF: Halls of Infusion
    410078, -- DF: Neltharion's Lair
    393276, -- DF: Neltharus
    410074, -- DF: The Underrot
    410080, -- DF: The Vortex Pinnacle
    393222 -- DF: Uldaman: Legacy of Tyr
}
E.Octo_Table.OctoTable_Portals_Mage_Solo_Horde =
    {
        3567, -- телепортация-оргриммар
        3563, -- телепортация-подгород
        3566, -- телепортация-громовой-утес
        32272, -- телепортация-луносвет
        49358, -- телепортация-в-каменор
        35715, -- телепортация-шаттрат
        53140, -- телепортация-даларан-нордскол
        88344, -- телепортация-тол-барад
        120145, -- телепортация-даларан-старая
        132627, -- телепортация-вечноцветущий-дол
        176242, -- телепортация-копье-войны
        224869, -- телепортация-даларан-расколотые-острова
        281404, -- телепортация-дазаралор
        344587, -- телепортация-орибос
        395277, -- телепортация-вальдраккен
        193759 -- телепортация-оплот-хранителя
    }
E.Octo_Table.OctoTable_Portals_Mage_Group_Horde =
    {
        11417, -- портал-в-оргриммар
        11418, -- портал-в-подгород
        11420, -- портал-в-громовой-утес
        32267, -- портал-в-луносвет
        49361, -- портал-в-каменор
        35717, -- портал-в-шаттрат
        53142, -- портал-в-даларан-нордскол
        88346, -- портал-на-тол-барад
        120146, -- старый-портал-в-даларан
        132626, -- портал-в-вечноцветущий-дол
        176244, -- портал-в-копье-войны
        224871, -- Портал в Даларан (Расколотые острова)
        281402, -- портал-в-дазаралор
        344597, -- портал-орибос
        395289 -- портал-вальдраккен
    }
E.Octo_Table.OctoTable_Portals_Mage_Solo_Alliance =
    {
        3561, -- телепортация-штормград
        3562, -- телепортация-стальгорн
        3565, -- телепортация-дарнас
        32271, -- телепортация-экзодар
        49359, -- телепортация-терамор
        33690, -- телепортация-шаттрат
        53140, -- телепортация-даларан-нордскол
        88342, -- телепортация-тол-барад
        120145, -- телепортация-даларан-старая
        132621, -- телепортация-вечноцветущий-дол
        176248, -- телепортация-преграда-ветров
        224869, -- телепортация-даларан-расколотые-острова
        281403, -- телепортация-боралус
        344587, -- телепортация-орибос
        395277, -- телепортация-вальдраккен
        193759 -- телепортация-оплот-хранителя
    }
E.Octo_Table.OctoTable_Portals_Mage_Group_Alliance =
    {
        10059, -- портал-в-штормград
        11416, -- портал-в-стальгорн
        11419, -- портал-в-дарнас
        32266, -- портал-в-экзодар
        49360, -- портал-в-терамор
        33691, -- портал-в-шаттрат
        53142, -- портал-в-даларан-нордскол
        88345, -- портал-на-тол-барад
        120146, -- старый-портал-в-даларан
        132620, -- портал-в-вечноцветущий-дол
        176246, -- портал-в-преграду-ветров
        224871, -- Портал в Даларан (Расколотые острова)
        281400, -- портал-в-боралус
        344597, -- портал-орибос
        395289 -- портал-вальдраккен
    }
-- E.Octo_Table.OctoTable_Portals_DRUID = {
-- 	193753, --Сноходец
-- }
-- E.Octo_Table.OctoTable_Portals_DEATHKNIGHT = {
-- 	50977,
-- }
-- E.Octo_Table.OctoTable_Portals_SHAMAN = {
-- 	556,
-- }
-- E.Octo_Table.OctoTable_Portals_MONK = {
-- 	126892,
-- }

-- https://www.wowhead.com/ru/spell=343140/портал
-- https://www.wowhead.com/ru/spell=281400/портал-в-боралус
-- https://www.wowhead.com/ru/spell=132620/портал-в-вечноцветущий-дол
-- https://www.wowhead.com/ru/spell=132626/портал-в-вечноцветущий-дол
-- https://www.wowhead.com/ru/spell=11420/портал-в-громовой-утес
-- https://www.wowhead.com/ru/spell=281402/портал-в-дазаралор
-- https://www.wowhead.com/ru/spell=53142/портал-в-даларан-нордскол
-- https://www.wowhead.com/ru/spell=11419/портал-в-дарнас
-- https://www.wowhead.com/ru/spell=49361/портал-в-каменор
-- https://www.wowhead.com/ru/spell=176244/портал-в-копье-войны
-- https://www.wowhead.com/ru/spell=32267/портал-в-луносвет
-- https://www.wowhead.com/ru/spell=11417/портал-в-оргриммар
-- https://www.wowhead.com/ru/spell=11418/портал-в-подгород
-- https://www.wowhead.com/ru/spell=176246/портал-в-преграду-ветров
-- https://www.wowhead.com/ru/spell=11416/портал-в-стальгорн
-- https://www.wowhead.com/ru/spell=49360/портал-в-терамор
-- https://www.wowhead.com/ru/spell=33691/портал-в-шаттрат
-- https://www.wowhead.com/ru/spell=35717/портал-в-шаттрат
-- https://www.wowhead.com/ru/spell=10059/портал-в-штормград
-- https://www.wowhead.com/ru/spell=32266/портал-в-экзодар
-- https://www.wowhead.com/ru/spell=88345/портал-на-тол-барад
-- https://www.wowhead.com/ru/spell=88346/портал-на-тол-барад
-- https://www.wowhead.com/ru/spell=395289/портал-вальдраккен
-- https://www.wowhead.com/ru/spell=344597/портал-орибос
-- https://www.wowhead.com/ru/spell=120146/старый-портал-в-даларан
-- https://www.wowhead.com/ru/spell=343127/телепортация
-- https://www.wowhead.com/ru/spell=49358/телепортация-в-каменор
-- https://www.wowhead.com/ru/spell=281403/телепортация-боралус
-- https://www.wowhead.com/ru/spell=395277/телепортация-вальдраккен
-- https://www.wowhead.com/ru/spell=132627/телепортация-вечноцветущий-дол
-- https://www.wowhead.com/ru/spell=132621/телепортация-вечноцветущий-дол
-- https://www.wowhead.com/ru/spell=3566/телепортация-громовой-утес
-- https://www.wowhead.com/ru/spell=281404/телепортация-дазаралор
-- https://www.wowhead.com/ru/spell=53140/телепортация-даларан-нордскол
-- https://www.wowhead.com/ru/spell=224869/телепортация-даларан-расколотые-острова
-- https://www.wowhead.com/ru/spell=120145/телепортация-даларан-старая
-- https://www.wowhead.com/ru/spell=3565/телепортация-дарнас
-- https://www.wowhead.com/ru/spell=176242/телепортация-копье-войны
-- https://www.wowhead.com/ru/spell=32272/телепортация-луносвет
-- https://www.wowhead.com/ru/spell=193759/телепортация-оплот-хранителя
-- https://www.wowhead.com/ru/spell=3567/телепортация-оргриммар
-- https://www.wowhead.com/ru/spell=344587/телепортация-орибос
-- https://www.wowhead.com/ru/spell=3563/телепортация-подгород
-- https://www.wowhead.com/ru/spell=176248/телепортация-преграда-ветров
-- https://www.wowhead.com/ru/spell=3562/телепортация-стальгорн
-- https://www.wowhead.com/ru/spell=49359/телепортация-терамор
-- https://www.wowhead.com/ru/spell=88344/телепортация-тол-барад
-- https://www.wowhead.com/ru/spell=88342/телепортация-тол-барад
-- https://www.wowhead.com/ru/spell=33690/телепортация-шаттрат
-- https://www.wowhead.com/ru/spell=35715/телепортация-шаттрат
-- https://www.wowhead.com/ru/spell=3561/телепортация-штормград
-- https://www.wowhead.com/ru/spell=32271/телепортация-экзодар
-- https://www.wowhead.com/ru/spell=2139/антимагия
-- https://www.wowhead.com/ru/spell=130/замедленное-падение
-- https://www.wowhead.com/ru/spell=131784/иллюзия
-- https://www.wowhead.com/ru/spell=80353/искажение-времени
-- https://www.wowhead.com/ru/spell=122/кольцо-льда
-- https://www.wowhead.com/ru/spell=120/конус-холода
-- https://www.wowhead.com/ru/spell=116/ледяная-стрела
-- https://www.wowhead.com/ru/spell=137018/маг
-- https://www.wowhead.com/ru/spell=66/невидимость
-- https://www.wowhead.com/ru/spell=319836/огненный-взрыв
-- https://www.wowhead.com/ru/spell=118/превращение
-- https://www.wowhead.com/ru/spell=161372/превращение
-- https://www.wowhead.com/ru/spell=28272/превращение
-- https://www.wowhead.com/ru/spell=161353/превращение
-- https://www.wowhead.com/ru/spell=28271/превращение
-- https://www.wowhead.com/ru/spell=61780/превращение
-- https://www.wowhead.com/ru/spell=126819/превращение
-- https://www.wowhead.com/ru/spell=391622/превращение
-- https://www.wowhead.com/ru/spell=161354/превращение
-- https://www.wowhead.com/ru/spell=321395/превращение
-- https://www.wowhead.com/ru/spell=161355/превращение
-- https://www.wowhead.com/ru/spell=277792/превращение
-- https://www.wowhead.com/ru/spell=277787/превращение
-- https://www.wowhead.com/ru/spell=61305/превращение
-- https://www.wowhead.com/ru/spell=61721/превращение
-- https://www.wowhead.com/ru/spell=1953/скачок
-- https://www.wowhead.com/ru/spell=190336/сотворение-яств
-- https://www.wowhead.com/ru/spell=210086/чародей-полиглот
-- https://www.wowhead.com/ru/spell=1449/чародейский-взрыв
-- https://www.wowhead.com/ru/spell=1459/чародейский-интеллект
