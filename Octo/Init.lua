local GlobalAddonName, E = ...
E.GlobalAddonName = GlobalAddonName
_G.OctoEngine = E

E.Modules = {}
-- local OctoEngineFrame = CreateFrame("Frame", "OctoEngineFrame")
-- E.OctoEngineFrame = OctoEngineFrame
-- лучше вешать на кор обьект аддона функции а он уже в глобале а не на нс