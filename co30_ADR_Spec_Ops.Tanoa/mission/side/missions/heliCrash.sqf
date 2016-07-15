/*
Author:	ToxaBes
Description: Secure helicopter crash area and find scout equipment.
*/

// define some keywords and definitions
#define INFANTRY_MISSION "Спецоперация: Прерванный полёт (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_PATROL "O_T_InfSquad","O_T_InfSquad_Weapons","O_T_InfTeam","O_T_InfTeam_AA","O_T_InfTeam_AT","O_T_reconPatrol"
#define INFANTRY_STATIC "O_HMG_01_high_F","O_GMG_01_high_F"
#define INFANTRY_HOUSE "O_T_Soldier_AR_F","O_T_Soldier_M_F","O_T_Soldier_TL_F"
#define INFANTRY_MOTORIZED "O_G_Offroad_01_armed_F","O_T_LSV_02_armed_F"

// define all priviate variables
private ["_enemiesArray", "_targets", "_position", "_flatPos", "_startPoint", "_heliCoords", "_fullyRandom", "_heliPos", "_azimut", "_heliObj", "_distance", "_z", "_chemPosRed", "_chemlightRed", "_inHouse", "_goodPos", "_houseList", "_c", "_scoutPos", "_scoutBox", "_mkrScout", "_chemPosBlue", "_chemlightBlue", "_patrolGroup", "_randomPos", "_unitPos", "_houseGroup", "_sniperGroup", "_nearRoads", "_staticGroup", "_roadSegment", "_static", "_technicalGroup", "_technicalVehicle", "_guardsGroup", "_city", "_briefing", "_showSabotageMessage", "_showGetdataMessage", "_viperSquadSpawned"];

_enemiesArray = [grpNull];

