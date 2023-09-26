COMBAT_LOG_EVENT_UNFILTERED:SPELL_CAST_SUCCESS
----------------------------------------------
function(event, _, message, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName)
    if(message == "SPELL_CAST_SUCCESS") and (spellID == 73325 or spellID == 161399) then
        SendChatMessage(source .. " gripped " .. dest, "RAID", nil)
        return true
    end
end
----------------------------------------------
function()
    return true
end