/*
Author: ToxaBes
Description: set mine to facility
*/
private ["_object", "_bomb"];
player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
sleep 1;
_object = _this select 0;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
hint "Заряд установлен. 30 секунд до взрыва...";
sleep 29;
_object allowDamage true;
sleep 1;
_object setDamage 1;
_bomb = createVehicle ["Bo_GBU12_LGB", getPos _object, [], 0, "NONE"]; 
SM_SUCCESS_SABOTAGE = true; publicVariable "SM_SUCCESS_SABOTAGE";