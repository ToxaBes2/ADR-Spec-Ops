/*
Author:	ToxaBes
Description: change watch direction from time to time
Format: [_unit, _directions, _time]
*/
TB_fnc_relativePos = {
    private ["_p1", "_dir", "_dst", "_r", "_alt"];
    _p1 = _this select 0;
    _dir = _this select 1;
    _dst = _this select 2;
    _alt = 0;
    if (count _this  == 3) then {
        _alt = _this select 3;
    };
    _r = [(_p1 select 0) + sin _dir * _dst, (_p1 select 1) + cos _dir * _dst, _alt];
    _r
};
_unit = _this select 0;
_directions = _this select 1;
_time = _this select 2;
_watchDir = _directions call BIS_fnc_selectRandom;
_unit setDir _watchDir;
if (_time == 0) then {    
    _watchPos = [getPos _unit, _watchDir, ((round (random 50) + 30)), 1] call TB_fnc_relativePos;
    _unit doWatch _watchPos;
} else {
	while {alive _unit && isNull (_unit findNearestEnemy (getPos _unit))} do {
        _watchDir = _directions call BIS_fnc_selectRandom;
        _unit setDir _watchDir;
        _watchPos = [getPos _unit, _watchDir, ((round (random 30) + 30)), 1] call TB_fnc_relativePos;
        _unit doWatch _watchPos;       	
        sleep _time;
    };
};
