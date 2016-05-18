/*
Author: ToxaBes
Description: call for retreat command to enemy forces
*/
private ["_object"];
player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
_object = _this select 0;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
sleep 2;
hqSideChat = "Внимание всем, прекратить операцию, мы отступаем!";
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat;
sleep 3;
BLOCKED_DEVICES = 2; publicVariable "BLOCKED_DEVICES";
sleep 2;
deleteVehicle _object;
