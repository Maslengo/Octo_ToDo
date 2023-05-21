local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
E.modules = {}
--------------------------------------------------------------------------------
local Octo_AUTO_GOSSIP = CreateFrame("Frame", AddonTitle)
--local Enable_Module = true
-- Octo_AUTO_GOSSIP:RegisterEvent("QUEST_GREETING")
Octo_AUTO_GOSSIP:RegisterEvent("GOSSIP_SHOW")
-- Octo_AUTO_GOSSIP:RegisterEvent("QUEST_DETAIL")
-- Octo_AUTO_GOSSIP:RegisterEvent("QUEST_PROGRESS")
-- Octo_AUTO_GOSSIP:RegisterEvent("QUEST_COMPLETE")
-- Octo_AUTO_GOSSIP:RegisterEvent("QUEST_LOG_UPDATE")
-- Octo_AUTO_GOSSIP:RegisterEvent("QUEST_ACCEPTED")
Octo_AUTO_GOSSIP:SetScript("OnEvent", function(self, event, ...)
		if Octo_ToDo_DragonflyVars.config.AutoGossip and event == "GOSSIP_SHOW" then
--https://wowpedia.fandom.com/wiki/Category:API_namespaces/C_GossipInfo
				local numQuests1 = C_GossipInfo.GetNumActiveQuests()
				local numQuests2 = C_GossipInfo.GetNumAvailableQuests()
				--local info1 = C_GossipInfo.GetActiveQuests()
				--local info2 = C_GossipInfo.GetAvailableQuests()
				-- print ("numQuests1: "..numQuests1)
				-- print ("numQuests2: "..numQuests2)
				-- print (info1)
				-- print (info2)
				if numQuests1 > 0 or numQuests2 > 0 or InCombatLockdown() then return end
-- title	string
-- questLevel	number
-- isTrivial	boolean
-- frequency	number?
-- repeatable	boolean?
-- isComplete	boolean?
-- isLegendary	boolean
-- isIgnored	boolean
-- questID	number
			local UnitID = "TARGET"
			local guid = UnitGUID(UnitID)
			local First_Option = {
				[193127] = true, --https://ru.wowhead.com/npc=193127
				[167032] = true, --Хроми в огри
				-- SL covenant swap in Oribos
				[171787] = true,
				[171821] = true,
				[171795] = true,
				[171589] = true,
				[188868] = true, -- Гаргток <Организатор боев>
				[36939] = true, -- ЦЛК Битва на кораблях в Ледяной Короне
				[37187] = true, -- ЦЛК Саурфанг Смертоносный
				[38995] = true, -- ЦЛК Король-лич
				[187495] = true, -- Гневион
				[185894] = true, -- Сабелион
				[194916] = true,
				[192722] = true,
				[189895] = true, --Жители Вальдракена(ебаный квест)
				[189869] = true,
				[198927] = true, --Служитель времени (не тайм в кее)
				--legion прокчка
				[4311] = true,
				--DRAENOR прокачка
				[149626] = true, -- ТП в вызженные(огри)
				[78423] = true, --Кадгар (вызженные)
				[78556] = true, --Килрог у глаз (цепочка дренора)
				[80225] = true, -- заставить батраков работать
				[86775] = true, -- заставить батраков 2
				[78563] = true,
				[91483] = true, -- Панда в ашране
				[167298] = true, -- остров
				[167598] = true, -- /помахать https://ru.wowhead.com/quest=59978
				[168441] = true,
				--DF
				[184796] = true,
				[184787] = true,
				[184795] = true,
				[199532] = true, --2 на острове
				[200987] = true, --3 на острове про суп
				--[200040] = true, --4 вход в жирного
				[204185] = true,
			}
			local Second_Option = {
				[201398] = true, -- 1 в городе
			}
			if guid and UnitGUID(UnitID):match("%a+") ~= "Player" then
					local info = C_GossipInfo.GetOptions()
					local targetNPCID = tonumber(UnitGUID(UnitID):match("-(%d+)-%x+$"), 10)
					for i, v in ipairs(info) do
						--print (i..") "..v.icon.."|T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
						if
						-- v.name == "Я хочу опробовать этот маршрут." or
						-- v.name == "Я готова." or
						-- v.name == "<Съесть немного супа.>" or
						-- v.name == "У меня есть для тебя один знак Сарги." or
						-- v.name == "У меня есть для тебя одна печатка Сарги." or
						-- v.name == "Я подам сигнал к началу великой охоты!" or
						v.name == "Выбрать временную линию." or
						v.name:find("Попробовать") or
						v.name:find("Кинуук") or
						v.name:find("Нужно добавить") or
						v.name:find("taste") or
						v.name:find("Задание")
						and not IsShiftKeyDown() then
							C_GossipInfo.SelectOption(v.gossipOptionID)
							StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
							print ("|cFF00A3FFAUTO_GOSSIP SELECT:|r |cff00FF00("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t|cFFFF5771"..v.name.."|r")
						end
						if First_Option[targetNPCID] and not IsShiftKeyDown() then
							C_GossipInfo.SelectOption(v.gossipOptionID)
							StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
							print ("|cFF00A3FFAUTO_GOSSIP SELECT:|r |cff00FF00("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t|cFFFF5771"..v.name.."|r")
						end
						if Second_Option[targetNPCID] and not IsShiftKeyDown() and i == 2 then
							C_GossipInfo.SelectOption(v.gossipOptionID)
							StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
							print ("|cFF00A3FFAUTO_GOSSIP SELECT:|r |cff00FF00("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t|cFFFF5771"..v.name.."|r")
						end
						if #info == 1 and not IsShiftKeyDown() then -- Длина строки
							C_GossipInfo.SelectOption(v.gossipOptionID)
							StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
						end
						-- if i == 1 and i ~= 2 and v.icon == 132053 and not IsShiftKeyDown() then
						-- 	C_GossipInfo.SelectOption(v.gossipOptionID)
						-- 	StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
						-- 	print ("3".."|cFF00A3FFAUTO_GOSSIP SELECT:|r |cff00FF00("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t|cFFFF5771"..v.name.."|r")
						-- end
					end
				end
			end
end)
-- 132060 Можно мне взглянуть на товар?
-- 132053 попиздеть белая с черточкой
-- 136358 Я хочу остановиться здесь.
-- 11673939 трансмогрификация
-- 2132060 Мне бы хотелось купить что-нибудь у тебя(такой же как и 132060)
-- 4382512 CLOWN(просто так)
-- 1132050 Я хотел бы проверить свою ячейку.