// init area coords - we use 3 "interesting" landing places in each city with 40% of luck. Other 60% are random.
// format:
//  [city name,                    [center coords x,y],     [heli 1 crash x,y,z,azimut], [heli 2 crash x,y,z,azimut], [heli 3 crash x,y,z,azimut]]
_targets = [
    ["Туванака",                   [1859.39,11980.4],       [1842.87,11973.3,0,275],     [1898.08,11969.9,0,93],      [1821.84,11831.7,0,219]    ],
    ["Бельфор",                    [3068.73,11131.9],       [3023.67,11152.6,0,71],      [3088.57,11056,0,327],       [3107.85,11231.4,0,326]    ],
    ["Сосову",                     [2654.66,9308.16],       [2638.39,9387.09,0,139],     [2564.45,9314.13,0,255],     [2671.5,9121.63,0,212]     ],
    ["Таву",                       [951.226,7687.24],       [978.527,7699.08,0,90],      [956.922,7542.02,0,213],     [1092.03,7779.5,0,68]      ],
    ["Балаву",                     [2576.21,7353.31],       [2507.1,7303.61,0,192],      [2559.85,7553.01,0,305],     [2746.24,7220.77,0,194]    ],
    ["Раутаке",                    [3426.78,6704.81],       [3363.12,6818.76,0,235],     [3476.81,6597.26,0,235],     [3514.3,6702.1,0,222]      ],
    ["Лаикоро",                    [1734.51,6146.93],       [1814.81,6005.19,0,118],     [1646.48,6124.88,0,68],      [1865.95,6160.47,0,68]     ],
    ["Каткоула",                   [5556.57,4122.71],       [5489.54,4167.42,0,228],     [5713.53,4177.88,0,170],     [5658.52,4046.86,0,29]     ],
    ["Каткоула",                   [5451.1,4024.77],        [5484.96,3959.3,0,111],      [5451.58,4107.74,0,154],     [5365.99,3950.22,0,80]     ],
    ["Янукка",                     [3027.3,3409.44],        [3099.43,3415.5,0,318],      [3337.79,3315.16,0,212],     [2838.62,3365.46,2,334]    ],
    ["Модергат",                   [9410.32,4024.67],       [9608.41,3977.37,0,62],      [9312.03,3919.36,0,264],     [9446.02,4190.77,3,82]     ],
    ["Блерик",                     [10359.6,2661.27],       [10389.1,2608.71,0,339],     [10477.2,2706.39,0,339],     [10238.4,2666.43,0,48]     ],
    ["Буа Буа",                    [13307.9,2961.2],        [13191.4,2881.92,0,0],       [13353.9,2887.89,0,27],      [13199.3,2990.4,0,70]      ],
    ["Лиджинхавен",                [11640.4,2785.28],       [11759.7,2666.35,1,307],     [11752.4,2850.94,0,44],      [11510.7,2831.04,0,44]     ],
    ["Дудстил",                    [12790,4761.07],         [12696.2,4772.18,0,288],     [12938.1,4639.27,0,96],      [12902.7,4898.02,0,96]     ],
    ["Харкорт",                    [11233.8,5223.2],        [11179.3,5120.99,0,234],     [11205.9,5377.94,0,234],     [11458.1,5304.05,0,275]    ],
    ["Котомо",                     [10869.7,6304.12],       [10897.2,6105.84,0,193],     [10919.4,6562.55,0,228],     [10747,6315.5,0,334]       ],
    ["Оумере",                     [12793.5,7391.32],       [12714.8,7420.96,0,12],      [12841.3,7299.19,0,10],      [12893.3,7454.42,0,45]     ],
    ["Луганвилл",                  [13959.9,8337.46],       [14140.2,8556.18,4.7684,39], [13810.3,8489.89,0,331],     [13951.7,8174.71,0,331]    ],
    ["Нандай",                     [14365.4,8898.75],       [14452.8,8915.98,0,315],     [14255.3,8958.12,0,272],     [14482.8,8823.01,0,354]    ],
    ["Промышленный порт Блу Перл", [13137.4,11920.4],       [13221.4,12016.6,5,77],      [13335.2,11798.6,0,77],      [12851.1,11936.2,0,206]    ],
    ["Ипота",                      [12359.9,14093.4],       [12442.5,14270.1,0,335],     [12307.8,13924.1,0,279],     [12451.5,13983,0,250]      ],
    ["Овау",                       [12415.2,12715.5],       [12378.8,12809.3,0,244],     [12566.8,12756.6,0,148],     [12308.3,12593.3,0,248]    ],
    ["Насуа",                      [11392.6,12359.8],       [11220,12302.5,0,338],       [11509.4,12279.2,0,338],     [11414.5,12229.2,0,281]    ],
    ["Пенело",                     [10976.8,13221.6],       [11100.5,13287,0,114],       [10814.1,13143.4,0,197],     [11077.4,13034,0,197]      ],
    ["Момеа",                      [10326.9,13271.1],       [10383.7,13069,0,257],       [10179.5,13329.9,0,297],     [10490.3,13264.7,0,176]    ],
    ["Ла-Рошель",                  [9790.26,13467.4],       [9809.65,13583.7,0,215],     [9816.74,13428.2,0,324],     [9616.83,13464.3,0,217]    ],
    ["Ла-Рошель",                  [9446.88,13417.2],       [9278.21,13456.9,0,13],      [9610.55,13083,0,133],       [9464.79,13610.8,0,346]    ],
    ["Саву",                       [8480.2,13616.8],        [8473.69,13428.8,0,127],     [8280.43,13740.6,0,290],     [8584.08,13790.2,0.2,117]  ],
    ["Сен Поль",                   [7859.01,13469.6],       [8108.24,13374.8,0,34],      [7714.58,13581.7,0,182],     [7996.98,13616.5,0,105]    ],
    ["Пети Николет",               [6926.83,13308.6],       [6826.09,13417.6,0,253],     [7055.09,13415.7,0,54],      [6725.42,13230.4,0,300]    ],
    ["Николет",                    [6490.84,12804],         [6471.05,12634.6,0,169],     [6126.45,12807.4,0,242],     [6479.21,12982.9,0,341]    ],
    ["Оуа-Оуэ",                    [5682.99,12427.7],       [5422.15,12434.8,0,321],     [5776.1,12596,0,91],         [5696.45,12330.1,0,199]    ],
    ["Сен-Жюльен",                 [5764.02,11148],         [5774.03,10930.3,0,146],     [5420.06,11145.5,0,38],      [6109.66,11132.6,0,334]    ],
    ["Джоджтаун",                  [5835.72,10616.4],       [5701.44,10531.7,1.5,247],   [6055.24,10676.5,0,0],       [5839.39,10613.3,0,296]    ],
    ["Джоджтаун",                  [5829.04,10190.1],       [5987.57,10417.3,0.1,265],   [6120.69,10074.4,0,168],     [5709.1,10167.5,0,58]      ],
    ["Регина",                     [5082.42,8711.28],       [5244.15,8615.31,0,219],     [5337.64,8797.41,0,92],      [4934.36,8919.42,0,85]     ],
    ["Таноука",                    [8867.6,10211.7],        [8525.49,10342.4,0,355],     [8764.3,9972.61,0,43],       [9068.09,10354.4,0,308]    ],
    ["Вагалала",                   [11015,9710.5],          [10799,9674.91,0,0],         [11117.1,9607.57,0,49],      [11177,9850.79,0,187]      ],
    ["Радиовышка Браво",           [11061.7,11502.9],       [11082.7,11593.4,0,139],     [10887,11416.2,0,49],        [11050.9,11430,0,330]      ],
    ["Радиовышка Альфа",           [10030.2,11790.4],       [9939.23,12102.5,0,306],     [10409.7,11770.4,0,135],     [9737.23,11893.7,0,308]    ]
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

// spawn helicopter
if ((random 10) < 6) then {

	// we can't use safe positions here because nobody know where heli landed (but we need to avoid landing on roofs etc)
    _heliCoords = [(_flatPos select 0) + (random 190), (_flatPos select 1) + (random 190), 20, (round (random 360))];
    _fullyRandom = true;
} else {

    // choose one of 3 pre-selected interesting positions for landing
	_heliCoords = selectRandom [_position select 2, _position select 3, _position select 4];
	_fullyRandom = false;
};
_heliPos = [_heliCoords select 0, _heliCoords select 1, _heliCoords select 2];
_azimut  = _heliCoords select 3;

_heliObj = createVehicle ["I_Heli_light_03_unarmed_F", [300,300,300], [], 0, "NONE"];
waitUntil {!isNull _heliObj};
_heliObj allowDamage false;
_heliObj setDir _azimut;
_heliObj setPos _heliPos;
_heliObj setVehicleLock "LOCKED";
_heliObj lock true;
{
	_x addCuratorEditableObjects [[_heliObj], false];
} foreach allCurators;
sleep 0.5;

_distance = [_heliPos, _startPoint] call BIS_fnc_distance2D;
if (_distance > 200) then {
    _fullyRandom = true;
};

if (_fullyRandom) then {
    _z = (getPosATL _heliObj) select 2;
    while {_z < -1 || _z > 2 || surfaceIsWater (getPos _heliObj)} do {
        while {true} do {
            _heliPos = [(_flatPos select 0) + (random 160), (_flatPos select 1) + (random 160), 10];
            if !(surfaceIsWater _heliPos) exitWith {};
        };
        _heliObj setPos _heliPos;
        sleep 5;
        _z = (getPosATL _heliObj) select 2;
    };
};

// it was hard landing
_heliObj setDamage 0.9;

// set sabotage action
[_heliObj,"QS_fnc_addActionSabotage",nil,true] spawn BIS_fnc_MP;

// spawn red chemlight
_chemPosRed = [(getPos _heliObj select 0) + (random 10), (getPos _heliObj select 1) + (random 10), (getPos _heliObj select 2) + (random 10)];
_chemlightRed = createVehicle ["Chemlight_red", _chemPosRed, [], 0, "NONE"];

// spawn scout box in some house
_inHouse = true;
_goodPos = [];
_houseList = _startPoint nearObjects ["House", 200];
{
	_c = 0;
    while { format ["%1", _x buildingPos _c] != "[0,0,0]" } do {
        if (((_x buildingPos _c) select 2 < 2.5) and !(surfaceIsWater (_x buildingPos _c))) then {
            _goodPos set [(count _goodPos), _x buildingPos _c];
        };
        _c = _c + 1;
    };
} forEach _houseList;

// ok, may be in some building, not in house
if ((count _goodPos) == 0) then {
	_inHouse = false;
    _houseList = _startPoint nearObjects ["building", 200];
    {
    	_c = 0;
        while { format ["%1", _x buildingPos _c] != "[0,0,0]" } do {
            if (((_x buildingPos _c) select 2 < 2.5) and !(surfaceIsWater (_x buildingPos _c))) then {
                _goodPos set [(count _goodPos), _x buildingPos _c];
            };
            _c = _c + 1;
        };
    } forEach _houseList;
    sleep 1;
};

if ((count _goodPos) > 0) then {
	// put it inside some house or building if possible
    _scoutPos = selectRandom _goodPos;
    _fullyRandom = false;
} else {
    // no houses, no buildings - put it somewhere in 150m of area center
    while {true} do {
        _scoutPos = [(_flatPos select 0) + (random 150), (_flatPos select 1) + (random 150), 1];
        if !(surfaceIsWater _scoutPos) exitWith {};
    };
	_fullyRandom = true;
};

_scoutBox = createVehicle ["Land_SatellitePhone_F", [20,20,20], [], 0, "NONE"];
waitUntil {!isNull _scoutBox};
_scoutBox allowDamage false;
_scoutBox setPos _scoutPos;
{
	_x addCuratorEditableObjects [[_scoutBox], false];
} foreach allCurators;

if (_fullyRandom) then {
    _z = (getPos _scoutBox) select 2;
    while {_z < -0.5 || _z > 1.5 || surfaceIsWater (getPos _scoutBox)} do {
        while {true} do {
            _scoutPos = [(_flatPos select 0) + (random 150), (_flatPos select 1) + (random 150), 10];
            if !(surfaceIsWater _scoutPos) exitWith {};
        };
        _scoutBox setPos _scoutPos;
        sleep 5;
        _z = (getPos _scoutPos) select 2;
    };
};

// very hard to search scout box outside houses or in big cities so put marker on the map
if (!_inHouse || (count _houseList) > 20) then {
    _mkrScout = createMarker ["scoutMarker", _scoutPos];
    _mkrScout setMarkerType "Mil_dot";
    _mkrScout setMarkercolor "colorRed";
    _mkrScout setMarkerSize [0.5,0.5];
    _mkrScout setMarkerDir 1;
    _mkrScout setMarkerText 'разведданные';
};

// spawn blue chemlight
_chemPosBlue = [(getPos _scoutBox select 0) + (random 2), (getPos _scoutBox select 1) + (random 2), (getPos _scoutBox select 2) + (random 1)];
_chemlightBlue = createVehicle ["Chemlight_blue", _chemPosBlue, [], 0, "NONE"];

// set getData action
[_scoutBox,"QS_fnc_addActionGetData",nil,true] spawn BIS_fnc_MP;

// spawn infantry patrols
for "_x" from 1 to 6 do {
    _patrolGroup = createGroup EAST;
    _randomPos = [[[_startPoint, 200],[]],["water","out"]] call BIS_fnc_randomPos;
    _patrolGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "EAST" >> "OPF_T_F" >> "Infantry" >> selectRandom [INFANTRY_PATROL])] call BIS_fnc_spawnGroup;
    _patrolGroup setBehaviour "COMBAT";
    _patrolGroup setCombatMode "RED";
    [_patrolGroup, (getMarkerPos "sideMarker"), 200] call BIS_fnc_taskPatrol;
    _enemiesArray = _enemiesArray + [_patrolGroup];
};

