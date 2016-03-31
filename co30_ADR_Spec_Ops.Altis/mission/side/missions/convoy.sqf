/*
Author:	ToxaBes
Description: Ambush convoy and defuse the bomb.
*/

// define some keywords
#define INFANTRY_MISSION "Спецоперация: Конвой (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_DEVICE_VEHICLE "O_Truck_03_device_F"
#define INFANTRY_FIRST_VEHICLE "O_APC_Wheeled_02_rcws_F"
#define INFANTRY_CONVOY "O_APC_Wheeled_02_rcws_F","O_Truck_03_covered_F","O_Truck_03_device_F","O_Truck_03_transport_F","O_MRAP_02_hmg_F"
#define INFANTRY_SOLDIERS "O_Soldier_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_TL_F","O_soldier_M_F","O_Soldier_LAT_F","O_medic_F","O_soldier_repair_F","O_soldier_exp_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_soldier_PG_F","O_recon_F","O_recon_M_F","O_recon_LAT_F","O_recon_medic_F","O_recon_TL_F","O_Soldier_AAT_F","O_soldierU_M_F","O_SoldierU_GL_F"

// define private variables
private ["_targets","_accepted","_distance","_briefing","_position","_city","_flatPos","_x","_enemiesArray","_startPoint"];         

_enemiesArray = [grpNull];

