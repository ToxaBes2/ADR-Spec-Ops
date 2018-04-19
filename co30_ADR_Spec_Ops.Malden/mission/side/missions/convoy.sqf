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
#define INFANTRY_SOLDIERS "O_Soldier_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_TL_F","O_soldier_M_F","O_Soldier_LAT_F","O_medic_F","O_soldier_repair_F","O_soldier_exp_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_recon_F","O_recon_M_F","O_recon_LAT_F","O_recon_medic_F","O_recon_TL_F","O_Soldier_AAT_F","O_soldierU_M_F","O_SoldierU_GL_F"

// define private variables
private ["_targets","_accepted","_distance","_briefing","_position","_city","_flatPos","_x","_enemiesArray","_startPoint"];

_enemiesArray = [grpNull];

// format: [city name,            [coords x,y],         [[arrow1 x,y,dir],[arrow2 x,y,dir]],             [array of five init vehicle points x,y,z,dir],                                                                                          [array of convoy waypoints x,y,z]]
_targets = [        
    ["Эради",                     [5544,6991],          [[5738.8,6945.68,296],[5371.12,6890.74,208]],    [[5912.72,7141.71,0,205],[5923.05,7156.36,0,227],[5936.32,7167.09,0,235],[5953.15,7171.84,0,258],[5969.65,7171,0,274]],                 [[5820.1,7039.94,0],[5850.49,6932.33,0],[5594.24,7022.25,0],[5207.18,6686.09,0]]],
    ["Ла Трините",                [7270,7959],          [[7238.44,7762.66,30],[7248.52,8159.14,340]],    [[7046.53,7598.23,0,339],[7054.52,7578.45,0,340],[7061.61,7560.53,0,335],[7070.67,7542.64,0,327],[7079.87,7528.6,0,328]],               [[7039.99,7671.95,0],[7238.75,7761.87,0],[7236.55,8197.7,0],[7304.79,8563.45,0]]],
    ["Сэнт-Луис",                 [7129,8963],          [[6958.91,8860.12,69],[6977.25,9094.9,307]],     [[6485.01,8759.86,0,75],[6468.36,8755.35,0,75],[6453.13,8751.47,0,75],[6437.06,8747.16,0,75],[6423.63,8744.22,0,75]],                   [[6989.35,8870.05,0],[7121.55,8960.79,0],[7108.1,8985.12,0],[6583.77,9313.77,0]]],
    ["Ларше",                     [6058,8625],          [[5859.76,8642.35,84],[6248.73,8688.09,77]],     [[5552.17,8698.09,0,104],[5535.53,8701.57,0,101],[5516.46,8703.86,0,96],[5499.52,8704.59,0,75],[5485.69,8697.59,0,60]],                 [[5604.26,8624.9,0],[5946.3,8641.32,0],[5982.93,8643.96,0],[6098.56,8635.87,0],[6503.55,8765.39,0]]],
    ["Заброшенная Военная База",  [6095,10755],         [[5895.12,10750.9,104],[6283.03,10685.8,108]],   [[5740.15,10751.8,0,108],[5726.8,10756.9,0,129],[5717.2,10768.7,0,157],[5709.3,10783.6,0,140],[5699.86,10793,0,134]],                   [[6052.86,10761.5,0],[6062.58,10750.7,0],[6095.49,10726.4,0],[6130.37,10759.1,0],[6314.36,10675.8,0],[6415.46,10644.2,0],[6592.29,10697,0]]],
    ["Ла Пессане",                [3099,6320],          [[3294.01,6275.76,296],[3012.63,6139.42,201]],   [[3597.8,6522.09,0,164],[3595.25,6536.74,0,177],[3595.38,6550.32,0,178],[3595.61,6566.83,0,182],[3598.61,6583.62,0,191]],               [[3270.89,6288.58,0],[3057.6,6331.3,0],[2997.98,6063.79,0],[3086.79,5739.68,0]]],
    ["Ле Порт",                   [8226,3194],          [[8283.5,3386.19,171],[8070.2,3068.68,255]],     [[8237.8,3610.4,0,168],[8234.76,3624.19,0,168],[8231.74,3641.5,0,168],[8229.1,3661.21,0,168],[8226.75,3677.84,0,168]],                  [[8282.74,3349.57,0],[8152.15,3115.64,0],[8138.82,3097.43,0],[7960.09,3060.72,0],[7924.89,3049.02,0],[7833.39,3110.13,0]]],
    ["Электростанция",            [7755,3261],          [[7856.11,3088.43,117],[7695.77,3452.18,169]],   [[7610.78,3791.1,0,123],[7597.18,3800.51,0,128],[7584.54,3810.59,0,128],[7569.72,3824.49,0,129],[7553.27,3837.87,0,128]],               [[7777.14,3670.22,0],[7692.17,3466.27,0],[7804.77,3235.07,0],[7828.91,3123.3,0],[7842.82,3098,0],[7927.17,3048.3,0],[8128.32,3092.45,0]]]                    
];