// spawn house guards
_unitPos = ["UP", "MIDDLE"];
_houseGroup = createGroup EAST;
for "_x" from 1 to 10 do {
    if ((count _goodPos) > 0) then {
        _randomPos = selectRandom _goodPos;
    } else {
        _randomPos = [_startPoint, 0, 180, 2, 0, 0.5, 0, [], [_startPoint]] call BIS_fnc_findSafePos;
    };
    (selectRandom [INFANTRY_HOUSE]) createUnit [_randomPos, _houseGroup, "currentGuard = this"];
    doStop currentGuard;
    commandStop currentGuard;
    currentGuard setPosASL _randomPos;
    currentGuard setUnitPos (selectRandom _unitPos);
    currentGuard disableAI "MOVE";
};
_houseGroup setBehaviour "COMBAT";
_houseGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_houseGroup];

// spawn snipers
for "_x" from 1 to 2 do {
    _sniperGroup = createGroup EAST;
    _randomPos = [_startPoint, 800, 10, 50] call BIS_fnc_findOverwatch;
    _sniperGroup = [_randomPos, EAST,(configfile >> "CfgGroups" >> "EAST" >> "OPF_T_F" >> "Infantry" >> "O_T_SniperTeam")] call BIS_fnc_spawnGroup;
    _sniperGroup setBehaviour "COMBAT";
    _sniperGroup setCombatMode "RED";
    sleep 0.2;
    _enemiesArray = _enemiesArray + [_sniperGroup];
};

