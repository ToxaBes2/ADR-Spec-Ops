/*
Author: Zerty
Description: limit distance for ir missles
*/
private ["_unit","_ammo", "_source"];
_unit = _this select 0;
_ammo = _this select 1;
_source = _this select 2;
_limit = 3000; // 3 km
if (!(_unit isKindOf "Man")) then {
    _missile = nearestObject [_source, _ammo];
    if (isNull _missile) exitWith {};
    _irLock = getNumber(configFile >> "CfgAmmo" >> _ammo >> "irLock");
    if (_irLock == 1) then {
    	_source = getPos _source;
    	_distance = _unit distance _source;
    	if (_distance > _limit || _limit != 0) then {
    		waitUntil {_missile distance _source > _limit};
    		deleteVehicle _missile;
    	};
    };
};