/*
@filename: onPlayerKilled.sqf
Author:
	
	Quiksilver

Last modified:

	12/10/2014
	
Description:

	Client scripts that should execute when a player is killed.
	
______________________________________________________*/

private ["_playerOld"];

_playerOld = _this select 0;

killed_PrimaryWeapon = primaryWeapon _playerOld;
if (!isNil killed_PrimaryWeapon) then {
	killed_PrimaryWeaponItems = primaryWeaponItems _playerOld;
};
[_playerOld,[player,"KilledInventory"]] call BIS_fnc_saveInventory;