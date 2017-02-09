/*
Author: ToxaBes
Description: add support air landed on blufor base every X mins
*/
_interval = 420;
_height = 1000;
_land = [15173,17070,0];
_move = [15432,16108,0];
landpoint = "Land_HelipadEmpty_F" createVehicle _land;
_start = [0,0,0];
_startCargo = [0,0,0];
_type = "";
_cargo = objNull;
while {true} do {
    _idx = 0;
    if (random 10 > 6) then {
        _type = "B_Heli_Transport_03_F";
        _height = 500;
        _start = [14700,12162,_height];
        _startCargo = [15000,0,(_height-10)];
    } else {
        _type = "B_T_VTOL_01_infantry_F";
        _height = 1000;
        _start = [18282,21573,_height];
        _startCargo = [15000,30000,(_height-10)];
    };    
    _veh = createVehicle [_type, _start, [], 0, "FLY"];
    createVehicleCrew _veh;
    _veh setPos _start;
    _veh addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    _veh lock 2;
    _veh allowCrewInImmobile true;
    if (_type == "B_Heli_Transport_03_F") then {
        _cargo = "B_Slingload_01_Ammo_F" createVehicle _startCargo;
        _cargo setPos _startCargo;
        _veh setSlingLoad _cargo;
    };
    _crew = crew _veh;
    _group = group (driver _veh);
    {
     	_x addCuratorEditableObjects [[_veh], true];
    } forEach allCurators;    
    if (_type == "B_Heli_Transport_03_F") then {
        _wp0 = _group addWayPoint [_move, _idx];
        _wp0 setWaypointType "Move";
        _wp0 setWaypointSpeed "Normal";
        _wp0 setWaypointBehaviour "CARELESS";
        _wp0 setWaypointForceBehaviour true;
        _wp0 setWaypointCombatMode "BLUE";
        _wp0 setWaypointStatements ["true", "(vehicle this) flyInHeight 30;"];
        _idx = _idx + 1;
        _wp1 = _group addWayPoint [_land, _idx];        
        _wp1 setWaypointForceBehaviour true;
        _wp1 setWaypointSpeed "Limited";
        _wp1 setWaypointBehaviour "CARELESS";
        _wp1 setWaypointCombatMode "BLUE";
        _wp1 setWaypointType "UNHOOK";
        _wp1 setWaypointStatements ["true", "((vehicle this) select 0) setSlingLoad objNull;(vehicle this) flyInHeight 100;"];
        _idx = _idx + 1;
    } else {
        _wp0 = _group addWayPoint [_land, _idx];
        _wp0 setWaypointBehaviour "SAFE";
        _wp0 setWaypointSpeed "NORMAL";
        _wp0 setWaypointBehaviour "CARELESS";
        _wp0 setWaypointForceBehaviour true;
        _wp0 setWaypointCombatMode "BLUE";
        _wp0 setWaypointCompletionRadius 30;
        _wp0 setWaypointType "SCRIPTED";
        _wp0 setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf ";
        _idx = _idx + 1;
    };
    _wp2 = _group addWayPoint [_start, _idx];
    _wp2 setWaypointType "MOVE";
    _wp2 setWaypointBehaviour "SAFE";
    _wp2 setWaypointForceBehaviour true;
    _wp2 setWaypointSpeed "FULL";    
    _wp2 setWaypointStatements ["true", "cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew cleanUpveh + [cleanUpveh]; deleteGroup this;"];
    _success = false;
    if (_type == "B_Heli_Transport_03_F") then {
        waitUntil {
            sleep 5;
            if (!(alive _cargo) || ((_cargo distance2D _land < 20) && ((getPosATL _cargo) select 2 < 1))) exitWith {true};        
        }; 
        sleep 10;
        if (alive _cargo) then {  
            _success = true;
        };
        deleteVehicle _cargo;
    } else {
        waitUntil {
            sleep 5;
            if (!(alive _veh) || ((_veh distance2D _land < 10) && ((getPosATL _veh) select 2 < 2))) exitWith {true};        
        };
        sleep 10;
        if (alive _veh) then {  
            _success = true;
        };
    };    
    if (_success) then {    

        _veh setDamage 0;
        _veh setFuel 1;
        _veh setVehicleAmmo 1;        
    };
    sleep 90;
    try {
        {
            deleteVehicle _x;
        } forEach _crew;
        deleteVehicle _veh;
    } catch {};
    sleep _interval;
};