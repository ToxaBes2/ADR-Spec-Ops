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

// hide data for thermal map
_uid = getPlayerUID player;
_map = 0;
_pos = format ["%1,%2", floor ((getPos player) select 0), floor ((getPos player) select 1)];
if (worldName == "Tanoa") then {
    _map = 1;
};
_side = 0;
if (playerSide == resistance) then {
    _side = 1;
};
["logDeath",[_uid, _map, _pos, _side], player] remoteExec ["sqlServerCall", 2];
