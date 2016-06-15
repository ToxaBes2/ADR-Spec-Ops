/*
Author: ToxaBes
Description: get data from object
*/
private ["_object"];
player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
sleep 1;
_object = _this select 0;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
hint "Получение данных...";
sleep 1;
hint "Проверка...";
sleep 2;
SM_SUCCESS_GETDATA = true; publicVariable "SM_SUCCESS_GETDATA";