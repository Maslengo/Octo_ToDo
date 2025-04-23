-- local GlobalAddonName, E = ...
-- local LibThingsLoad = LibStub("LibThingsLoad-1.0")
-- local LibCustomGlow = LibStub("LibCustomGlow-1.0")
-- ----------------------------------------------------------------------------------------------------------------------------------
-- local Octo_PortalsFrame = CreateFrame("Frame")
-- Octo_PortalsFrame:Hide()
-- -- Octo_PortalsFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
-- -- Octo_PortalsFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
-- function Octo_PortalsFrame:PortalsFrame()
-- 	local Height = Octo_ToDo_DB_Vars.AddonHeight
-- 	local curFaction = UnitFactionGroup("PLAYER")
-- 	local curRace = select(2, UnitRace("PLAYER"))
-- 	local curClass = select(2, UnitClass("PLAYER"))
-- 	local curProfession = ""
-- 	for _, v in next, ({GetProfessions()}) do
-- 		local skillLine = select(7, GetProfessionInfo(v))
-- 		if skillLine == 202 then
-- 			curProfession = "Engineering"
-- 		end
-- 	end
-- 	local curLevel = UnitLevel("PLAYER")
-- 	local AnchorFrame = CreateFrame("Frame", nil, Octo_MainFrame_ToDo, "BackdropTemplate")
-- 	AnchorFrame:SetPoint("TOPRIGHT", Octo_MainFrame_ToDo, "TOPLEFT", 0, Height)
-- 	AnchorFrame:SetSize(Height, Height)
-- 	AnchorFrame.icon = AnchorFrame:CreateTexture()
-- 	AnchorFrame.icon:SetAllPoints(AnchorFrame)
-- 	AnchorFrame.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow0.tga")
-- 	-- AnchorFrame.icon:SetTexture(3610528)
-- 	AnchorFrame.icon:SetRotation(math.pi*0.75)
-- 	E:func_SetBackdrop(AnchorFrame)
-- 	if not AnchorFrame.isInit2 then
-- 		AnchorFrame.isInit2 = true
-- 		if AnchorFrame then
-- 			AnchorFrame:HookScript("OnMouseUp", function(self)
-- 					local children = {AnchorFrame:GetChildren()}
-- 					for i, child in ipairs(children) do
-- 						child:SetShown(not child:IsShown())
-- 					end
-- 			end)
-- 		end
-- 	end
-- 	-- Octo_ToDo_DB_Vars.PortalsButtonsOnlyAvailable
-- 	if not InCombatLockdown() then
-- 		if Octo_MainFrame_ToDo then
-- 			-- fpde(E.OctoTable_Portals)
-- 			local stolbec = 1
-- 			for _, tbl in ipairs(E.OctoTable_Portals) do
-- 				local stroka = 1
-- 				for _, v in ipairs (tbl) do
-- 					if type(v) == "number" then
-- 						if (Octo_ToDo_DB_Vars.PortalsButtonsOnlyAvailable == true and E:func_IsAvailable(v, "spell") == true) then
-- 							E:CreateUsableSpellFrame(v, "TOPLEFT", AnchorFrame, "TOPLEFT", -Height*stolbec, -Height*stroka, Height)
-- 							stroka = stroka + 1
-- 						elseif Octo_ToDo_DB_Vars.PortalsButtonsOnlyAvailable == false then
-- 							E:CreateUsableSpellFrame(v, "TOPLEFT", AnchorFrame, "TOPLEFT", -Height*stolbec, -Height*stroka, Height)
-- 							stroka = stroka + 1
-- 						end
-- 					else
-- 						if (not v.faction or v.faction == curFaction)
-- 						and (not v.race or v.race == curRace)
-- 						and (not v.class or v.class == curClass)
-- 						and (not v.profession or v.profession == curProfession)
-- 						and (not v.level or v.level > curLevel)
-- 						then
-- 							if (Octo_ToDo_DB_Vars.PortalsButtonsOnlyAvailable == true and E:func_IsAvailable(v.id, v.curType) == true) then
-- 								E:CreateUsableSpellFrame(v.id, "TOPLEFT", AnchorFrame, "TOPLEFT", -Height*stolbec, -Height*stroka, Height, v.curType)
-- 								stroka = stroka + 1
-- 							elseif Octo_ToDo_DB_Vars.PortalsButtonsOnlyAvailable == false then
-- 								E:CreateUsableSpellFrame(v.id, "TOPLEFT", AnchorFrame, "TOPLEFT", -Height*stolbec, -Height*stroka, Height, v.curType)
-- 								stroka = stroka + 1
-- 							end
-- 						end
-- 					end
-- 				end
-- 				if stroka > 1 then
-- 					stolbec = stolbec + 1
-- 				end
-- 			end
-- 		end
-- 	end
-- end
-- E.PortalsFrame = Octo_PortalsFrame.PortalsFrame


















local GlobalAddonName, E = ...
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibCustomGlow = LibStub("LibCustomGlow-1.0")

local Octo_PortalsFrame = CreateFrame("Frame")
Octo_PortalsFrame:Hide()

local function ShouldShowButton(v, curFaction, curRace, curClass, curProfession, curLevel)
    if type(v) == "number" then return true end

    return (not v.faction or v.faction == curFaction)
        and (not v.race or v.race == curRace)
        and (not v.class or v.class == curClass)
        and (not v.profession or v.profession == curProfession)
        and (not v.level or v.level <= curLevel)
end

function Octo_PortalsFrame:PortalsFrame()
    local Height = Octo_ToDo_DB_Vars.AddonHeight
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
    local AnchorFrame = CreateFrame("Frame", nil, Octo_MainFrame_ToDo, "BackdropTemplate")
    AnchorFrame:SetPoint("TOPRIGHT", Octo_MainFrame_ToDo, "TOPLEFT", 0, Height)
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
                        E:CreateUsableSpellFrame(
                            id,
                            "TOPLEFT",
                            AnchorFrame,
                            "TOPLEFT",
                            -Height * column,
                            -Height * row,
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

E.PortalsFrame = Octo_PortalsFrame.PortalsFrame