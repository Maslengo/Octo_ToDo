local GlobalAddonName, E = ...
if not E.Enable_Moduls then return end



local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibCustomGlow = LibStub("LibCustomGlow-1.0")

local Octo_EventFrame_PortalsFrame = CreateFrame("Frame")
Octo_EventFrame_PortalsFrame:Hide()

local function ShouldShowButton(v, curFaction, curRace, curClass, curProfession, curLevel)
	if type(v) == "number" then return true end

	return (not v.faction or v.faction == curFaction)
		and (not v.race or v.race == curRace)
		and (not v.class or v.class == curClass)
		and (not v.profession or v.profession == curProfession)
		and (not v.level or v.level <= curLevel)
end

function Octo_EventFrame_PortalsFrame:PortalsFrame()
	local Height = 40 -- Octo_ToDo_DB_Vars.AddonHeight
	local curFaction = UnitFactionGroup("player")
	local curRace = select(2, UnitRace("player"))
	local curClass = select(2, UnitClass("player"))
	local curLevel = UnitLevel("player")

	-- Get profession
	local curProfession = ""
	for _, v in next, {GetProfessions()} do
		if select(7, GetProfessionInfo(v)) == 202 then
			curProfession = "Engineering"
			break
		end
	end

	-- Create anchor frame
	local indend = 1
	local AnchorFrame = CreateFrame("Frame", nil, GameMenuFrame, "BackdropTemplate")
	AnchorFrame:SetPoint("TOPRIGHT", GameMenuFrame, "TOPLEFT", -(indend*2), Height+(indend*2))
	AnchorFrame:SetSize(Height, Height)

	AnchorFrame.icon = AnchorFrame:CreateTexture()
	AnchorFrame.icon:SetAllPoints(AnchorFrame)
	AnchorFrame.icon:SetTexture(format("Interface\\AddOns\\%s\\Media\\ElvUI\\Arrow0.tga", GlobalAddonName))
	AnchorFrame.icon:SetRotation(math.pi * 0.75)
	E:func_SetBackdrop(AnchorFrame)

	-- Add click handler if not already added
	if not AnchorFrame.isInit2 then
		AnchorFrame.isInit2 = true
		AnchorFrame:HookScript("OnMouseUp", function(self)
			for _, child in ipairs({self:GetChildren()}) do
				child:SetShown(not child:IsShown())
			end
		end)
	end

	-- Create buttons if not in combat
	if not InCombatLockdown() and Octo_MainFrame_ToDo then
		local column = 1
		for _, tbl in ipairs(E.OctoTable_Portals) do
			local row = 1

			for _, v in ipairs(tbl) do
				if ShouldShowButton(v, curFaction, curRace, curClass, curProfession, curLevel) then
					local id = type(v) == "number" and v or v.id
					local curType = type(v) == "number" and "spell" or v.curType

					if not Octo_ToDo_DB_Vars.PortalsButtonsOnlyAvailable or E:func_IsAvailable(id, curType) then
						-- E:CreateUsableSpellFrame(
						E:OctoCreateButton(


							id,
							"TOPLEFT",
							AnchorFrame,
							"TOPLEFT",
							-(Height+indend) * column,
							-(Height+indend) * row,
							Height,
							curType
						)
						row = row + 1
					end
				end
			end

			if row > 1 then
				column = column + 1
			end
		end
	end
end

E.PortalsFrame = Octo_EventFrame_PortalsFrame.PortalsFrame