// format: [city name,    [coords x,y],         [[arrow1 x,y,dir],[arrow2 x,y,dir]],             [array of five init vehicle points x,y,z,dir],                                                                                          [array of convoy waypoints x,y,z]]
_targets = [
    ["Ореокастро",        [4549.12,21415.7],    [[4633.87,21597,191],[4383.42,21305.9,205]],     [[4563,21956,0.1,212],[4570,21970,0.1,212],[4576,21987,0.1,212],[4581,22002,0.1,212],[4589,22017,0.1,212]],                             [[4411.5,21901,0],[4622.3,21662.3,0],[4559.9,20734.4,0]]],
    ["Фрини",             [14607.8,20773.2],    [[14532.4,20959.4,146],[14510.2,20598.9,194]],   [[14456,21402,0.1,145],[14440,21426,0.1,158],[14422,21452,0.1,88],[14400,21462,0.1,133],[14382,21491,0.1,149]],                         [[14592.9,20821,0],[14364.9,20166.8,0]]],
    ["Атира",             [14020,18720],        [[13830.6,18654.4,58],[14132.8,18886.1,3]],      [[13107,18687.5,0.1,113],[13085.5,18705.6,0.1,133],[13070.2,18722.6,0.1,136],[13054.9,18740.2,0.1,137],[13037.3,18756.2,0.1,135]],      [[13847.2,18666,0],[14131.9,18880.1,0],[14250.9,19302.2,0]]],
    ["Галати",            [10311,19070],        [[10305.4,18869.3,359],[10367.5,19262,38]],      [[10045.7,18677.2,0.1,83],[10019.2,18673.7,0.1,82],[9996.51,18671.2,0.1,84],[9973.4,18666,0.1,83],[9951.52,18658,0.1,81]],              [[10230.2,18702,0],[10212.6,19679.8,0]]],
    ["Абдера",            [9423,20223],         [[9541.79,20384.1,5],[9463.32,20026.9,21]],      [[9347.07,19679.7,0.1,66],[9323.45,19674.5,0.1,79],[9299.73,19673.2,0.1,84],[9276.45,19673.6,0.1,89],[9254.27,19674.6,0.1,90]],         [[9410.07,20288.2,0],[9506.26,20316.9,0],[9347.49,20705.3,0]]],
    ["Сирта",             [8583.91,18270],      [[8590.58,18069.9,351],[8672,18449,60]],         [[8843.48,17853.2,0.1,22],[8831.44,17834.2,0.1,30],[8824.02,17812,0.1,16],[8819.72,17788.2,0.1,7],[8819.09,17764.3,0.1,358]],           [[8856.75,17926.9,0],[8595.77,18386.5,0],[9037.57,18555.7,0]]],
    ["Негадес",           [4873.59,16148],      [[4835.86,16343.8,123],[4674.71,16135.5,265]],   [[4555.96,16302.7,0.1,34],[4547.64,16283.3,0.1,24],[4541.3,16263.2,0.1,18],[4532.61,16241,0.1,19],[4523.59,16220.5,0.1,21]],            [[4810.95,16431,0],[5048.86,16160.3,0],[4356.67,15948.1,0]]],
    ["Айос-Дионисиос",    [9283.31,15856.3],    [[9472.77,15922.7,250],[9154.59,15703.8,185]],   [[9801.11,15975.4,0.1,238],[9820.15,15980.7,0.1,253],[9842.09,15984.8,0.1,258],[9866.02,15984.8,0.1,268],[9888.86,15979.4,0.1,283]],    [[9136.25,15794.1,0],[9132.83,15310.6,0]]],
    ["Неохори",           [12523.7,14378.8],    [[12663.6,14235.8,332],[12372.5,14509.8,322]],   [[12993.3,14340.2,0.1,250],[13011.9,14351.8,0.1,238],[13030.1,14363.9,0.1,236],[13047.6,14375.9,0.1,237],[13065.5,14388.5,0.1,236]],    [[12663.1,14235.9,0],[12515.7,14464.7,0],[12353.8,14517.4,0],[11920.5,14724.1,0]]],
    ["Зарос",             [9050,11977],         [[9032.73,11777.7,29],[8909.28,12119.1,256]],    [[8779.29,11555.2,0.1,71],[8756.58,11547.4,0.1,70],[8737.16,11535.3,0.1,57],[8718.67,11522.9,0.1,56],[8701.19,11510.1,0.1,56]],         [[9080.89,11863.2,0],[8967.77,11991.7,0],[8993.01,12106.8,0],[8895.54,12127.8,0],[8909.65,12486.2,0]]],
    ["Панохори",          [5090,11262],         [[5221.58,11111.1,306],[4957.62,11412,323]],     [[5472.25,10902.1,0.1,289],[5494.45,10902.1,0.1,264],[5515.18,10909,0.1,252],[5533.93,10918,0.1,241],[5552.16,10928,0.1,241]],          [[5220.05,11113,0],[4719.08,11760.9,0]]],
    ["Нери",              [4152,11745.9],       [[4321.78,11851.7,239],[3994.25,11623.5,238]],   [[4258.99,12146.3,0.1,156],[4249.86,12165.2,0.1,153],[4240.22,12183.1,0.1,152],[4230.47,12200.1,0.1,151],[4219.99,12217.9,0.1,151]],    [[4331.31,12046.4,0],[4360.16,11884.1,0],[4166.46,11789.7,0],[3828.47,11526.8,0],[3802.1,11340,0]]],
    ["Кавала",            [3612.34,13024],      [[3638.48,13222.5,192],[3677.03,12834.9,158]],   [[3563.66,13288,0.1,123],[3545.63,13301.3,0.1,125],[3520.26,13324.1,0.1,130],[3509.48,13336.7,0.1,132],[3480.17,13357.1,0.1,116]],      [[3646.27,13267.6,0],[3649.71,13255,0],[3623.03,12965,0],[3665.88,12925.2,0],[3985.68,12586.6,0]]],
    ["Аггелохори",        [3869.5,13742.1],     [[4042.27,13842.9,233],[3717.87,13872.4,304]],   [[4343.7,13956,0.1,243],[4362.95,13965.5,0.1,243],[4381.83,13975,0.1,243],[4401.21,13985.3,0.1,243],[4420.02,13994.9,0.1,243]],         [[4087.92,13893.5,0],[3880.61,13742.5,0],[3641.39,13929.9,0],[3645.09,14233.4,0]]],   
    ["Парос",             [20931.3,16934],      [[20781.9,16801.1,49],[21081.7,17065.7,59]],     [[20464.7,16761.1,0.1,96],[20443,16765.4,0.1,98],[20422.3,16773.4,0.1,110],[20401.5,16782.2,0.1,112],[20380.5,16788.7,0.1,111]],        [[20609.3,16733.8,0],[20912.7,16921.7,0],[21379.8,17269,0]]],
    ["Пиргос",            [16738.7,12796],      [[16933.7,12840.8,229],[16784.4,12601.3,180.]],  [[16945.7,13170.1,0.1,179],[16949.5,13192.1,0.1,183],[16954.4,13213.2,0.1,189],[16960.6,13234.6,0.1,196],[16972.1,13254.2,0.1,208]],    [[16873.5,12853.6,0],[16803.3,12685.9,0],[16846.6,12245.1,0]]],
    ["Халкея",            [20251.8,11677.5],    [[20175.1,11492.5,345],[20399.7,11812,51]],      [[20342.2,11251,0.1,344],[20347,11230.4,0.1,346],[20350.9,11210.6,0.1,348],[20354.4,11189.8,0.1,347],[20358.1,11168.5,0.1,350]],        [[20175.2,11584.5,0],[20309.7,11756.7,0],[20742,11823.5,0]]]
];

