/*
Author: ToxaBes
Description: respawn on avanpost
*/
_pos = missionNamespace getVariable ["AVANPOST_COORDS", false];
if (isNil "_pos" || {_pos isEqualTo false}) exitWith {};
if (count _pos == 2) then {
    _pos set [2, 0];
};
player setDir (random 360);
_newPos = [_pos, 0, 8, 1, 0, 0, 0] call QS_fnc_findSafePos;
if (count _newPos == 2) then {
    _newPos set [2, 0];
};
if (_newPos distance2D _pos > 10) then {
    _newPos = _pos;
};
player setPosATL _newPos;