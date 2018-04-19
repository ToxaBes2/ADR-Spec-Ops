/*
Author:	ToxaBes
Description: Ambush convoy and defuse the bomb.
*/

// define some keywords
#define INFANTRY_MISSION "Спецоперация: Конвой (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_DEVICE_VEHICLE "O_T_Truck_03_device_ghex_F"
#define INFANTRY_FIRST_VEHICLE "O_T_APC_Wheeled_02_rcws_ghex_F"
#define INFANTRY_CONVOY "O_T_APC_Wheeled_02_rcws_ghex_F","O_T_Truck_03_covered_ghex_F","O_T_Truck_03_device_ghex_F","O_T_Truck_03_transport_ghex_F","O_T_MRAP_02_hmg_ghex_F"
#define INFANTRY_SOLDIERS "O_V_Soldier_TL_ghex_F", "O_V_Soldier_ghex_F", "O_V_Soldier_Medic_ghex_F", "O_V_Soldier_M_ghex_F", "O_V_Soldier_LAT_ghex_F", "O_V_Soldier_JTAC_ghex_F", "O_V_Soldier_Exp_ghex_F", "O_T_Recon_TL_F", "O_T_Recon_F", "O_T_Recon_LAT_F", "O_T_Recon_JTAC_F", "O_T_Recon_Exp_F", "O_T_Recon_Medic_F", "O_T_Recon_M_F", "O_T_Soldier_GL_F", "O_T_Soldier_TL_F", "O_T_Soldier_SL_F", "O_T_Medic_F", "O_T_Soldier_F", "O_T_Crew_F", "O_T_Soldier_AR_F"

// define private variables
private ["_targets","_accepted","_distance","_briefing","_position","_city","_flatPos","_x","_enemiesArray","_startPoint"];

_enemiesArray = [grpNull];

