/*
Author: Alex Rus
Description: action for priority mission
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
[[player, "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon"], "QS_fnc_switchMoveMP", nil, false] spawn BIS_fnc_MP;
sleep 1;
hqSideChat = "Ремонтируем генератор..."; 
publicVariable "hqSideChat"; 
[OUR_SIDE, "HQ"] sideChat hqSideChat;
sleep 20;
POWERFIX = true; publicVariable "POWERFIX";
hqSideChat = "Генератор отремонтирован и запущен."; 
publicVariable "hqSideChat"; 
[OUR_SIDE, "HQ"] sideChat hqSideChat;