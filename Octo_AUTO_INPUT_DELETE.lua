local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
E.modules = {}
--------------------------------------------------------------------------------
tinsert(E.modules, function()
    if Octo_ToDo_DragonflyVars.config.InputDelete == true then
        local TypeDeleteLine = gsub(DELETE_GOOD_ITEM, "[\r\n]", "@")
        local void, TypeDeleteLine = strsplit("@", TypeDeleteLine, 2)
        StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
        StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
        StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
        StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
        StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
        StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
        local easyDelFrame = CreateFrame("FRAME")
        easyDelFrame:RegisterEvent("DELETE_ITEM_CONFIRM")
        easyDelFrame:SetScript("OnEvent", function()
            if StaticPopup1EditBox:IsShown() then
                StaticPopup1EditBox:Hide()
                StaticPopup1Button1:Enable()
                local link = select(3, GetCursorInfo())
                local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
                if linkType == "battlepet" then
                    local speciesID, level, breedQuality = strsplit(":", linkOptions)
                    local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
                    link = qualityColor:WrapTextInColorCode(name .. " |n" .. L["Level"] .. " " .. level .. L["Battle Pet"])
                end
                StaticPopup1Text:SetText(gsub(StaticPopup1Text:GetText(), gsub(TypeDeleteLine, "@", ""), "") .. "|n" .. link)
            else
                StaticPopup1:SetHeight(StaticPopup1:GetHeight() + 40)
                StaticPopup1EditBox:Hide()
                StaticPopup1Button1:Enable()
                local link = select(3, GetCursorInfo())
                local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
                if linkType == "battlepet" then
                    local speciesID, level, breedQuality = strsplit(":", linkOptions)
                    local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
                    link = qualityColor:WrapTextInColorCode(name .. " |n" .. L["Level"] .. " " .. level .. L["Battle Pet"])
                end
                StaticPopup1Text:SetText(gsub(StaticPopup1Text:GetText(), gsub(TypeDeleteLine, "@", ""), "") .. "|n|n" .. link)
            end
        end)
    end
end)