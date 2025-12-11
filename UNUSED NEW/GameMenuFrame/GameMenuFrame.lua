-------------------------------------------------
Config_GameMenuFrame = {
	type = "range",
	name = "GameMenuFrame Scale",
	desc = "",
	min = 0.5,
	max = 1.5,
	step = .05,
	get = function()
		return Octo_ToDo_DB_Vars.Config_GameMenuFrame
	end,
	set = function(_, value)
		Octo_ToDo_DB_Vars.Config_GameMenuFrame = value
		if GameMenuFrame then
			GameMenuFrame:SetScale(value)
		end
	end,
	width = E.FULL_WIDTH/4,
	order = GetOrder(),
},

if GameMenuFrame and Octo_ToDo_DB_Vars.Config_GameMenuFrame then
	GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.Config_GameMenuFrame)
end



Config_GameMenuFrame = 1,