// spawn static weapons and put it on roads or overwatch positions
_nearRoads = [_flatPos select 0,_flatPos select 1] nearRoads 150;
for "_x" from 1 to 2 do {
    _staticGroup = createGroup EAST;
    if((count _nearRoads) > 0) then {
        _roadSegment = selectRandom _nearRoads;
        _randomPos = getPos _roadSegment;
    } else {
        _randomPos = [_startPoint, 200, 10, 10] call BIS_fnc_findOverwatch;
    };
    _static = selectRandom [INFANTRY_STATIC] createVehicle _randomPos;
    waitUntil{!isNull _static};
    _static setDir random 360;
    "O_T_Support_MG_F" createUnit [_randomPos,_staticGroup];
    ((units _staticGroup) select 0) assignAsGunner _static;
    ((units _staticGroup) select 0) moveInGunner _static;
    _staticGroup setBehaviour "COMBAT";
    _staticGroup setCombatMode "RED";
    _static setVectorUp [0,0,1];
    _static lock 3;
    _enemiesArray = _enemiesArray + [_staticGroup];
    sleep 0.2;
    _enemiesArray = _enemiesArray + [_static];
};

// spawn technical
for "_x" from 1 to 2 do {
    _technicalGroup = createGroup EAST;
    if((count _nearRoads) > 0) then {
        _roadSegment = selectRandom _nearRoads;
        _randomPos = getPos _roadSegment;
    } else {
        _randomPos = [[[_startPoint, 200],[]],["water","out"]] call BIS_fnc_randomPos;
    };
    _technicalVehicle = selectRandom [INFANTRY_MOTORIZED] createVehicle _randomPos;
    waitUntil{!isNull _technicalVehicle};
    "O_T_Engineer_F" createUnit [_randomPos,_technicalGroup];
    "O_T_Engineer_F" createUnit [_randomPos,_technicalGroup];
    ((units _technicalGroup) select 0) assignAsDriver _technicalVehicle;
    ((units _technicalGroup) select 0) moveInDriver _technicalVehicle;
    ((units _technicalGroup) select 1) assignAsGunner _technicalVehicle;
    ((units _technicalGroup) select 1) moveInGunner _technicalVehicle;
    [_technicalGroup, _startPoint, 200] call BIS_fnc_taskPatrol;
    _technicalVehicle lock 3;
    _technicalGroup setBehaviour "COMBAT";
    _technicalGroup setCombatMode "RED";
    sleep 1;
    _enemiesArray = _enemiesArray + [_technicalGroup];
    sleep 0.2;
    _enemiesArray = _enemiesArray + [_technicalVehicle];
};

