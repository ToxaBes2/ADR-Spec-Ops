/*
Author: ToxaBes
Description: add change loadout service action
*/
_veh = _this select 3;
_veh engineOn false;
_veh setVelocity [0, 0, 0];
[_veh] call DL_fnc_AircraftLoadout;