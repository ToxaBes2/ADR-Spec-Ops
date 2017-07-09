/*
@filename: fn_conditionUH80TurretControl.sqf
Author:

	Quiksilver
	
Last modified:

	22/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Add action condition for pilot control of UH80 turrets
_______________________________________________________________*/

private ["_c", "_v", "_type"];

_c = false;
_v = vehicle player;
_type = typeOf _v;
_uh80 = ["B_Heli_Transport_01_camo_F", "B_Heli_Transport_01_F", "B_Heli_Transport_03_F"];
if (_type in _uh80) then {
	if ((!(_v getVariable "turrets_locked")) and (player == (driver _v))) then {
		_c = true;
	};
};
_c;