// select correct place for mission
if (PARAMS_AO == 1) then {
    _accepted = false;
    while {!_accepted} do {    
        _position = _targets call BIS_fnc_selectRandom;
        _flatPos  = _position select 1;  
        _distance = [_flatPos, getMarkerPos currentAO] call BIS_fnc_distance2D;
        if (_distance > 3000) then {
            _distance = [_flatPos, getMarkerPos "priorityMarker"] call BIS_fnc_distance2D;
            if (_distance > 1500) then {
                _accepted = true;
            };  
        };
        sleep 5;
    };
} else {
    _position = _targets call BIS_fnc_selectRandom;
    _flatPos  = _position select 1;
};

// set zone area
_startPoint = [(_flatPos select 0),(_flatPos select 1),1];
{ _x setMarkerPos _flatPos; } forEach ["sideMarker", "sideCircle"];
"sideCircle" setMarkerSize [200, 200]; publicVariable "sideCircle";
sideMarkerText = [INFANTRY_MISSION, true]; publicVariable "sideMarkerText";
"sideMarker" setMarkerText INFANTRY_MISSION; publicVariable "sideMarker";
SM_CONVOY_FAIL = false; publicVariable "SM_CONVOY_FAIL";
SM_CONVOY_SUCCESS = false; publicVariable "SM_CONVOY_SUCCESS";

// mark convoy direction on map
_markers = [];
_i = 0;
_arrows = _position select 2;
{
    _markerPos = [_x select 0, _x select 1];
    _markerDir = _x select 2;
    _markerNameA = "markerArrow" + (str _i);
    _markerA = createMarker[_markerNameA, _markerPos];
    _markerA  setMarkercolor "colorRed";
    _markerA  setMarkerSize [1,1];
    _markerA  setMarkerType "Mil_arrow";
    _markerA setMarkerDir _markerDir;
    _markers = _markers + [_markerA];
    _i = _i + 1;
} forEach _arrows;

// show brief information
_city = _position select 0;
_briefing = format ["<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FF9999'>Конвой</t><br/>____________________<br/>Недалеко от %1 разведка обнаружила конвой противника перевозящий Тактический Ядерный Заряд. Цель перемещения неизвестна, но визуальный осмотр показал что Заряд поврежден - есть угроза возникновения неконтролируемой ядерной реакции. Командование назначило пехотную спецоперацию.<br/><br/>Ваша задача — выдвинуться в указанный район, остановить конвой и обезвредить Заряд. Будьте осторожны - любое повреждение объекта может запустить цепную реакцию.</t>", _city];
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSideMission", "Конвой"]; publicVariable "showNotification";
sideMissionUp = true; publicVariable "sideMissionUp";

