local GlobalAddonName, E = ...
if not E.Enable_Moduls then return end



local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local STATICPOPUP_NUMDIALOGS = STATICPOPUP_NUMDIALOGS or 1
tinsert(E.Modules, function()
	if not Octo_ToDo_DB_Vars.InputDelete then return end

	-- Подготовка текста для сравнения
	local deleteTextPattern = gsub(DELETE_GOOD_ITEM:gsub("[\r\n]", ""), "%%s", ".+")

	local function ProcessDeletePopup()
		for i = 1, STATICPOPUP_NUMDIALOGS do
			local popup = _G["StaticPopup"..i]
			if not popup then break end

			local popupType = popup.which
			if (popupType == "DELETE_ITEM" or popupType == "DELETE_QUEST_ITEM" or
				popupType == "DELETE_GOOD_QUEST_ITEM" or popupType == "DELETE_GOOD_ITEM") then

				local editBox = _G["StaticPopup"..i.."EditBox"]
				if editBox:IsShown() then
					-- Упрощаем попап
					editBox:Hide()
					popup:SetHeight(popup:GetHeight() - 22)
					_G["StaticPopup"..i.."Button1"]:Enable()

					-- Обработка ссылки на предмет
					local _, _, link = GetCursorInfo()
					if link then
						local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
						local displayText = name

						-- Специальная обработка питомцев
						if linkType == "battlepet" then
							local speciesID, level, breedQuality = strsplit(":", linkOptions)
							local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
							displayText = qualityColor:WrapTextInColorCode(
								format("%s\n%s %s %s", name, L["Level"], level, L["Battle Pet"])
							)
						end

						-- Обновляем текст попапа
						local popupText = _G["StaticPopup"..i.."Text"]
						popupText:SetText(
							popupText:GetText():gsub(deleteTextPattern, "") .. "\n" .. displayText
						)
					end
					break
				end
			end
		end
	end

	-- Создаем и настраиваем фрейм
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("DELETE_ITEM_CONFIRM")
	frame:SetScript("OnEvent", ProcessDeletePopup)
end)