local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-- local isElvUI = IsAddOnLoaded("ElvUI")
-- local _, _, _, isRCLootCouncil = GetAddOnInfo("RCLootCouncil")
----------------------------------------------------------------------------------------------------------------------------------
local enable_module = true
if enable_module == true then
	print ("Octo_AutoTurnIn |CFFFF0000ВКЛЮЧЕН|r")
	local Octo_AutoTurnInFrame_EventFrame = nil
	function Octo_AutoTurnInOnLoad()
		if not Octo_AutoTurnInFrame_EventFrame then
			Octo_AutoTurnInFrame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
		end
		Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_DETAIL")
		Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_COMPLETE")
		Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_GREETING")
		Octo_AutoTurnInFrame_EventFrame:RegisterEvent("GOSSIP_SHOW")
		Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_PROGRESS")
		Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
		Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_ACCEPTED")
	end





	local function OnEvent(self, event, ...)
		if event == "QUEST_DETAIL" then
			print (event)
			AcceptQuest()
		elseif event == "QUEST_COMPLETE" then
			print (event)
			GetQuestReward(1)
		elseif event == "QUEST_GREETING" then -- Запускается при разговоре с NPC, который предлагает или принимает более одного квеста, т. е. имеет более одного активного или доступного квеста.
			print (event)
		-- elseif event == "GOSSIP_SHOW" then
		-- 	print (event)
		-- elseif event == "QUEST_PROGRESS" then
		-- 	print (event)
		-- elseif event == "QUEST_LOG_UPDATE" then
		-- 	print (event)
		-- elseif event == "QUEST_ACCEPTED" then
		-- 	print (event)
		end
	end

	Octo_AutoTurnInOnLoad()
	Octo_AutoTurnInFrame_EventFrame:SetScript("OnEvent", OnEvent) --for function
end