// wait for player in zone, then wait a bit and spawn convoy
canStart = false;
_trig = createTrigger ["EmptyDetector", _flatPos, false]; 
_trig setTriggerArea [150, 150, 0, false];
_trig setTriggerActivation ["WEST", "PRESENT", false];
_trig setTriggerStatements ["this", "canStart = true;", ""];
while {!canStart} do {
    sleep 5;
};
hqSideChat = "Конвой будет в зоне операции через несколько минут, приготовьтесь!"; publicVariable "hqSideChat"; [OUR_SIDE, "HQ"] sideChat hqSideChat;

sleep 30 + (random 60);

_convoyCenter = createCenter ENEMY_SIDE;
_convoyGroup = createGroup ENEMY_SIDE;  
_convoyGroup setSpeedMode "NORMAL";
_convoyGroup setBehaviour "SAFE";
_convoyGroup setCombatMode "RED";
_convoyGroup allowFleeing 0;

// set waypoints
_currentWP = false;
_wayPoints = _position select 4;
_cntWaypoints = count _wayPoints;
for "_i" from 0 to (_cntWaypoints -1) do { 
    _currentWP = (_wayPoints select _i);
    _wp = _convoyGroup addWaypoint [_currentWP, 0];
    [_convoyGroup,_i] setWaypointType "MOVE";
    [_convoyGroup,_i] setWaypointCompletionRadius 10;    
    [_convoyGroup,_i] setWaypointFormation "FILE";
    [_convoyGroup,_i] setWaypointBehaviour "SAFE";
    [_convoyGroup,_i] setWaypointCombatMode "NO CHANGE";

    // debug waypoint markers
    //_wpmarkerName = "wpmarker" + (str _i);
    //_wpmarker = createMarker[_wpmarkerName,_currentWP];
    //_wpmarker setMarkercolor "colorRed";
    //_wpmarker setMarkerSize [1,1];
    //_wpmarker setMarkerType "Mil_dot";
};

// spawn vehicles
convoyVclDestroyed = false; publicVariable "convoyVclDestroyed";
_vehicles = [INFANTRY_CONVOY];
_positions = _position select 3;
_convoy = [];
_convoyVehs = [];
for "_i" from 0 to ((count _vehicles) - 1) do {
    _initPosition = [(_positions select _i) select 0, (_positions select _i) select 1, (_positions select _i) select 2];
    _currentVeh = _vehicles select _i;
    _spawn = [_initPosition, 180, _currentVeh, _convoyGroup] call BIS_fnc_spawnVehicle;
    _spawned = (_spawn select 0);    
    _initDir = (_positions select _i) select 3;
    _spawned setPos _initPosition;
    _spawned setDir _initDir;
    if (_currentVeh == INFANTRY_DEVICE_VEHICLE) then {
        [_spawned, "QS_fnc_addActionDefuse", nil, true] spawn BIS_fnc_MP;
        vehDevice = (_spawn select 0);
        vehDevice setDamage 0.5;
        vehDevice addMPEventHandler ["MPKilled", {
            SM_CONVOY_FAIL = true; publicVariable "SM_CONVOY_FAIL";
            _basePos = getMarkerPos "respawn_west";
            _curObj = _this select 0;
            _curObj setDamage 0.9;
            _epicenter = getPos _curObj;            
            if (isServer) then {
                convoyVclDestroyed = true; publicVariable "convoyVclDestroyed";   
                _bigBomb = createVehicle ["Bo_GBU12_LGB", _epicenter, [], 0, "NONE"];   
                if (((_this select 0) distance _basePos) > 2200) then {      
                    _k = 1.66;
                    _radius = 900;
                    _radiusEMI = 1400;                   
                    _allObjects1 = nearestObjects [_epicenter,[], _radius];
                    {
                        _distance = [_epicenter, getPos _x] call BIS_fnc_distance2D;
                        _x setDamage (abs ((_distance / _radius) - _k));
                    } foreach _allObjects1;
                    _allObjects2 = nearestObjects [_epicenter, ["LandVehicle","Air","Ship"], _radiusEMI];
                    {
                        _x engineOn false;
                        _x setfuel 0;        
                    } foreach _allObjects2;
                };     
                [_curObj, "QS_fnc_removeAction0", nil, true] spawn BIS_fnc_MP;
                deleteVehicle _curObj;                
            };

            // show nuke explotion effect for players
            if (hasInterface) then {
                //[[_epicenter], "scripts\nuke.sqf"] call BIS_fnc_execVM;
                [_epicenter] execVM "scripts\nuke.sqf";
            };            
        }];

        // remove passengers from device vehicle        
        {
            if (_x != driver _spawned) then {
                deleteVehicle _x;
            };
        } forEach (crew _spawned);
    } else {
        _spawned setVehicleLock "LOCKED"; 
        _spawned lock true; 
        _convoyVehs = _convoyVehs + [_spawned];
         
    };
    _spawned addEventHandler ["dammaged", {
            convoyVclDestroyed = true; publicVariable "convoyVclDestroyed";
        }
    ];    
    _convoy = _convoy + [_spawned];

    // fill cargo places
    if (_currentVeh != INFANTRY_DEVICE_VEHICLE && _currentVeh != INFANTRY_FIRST_VEHICLE) then { 
        _cargoPlaces = _spawned emptyPositions "cargo";
        if (_cargoPlaces > 0) then {
            _cargoPos =  _initPosition findEmptyPosition [10, 100];
            sleep 0.2;
            if (_cargoPos select 0 > 0)then {
                for "_i" from 1 to _cargoPlaces do { 
                    ([INFANTRY_SOLDIERS] call BIS_fnc_selectRandom) createUnit [_cargoPos, _convoyGroup, "currentSoldier = this"];
                    sleep 0.1;
                    currentSoldier moveInCargo _spawned;
                };
            };        
        };
    };
    sleep 3;  
};
[(units _convoyGroup)] call QS_fnc_setSkill3;
_enemiesArray = _enemiesArray + [_convoyGroup];

