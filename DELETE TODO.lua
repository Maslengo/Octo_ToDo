коллект олл итемс ин баг + TSM https://youtu.be/FmICFh3Kwd8?t=9112

убрать распределение PTR / retail

разбить коллект по файлам?

local i = 1
repeat
    local _, _, _, _, _, _, _, _, _, spellID = UnitBuff("target", i)
    if spellID and spellID == 12351 then
        
        i = i + 1
    end
until not spellID
