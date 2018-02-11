/*
Author: ToxaBes
Description: blackfish gunship support
*/
_center = _this select 0;
["<t color='#7FDA0B' size = '.48'>Запрос авиаподдержки...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
_radius = 100;
_height = 600;
_loiterRadius = 500;
_duration = selectRandom [180, 240, 300];
_pos = [
	(_center select 0) - _radius + (2 * random _radius),
	(_center select 1) - _radius + (2 * random _radius),
	_height
];
_spawnPos = [(_pos select 0) + 2000, (_pos select 1) + 2000, _height];
_jet = createVehicle ["B_T_VTOL_01_armed_F", _spawnPos, [], 0, "FLY"];
createVehicleCrew _jet;
_vehGroup = group (driver _jet);
[(units _vehGroup)] call QS_fnc_setSkill4;
_jet move _center;
_jet setSpeedMode "Normal";
while {(count (waypoints _vehGroup)) > 0} do {
    deleteWaypoint ((waypoints _vehGroup) select 0);
};
[_jet, _spawnPos, _vehGroup, _center, _duration, _loiterRadius, _pos] spawn {
    _jet = _this select 0;
    _spawnPos = _this select 1;
    _vehGroup = _this select 2;
    _center   = _this select 3;
    _duration = _this select 4;
    _loiterRadius = _this select 5;
    _pos      = _this select 6;
    waituntil { (_center distance2D _jet < _loiterRadius + 300) || {!(alive _jet)} || {!(canmove _jet)} || {!(alive (driver _jet))} };

    _wp = _vehGroup addwaypoint [_pos, 0];
    _wp setWPPos _pos;
    _wp setWaypointType "LOITER";
    _wp setWaypointLoiterType "CIRCLE_L";
    _wp setWaypointLoiterRadius _loiterRadius;
    _jet setSpeedMode "Normal";
    _wp setWaypointSpeed "Normal";
    _wp setWaypointCombatMode "RED";
    _vehGroup setCurrentWaypoint _wp;

    sleep _duration;
    while {(count (waypoints _vehGroup)) > 0} do {
        deleteWaypoint ((waypoints _vehGroup) select 0);
    };

    _spawnPos set [2, 1000];
    _jet move _spawnPos;
    _jet setSpeedMode "FULL";

    sleep 60;
    _wp2 = _vehGroup addWayPoint [_spawnPos, 0];
    _wp2 setWaypointType "MOVE";
    _wp2 setWaypointBehaviour "SAFE";
    _wp2 setWaypointForceBehaviour true;
    _wp2 setWaypointSpeed "FULL";    
    _wp2 setWaypointStatements ["true", "cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew cleanUpveh + [cleanUpveh];"];
};