// wait for attack
while {!convoyVclDestroyed && !SM_CONVOY_SUCCESS && !SM_CONVOY_FAIL} do {
    {

        // check destination point
        if ((typeOf _x) == INFANTRY_DEVICE_VEHICLE) then {            
            if (((getPos _x) distance2D _currentWP) < 100) then {
                SM_CONVOY_FAIL = true; publicVariable "SM_CONVOY_FAIL";
            };
        };

        if (!alive _x || !canMove _x || isNull (driver _x)) exitWith {
            convoyVclDestroyed = true; publicVariable "convoyVclDestroyed";
        };
    } foreach _convoy;
    sleep 4;    
};

// Convoy under attack - remove waypoints
for "_i" from 0 to (_cntWaypoints -1) do { 
    deleteWaypoint [_convoyGroup, _i];
};

// Stop all vehicles   
_outGroup = [];
_defPoint = [0,0,0]; 
{
    _vcl = _x;
    if (alive _vcl) then {
        _vcl forceSpeed 0; 
        _vcl engineOn false;
        _driver = driver _vcl;
        if ((typeOf _vcl) in ["O_APC_Wheeled_02_rcws_F","O_MRAP_02_hmg_F","O_Truck_03_device_F"]) then {            
            if ((typeOf _vcl) == "O_Truck_03_device_F") then {
                _defPoint = getPos _vcl;
                if (!isNull _driver) then {
                    _driver action ["Eject", _vcl];
                    [_driver] allowGetIn false;
                };
            } else {
                _outGroup = _outGroup + fullCrew [_vcl, "cargo"];
            };
        } else {
            _vcl setfuel 0;
            if (!isNull _driver) then {
                _driver action ["Eject", _vcl];
                [_driver] allowGetIn false;
            };
            _outGroup = _outGroup + fullCrew _vcl;
        };
    };
} forEach _convoy;

_convoyGroup setBehaviour "COMBAT";
_convoyGroup setCombatMode "RED";

// Disembark
_outUnits = [];  
{                         
    _unit = _x select 0;
    if (alive _unit) then {   
        _unit action ["Eject", (vehicle _unit)]; 
        _outUnits = _outUnits + [_unit];
    };
} forEach _outGroup;
_outUnits allowGetIn false;

