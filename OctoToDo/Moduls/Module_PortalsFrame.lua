local GlobalAddonName, E = ...
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
----------------------------------------------------------------------------------------------------------------------------------
local OctoToDo_PortalsFrame = CreateFrame("Frame")
OctoToDo_PortalsFrame:Hide()
-- OctoToDo_PortalsFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
-- OctoToDo_PortalsFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

function OctoToDo_PortalsFrame:PortalsFrame()
	local Height = OctoToDo_DB_Vars.curHeight
	local curFaction = UnitFactionGroup("PLAYER")
	local RaceLocal, curRace, raceID = UnitRace("PLAYER")
	local className, curClass, classId = UnitClass("PLAYER")

	local curProfession = ""

	for k, v in next, ({GetProfessions()}) do
		local skillLine = select(7, GetProfessionInfo(v))
		if skillLine == 202 then
			curProfession = "Engineering"
		end
	end
	local curLevel = UnitLevel("PLAYER")
	local AnchorFrame = CreateFrame("Frame", nil, OctoToDo_MainFrame_OCTOMAIN, "BackdropTemplate")
	AnchorFrame:SetPoint("TOPRIGHT", OctoToDo_MainFrame_OCTOMAIN, "TOPLEFT", 0, Height)
	AnchorFrame:SetSize(Height, Height)

	AnchorFrame.icon = AnchorFrame:CreateTexture()
	AnchorFrame.icon:SetAllPoints(AnchorFrame)
	AnchorFrame.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow0.tga")



	-- AnchorFrame.icon:SetTexture(3610528)
	AnchorFrame.icon:SetRotation(math.pi*0.75)
	E:func_SetBackdrop(AnchorFrame)

	if not AnchorFrame.isInit2 then
		AnchorFrame.isInit2 = true
		if AnchorFrame then
			AnchorFrame:HookScript("OnMouseUp", function(self)
				local children = {AnchorFrame:GetChildren()}
				for i, child in ipairs(children) do
					child:SetShown(not child:IsShown())
				end
			end)
		end
	end


	if not InCombatLockdown() then
		if OctoToDo_MainFrame_OCTOMAIN then
			-- fpde(E.OctoTable_Portals)
			local stolbec = 1
			for _, tbl in ipairs(E.OctoTable_Portals) do
				local stroka = 1
				for _, v in ipairs (tbl) do
					if type(v) == "number" then
						E:CreateUsableSpellFrame(v, "TOPLEFT", AnchorFrame, "TOPLEFT", -Height*stolbec, -Height*stroka, Height)
						stroka = stroka + 1
					else
						if (not v.faction or v.faction == curFaction)
							and (not v.race or v.race == curRace)
							and (not v.class or v.class == curClass)
							and (not v.profession or v.profession == curProfession)
							and (not v.level or v.level > curLevel)
							then
							E:CreateUsableSpellFrame(v.id, "TOPLEFT", AnchorFrame, "TOPLEFT", -Height*stolbec, -Height*stroka, Height, v.isItem)
							stroka = stroka + 1
						end
					end
				end
				if stroka > 1 then
					stolbec = stolbec + 1
				end
			end
		end
	end
end

local MyEventsTable = {
	"ADDON_LOADED",
}
E.RegisterMyEventsToFrames(OctoToDo_PortalsFrame, MyEventsTable, E.func_DebugPath())

function OctoToDo_PortalsFrame:ADDON_LOADED(addonName)

	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		C_Timer.After(.1, function()
			if OctoToDo_DB_Vars.PortalsButtons then
				self:PortalsFrame()
			end
		end)
	end
end

-- function OctoToDo_PortalsFrame:PLAYER_REGEN_DISABLED()
-- end

-- function OctoToDo_PortalsFrame:PLAYER_REGEN_ENABLED()
-- end