local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
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
function E:func_Create_DDframe_AddonsManager()
	local AddonHeight = OctoToDo_AddonsManager.AddonHeight
	local MainFrameNumLines = OctoToDo_AddonsManager.MainFrameNumLines
	local AddonLeftFrameWeight = OctoToDo_AddonsManager.curWidthTitle
	local DD_AddonsManager = CreateFrame("Button", "DD_AddonsManager", OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
	DD_AddonsManager:SetSize(AddonLeftFrameWeight/4, AddonHeight)
	E:func_SetBackdrop(DD_AddonsManager)
	DD_AddonsManager.ExpandArrow = DD_AddonsManager:CreateTexture(nil, "ARTWORK")
	DD_AddonsManager.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DD_AddonsManager.ExpandArrow:SetSize(16, 16)
	DD_AddonsManager.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD_AddonsManager.text = DD_AddonsManager:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_AddonsManager.text:SetAllPoints()
	DD_AddonsManager.text:SetFontObject(OctoFont11)
	DD_AddonsManager.text:SetJustifyV("MIDDLE")
	DD_AddonsManager.text:SetJustifyH("CENTER")
	DD_AddonsManager.text:SetTextColor(1, 1, 1, 1)
	DD_AddonsManager.text:SetText(MAIN_MENU)
	LibSFDropDown:SetMixin(DD_AddonsManager)
	DD_AddonsManager:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_AddonsManager, "TOPLEFT", 0, 0)
	DD_AddonsManager:ddSetDisplayMode(GlobalAddonName)
	DD_AddonsManager:ddSetOpenMenuUp(true)
	DD_AddonsManager:ddSetNoGlobalMouseEvent(true)
	DD_AddonsManager:ddHideWhenButtonHidden()
	DD_AddonsManager:RegisterForClicks("LeftButtonUp")
	DD_AddonsManager:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	DD_AddonsManager:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			if level == 1 then
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = L["fullName"]
				info.hasArrow = nil
				info.checked = OctoToDo_AddonsManager.config.fullName
				info.func = function(_, _, _, checked)
					OctoToDo_AddonsManager.config.fullName = checked
					E.AddonList_Update()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = L["showIcons"]
				info.value = "showIcons"
				info.hasArrow = true
				info.checked = OctoToDo_AddonsManager.config.showIcons
				info.func = function(_, _, _, checked)
					OctoToDo_AddonsManager.config.showIcons = checked
					E.AddonList_Update()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = L["showVersion"]
				info.hasArrow = nil
				info.checked = OctoToDo_AddonsManager.config.showVersion
				info.func = function(_, _, _, checked)
					OctoToDo_AddonsManager.config.showVersion = checked
					E.AddonList_Update()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..L["showIndex"].."|r"
				info.hasArrow = nil
				info.checked = OctoToDo_AddonsManager.config.showIndex
				info.func = function(_, _, _, checked)
					OctoToDo_AddonsManager.config.showIndex = checked
					E.AddonList_Update()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = ADDON_FORCE_LOAD
				info.hasArrow = nil
				info.checked = not C_AddOns.IsAddonVersionCheckEnabled()
				info.func = function(_, _, _, checked)
					E.compat.SetAddonVersionCheck(not checked)
					E.AddonList_Update()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = L["defaultAddonList"]
				info.hasArrow = nil
				info.checked = OctoToDo_AddonsManager.config.defaultAddonList
				info.func = function(_, _, _, checked)
					OctoToDo_AddonsManager.config.defaultAddonList = checked
					E.CreateMyDataProvider()
					E.AddonList_Update()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = L["showOnlyLoaded"]
				info.hasArrow = nil
				info.checked = OctoToDo_AddonsManager.config.showOnlyLoaded
				info.func = function(_, _, _, checked)
					OctoToDo_AddonsManager.config.showOnlyLoaded = checked
					E.CreateMyDataProvider()
					E.AddonList_Update()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				self:ddAddSeparator(level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = "ПРОФИЛИ"
				info.value = "ПРОФИЛИ"
				info.hasArrow = true
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE
				info.value = CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE
				info.hasArrow = true
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				self:ddAddSeparator(level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = ENABLE_ALL_ADDONS
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					E.func_EnableAllAddOns()
					E.AddonList_Update()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = DISABLE_ALL_ADDONS
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					E.func_DisableAllAddons()
					E.AddonList_Update()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				self:ddAddSeparator(level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..BINDING_HEADER_DEBUG.."|r"
				info.value = BINDING_HEADER_DEBUG
				info.hasArrow = true
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			elseif value == BINDING_HEADER_DEBUG then
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color.."fpde(OctoToDo_AddonsManager)".."|r"
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					fpde(OctoToDo_AddonsManager)
					for k, v in ipairs(E.OctoTable_Frames) do
						if v:IsShown() then
							if k == 2 then
								-- ПОФИКСИТЬ
								v:Hide()
							end
						end
					end
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..DELETE.." "..ALL.."|r"
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					OctoToDo_AddonsManager = {}
					ReloadUI()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..RELOADUI.."|r"
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					ReloadUI()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			elseif value == "showIcons" then
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = L["showIconsQuestionMark"]
				info.hasArrow = nil
				info.checked = OctoToDo_AddonsManager.config.showIconsQuestionMark
				info.func = function(_, _, _, checked)
					OctoToDo_AddonsManager.config.showIconsQuestionMark = checked
					E.AddonList_Update()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			elseif value == CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE then
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = "Create"
				info.hasArrow = nil
				info.func = function() self:createProfile() end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = "|cffFFFFFFCopy current|r" -- ПОФИКСИТЬ
				info.hasArrow = nil
				info.func = function() self:createProfile(true) end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			elseif value == "ПРОФИЛИ" then
				----------------------------------------------------------------
				for profileName, v in next, (OctoToDo_AddonsManager.profiles) do
					print (profileName, "QWEQWEQWEWE")
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = profileName
					info.value = profileName
					info.hasArrow = true
					info.func = function()
						E.func_LoadProfile(profileName)
						E.AddonList_Update()
					end
					self:ddAddButton(info, level)
				end
				----------------------------------------------------------------
				self:ddAddSeparator(level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..RELOADUI.."|r"
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					ReloadUI()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			elseif value == profileName then
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..RELOADUI.."|r"
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					ReloadUI()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			end
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
	end)
	DD_AddonsManager:ddSetMenuButtonHeight(16)
end