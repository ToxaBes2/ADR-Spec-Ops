/*
Author: ToxaBes
Description: add ammo support for blufor base every X mins
*/
_interval = 2400;
_endPos = [8107,9980];
_truck = "B_Truck_01_box_F";
_guards = "B_LSV_01_armed_F";
_start = [
    [3105.2,8406.68,0],[5576.79,11476.9,0],[1660.25,4658.95,0],[1139.85,601.48,0],[3741.1,3081.08,0],[5112.64,1238.34,0],
    [5808.74,2441.88,0],[6798.63,2757.28,0],[8243.75,3274.42,0],[7610.85,5872.55,0],[5661.72,6980.78,0]
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