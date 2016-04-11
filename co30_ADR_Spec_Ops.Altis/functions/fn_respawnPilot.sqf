/*
Author: Quiksilver
Last modified: 13/10/2014 ArmA 1.30 by Quiksilver
Description: Separate pilot respawn
*/
if !(isNil "PARAMS_PilotRespawn") then {
    if (PARAMS_PilotRespawn == 0) exitWith {};
};
_pos = getMarkerPos "respawn_pilot";
_pilots = ["B_Pilot_F","B_Helipilot_F"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;
if (_iampilot) then {
	player setDir 140;
	_newPos = [(((_pos select 0) + random 2) - random 4), (((_pos select 1) + random 2) - random 4), 0];
    _flatPos = _newPos isFlatEmpty [2];
    _res = count _flatPos;
    while {_res == 0} do {
        _newPos = [_pos, 0, 15, 1, 0, 1, 0] call BIS_fnc_findSafePos;   
        _flatPos = _newPos isFlatEmpty [1];
        _res = count _flatPos;
    };
	player setPosATL _newPos;
};