_guardsGroup = [_startPoint, 350, 40, ENEMY_SIDE] call QS_fnc_FillBots;

// set skills
[(units _patrolGroup)] call QS_fnc_setSkill3;
[(units _houseGroup)] call QS_fnc_setSkill3;
[(units _sniperGroup)] call QS_fnc_setSkill3;
[(units _staticGroup)] call QS_fnc_setSkill3;
[(units _technicalGroup)] call QS_fnc_setSkill3;

// show brief information
_city = _position select 0;
_briefing = format ["<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FFC107'>Прерванный полёт</t><br/>____________________<br/>Противник сбил наш вертолет разведки над %1. Пилоты спрятали блок с разведанными недалеко от места падения, после чего выдвинулись на точку эвакуации. Командование назначило пехотную спецоперацию<br/><br/>Ваша задача — выдвинуться в указанный район, обезвредить противника, найти данные разведки и уничтожить вертолет.</t>", _city];
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSpecMission", "Прерванный полёт"]; publicVariable "showNotification";

sideMissionUp = true; publicVariable "sideMissionUp";
SM_SUCCESS_SABOTAGE = false; publicVariable "SM_SUCCESS_SABOTAGE";
SM_SUCCESS_GETDATA = false; publicVariable "SM_SUCCESS_GETDATA";
_showSabotageMessage = true;
_showGetdataMessage = true;
_viperSquadSpawned = false;
[_startPoint, 200, ["vehicles", "fire"]] call QS_fnc_addHades;
while { sideMissionUp } do {
	// Heli part done
    if ((SM_SUCCESS_SABOTAGE || !alive _heliObj) && _showSabotageMessage) then {
    	hint "";
    	_showSabotageMessage = false;
        if (SM_SUCCESS_GETDATA) then {
        	hqSideChat = "Вертолет уничтожен!";
        } else {
            hqSideChat = "Вертолет уничтожен! Продолжайте поиск разведданных.";
        };
        deleteVehicle _chemlightRed;
    	publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
    };
    sleep 1;

    // Scout box part done
    if (SM_SUCCESS_GETDATA && _showGetdataMessage) then {
        hint "";
        _showGetdataMessage = false;
        if (SM_SUCCESS_SABOTAGE) then {
            hqSideChat = "Данные захвачены!";
        } else {
            hqSideChat = "Данные захвачены! Найдите и уничтожите вертолет.";
        };
        publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
        { deleteVehicle _x; } forEach [_scoutBox,_chemlightBlue];
        deleteMarker "scoutMarker";
    };
    sleep 1;

    // Spawn Viper group
    if (!_viperSquadSpawned) then {
        if (SM_SUCCESS_GETDATA) exitWith {
            _viperSquadSpawned = true;
            if (random 1 > 0.5) then {
                _enemiesArray pushBack ([_heliPos, 500, 500, 3000, true, ENEMY_SIDE] call QS_fnc_spawnViper);
            };
        };
        if (SM_SUCCESS_SABOTAGE or !alive _heliObj) exitWith {
            _viperSquadSpawned = true;
            if (random 1 > 0.5) then {
                _enemiesArray pushBack ([_scoutPos, 500, 500, 3000, true, ENEMY_SIDE] call QS_fnc_spawnViper);
            };
        };
    };
    sleep 1;

    // All done, de-briefing
	if (SM_SUCCESS_SABOTAGE && SM_SUCCESS_GETDATA) exitWith {
		sideMissionUp = false; publicVariable "sideMissionUp";
		{ _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
		[true] call QS_fnc_SMhintSUCCESS;
        sleep 120;
        { [_x] call QS_fnc_TBdeleteObjects; } forEach [_enemiesArray, _guardsGroup];
        deleteVehicle _heliObj;
        [_startPoint, 500] call QS_fnc_DeleteEnemyEAST;
	};
	sleep 1;
};