// format: [city name,           [coords x,y],          [[arrow1 x,y,dir],[arrow2 x,y,dir]],                [array of five init vehicle points x,y,z,dir],                                                                                          [array of convoy waypoints x,y,z]]
_targets = [
    ["Порт Голубая жемчужина",   [13498.8,12014.5],     [[13312.5,12087.2,117],[13572.8,11828.7,202]],      [[13092.8,12295.1,0.1,163],[13089,12316.6,0.1,170],[13085.5,12337.8,0.1,173],[13081.7,12359.2,0.1,167],[13075.9,12377.5,0.1,165]],      [[13498.5,12013.2,0],[13619.3,11961.5,0,[13567.3,11790.2,0],[13925.5,11806.4,0]]],
    ["Луганвил",                 [13968.7,8329.76],     [[14137.3,8437.2,252],[13984,8130.5,160]],          [[14254.2,8601.04,0.1,175],[14258,8620.57,0.1,194],[14267.7,8638.76,0.1,206],[14280.7,8654.89,0.1,223],[14297.2,8665.83,0.1,235]],      [[13993.6,8313.7,0],[13861.3,7955.52,0]]],
    ["Таноука",                  [8845.45,10180.4],     [[8663.69,10097.2,67],[8985.03,10323.6,26]],        [[8491.98,9932.83,0.1,45],[8478.76,9918.15,0.1,42],[8463.13,9902.7,0.1,46],[8449.61,9887.74,0.1,43],[8436.81,9871.72,0.1,43]],          [[8789.23,10221.1,0],[8889.7,10197.7,0],[8911.37,10205.8,0],[9030.66,10616.3,0]]],
    ["Регина",                   [5216.22,8711.43],     [[5038.4,8803.04,92],[5201.69,8511.98,170]],        [[4792.96,8838.11,0.1,103],[4772.33,8844.04,0.1,103],[4752.77,8847.9,0.1,103],[4732.33,8849.27,0.1,100],[4711.6,8848.09,0.1,89]],       [[5219.01,8756.16,0],[5339.45,8297.66,0]]],
    ["Джорджтаун",               [5648.28,10092.1],     [[5571.13,9907.8,58],[5730.19,10274.6,25]],         [[5273.88,9888.5,0.1,95],[5252.57,9888.62,0.1,90],[5231.85,9889.39,0.1,90],[5212.26,9890.75,0.1,94],[5191.45,9891.38,0.1,95]],          [[5504.34,9887.46,0],[5541.23,9873.41,0],[5564.7,9901.91,0],[5706.63,10132.1,0],[5769.35,10368.5,0],[5817.75,10380.6,0], [5782.94,10665.9,0]]],
    ["Джорджтаун",               [5788.12,10572.7],     [[5780.69,10772.6,184],[5819.21,10376.1,183]],      [[5978.78,10926,0.1,254],[6000.27,10931.3,0.1,256],[6021.09,10936.9,0.1,255],[6041.61,10940.8,0.1,255],[6061.69,10944.4,0.1,261]]],     [[5854.54,10835.9,0],[5844.4,10813.5,0],[5787.07,10573,0],[5724.27,10226.7,0]]],
    ["Джорджтаун",               [5994.58,10417.1],     [[6109.73,10253.8,270],[6122.11,10571.2,324]],      [[6272.64,10137.9,0.1,333],[6287.27,10122.8,0.1,324],[6301.59,10107,0.1,323],[6313.26,10089.3,0.1,331],[6320.2,10073.4,0.1,331]],       [[6088.69,10254.8,0],[6085.33,10265,0],[6134.73,10423.5,0],[5919.57,10605.5,0],[5854.3,10837.9,0]]],
    ["Николет",                  [6362.64,12824.6],     [[6168.36,12777.1,71],[6542.97,12911,38]],          [[5972.07,12817.1,0.1,90],[5950.98,12811.6,0.1,78],[5936,12805.5,0.1,78],[5921.61,12798.2,0.1,67],[5907.08,12787.9,0.1,68]],            [[6361.11,12859.7,0],[6655.77,13113.5,0]]],
    ["Ла Рошель",                [9473.37,13545.3],     [[9290.15,13625.5,143],[9672.43,13532.4,104]],      [[9119.21,13731.6,0.1,87],[9098.61,13727.7,0.1,84],[9078.07,13721.2,0.1,80],[9058.87,13714.4,0.1,80],[9038.21,13707.1,0.1,79]],         [[9476.34,13548.1,0],[9958.06,13502.1,0]]],
    ["Ла Рошель",                [9884.17,13505.4],     [[10083.9,13491.3,273],[9685.82,13530.5,274]],      [[10282.1,13405.9,0.1,292],[10307.7,13406.9,0.1,275],[10325.9,13410.4,0.1,264],[10343.4,13415,0.1,259],[10362.1,13421.4,0.1,255]],      [[9905.41,13503.8,0],[9862.65,13503,0],[9313.27,13606.7,0]]],
    ["Момеа",                    [10620.6,13374.7],     [[10812.8,13429.4,279],[10435,13449.2,247]],        [[10981.3,13322.5,0.1,298],[11001.5,13312.5,0.1,296],[11019.1,13302.5,0.1,299],[11036,13292.2,0.1,300],[11051.2,13281.2,0.1,303]],      [[10638,13458.2,0],[10232.4,13424.3,0]]],
    ["Лесной склад",             [8854.49,11891.1],     [[8852.12,11691,50],[8710.52,12029.7,279]],         [[8962.93,11526.7,0.1,299],[8980.17,11515.1,0.1,305],[8996.57,11502.6,0.1,308],[9013.54,11486.5,0.1,313],[9028.27,11469.1,0.1,318]],    [[8811.16,11859.1,0],[8548.99,12244.3,0]]],
    ["Лесопилка",                [11516.8,7572.6],      [[11532.2,7771.94,181],[11561.9,7377.75,147]],      [[11544.6,7972.19,0.1,163],[11536,7990.18,0.1,160],[11526.6,8008.36,0.1,160],[11513.3,8025.38,0.1,159],[11503.1,8041.2,0.1,158]],       [[11517,7572.71,0],[11658.8,7224.84,0]]],
    ["Руины",                    [10278.1,8611.61],     [[10088.8,8677.24,114],[10324.7,8417.16,220]],      [[9990.88,8851.35,0.1,196],[9994.65,8869.87,0.1,193],[9999.39,8890.43,0.1,198],[10005.5,8914.21,0.1,198],[10014,8936.64,0.1,201]],      [[10279.4,8608.31,0],[10329.8,8423.44,0],[10212.4,8259.01,0]]],
    ["Лиджинхавен",              [11633.8,2653.05],     [[11483.8,2520.59,12],[11639.3,2852.26,6]],         [[11638,2391.88,0.1,304],[11654.1,2374.89,0.1,311],[11664.6,2361.17,0.1,316],[11676.7,2344.63,0.1,316],[11687.2,2326.47,0.1,331]],      [[11573.7,2438.3,0],[11484,2522.03,0],[11496.5,2535.45,0],[11548.1,2551.45,0],[11638.5,2665.93,0],[11638.8,2856.24,0],[11671.1,2992.19,0],[11557.5,3079.76,0]]],
    ["Катколуа",                 [5479.82,4054.04],     [[5636.11,4179.7,234],[5280.09,4061.9,254]],        [[5807.34,4289.26,0.1,237],[5824.28,4301.7,0.1,238],[5838.18,4314.97,0.1,238],[5855.63,4329.05,0.1,236],[5870.55,4342.84,0.1,235]],     [[5483.86,4058.16,0],[5473.04,4059.44,0],[5039.05,3989.7,0]]],
    ["Туванака",                 [1776.83,11993.6],     [[1888.35,11828.3,329],[1851.35,12178.9,2]],        [[2092.97,11830.8,0.1,289],[2112.74,11823.7,0.1,289],[2130.5,11815.7,0.1,294],[2152.17,11805.8,0.1,293],[2175.25,11797.1,0.1,296]],     [[1801.31,11997.4,0],[1831.31,12358.1,0]]]
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
    _spawned addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
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
        if ((typeOf _vcl) in ["O_T_APC_Wheeled_02_rcws_ghex_F","O_T_MRAP_02_hmg_ghex_F","O_T_Truck_03_device_ghex_F"]) then {
            if ((typeOf _vcl) == "O_T_Truck_03_device_ghex_F") then {
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
        if ((typeOf _vcl) == "O_T_Truck_03_device_ghex_F") then {
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
