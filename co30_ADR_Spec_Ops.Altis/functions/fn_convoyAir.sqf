/*
Author: ToxaBes
Description: blufor ammo supply air convoy
*/
waitUntil {(getMarkerPos "sideMarker") select 0 > 0 && (getMarkerPos "sideMarker") select 1 > 0};
_s = 120 + random 60;
sleep _s;
_basePos = getMarkerPos "respawn_west";
_name = worldName;
_coords = "";
_endPos = [0,0];
if (_name == "Altis") then {
	_endPos = [15266,17398];
	_coords = [[5382,27537],[14769,27537],[25358,27614],[1115,15629],[26832,14504],[4490,5350],[15777,4807],[26715,5893]];
};
if (_name == "Tanoa") then {
	_endPos = [6883,7382];
	_coords = [[679,14689],[8146,15232],[14371,14747],[524,9646],[15089,8580],[699,5069],[7196,2063],[14740,3460]];
};
if (_name == "Malden") then {
	_endPos = [8107,9980];
	_coords = [[62,12712],[6058,12680],[12167,12518],[466,6959],[12231,7686],[450,1221],[6801,817],[11973,1835]];
};

_startPos = _coords select 0;
_markerPos = getMarkerPos "sideMarker";
_dist = _markerPos distance2D _startPos;
{
    _data = _x;
    _distTmp = _markerPos distance2D _data;
    if (_dist < _distTmp) then {
        _startPos = _data;
        _dist = _distTmp;
    };
} forEach _coords;

_xCoord = floor ((_startPos select 0) / 100);
_yCoord = floor ((_startPos select 1) / 100);
if (_xCoord < 100) then {
    _xCoord = "0" + str _xCoord;
};
if (_yCoord < 100) then {
    _yCoord = "0" + str _yCoord;
};
_grid = format["%1%2", _xCoord, _yCoord];

_briefing = format ["<t align='center'><t size='1.5' color='#6B8E23'>Конвой с боеприпасами</t><br/>____________________<br/>Авиационный конвой с боеприпасами вылетел с авианосца. <br/><br/>Текущий квадрат: %1", _grid];
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";

