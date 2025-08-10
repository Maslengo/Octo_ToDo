-- local GlobalAddonName, ns = ...
-- E = _G.OctoEngine
-- local Octo_EventFrame_TEST = CreateFrame("FRAME")
-- Octo_EventFrame_TEST:Hide()

-- -- Создание главного фрейма для тестового интерфейса
-- local Octo_MainFrame_TEST = CreateFrame("BUTTON", "Octo_MainFrame_TEST", UIParent, "BackdropTemplate")
-- Octo_MainFrame_TEST:Hide()







-- function Octo_EventFrame_TEST:Octo_Create_MainFrame_TestFrame()
-- 	local ScrollBox = CreateFrame("Frame", nil, UIParent, "WowScrollBoxList")
-- 	ScrollBox:SetPoint("CENTER")
-- 	ScrollBox:SetSize(300, 300)

-- 	local ScrollBar = CreateFrame("EventFrame", nil, UIParent, "MinimalScrollBar")
-- 	ScrollBar:SetPoint("TOPLEFT", ScrollBox, "TOPRIGHT")
-- 	ScrollBar:SetPoint("BOTTOMLEFT", ScrollBox, "BOTTOMRIGHT")

-- 	local DataProvider = CreateTreeDataProvider()
-- 	local ScrollView = CreateScrollBoxListTreeListView()
-- 	ScrollView:SetDataProvider(DataProvider)

-- 	ScrollUtil.InitScrollBoxListWithScrollBar(ScrollBox, ScrollBar, ScrollView)

-- 	local function Initializer(button, node)
-- 		local frameData = node:GetData()
-- 		button:SetText(frameData.text)
-- 		button:SetScript("OnClick", function()
-- 			node:ToggleCollapsed()
-- 		end)
-- 	end

-- 	ScrollView:SetElementInitializer("UIPanelButtonTemplate", Initializer)

-- 	for i, v in ipairs(E.OctoTable_Expansions) do
-- 			local catName = v.color .. v.name .. "|r"
-- 			-- Первый уровень (родительский элемент)
-- 			local FIRST = DataProvider:Insert({
-- 				text = catName,
-- 			})
-- 			FIRST:SetCollapsed(self:isCatCollapsed(catName))

-- 			local SECOND = FIRST:Insert({
-- 				text = v.nameBlizzard,
-- 			})
-- 	end
-- end

-- function Octo_EventFrame_TEST:isCatCollapsed(name)
-- 	return self.catCollapsed[name] and self.notSearched
-- end

-- local MyEventsTable = {
-- 	"ADDON_LOADED",
-- 	"PLAYER_LOGIN",
-- }
-- E:func_RegisterMyEventsToFrames(Octo_EventFrame_TEST, MyEventsTable)
-- function Octo_EventFrame_TEST:ADDON_LOADED(addonName)
-- 	if addonName ~= GlobalAddonName then return end
-- 	SavedVariables = SavedVariables or {}
-- 	self.db = SavedVariables
-- 	self.db.catCollapsed = self.db.catCollapsed or {}

-- 	self.catCollapsed = self.db.catCollapsed
-- end

-- function Octo_EventFrame_TEST:PLAYER_LOGIN()
-- 	Octo_EventFrame_TEST:Octo_Create_MainFrame_TestFrame()
-- end



-- -- SetElementFactory
-- -- self.view:SetElementFactory(function(factory, node)
-- -- 	local data = node:GetData()
-- -- 	if data.isNormal then
-- -- 		factory(normalTemp, normalInit)
-- -- 	elseif data.isParent then
-- -- 		factory(parentTemp, parentInit)
-- -- 	elseif data.isCategory then
-- -- 		factory(categoryTemp, categoryInit)
-- -- 	else
-- -- 		factory(devidierTemp)
-- -- 	end
-- -- end)