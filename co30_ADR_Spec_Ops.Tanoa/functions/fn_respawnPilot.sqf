/*
Author: Quiksilver
Last modified: 13/10/2014 ArmA 1.30 by Quiksilver
Description: Separate pilot respawn
*/
if !(isNil "PARAMS_PilotRespawn") then {
    if (PARAMS_PilotRespawn == 0) exitWith {};
};
_pos = getMarkerPos "respawn_pilot";
_pilots = ["B_Helipilot_F", "B_T_Helipilot_F"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;
if (_iampilot) then {
	player setDir 140;
	_newPos = [(((_pos select 0) + random 2) - random 3), (((_pos select 1) + random 2) - random 3), 0];
	player setPosATL _newPos;
};