hqSideChat = format ["Авиационный конвой c боеприпасами в квадрате %1", _grid];
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat; 
_pos = [_startPos select 0, _startPos select 1, 50];
_heli1 = createVehicle ["B_Heli_Transport_03_F", [0,0,1800], [], 0, "FLY"];
_heli1 setPos _pos;
_heli1 allowDamage false;
createVehicleCrew _heli1;
_pos set [2, 40];
_cargo = createVehicle ["B_Slingload_01_Cargo_F", [0,0,1900], [], 0, "CAN_COLLIDE"];
_cargo allowDamage false;
_heli1 setSlingLoad _cargo;
_pos set [0, (_pos select 0) + 200];
_pos set [1, (_pos select 1) + 200];
_pos set [2, 80];
_heli2 = createVehicle ["B_Heli_Attack_01_dynamicLoadout_F", [0,0,2000], [], 0, "FLY"];
_heli2 setPos _pos;
createVehicleCrew _heli2;
{
    _x addCuratorEditableObjects [[_cargo], true];
} forEach allCurators;
_group1 = group _heli1;
_group2 = group _heli2;
[(units _group1)] call QS_fnc_setSkill4;
[(units _group2)] call QS_fnc_setSkill4;
_heli1 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
_heli2 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
[_cargo, "QS_fnc_addActionUnloadAmmo", nil, true] spawn BIS_fnc_MP;
_group1 setSpeedMode "NORMAL";
_group1 setBehaviour "SAFE";
_group1 setCombatMode "RED";
_group1 allowFleeing 0;
_group2 setSpeedMode "NORMAL";
_group2 setBehaviour "SAFE";
_group2 setCombatMode "RED";
_group2 allowFleeing 0;
_wp2 = _group2 addWaypoint [getPos _heli1, 0];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointCompletionRadius 10;
_wp2 setWaypointSpeed "NORMAL";
_wp2 setWaypointBehaviour "SAFE";   
_wp1 = _group1 addWaypoint [_endPos, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointCompletionRadius 5;
_wp1 setWaypointFormation "COLUMN";
_wp1 setWaypointBehaviour "SAFE";
_wp1 setWaypointCombatMode "NO CHANGE";
_heli1 allowDamage true;
if (!isNil "CONVOY_GROUPS") then {
	{
	    _grp = _x;
        {
                deleteVehicle _x;
        } forEach units _grp;
        deleteGroup _grp;
    } forEach CONVOY_GROUPS;
};
CONVOY_GROUPS = [_group1, _group2];
publicVariable "CONVOY_GROUPS";
if (!isNil "CONVOY_VEHICLES") then {
	{
	    _veh = _x;
        if !(typeOf _veh == "B_Slingload_01_Cargo_F") then {
            {
                deleteVehicle _x;
            } forEach crew _veh;
        };
        deleteVehicle _veh;
    } forEach CONVOY_VEHICLES;
};
CONVOY_VEHICLES = [_heli1,_heli2];
publicVariable "CONVOY_VEHICLES";

sleep 5;
while {true} do {                                
    while {(count (waypoints _group2)) > 0} do {
        deleteWaypoint ((waypoints _group2) select 0);
    };
    _p1 = position _heli1;
    _p1 set [1, (_p1 select 1) + 30];
    _wp2 = _group2 addWaypoint [_p1, 0];
    _wp2 setWaypointType "MOVE";
    _wp2 setWaypointCompletionRadius 5;
    _wp2 setWaypointSpeed "NORMAL";
    _wp2 setWaypointBehaviour "SAFE";       
    if (_cargo distance2D _endPos < 200) exitWith {
        hqSideChat = "Боеприпасы доставлены на базу!";
        publicVariable "hqSideChat"; 
        [WEST, "HQ"] sideChat hqSideChat;
        ARSENAL_ENABLED = true;
        publicVariable "ARSENAL_ENABLED";
        ARSENAL_TIME = serverTime;
        publicVariableServer "ARSENAL_TIME";  
        _heli1 setSlingLoad objNull;            
        _parachute = createVehicle ["B_Parachute_02_F", [100, 100, 200], [], 0, 'FLY'];
        _parachute allowDamage false;
        sleep 1.5;
        _parachute setPos (getPos _cargo);
        _cargo attachTo [_parachute, [0, 0, -0.4]];            
        while {(count (waypoints _group1)) > 0} do {
            deleteWaypoint ((waypoints _group1) select 0);
        };
        _wpEnd1 = _group1 addWaypoint [_pos, 0];
        _wpEnd1 setWaypointType "MOVE";
        _wpEnd1 setWaypointCompletionRadius 5;
        _wpEnd1 setWaypointFormation "COLUMN";
        _wpEnd1 setWaypointBehaviour "SAFE";
        _wpEnd1 setWaypointCombatMode "NO CHANGE";
        while {(count (waypoints _group2)) > 0} do {
            deleteWaypoint ((waypoints _group2) select 0);
        };
        _wpEnd2 = _group2 addWaypoint [_pos, 0];
        _wpEnd2 setWaypointType "MOVE";
        _wpEnd2 setWaypointCompletionRadius 5;
        _wpEnd2 setWaypointSpeed "NORMAL";
        _wpEnd2 setWaypointBehaviour "SAFE";
        waitUntil {(getPos _cargo select 2) < 5};
        detach _cargo;
        deleteVehicle _cargo;            
    };
    if ((getPosASL _cargo) select 2 < 0) exitWith {    
        hqSideChat = "Боеприпасы уничтожены!";
        publicVariable "hqSideChat"; 
        [WEST, "HQ"] sideChat hqSideChat;
        ARSENAL_ENABLED = false;
        publicVariable "ARSENAL_ENABLED";            
    }; 
    if (_cargo distance2D _endPos > 200 && (getPosASL _cargo) select 2 >= 0 && (getPos _cargo) select 2 < 1) exitWith {
        if (alive _heli1) then {
            while {(count (waypoints _group1)) > 0} do {
                deleteWaypoint ((waypoints _group1) select 0);
            };    
            _wpEnd1 = _group1 addWaypoint [_pos, 0];
            _wpEnd1 setWaypointType "MOVE";
            _wpEnd1 setWaypointBehaviour "SAFE";
            _wpEnd1 setWaypointForceBehaviour true;
            _wpEnd1 setWaypointSpeed "FULL";    
            _wpEnd1 setWaypointStatements ["true", "cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew cleanUpveh + [cleanUpveh];"];
        };
        if (alive _heli2) then {
            while {(count (waypoints _group2)) > 0} do {
                deleteWaypoint ((waypoints _group2) select 0);
            };
            _wpEnd2 = _group2 addWaypoint [_pos, 0];
            _wpEnd2 setWaypointType "MOVE";
            _wpEnd2 setWaypointBehaviour "SAFE";
            _wpEnd2 setWaypointForceBehaviour true;
            _wpEnd2 setWaypointSpeed "FULL";    
            _wpEnd2 setWaypointStatements ["true", "cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew cleanUpveh + [cleanUpveh];"];
        };
        _vehPos = getPos _cargo;
        _xCoord = floor ((_vehPos select 0) / 100);
        _yCoord = floor ((_vehPos select 1) / 100);
        if (_xCoord < 100) then {
            _xCoord = "0" + str _xCoord;
        };
        if (_yCoord < 100) then {
            _yCoord = "0" + str _yCoord;
        };
        _grid = format["%1%2", _xCoord, _yCoord];
        hqSideChat = format ["Конвой потерян в квадрате %1. Отправляйтесь на поиски!", _grid];
        publicVariable "hqSideChat"; 
        [WEST, "HQ"] sideChat hqSideChat; 
        sleep 900;
        if (alive _cargo) then {
            _fail = true;
            {
                if (_x distance2D _cargo < 100 && side _x == west) then {
                    _fail = false;
                };
            } forEach AllPlayers;
            if (_fail) then {
            	hqSideChat = "Активирована система самоуничтожения груза!";
                publicVariable "hqSideChat"; 
                [WEST, "HQ"] sideChat hqSideChat;
                _cargo allowDamage false;
              	_cargo setDamage 1; 
              	sleep 20;
              	deleteVehicle _cargo;               	
            };     
        };
    };
    sleep 5;
};

if (alive _heli1) then {
    while {(count (waypoints _group1)) > 0} do {
        deleteWaypoint ((waypoints _group1) select 0);
    };    
    _wpEnd1 = _group1 addWaypoint [_pos, 0];
    _wpEnd1 setWaypointType "MOVE";
    _wpEnd1 setWaypointBehaviour "SAFE";
    _wpEnd1 setWaypointForceBehaviour true;
    _wpEnd1 setWaypointSpeed "FULL";    
    _wpEnd1 setWaypointStatements ["true", "cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew cleanUpveh + [cleanUpveh];"];
};
if (alive _heli2) then {
    while {(count (waypoints _group2)) > 0} do {
        deleteWaypoint ((waypoints _group2) select 0);
    };
    _wpEnd2 = _group2 addWaypoint [_pos, 0];
    _wpEnd2 setWaypointType "MOVE";
    _wpEnd2 setWaypointBehaviour "SAFE";
    _wpEnd2 setWaypointForceBehaviour true;
    _wpEnd2 setWaypointSpeed "FULL";    
    _wpEnd2 setWaypointStatements ["true", "cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew cleanUpveh + [cleanUpveh];"];
};  
