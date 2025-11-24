local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Legion_Remix = {}
E.OctoTables_DataOtrisovka.Legion_Remix.Text = {E.OctoTable_Expansions[7].color..E.OctoTable_Expansions[7].name.." (REMIX)|r"}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Legion_Remix.Currencies = {
	3292, -- E.func_IsRemix()
	3268, -- E.func_IsRemix()
	3252, -- E.func_IsRemix()
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Legion_Remix.Items = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Legion_Remix.Reputations = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Legion_Remix.UniversalQuests = {

		{
			showTooltip = true,
			textleft = "Повышение в бесконечных исследованиях",
			name_save = "InfiniteResearchPromotion",
			reset = "Once",
			desc = "Legion",
			quests = {
				{91613},
				{91845},
				{91844},
			},
		},




		{
			showTooltip = true,
			sorted = false,
			textleft = E.func_questName(43596),
			name_save = "hz43596",
			reset = "Once",
			desc = "Legion",
			quests ={
				{39984},
				{40044},
				{40046},
				{43595},
				{43596},
			},
		},





		{
			showTooltip = true,
			sorted = false,
			textleft = "Карты, деньги, два гоблина",
			name_save = "hz43331",
			reset = "Once",
			desc = "Legion",
			quests ={
				{39789},
				{39793},
				{39787},
				{39792},
				{39786},
				{42483},
				{43331},
			},
		},
}
----------------------------------------------------------------
E.func_TableConcat(E.ALL_Currencies, E.OctoTables_DataOtrisovka.Legion_Remix.Currencies)
E.func_TableConcat(E.ALL_Items, E.OctoTables_DataOtrisovka.Legion_Remix.Items)
E.func_TableConcat(E.ALL_Reputations, E.OctoTables_DataOtrisovka.Legion_Remix.Reputations)
E.func_TableConcat(E.ALL_UniversalQuests, E.OctoTables_DataOtrisovka.Legion_Remix.UniversalQuests)

E.func_TableConcat(E.OctoTables_Vibor, E.OctoTables_DataOtrisovka.Legion_Remix.Text)