// select correct place for mission
_position = selectRandom _targets;
_flatPos  = _position select 1;

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
_briefing = format ["<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FFC107'>Конвой</t><br/>____________________<br/>Недалеко от %1 разведка обнаружила конвой противника перевозящий Тактический Ядерный Заряд. Цель перемещения неизвестна, но визуальный осмотр показал что Заряд поврежден - есть угроза возникновения неконтролируемой ядерной реакции. Командование назначило пехотную спецоперацию.<br/><br/>Ваша задача — выдвинуться в указанный район, остановить конвой и обезвредить Заряд. Будьте осторожны - любое повреждение объекта может запустить цепную реакцию.</t>", _city];
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSpecMission", "Конвой"]; publicVariable "showNotification";
sideMissionUp = true; publicVariable "sideMissionUp";

// save info in DB
try {
    _posData = format ["%1,%2", floor (_flatPos select 0), floor (_flatPos select 1)];
    ["setInfo",["spec_name", "Конвой"], 0] remoteExec ["sqlServerCall", 2];
    ["setInfo",["spec_position", _posData], 0] remoteExec ["sqlServerCall", 2];
} catch {};

// wait for player in zone, then wait a bit and spawn convoy
canStart = false;
_trig1 = createTrigger ["EmptyDetector", _flatPos, false];
_trig1 setTriggerArea [150, 150, 0, false];
_trig1 setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trig1 setTriggerStatements ["this", "canStart = true;", ""];

//_trig2 = createTrigger ["EmptyDetector", _flatPos, false];
//_trig2 setTriggerArea [150, 150, 0, false];
//_trig2 setTriggerActivation ["GUER", "PRESENT", false];
//_trig2 setTriggerStatements ["this", "canStart = true;", ""];
while {!canStart} do {
    sleep 5;
};
hqSideChat = "Конвой будет в зоне операции через несколько минут, приготовьтесь!"; publicVariable "hqSideChat"; [OUR_SIDE, "HQ"] sideChat hqSideChat;

sleep 90 + (random 60);

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
    _spawned addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
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
            _unit = _this select 1;
            _side = side _unit;
            if (_side == west || _side == resistance) then {
                NUCLEAR_TIMER_SIDE = _side; publicVariable "NUCLEAR_TIMER_SIDE";
            };
            _epicenter = getPos _curObj;
            if (isServer) then {
                convoyVclDestroyed = true; publicVariable "convoyVclDestroyed";
                _bigBomb = createVehicle ["Bo_GBU12_LGB", _epicenter, [], 0, "NONE"];
                if (((_this select 0) distance2D _basePos) > 2000) then {
                    _radiusMAN = 1000;
                    _radiusEMI = 1500;
                    _radiusALL = 100;
                    _allObjects0 = nearestObjects [_epicenter,[], _radiusALL];
                    {
                        _x setDamage 1;
                    } foreach _allObjects0;
                    _allObjects1 = nearestObjects [_epicenter,["Man"], _radiusMAN];
                    {
                        (vehicle _x) setDamage 1;
                    } foreach _allObjects1;
                    _allObjects2 = nearestObjects [_epicenter, ["LandVehicle","Air","Ship"], _radiusEMI];
                    {
                        _x engineOn false;
                        _fuel = fuel _x;
                        _x setFuel 0;
                        sleep 0.01;
                        _x setFuel _fuel;
                        _x setHit ["motor", 1];
                        driver _x action ["lightOff", _x];
                        _x setHit ["elektronika", 1];
                    } foreach _allObjects2;
                };
                [_curObj, "QS_fnc_removeAction0", nil, true] spawn BIS_fnc_MP;
                deleteVehicle _curObj;
            };
            
            // show nuke explotion effect for players
            if (hasInterface) then {
                [_epicenter] execVM "scripts\nuke\nuke.sqf";
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
                    (selectRandom [INFANTRY_SOLDIERS]) createUnit [_cargoPos, _convoyGroup, "currentSoldier = this"];
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
[_startPoint, 200, ["vehicles", "fire"]] call QS_fnc_addHades;

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
            [true] call QS_fnc_SMhintFAIL;
        } else {
            _delConvoy = _convoyVehs;
            if (WIN_WEST > WIN_GUER) then {
                [4] spawn QS_fnc_bluforSUCCESS;
            } else {
                [4] spawn QS_fnc_partizanSUCCESS;
            };

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
                            _fuel = fuel _x;
                            _x setFuel 0;
                            sleep 0.01;
                            _x setFuel _fuel;
                            _x setHit ["motor", 1];
                            driver _x action ["lightOff", _x];
                            _x setHit ["elektronika", 1];
                        } foreach _allObjects2;
                    };
                    [_curObj, "QS_fnc_removeAction0", nil, true] spawn BIS_fnc_MP;
                    deleteVehicle _curObj;
                };

                // show nuke explotion effect for players
                if (hasInterface) then {
                    [_epicenter] execVM "scripts\nuke\nuke.sqf";
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
        deleteVehicle _trig1;
        //deleteVehicle _trig2;
    };
    sleep 3;
};
