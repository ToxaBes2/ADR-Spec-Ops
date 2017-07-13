/*
Author: ToxaBes
Description: add ammo support for blufor base every X mins
*/
_interval = 2400;
_endPos = [6883,7382];
_truck = "B_T_Truck_01_box_F";
_guards = selectRandom ["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","B_LSV_01_armed_F","B_LSV_01_armed_olive_F","B_LSV_01_armed_sand_F","B_APC_Wheeled_01_cannon_F"];
_start = [
[9338.55,8510.36,0],[9279.14,7524.7,0],[9893.94,9357.81,0],[10293.4,9579.52,0],[9326.46,11185.6,0],
[8928.65,11849.9,0],[10114.5,9786.71,0],[8492.07,10829.1,0],[8247.4,11063.5,0],[7978.5,10594.4,0],
[7015.62,10672.2,0],[5477.16,8727.74,0],[6089.17,9559.84,0],[5454.75,10102.3,0],[5780,10705,0],
[4365.64,8446.58,0],[5200.58,8566.34,0],[8600.33,8983.37,0],[4448.98,8759.18,0],[8390.99,10243.2,0]
];
while {true} do {
    _startPos = selectRandom _start;
    _roadSegments = _startPos nearRoads 20;
    while {count _roadSegments == 0} do {
        _startPos = selectRandom _start;
        _roadSegments = _startPos nearRoads 20;
    };
    _segment = selectRandom _roadSegments;
    _roadDirection1 = getDir _segment;         
    _firstPos = getPos _segment;  
    
    _veh1 = createVehicle [_truck, [50,50,500], [], 0, "NONE"];
    _veh1 setPos _firstPos;
    _veh1 setDir _roadDirection1;
    createVehicleCrew _veh1;
    _veh1 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    [_veh1, "QS_fnc_addActionUnloadAmmo", nil, true] spawn BIS_fnc_MP; 

    _driver = driver _veh1;
    _repairUnit = (group _driver) createUnit ["B_soldier_repair_F", _firstPos, [], 0, "CARGO"];
    
    _roadSegments = _firstPos nearRoads 70;
    _segment = selectRandom _roadSegments;
    _secondPos = getPos _segment;  
    while {_secondPos distance2D _firstPos < 10} do {
        _segment = selectRandom _roadSegments;
        _secondPos = getPos _segment; 
    };
    _roadDirection2 = getDir _segment;   
    
    _veh2 = createVehicle [_guards, [40,40,400], [], 0, "NONE"];
    _veh2 setPos _secondPos;
    _veh2 setDir _roadDirection2;
    createVehicleCrew _veh2;
    _veh2 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    
    _group1 = group _veh1;
    _group2 = group _veh2;
    [(units _group1)] call QS_fnc_setSkill4;
    [(units _group2)] call QS_fnc_setSkill4;

    _group1 setSpeedMode "LIMITED";
    _group1 setBehaviour "SAFE";
    _group1 setCombatMode "RED";
    _group1 allowFleeing 0;
    _group2 setSpeedMode "LIMITED";
    _group2 setBehaviour "SAFE";
    _group2 setCombatMode "RED";
    _group2 allowFleeing 0;
    
    {
        _x addCuratorEditableObjects [[_veh1], true];
    } forEach allCurators;
        
    _wp1 = _group1 addWaypoint [_endPos, 0];
    _wp1 setWaypointType "MOVE";
    _wp1 setWaypointCompletionRadius 5;
    _wp1 setWaypointFormation "COLUMN";
    _wp1 setWaypointBehaviour "SAFE";
    _wp1 setWaypointCombatMode "NO CHANGE";

    _briefing = format ["<t align='center'><t size='1.5' color='#6B8E23'>Конвой с боеприпасами</t><br/>____________________<br/>Командование регулярной армии отправило конвой с боеприпасами.<br/><br/>Его текущее местоположение: %1,%2</t>", _firstPos select 0, _firstPos select 1];
    GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";

    [_firstPos, _endPos] spawn {
        _pos1 = _this select 0;
        _newName1 = "ammo_support";
        _markerName1 = format ["mkr_%1", _newName1];
        _markerText1 = "Конвой с БК";
        _marker1 = createMarker [_markerName1, _pos1];
        _marker1 setMarkerAlpha 0;
        _marker1 setMarkerText _markerText1;
        _marker1 setMarkerType "mil_box";
        _marker1 setMarkerColor "ColorBLUFOR";
        _marker1 setMarkerSize [0.5, 0.5];
        [_markerName1, 1] remoteExec ["setMarkerAlphaLocal", west];
        [_markerName1, 1] remoteExec ["setMarkerAlphaLocal", resistance];
        _pos2 = _this select 1;
        _newName2 = "ammo_support_endpoint";
        _markerName2 = format ["mkr_%1", _newName2];
        _markerText2 = "Место разгрузки конвоя с БК";
        _marker2 = createMarker [_markerName2, _pos2];
        _marker2 setMarkerAlpha 0;
        _marker2 setMarkerText _markerText2;
        _marker2 setMarkerType "mil_box";
        _marker2 setMarkerColor "ColorBLUFOR";
        _marker2 setMarkerSize [0.5, 0.5];
        [_markerName2, 1] remoteExec ["setMarkerAlphaLocal", west];
        [_markerName2, 0] remoteExec ["setMarkerAlphaLocal", resistance];

        sleep 120;
        deleteMarker _markerName1;
        deleteMarker _markerName2;
    };

    [_veh1, _veh2, _endPos] spawn {
        _veh1 = _this select 0;
        _veh2 = _this select 1;
        _endPos = _this select 2;
        _group1 = group _veh1;
        _group2 = group _veh2;
        while {true} do {                 
            sleep 5;
            while {(count (waypoints _group2)) > 0} do {
                deleteWaypoint ((waypoints _group2) select 0);
            };
            _wp2 = _group2 addWaypoint [position _veh1, 0];
            _wp2 setWaypointType "MOVE";
            _wp2 setWaypointCompletionRadius 5;
            _wp2 setWaypointSpeed "LIMITED";
            _wp2 setWaypointBehaviour "SAFE";
            if (!(alive _veh1) || !(canMove _veh1)) exitWith {    
                hqSideChat = "Конвой с боеприпасами уничтожен!";
                publicVariable "hqSideChat"; 
                [WEST, "HQ"] sideChat hqSideChat;

                ARSENAL_ENABLED = false;
                publicVariable "ARSENAL_ENABLED";
            };            
            if (_veh1 distance2D _endPos <= 15) exitWith {
                hqSideChat = "Боеприпасы доставлены на базу!";
                publicVariable "hqSideChat"; 
                [WEST, "HQ"] sideChat hqSideChat;  

                ARSENAL_ENABLED = true;
                publicVariable "ARSENAL_ENABLED";
                ARSENAL_TIME = serverTime;
                publicVariableServer "ARSENAL_TIME";             
            };
            if (side _veh1 == resistance) exitWith { 
                hqSideChat = "Конвой захвачен партизанами!";
                publicVariable "hqSideChat"; 
                [WEST, "HQ"] sideChat hqSideChat; 

                ARSENAL_ENABLED = false;
                publicVariable "ARSENAL_ENABLED";
            };
        };
        sleep 5;
        try {
            {
                deleteVehicle _x;
            } forEach (units _group1);
            deleteGroup _group1;
            if !(side _veh1 == resistance) then {
                deleteVehicle _veh1;
            };
            {
                deleteVehicle _x;
            } forEach (units _group2);
            deleteGroup _group2;                    
            if !(side _veh2 == resistance) then {
                deleteVehicle _veh2;
            };                           
        } catch {};
    };        
    sleep _interval;    
};