/fprint C_BattleNet.GetAccountInfoByGUID(UnitGUID("player"))
/fprint C_BattleNet.GetGameAccountInfoByGUID(UnitGUID("player"))
/fprint C_BattleNet.GetAccountInfoByID(select(3, BNGetInfo()))
/fprint C_BattleNet.GetGameAccountInfoByGUID(UnitGUID("player"))
["Player-1615-0AE9B27E"]
/dump GetPlayerInfoByGUID("Player-1615-0AE9B27E")
/dump GetPlayerInfoByGUID(UnitGUID("player"))
/dump C_BattleNet.GetAccountInfoByGUID("Player-3391-0CF86A39")
/run local _,_,_,n = GetAchievementCriteriaInfo(41038, 1); print(n);
local playerAccountGUID = string.format("BNetAccount-0-%012X", (BNGetNumFriends() + 1));
local isBattleNetGUID = C_AccountInfo.IsGUIDBattleNetAccountType(playerAccountGUID);
local isLocalPlayerGUID = C_AccountInfo.IsGUIDRelatedToLocalAccount(playerAccountGUID);
fprint (playerAccountGUID, isBattleNetGUID, isLocalPlayerGUID);
inChromieTime = C_PlayerInfo.IsPlayerInChromieTime()
canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()
/dump UnitChromieTimeID("player")
https://www.wowhead.com/ru/achievement=40873 Спаситель ящиков
https://www.wowhead.com/ru/achievement=40979 Ни один ящик не пропадет
https://www.wowhead.com/ru/achievement=41013 Улучшенное облачение
https://www.wowhead.com/ru/achievement=41033 Классный стилист
/fprint {Octo_ToDo_DB_Vars, Octo_ToDo_DB_Other}






OctoToDo_MainFrame?