/*
Author: ToxaBes
Description: add support air landed on blufor base every X mins
*/
_interval = 600;
_height = 1000;
_land = [15323,17322,0];
landpoint = "Land_HelipadEmpty_F" createVehicle _land;
_start = [0,0,0];
while {true} do {
    if (random 10 > 6) then {
        _height = 500;
        _start = [14700,12162,_height];
    } else {
        _height = 1000;
        _start = [18282,21573,_height];
    };    
    _veh = createVehicle ["B_T_VTOL_01_infantry_F", _start, [], 0, "FLY"];
    createVehicleCrew _veh;
    _veh setPos _start;
    _veh addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    _veh lock 2;
    _veh allowCrewInImmobile true;
    _veh setPilotLight true;
    _veh setCollisionLight true;
    _crew = crew _veh;
    _group = group (driver _veh);
    {
     	_x addCuratorEditableObjects [[_veh], true];
    } forEach allCurators;   
    _wp0 = _group addWayPoint [_land, 0];
    _wp0 setWaypointBehaviour "SAFE";
    _wp0 setWaypointSpeed "NORMAL";
    _wp0 setWaypointBehaviour "CARELESS";
    _wp0 setWaypointForceBehaviour true;
    _wp0 setWaypointCombatMode "BLUE";
    _wp0 setWaypointCompletionRadius 30;
    _wp0 setWaypointType "SCRIPTED";
    _wp0 setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
    _wp2 = _group addWayPoint [_start, 1];
    _wp2 setWaypointType "MOVE";
    _wp2 setWaypointBehaviour "SAFE";
    _wp2 setWaypointForceBehaviour true;
    _wp2 setWaypointSpeed "FULL";    
    _wp2 setWaypointStatements ["true", "cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew cleanUpveh + [cleanUpveh];"];
    waitUntil {
        sleep 5;
        if (!(alive _veh) || (getPos _veh) select 2 < 1) exitWith {true};        
    };
    sleep 10;
    if (alive _veh && _veh distance2D _land < 20) then {  
        SUPPORT_CYCLES = SUPPORT_CYCLES + 1;
        publicVariableServer "SUPPORT_CYCLES";
        _veh setDamage 0;
        _veh setFuel 1;
        _veh setVehicleAmmo 1;
    };
    sleep 90;
    try {
        {
            deleteVehicle _x;
        } forEach _crew;
        deleteGroup _group;
        deleteVehicle _veh;
    } catch {};
    sleep _interval;
};