local GlobalAddonName, E = ... -- ns
E.GlobalAddonName = GlobalAddonName

-- local E = {}
OctoEngine = E -- в других аддонах
-- ns.E = E


-- local GlobalAddonName, E = ...
-- local GlobalAddonName, ns = ... |n local E = ns.E







E.whatShow = {
	{name = "TODO", vars = TODO},
	{name = "Reputations", vars = Reputations},
	{name = "Currencies", vars = Currencies},

}







E.Modules = {}
-- local OctoEngineFrame = CreateFrame("Frame", "OctoEngineFrame")
-- E.OctoEngineFrame = OctoEngineFrame
-- лучше вешать на кор обьект аддона функции а он уже в глобале а не на нс