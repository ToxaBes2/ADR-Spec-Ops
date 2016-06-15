/*
@filename: fn_uh80Turret.sqf
Author:

	Quiksilver
	
Last modified:

	24/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Send across network
___________________________________________________*/

private ["_v", "_t", "_w", "_type"];

_v = _this select 0;
_t = _this select 1;
_w = _this select 2;
_type = _this select 3;

if (_type == 0) then {
	_v removeWeaponTurret [_w, [_t]];
};

if (_type == 1) then {
	_v addWeaponTurret [_w, [_t]];
};