// make 10 groups which will attack enemies and defend object
_units1 = [];
_units2 = [];
_units3 = [];
_units4 = [];
_units5 = [];
_units6 = [];
_units7 = [];
_units8 = [];
_units9 = [];
_units10 = [];
_unitsGroup1 = createGroup ENEMY_SIDE;
_unitsGroup2 = createGroup ENEMY_SIDE;
_unitsGroup3 = createGroup ENEMY_SIDE;
_unitsGroup4 = createGroup ENEMY_SIDE;
_unitsGroup5 = createGroup ENEMY_SIDE;
_unitsGroup6 = createGroup ENEMY_SIDE;
_unitsGroup7 = createGroup ENEMY_SIDE;
_unitsGroup8 = createGroup ENEMY_SIDE;
_unitsGroup9 = createGroup ENEMY_SIDE;
_unitsGroup10 = createGroup ENEMY_SIDE;
_i = 0;
_n = 1;
{
    if (_i > 4) then {
        _i = 0;
        _n = _n + 1;
    };
    switch (_n) do { 
        case 1 : { _units1 = _units1 + [_x]; }; 
        case 2 : { _units2 = _units2 + [_x]; }; 
        case 3 : { _units3 = _units3 + [_x]; }; 
        case 4 : { _units4 = _units4 + [_x]; }; 
        case 5 : { _units5 = _units5 + [_x]; }; 
        case 6 : { _units6 = _units6 + [_x]; }; 
        case 7 : { _units7 = _units7 + [_x]; }; 
        case 8 : { _units8 = _units8 + [_x]; }; 
        case 9 : { _units9 = _units9 + [_x]; }; 
        default { _units10 = _units10 + [_x]; }; 
    };   
    _i = _i + 1;
} foreach _outUnits;
_units1 joinSilent _unitsGroup1;
_units2 joinSilent _unitsGroup2;
_units3 joinSilent _unitsGroup3;
_units4 joinSilent _unitsGroup4;
_units5 joinSilent _unitsGroup5;
_units6 joinSilent _unitsGroup6;
_units7 joinSilent _unitsGroup7;
_units8 joinSilent _unitsGroup8;
_units9 joinSilent _unitsGroup9;
_units10 joinSilent _unitsGroup10;
_enemiesArray = _enemiesArray + [_unitsGroup1, _unitsGroup2, _unitsGroup3, _unitsGroup4, _unitsGroup5, _unitsGroup6, _unitsGroup7, _unitsGroup8, _unitsGroup9, _unitsGroup10];

// get group leaders
_leader1 = leader _unitsGroup1;
_leader2 = leader _unitsGroup2;
_leader3 = leader _unitsGroup3;
_leader4 = leader _unitsGroup4;
_leader5 = leader _unitsGroup5;
_leader6 = leader _unitsGroup6;
_leader7 = leader _unitsGroup7;
_leader8 = leader _unitsGroup8;
_leader9 = leader _unitsGroup9;
_leader10 = leader _unitsGroup10;

