/*
Author: ToxaBes
Description: defuse the bomb
*/
private ["_object"];
player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
_object = _this select 0;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
if (BLOCKED_DEVICES == 0) then {
	hqSideChat = "Отключено устройств: 1 из 2х";
} else {
	hqSideChat = "Отключено устройств: 2 из 2х";
};
BLOCKED_DEVICES = BLOCKED_DEVICES + 1; publicVariable "BLOCKED_DEVICES";
sleep 2;
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat;
deleteVehicle _object;

