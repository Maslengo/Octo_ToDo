local GlobalAddonName, E = ...
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
function E.debugInfo(id)
	local result = E.Config_DebugID_ALL and (E.COLOR_GRAY.." id:"..id.."|r") or ""
	return result
end
function E.func_goldenHeight(width)
	return width / 1.61803398875
end
function E.func_goldenWidth(height)
	return height * 1.61803398875
end