/*
Author: ToxaBes
Description: back to patrol after combat
*/
_curGroup = _this select 0;
_distance = _this select 1;
_oldPos = getPos (leader _curGroup);
_alive = {alive _x} count units _curGroup;
while {_alive > 0} do {
    sleep 300;
    _alive = {alive _x} count units _curGroup;
    if (_alive > 0) then {
    	_leader = leader _curGroup;
    	_hasEnemy = _leader findNearestEnemy _leader;
        if !(_hasEnemy) then {
            while {(count (waypoints _curGroup)) > 0} do {
                 deleteWaypoint ((waypoints _curGroup) select 0);
            };
            [_curGroup, _oldPos, _distance] call BIS_fnc_taskPatrol;
            _alive =  0;
        };
    };
};                
