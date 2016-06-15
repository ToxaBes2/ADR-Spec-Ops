/*
Author: ToxaBes
Description: defuse the bomb
*/
private ["_object"];
player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
sleep 1;
_object = _this select 0;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
sleep 2;
_object setDamage 0;
hqSideChat = "Заряд обезврежен!";
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat;
TIMER_IN_USE = false; publicVariable "TIMER_IN_USE";
[_object,"QS_fnc_addActionTimer",nil,true] spawn BIS_fnc_MP;
SM_CONVOY_SUCCESS = true; publicVariable "SM_CONVOY_SUCCESS";