// find nearby enemies, attack them then back to defend point
_enemy1 = objNull;
_enemy2 = objNull;
_enemy3 = objNull;
_enemy4 = objNull;
_enemy5 = objNull;
_enemy6 = objNull;
_enemy7 = objNull;
_enemy8 = objNull;
_enemy9 = objNull;
_enemy10 = objNull;
_checkDistance = 450;
_attackersLeft = count (units _unitsGroup1) + count (units _unitsGroup2) + count (units _unitsGroup3) + count (units _unitsGroup4) + count (units _unitsGroup5) + count (units _unitsGroup6) + count (units _unitsGroup7) + count (units _unitsGroup8) + count (units _unitsGroup9) + count (units _unitsGroup10);
while {!SM_CONVOY_SUCCESS && !SM_CONVOY_FAIL && _attackersLeft > 0} do {
    sleep 2;
    _attackersLeft = count (units _unitsGroup1) + count (units _unitsGroup2) + count (units _unitsGroup3) + count (units _unitsGroup4) + count (units _unitsGroup5) + count (units _unitsGroup6) + count (units _unitsGroup7) + count (units _unitsGroup8) + count (units _unitsGroup9) + count (units _unitsGroup10);
    if (!alive _enemy1) then {     
        _enemy1 = _leader1 findNearestEnemy (getPos _leader1);
        if (!isNull _enemy1) then {
            _posEnemy = getPos _enemy1;
            if ((_posEnemy distance2D _defPoint) < _checkDistance) then {
                {                
                    _x doMove _posEnemy;
                } forEach (units _unitsGroup1);
            };
        } else {
            {
                _x doMove _defPoint;
            } forEach (units _unitsGroup1);
        };
    };
    if (!alive _enemy2) then {     
        _enemy2 = _leader2 findNearestEnemy (getPos _leader2);
        if (!isNull _enemy2) then {
            _posEnemy = getPos _enemy2;
            if ((_posEnemy distance2D _defPoint) < _checkDistance) then {
                {                
                    _x doMove _posEnemy;
                } forEach (units _unitsGroup2);
            };
        } else {
            {
                _x doMove _defPoint;
            } forEach (units _unitsGroup2);
        };
    };
    if (!alive _enemy3) then {     
        _enemy3 = _leader6 findNearestEnemy (getPos _leader3);
        if (!isNull _enemy3) then {
            _posEnemy = getPos _enemy3;
            if ((_posEnemy distance2D _defPoint) < _checkDistance) then {
                {                
                    _x doMove _posEnemy;
                } forEach (units _unitsGroup3);
            };
        } else {
            {
                _x doMove _defPoint;
            } forEach (units _unitsGroup3);
        };
    };
    if (!alive _enemy4) then {     
        _enemy4 = _leader4 findNearestEnemy (getPos _leader4);
        if (!isNull _enemy4) then {
            _posEnemy = getPos _enemy4;
            if ((_posEnemy distance2D _defPoint) < _checkDistance) then {
                {                
                    _x doMove _posEnemy;
                } forEach (units _unitsGroup4);
            };
        } else {
            {
                _x doMove _defPoint;
            } forEach (units _unitsGroup4);
        };
    };
    if (!alive _enemy5) then {     
        _enemy5w = _leader5 findNearestEnemy (getPos _leader5);
        if (!isNull _enemy5) then {
            _posEnemy = getPos _enemy5;
            if ((_posEnemy distance2D _defPoint) < _checkDistance) then {
                {                
                    _x doMove _posEnemy;
                } forEach (units _unitsGroup5);
            };
        } else {
            {
                _x doMove _defPoint;
            } forEach (units _unitsGroup5);
        };
    };
    if (!alive _enemy6) then {     
        _enemy6 = _leader6 findNearestEnemy (getPos _leader6);
        if (!isNull _enemy6) then {
            _posEnemy = getPos _enemy6;
            if ((_posEnemy distance2D _defPoint) < _checkDistance) then {
                {                
                    _x doMove _posEnemy;
                } forEach (units _unitsGroup6);
            };
        } else {
            {
                _x doMove _defPoint;
            } forEach (units _unitsGroup6);
        };
    };
    if (!alive _enemy7) then {     
        _enemy6 = _leader7 findNearestEnemy (getPos _leader7);
        if (!isNull _enemy7) then {
            _posEnemy = getPos _enemy7;
            if ((_posEnemy distance2D _defPoint) < _checkDistance) then {
                {                
                    _x doMove _posEnemy;
                } forEach (units _unitsGroup7);
            };
        } else {
            {
                _x doMove _defPoint;
            } forEach (units _unitsGroup7);
        };
    };
    if (!alive _enemy8) then {     
        _enemy6 = _leader8 findNearestEnemy (getPos _leader8);
        if (!isNull _enemy8) then {
            _posEnemy = getPos _enemy8;
            if ((_posEnemy distance2D _defPoint) < _checkDistance) then {
                {                
                    _x doMove _posEnemy;
                } forEach (units _unitsGroup8);
            };
        } else {
            {
                _x doMove _defPoint;
            } forEach (units _unitsGroup8);
        };
    };
    if (!alive _enemy9) then {     
        _enemy6 = _leader9 findNearestEnemy (getPos _leader9);
        if (!isNull _enemy9) then {
            _posEnemy = getPos _enemy9;
            if ((_posEnemy distance2D _defPoint) < _checkDistance) then {
                {                
                    _x doMove _posEnemy;
                } forEach (units _unitsGroup9);
            };
        } else {
            {
                _x doMove _defPoint;
            } forEach (units _unitsGroup9);
        };
    };
    if (!alive _enemy10) then {     
        _enemy6 = _leader10 findNearestEnemy (getPos _leader10);
        if (!isNull _enemy10) then {
            _posEnemy = getPos _enemy10;
            if ((_posEnemy distance2D _defPoint) < _checkDistance) then {
                {                
                    _x doMove _posEnemy;
                } forEach (units _unitsGroup10);
            };
        } else {
            {
                _x doMove _defPoint;
            } forEach (units _unitsGroup10);
        };
    };

    // check destination point
    {
        _vcl = _x;
        if ((typeOf _vcl) == "O_Truck_03_device_F") then {            
            if (((getPos _vcl) distance2D _currentWP) < 100) then {
                SM_CONVOY_FAIL = true; publicVariable "SM_CONVOY_FAIL";
            };
        };
    } forEach _convoy;

    sleep 2;
};

