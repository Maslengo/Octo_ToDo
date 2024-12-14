local GlobalAddonName = ...
local OctoToDo_EventFrame = CreateFrame("FRAME")
OctoToDo_EventFrame:Hide()
local E = OctoToDo_ToDO_E
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")








OctoToDo_EventFrame:RegisterEvent("ADDON_LOADED")
OctoToDo_EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
function OctoToDo_EventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		OctoToDo_TrashCan = OctoToDo_TrashCan or {}
		----------------------------------------------------------------
		-- MINIMAP
		----------------------------------------------------------------
		local MinimapName = E.func_AddonTitle(GlobalAddonName)
		local ldb_icon = LibDataBroker:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = E.func_AddonIconTexture(GlobalAddonName),
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, E.func_AddonTitle(GlobalAddonName).."|n".."ПКМ - Настройки")
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		OctoToDo_TrashCan.minimap = OctoToDo_TrashCan.minimap or {}
		OctoToDo_TrashCan.minimap.minimapPos = OctoToDo_TrashCan.minimap.minimapPos or 244
		LibDBIcon:Register(MinimapName, ldb_icon, OctoToDo_TrashCan.minimap)
		LibDBIcon:Show(MinimapName)
		----------------------------------------------------------------
	end
end



