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

Consistent naming: Used ALL_CAPS for constants and camelCase for functions to improve readability

%a    abbreviated weekday name (e.g., Wed)
%A    full weekday name (e.g., Wednesday)
%b    abbreviated month name (e.g., Sep)
%B    full month name (e.g., September)
%c    date and time (e.g., 09/16/98 23:48:10)
%d    day of the month (16) [01-31]
%H    hour, using a 24-hour clock (23) [00-23]
%I    hour, using a 12-hour clock (11) [01-12]
%M    minute (48) [00-59]
%m    month (09) [01-12]
%p    either "am" or "pm" (pm)
%S    second (10) [00-61]
%w    weekday (3) [0-6 = Sunday-Saturday]
%x    date (e.g., 09/16/98)
%X    time (e.g., 23:48:10)
%Y    full year (1998)
%y    two-digit year (98) [00-99]
%%    the character `%´



            ["CovenantAndAnima"] = {
                {
                    60,
                    -- 0,
                },
                {
                },
                {
                },
                {
                },
            },



local CovenantAndAnima = "curCov     #     renown  anima     #      renown  anima   #    renown  anima  #    renown  anima"



