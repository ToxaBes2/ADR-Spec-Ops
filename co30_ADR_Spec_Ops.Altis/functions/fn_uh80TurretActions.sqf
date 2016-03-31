/*
@filename: fn_uh80TurretActions.sqf
Author:

	Quiksilver
	
Last modified:

	22/10/2014 ArmA 1.32
	
Description:

	Turret actions
	
	_v setVariable ["turretL_locked",FALSE,TRUE];
	_v setVariable ["turretR_locked",FALSE,TRUE];
_______________________________________________*/

private ["_array", "_v", "_lock"];

_array = _this select 3;

_v = vehicle player;
_lock = _array select 0;

if (_lock == 0) then {
	[[_v, 1, "LMG_Minigun_Transport", 1], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
	[[_v, 2, "LMG_Minigun_Transport2", 1], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
	_v setVariable ["turrets_locked", false, true];
};

if (_lock == 1) then {
	[[_v, 1, "LMG_Minigun_Transport", 0], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
	[[_v, 2, "LMG_Minigun_Transport2", 0], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
	_v setVariable ["turrets_locked", true, true];
};