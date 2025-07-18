
	GSEARCH = {
		commands = {"/gsearch", "/gs"},
		handler = function(msg)
			-- Поиск глобальных переменных по строке
			local str = ""
			local color = E.classColorHexCurrent
			DEFAULT_CHAT_FRAME:AddMessage(color.."GSEARCH:|r "..msg)

			for i, n in pairs(_G) do
				if type(n) == "string" and n:find(msg) then
					str = str..color..i.."|r - "..n.."\n"
				end
			end

			local editBox = _G.editFrame.editFrame
			editBox:SetText(str)
			_G.editFrame:Show()
		end
	},