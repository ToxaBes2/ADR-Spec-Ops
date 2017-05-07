/*
Author:	malashin
Description: Tell player which vehicles are allowed for weapon loadout changing
*/

private ["_veh", "_vehType", "_allowedVehicles"];
_veh = _this select 0;
_vehType = typeOf _veh;
_allowedVehicles = ["I_Heli_light_03_F", "I_Plane_Fighter_03_AA_F", "I_Plane_Fighter_03_CAS_F"];

if (!(_vehType in _allowedVehicles)) exitWith {
	_veh vehicleChat "Смена вооружения доступна только для:";
	{
	    _veh vehicleChat format ["  -  %1", getText(configFile >> "CfgVehicles" >> _x >> "displayName")];
	} forEach _allowedVehicles;
};
