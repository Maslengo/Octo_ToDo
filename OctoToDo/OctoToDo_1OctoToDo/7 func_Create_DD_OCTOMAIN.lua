local GlobalAddonName, E = ...
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
		local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
		f:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
		f:SetPoint("TOPLEFT", 8, -2)
		f:SetPoint("BOTTOMRIGHT", -8, 2)
		f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
		f:SetBackdropBorderColor(0, 0, 0, 1)
		return f
end)
----------------------------------------------------------------
local AddonHeight = 20
local AddonLeftFrameWeight = 200
local AddonCentralFrameWeight = 90
local MainFrameDefaultLines = 30
local MainFrameTotalLines = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / AddonHeight))*.7)
if MainFrameDefaultLines > MainFrameTotalLines then
	MainFrameDefaultLines = MainFrameTotalLines
end
local SFDropDownWeight = 100
----------------------------------------------------------------


function E.func_Create_DD_OCTOMAIN()
	local DD_OCTOMAIN = CreateFrame("Button", "DD_OCTOMAIN", OctoToDo_MainFrame_OCTOMAIN, "SecureActionButtonTemplate, BackDropTemplate")
	DD_OCTOMAIN:SetSize(SFDropDownWeight, AddonHeight)
	E:func_SetBackdrop(DD_OCTOMAIN)
	DD_OCTOMAIN.ExpandArrow = DD_OCTOMAIN:CreateTexture(nil, "ARTWORK")
	DD_OCTOMAIN.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DD_OCTOMAIN.ExpandArrow:SetSize(16, 16)
	DD_OCTOMAIN.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD_OCTOMAIN.text = DD_OCTOMAIN:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_OCTOMAIN.text:SetAllPoints()
	DD_OCTOMAIN.text:SetFontObject(OctoFont11)
	DD_OCTOMAIN.text:SetJustifyV("MIDDLE")
	DD_OCTOMAIN.text:SetJustifyH("CENTER")
	DD_OCTOMAIN.text:SetTextColor(1, 1, 1, 1)
	DD_OCTOMAIN.text:SetText(E.classColorHexCurrent..L["Characters"].."|r")
	LibSFDropDown:SetMixin(DD_OCTOMAIN)
	DD_OCTOMAIN:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOMAIN, "TOPLEFT", 0, 0)
	DD_OCTOMAIN:ddSetDisplayMode(GlobalAddonName)
	DD_OCTOMAIN:ddSetNoGlobalMouseEvent(true)
	DD_OCTOMAIN:ddHideWhenButtonHidden()
	DD_OCTOMAIN:RegisterForClicks("LeftButtonUp")
	DD_OCTOMAIN:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
		end
	)
	local function selectFunctionisShownPLAYER(menuButton, _, _, checked)
		OctoToDo_DB_Levels[menuButton.value].isShownPLAYER = checked
		E.func_CreateMyDataProvider()
	end
	local function func_remove_GUID(menuButton)
		OctoToDo_DB_Levels[menuButton.value] = nil
		E.func_CreateMyDataProvider()
	end
	local function selectFunctionExpansion(menuButton, _, _, checked)
		OctoToDo_DB_Vars.ExpansionToShow[menuButton.value] = checked or nil
		-- DD_OCTOMAIN:SetText("EXP")
		E.func_CreateMyDataProvider()
	end
	DD_OCTOMAIN:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			local count = 0
			-- local ShowOnlyCurrentServer = OctoToDo_DB_Vars.ShowOnlyCurrentServer
			-- local ShowOnlyCurrentBattleTag = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
			-- local OnlyCurrentFaction = OctoToDo_DB_Vars.OnlyCurrentFaction
			-- local Reputations = OctoToDo_DB_Vars.Reputations
			if level == 1 then
				local BnetList = {}
				local OctoToDo_BatlleNets = {}
				for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
					if not BnetList[CharInfo.BattleTagLocal] then
						count = count + 1
						OctoToDo_BatlleNets[count] = CharInfo.BattleTagLocal
					end
					BnetList[CharInfo.BattleTagLocal] = true
				end
				sort(OctoToDo_BatlleNets)
				if count > 1 then
					for i, Bnets in ipairs(OctoToDo_BatlleNets) do
						local info = {}
						info.fontObject = OctoFont11
						info.hasArrow = true
						info.keepShownOnClick = true
						info.notCheckable = true
						local vivod = Bnets
						if Bnets == E.BattleTagLocal then
							vivod = E.classColorHexCurrent..Bnets.."|r"
						end
						if OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag == true then
							if Bnets ~= E.BattleTagLocal then
								vivod = E.Gray_Color..vivod.."|r"
							end
						end
						info.text = vivod
						info.value = Bnets
						tinsert(list, info)
					end
				else
					local GUID, CharInfo = next(OctoToDo_DB_Levels)
					value = CharInfo.BattleTagLocal
				end
			end
			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			if type(value) == "string" then
				local tbl_Players = {}
				for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
					if CharInfo.BattleTagLocal == value or not value then
						tbl_Players[CharInfo.curServer] = tbl_Players[CharInfo.curServer] or {}
						tbl_Players[CharInfo.curServer][GUID] = tbl_Players[CharInfo.curServer][GUID] or {}
						tbl_Players[CharInfo.curServer][GUID] = CharInfo.classColorHex..CharInfo.Name.."|r"..CharInfo.UnitLevel
					end
				end
				for Server, v in next, (tbl_Players) do
					local info = {}
					info.fontObject = OctoFont11
					info.hasArrow = true
					info.keepShownOnClick = true
					info.notCheckable = true
					local vivod = Server
					if OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag and (value ~= E.BattleTagLocal or OctoToDo_DB_Vars.ShowOnlyCurrentServer and Server ~= E.curServer)
					or not OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag and OctoToDo_DB_Vars.ShowOnlyCurrentServer and Server ~= E.curServer
					then
						vivod = E.Gray_Color..vivod.."|r"
					elseif Server == E.curServer then
						vivod = E.classColorHexCurrent..vivod.."|r"
					end
					info.text = vivod
					info.value = v
					tinsert(list, info)
				end
				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			elseif type(value) == "table" then
				local players_list = {}
				for GUID, names in next, (value) do
					tinsert(players_list, GUID)
				end
				sort(players_list, function(a, b)
						local infoA = OctoToDo_DB_Levels[a]
						local infoB = OctoToDo_DB_Levels[b]
						if infoA and infoB then
							return
							infoA.curServer > infoB.curServer or
							infoA.curServer == infoB.curServer and infoA.UnitLevel > infoB.UnitLevel or
							infoA.UnitLevel == infoB.UnitLevel and infoA.avgItemLevel > infoB.avgItemLevel or
							infoA.avgItemLevel == infoB.avgItemLevel and infoB.Name > infoA.Name
						end
					end
				)
				for _, GUID in next, (players_list) do
					local info = {}
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.isNotRadio = true
					local vivod = OctoToDo_DB_Levels[GUID].classColorHex..OctoToDo_DB_Levels[GUID].Name.."|r"
					if OctoToDo_DB_Levels[GUID].UnitLevel ~= E.currentMaxLevel then
						vivod = vivod.." "..E.Yellow_Color..OctoToDo_DB_Levels[GUID].UnitLevel.."|r"
					end
					info.text = vivod
					info.value = GUID
					info.func = selectFunctionisShownPLAYER
					info.checked = OctoToDo_DB_Levels[GUID].isShownPLAYER
					info.remove = func_remove_GUID
					info.removeDoNotHide = true
					info.icon = OctoToDo_DB_Levels[GUID].specIcon
					info.iconInfo = {tSizeX = 16, tSizeY = 16}
					tinsert(list, info)
				end
				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			end
			if level == 1 then
				----------------
				self:ddAddSeparator(level)
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = L["Only Current Server"]
				info.hasArrow = nil
				info.checked = OctoToDo_DB_Vars.ShowOnlyCurrentServer
				info.func = function(_, _, _, checked)
					OctoToDo_DB_Vars.ShowOnlyCurrentServer = checked
					E.func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				if count > 1 then
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false
					info.isNotRadio = true
					info.text = L["Only Current BattleTag"]
					info.hasArrow = nil
					info.checked = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
					info.func = function(_, _, _, checked)
						OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag = checked
						E.func_CreateMyDataProvider()
					end
					self:ddAddButton(info, level)
				end
				----------------
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				if E.func_UnitFaction("PLAYER") == "Horde" then
					info.text = E.func_texturefromIcon(E.Icon_Horde)..L["Only Horde"]
				else
					info.text = E.func_texturefromIcon(E.Icon_Alliance)..L["Only Alliance"]
				end
				info.icon = false
				info.hasArrow = nil
				info.checked = OctoToDo_DB_Vars.OnlyCurrentFaction
				info.func = function(_, _, _, checked)
					OctoToDo_DB_Vars.OnlyCurrentFaction = checked
					E.func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = REPUTATION
				info.icon = false
				info.hasArrow = nil
				info.checked = OctoToDo_DB_Vars.Reputations
				info.func = function(_, _, _, checked)
					OctoToDo_DB_Vars.Reputations = checked
					E.func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				self:ddAddSeparator(level)
				----------------
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = "Show all"
				info.icon = false
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
						CharInfo.isShownPLAYER = true
					end
					E.func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = "Hide all"
				info.icon = false
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
						CharInfo.isShownPLAYER = false
					end
					E.func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				self:ddAddSeparator(level)
				----------------
			end
			if level == 1 then
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = EXPANSION_FILTER_TEXT
				info.value = EXPANSION_FILTER_TEXT
				info.icon = false
				info.hasArrow = true
				info.func = nil
				-- info.func = function(_, _, _, checked)
				--     for expansionID, v in ipairs(E.OctoTable_Expansions) do
				--         OctoToDo_DB_Vars.ExpansionToShow[expansionID] = true
				--     end
				--     E.func_CreateMyDataProvider()
				-- end
				self:ddAddButton(info, level)
			elseif value == EXPANSION_FILTER_TEXT then
				for expansionID, v in ipairs(E.OctoTable_Expansions) do
					info.fontObject = OctoFont11
					info.isNotRadio = true
					info.notCheckable = false
					info.keepShownOnClick = true
					info.text = v.color..v.name.."|r"
					info.value = expansionID
					info.icon = v.icon
					info.checked = OctoToDo_DB_Vars.ExpansionToShow[expansionID]
					info.func = selectFunctionExpansion
					self:ddAddButton(info, level)
				end
				----------------
				self:ddAddSeparator(level)
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = "Show all"
				info.icon = false
				info.func = function(_, _, _, checked)
					for expansionID, v in ipairs(E.OctoTable_Expansions) do
						OctoToDo_DB_Vars.ExpansionToShow[expansionID] = true
					end
					E.func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				--------------------------------------------------
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = "Hide all"
				info.icon = false
				info.func = function(_, _, _, checked)
					for expansionID, v in ipairs(E.OctoTable_Expansions) do
						OctoToDo_DB_Vars.ExpansionToShow[expansionID] = false
					end
					E.func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
			end
		end
	)
	DD_OCTOMAIN:ddSetOpenMenuUp(true)
	DD_OCTOMAIN:ddSetMenuButtonHeight(16)
end