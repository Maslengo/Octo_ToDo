local GlobalAddonName, E = ...
----------------------------------------------------------------
function E.func_StartDebugTimer()
	local timer = debugprofilestart()
	return timer
end
function E.func_StopDebugTimer(funcName)
	if not funcName then funcName = "" end
	local timer = E.func_CompactRoundNumber(debugprofilestop())
	local result = funcName.." "..E.func_Gradient("debug timer: ", "|cffD177FF", "|cff63A4E0")
	result = result..timer
	return DEFAULT_CHAT_FRAME:AddMessage(result.."|cff63A4E0 ms.|r")
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- do
-- 	local funcNames = {
-- 		"Items",
-- 		"Currencies",
-- 		"NPCs",
-- 		"Quests",
-- 		"Reputations",
-- 		"Spells",
-- 		"Achievements",
-- 		"Mounts",
-- 		"Maps",
-- 		"Events",
-- 		"Professions",
-- 		"instanceID",
-- 		"worldBossID",
-- 	}
-- 	for _, name in ipairs(funcNames) do
-- 		E["debugInfo_"..name] = function(id)
-- 			local result = (E.Config_DebugID_ALL or Octo_ToDo_DB_Vars["Config_DebugID_"..name]) and (E.COLOR_GRAY.." id:"..id.."|r") or ""
-- 			return result
-- 		end
-- 	end
-- end

function E.debugInfo(id)
	local result = E.Config_DebugID_ALL and (E.COLOR_GRAY.." id:"..id.."|r") or ""
	return result
end


function E.func_goldenHeight(width)
    -- Золотое сечение: высота = ширина / 1.618
    return width / 1.61803398875
end


function E.func_goldenWidth(height)
    -- Ширина = высота × 1.618
    return height * 1.61803398875
end