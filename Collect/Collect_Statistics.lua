local GlobalAddonName, E = ...
local enable = false
----------------------------------------------------------------
local function Collect_Statistics()
	if not enable then return end
	----------------------------------------------------------------
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	-- E.func_StartDebugTimer()
	----------------------------------------------------------------
	-- local last5statistics = GetLatestUpdatedStats()
	----------------------------------------------------------------
	-- local tbl = {}
	-- for _, CategoryId in pairs(GetStatisticsCategoryList()) do
	-- 	tbl[CategoryId] = "CategoryId"
	-- 	for i = 1, GetCategoryNumAchievements(CategoryId) do
	-- 		local IDNumber, Name = GetAchievementInfo(CategoryId, i)
	-- 		tbl[IDNumber] = Name
	-- 	end
	-- end
	-- opde(tbl)
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- opde(GetStatisticsCategoryList())
	----------------------------------------------------------------
	-- E.func_StopDebugTimer()
end
----------------------------------------------------------------
function E.Collect_Statistics()
	E.func_SpamBlock(Collect_Statistics, false)
end