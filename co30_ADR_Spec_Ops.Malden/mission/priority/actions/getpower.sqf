/*
Author: Alex Rus
Description: action for priority mission
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
[[player, "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon"], "QS_fnc_switchMoveMP", nil, false] spawn BIS_fnc_MP;
sleep 1;
if (POWERFIX) then { 
	hqSideChat = "Данные загружаются в наш терминал. Ожидайте..."; 
	publicVariable "hqSideChat"; 
	[OUR_SIDE, "HQ"] sideChat hqSideChat;
	sleep 20;
	SM_POWER = true; publicVariable "SM_POWER";
	hqSideChat = "Данные загружены в наш терминал."; 
	publicVariable "hqSideChat"; 
	[OUR_SIDE, "HQ"] sideChat hqSideChat;
} else {
	hqSideChat = "Генератор не работает, нет питания на терминале связи. Сначала необходимо починить генератор!"; 
	publicVariable "hqSideChat"; 
	[OUR_SIDE, "HQ"] sideChat hqSideChat;
};