/*
Author: ToxaBes
Description: add change loadout service action
*/
_veh = _this select 3;
_veh engineOn false;
_veh setVelocity [0, 0, 0];
[_veh, "PILOT"] call DL_fnc_AircraftLoadout;