local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
-- AUTO_INPUT_DELETE
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.InputDelete then
			local TypeDeleteLine = gsub(DELETE_GOOD_ITEM, "[\r\n]", "@")
			local void, TypeDeleteLine = strsplit("@", TypeDeleteLine, 2)
			-- StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
			-- StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
			-- StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
			-- StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
			-- StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
			-- StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
			-- StaticPopupDialogs["UNLEARN_SKILL"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
			-- StaticPopupDialogs["UNLEARN_SKILL"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
			if not easyDelFrame then
				easyDelFrame = CreateFrame("FRAME")
				easyDelFrame:Hide()
			end
			easyDelFrame:RegisterEvent("DELETE_ITEM_CONFIRM")
			easyDelFrame:SetScript("OnEvent", function()
					local i = 1
					local popup = _G["StaticPopup"..i]
					while popup do
						if (popup.which == "DELETE_ITEM" or popup.which == "DELETE_QUEST_ITEM" or popup.which == "DELETE_GOOD_QUEST_ITEM" or popup.which == "DELETE_GOOD_ITEM") and _G["StaticPopup"..i.."EditBox"]:IsShown() then
							_G["StaticPopup"..i.."EditBox"]:Hide()
							_G["StaticPopup"..i]:SetHeight(_G["StaticPopup"..i]:GetHeight() - 22)
							_G["StaticPopup"..i.."Button1"]:Enable()
							local link = select(3, GetCursorInfo())
							local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
							if linkType == "battlepet" then
								local speciesID, level, breedQuality = strsplit(":", linkOptions)
								local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
								link = qualityColor:WrapTextInColorCode(name .. " |n" .. L["Level"] .. " " .. level .. " " .. L["Battle Pet"])
							end
							_G["StaticPopup"..i.."Text"]:SetText(gsub(_G["StaticPopup"..i.."Text"]:GetText(), gsub(TypeDeleteLine, "@", ""), "") .. "|n" .. link)
							break
						else
							i = i + 1
							popup = _G["StaticPopup"..i]
						end
					end
			end)
		end
end)

