/*
Author: ToxaBes
Description: call for hide body
*/
player playMove "AinvPknlMstpSnonWrflDnon_medic";
_object = _this select 0;
hideBody _object;
sleep 5;
deleteVehicle _object;