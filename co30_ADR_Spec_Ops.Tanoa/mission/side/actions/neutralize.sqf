/*
Author: ToxaBes
Description: neutralize gas barrel
*/
private ["_object"];
player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
_object = _this select 0;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
hqSideChat = "Отравляющее вещество обнаружено и нейтрализовано!";
SM_YELLOWFOG_SUCCESS = true; publicVariable "SM_YELLOWFOG_SUCCESS";
sleep 2;
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat;
deleteVehicle _object;