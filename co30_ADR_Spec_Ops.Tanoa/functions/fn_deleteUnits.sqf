private["_deleteVehicles"];

_deleteVehicles = if(count _this > 1) then {_this select 1} else {true};

{
	if(_deleteVehicles) then {deleteVehicle (vehicle _x)} else{moveOut _x};
	deleteVehicle _x;
} forEach (_this select 0);

[] spawn QS_fnc_cleanGroups;