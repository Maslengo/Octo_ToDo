local GlobalAddonName, E = ...
local enable = false
----------------------------------------------------------------
local function Collect_Statistics()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	if not enable then return end
	-- E.DEBUG_START()
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
	-- E.DEBUG_STOP()
end
----------------------------------------------------------------
function E.Collect_Statistics()
	E.func_SpamBlock(Collect_Statistics, false)
end