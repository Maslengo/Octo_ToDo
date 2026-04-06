local GlobalAddonName, E = ...
----------------------------------------------------------------
E.Octo_Table_ProfCurr = {
	[129] = {
		name = "FirstAid",
		DRAGONFLIGHT = nil,
		TWW = nil,
		MIDNIGHT = nil,
	},
	[164] = {
		name = "Blacksmithing", -- WorldofWarcraft
		DRAGONFLIGHT = 2035,
		TWW = 2786,
		MIDNIGHT = 3151,
	},
	[165] = {
		name = "Leatherworking",
		DRAGONFLIGHT = 2025,
		TWW = 2792,
		MIDNIGHT = 3157,
	},
	[171] = {
		name = "Alchemy",
		DRAGONFLIGHT = 2024,
		TWW = 2785,
		MIDNIGHT = 3150,
	},
	[182] = {
		name = "Herbalism",
		DRAGONFLIGHT = 2034,
		TWW = 2789,
		MIDNIGHT = 3154,
	},
	[185] = {
		name = "Cooking",
		DRAGONFLIGHT = nil,
		TWW = nil,
		MIDNIGHT = nil,
	},
	[186] = {
		name = "Mining",
		DRAGONFLIGHT = 2035,
		TWW = 2793,
		MIDNIGHT = 3158,
	},
	[197] = {
		name = "Tailoring",
		DRAGONFLIGHT = 2026,
		TWW = 2795,
		MIDNIGHT = 3160,
	},
	[202] = {
		name = "Engineering",
		DRAGONFLIGHT = 2027,
		TWW = 2788,
		MIDNIGHT = 3153,
	},
	[333] = {
		name = "Enchanting",
		DRAGONFLIGHT = 2030,
		TWW = 2787,
		MIDNIGHT = 3152,
	},
	[356] = {
		name = "Fishing",
		DRAGONFLIGHT = nil,
		TWW = nil,
		MIDNIGHT = nil,
	},
	[393] = {
		name = "Skinning",
		DRAGONFLIGHT = 2033,
		TWW = 2794,
		MIDNIGHT = 3159,
	},
	[755] = {
		name = "Jewelcrafting",
		DRAGONFLIGHT = 2029,
		TWW = 2791,
		MIDNIGHT = 3156,
	},
	[773] = {
		name = "Inscription", -- BurningCrusade
		DRAGONFLIGHT = 2028,
		TWW = 2790,
		MIDNIGHT = 3155,
	},
	[794] = {
		name = "Archaeology", -- WrathoftheLichKing
		DRAGONFLIGHT = nil,
		TWW = nil,
		MIDNIGHT = nil,
	},
	-- Cataclysm
}




for k, SkillLineID in next,(E.Octo_Table_ProfCurr) do
	if SkillLineID.DRAGONFLIGHT then
		-- print (SkillLineID.DRAGONFLIGHT)
	end
end