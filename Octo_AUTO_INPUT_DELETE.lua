local TypeDeleteLine = gsub(DELETE_GOOD_ITEM, "[\r\n]", "@")
local void, TypeDeleteLine = strsplit("@", TypeDeleteLine, 2)
local Enable_Module = true
if Enable_Module == true then
    -- Add hyperlinks to regular item destroy
    StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
    StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
    StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
    StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
    StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
    StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave

    -- Hide editbox and set item link
    local easyDelFrame = CreateFrame("FRAME")
    easyDelFrame:RegisterEvent("DELETE_ITEM_CONFIRM")
    easyDelFrame:SetScript("OnEvent", function()
        if StaticPopup1EditBox:IsShown() then
            -- Item requires player to type delete so hide editbox and show link
            StaticPopup1EditBox:Hide()
            StaticPopup1Button1:Enable()
            local link = select(3, GetCursorInfo())
            -- Custom link for battle pets
            local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
            if linkType == "battlepet" then
                local speciesID, level, breedQuality = strsplit(":", linkOptions)
                local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
                link = qualityColor:WrapTextInColorCode(name .. " |n" .. L["Level"] .. " " .. level .. L["Battle Pet"])
            end
            StaticPopup1Text:SetText(gsub(StaticPopup1Text:GetText(), gsub(TypeDeleteLine, "@", ""), "") .. "|n" .. link)
        else
            -- Item does not require player to type delete so just show item link
            StaticPopup1:SetHeight(StaticPopup1:GetHeight() + 40)
            StaticPopup1EditBox:Hide()
            StaticPopup1Button1:Enable()
            local link = select(3, GetCursorInfo())
            -- Custom link for battle pets
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