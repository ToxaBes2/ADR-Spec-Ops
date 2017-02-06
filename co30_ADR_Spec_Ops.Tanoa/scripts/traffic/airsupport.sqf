/*
Author: ToxaBes
Description: add support plane landed on blufor base airfield every X mins
*/
private ["_interval","_height","_name","_corners","_crew","_plane","_group","_wp","_pos","_posX"];
_interval = 420; // 7 mins (~10 mins total time)
_height = 1000; // meters
_name = worldName;
_plane = false;
if (_name == "Altis") then {
    _corners = [[15000,30000,_height],[0,15000,_height],[30000,15000,_height],[15000,0,_height]];
    _posX = [7258.77,6814.46,0];
};
if (_name == "Tanoa") then {
    _corners = [[7500,15000,_height],[0,7500,_height],[7500,0,_height],[15000,7500,_height]];
    _posX = [5647.6,10402.6,0];
};
sleep _interval;
while {true} do {
    if (!_plane) then {
    	_pos = selectRandom _corners;
        _plane = createVehicle ["B_T_VTOL_01_infantry_F", _pos, [], 0, "FLY"];
        _plane lock 2;
        createVehicleCrew _plane;
        _plane allowCrewInImmobile true;
        _crew = crew _plane;  
        _group = group (driver _plane);
        {
         	_x addCuratorEditableObjects [[_plane], true]
        } forEach allCurators;      
    };       
    _wp = _group addWayPoint [_posX,0];
    _wp setWaypointType "MOVE";
    _plane flyInHeight _height;
    waitUntil {
        sleep 5;
        if (!(alive _plane) || (_plane distance2D _posX < 2000)) exitWith {true};        
    }; 
    if (alive _plane) then {
    	while {(count (waypoints _group)) > 0} do {
            deleteWaypoint ((waypoints _group) select 0);
        }; 
        _plane landAt 0;
    };
    waitUntil {
        sleep 3;
        if (!(alive _plane) || (getPosATL _plane) select 2 < 1) exitWith {true};        
    };    
    while {(count (waypoints _group)) > 0} do {
        deleteWaypoint ((waypoints _group) select 0);
    };
    _plane engineOn false;
    sleep 10;
    if (alive _plane) then {    
        // spawn vehicles here
        
        _plane setDamage 0;
        _plane setFuel 1;
        _plane setVehicleAmmo 1;
        _plane engineOn true;
        while {(count (waypoints _group)) > 0} do {
            deleteWaypoint ((waypoints _group) select 0);
        };
        _wp = _group addWayPoint [_pos,0];
        _wp setWaypointType "MOVE";
        _plane flyInHeight _height;             
    };
    sleep 60;
    try {
        {
            deleteVehicle _x;
        } forEach _crew;
        deleteVehicle _plane;
    } catch {};
    _plane = false;
    sleep _interval;
};