while { sideMissionUp } do {
    sleep 2;

    // de-briefing
    if (SM_CONVOY_SUCCESS || SM_CONVOY_FAIL) exitWith {  
        _delConvoy = [];
        sideMissionUp = false; publicVariable "sideMissionUp";        
        { _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
        if (SM_CONVOY_FAIL) then {
            _delConvoy = _convoy;
            [] call QS_fnc_SMhintFAIL;            
        } else {
            _delConvoy = _convoyVehs;
            [] call QS_fnc_SMhintSUCCESS;  

            // change event to prevent next convoy fail on destroy device from previous mission
            vehDevice removeAllMPEventHandlers "MPKilled";
            vehDevice addMPEventHandler ["MPKilled", {
                _basePos = getMarkerPos "respawn_west";
                _curObj = _this select 0;
                _curObj setDamage 0.9;
                _epicenter = getPos _curObj;            
                if (isServer) then {  
                    _bigBomb = createVehicle ["Bo_GBU12_LGB", _epicenter, [], 0, "NONE"];   
                    if (((_this select 0) distance _basePos) > 2200) then {      
                        _k = 1.66;
                        _radius = 900;
                        _radiusEMI = 1400;                   
                        _allObjects1 = nearestObjects [_epicenter,[], _radius];
                        {
                            _distance = [_epicenter, getPos _x] call BIS_fnc_distance2D;
                            _x setDamage (abs ((_distance / _radius) - _k));
                        } foreach _allObjects1;
                        _allObjects2 = nearestObjects [_epicenter, ["LandVehicle","Air","Ship"], _radiusEMI];
                        {
                            _x engineOn false;
                            _x setfuel 0;        
                        } foreach _allObjects2;
                    };
                    [_curObj, "QS_fnc_removeAction0", nil, true] spawn BIS_fnc_MP;
                    deleteVehicle _curObj;                
                };
    
                // show nuke explotion effect for players
                if (hasInterface) then {
                    //[[_epicenter], "scripts\nuke.sqf"] call BIS_fnc_execVM;
                    [_epicenter] execVM "scripts\nuke.sqf";
                };            
            }];
        };
        _i = 0;
        {
            _markerNameA = "markerArrow" + (str _i);
            deleteMarker _markerNameA;
            _i = _i + 1;
        } forEach _markers;
        sleep 120;
        { 
            if (alive _x) then {
                deleteVehicle _x;
            };
        } forEach _delConvoy;  
        { 
            if (typeName _x == "GROUP") then {
                {
                    deleteVehicle _x;
                } forEach (units _x);
            } else {
                deleteVehicle _x;
            };
            sleep 0.5;
        } forEach _enemiesArray; 
    };
    sleep 3;
};