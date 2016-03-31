/*
Author:	ToxaBes
Description: Secure helicopter crash area and find scout equipment.
*/

// define some keywords and definitions
#define INFANTRY_MISSION "Спецоперация: Прерванный полёт (техника запрещена)"
#define INFANTRY_PATROL "OIA_InfSquad","OIA_InfSquad_Weapons","OIA_InfTeam","OIA_InfTeam_AA","OIA_InfTeam_AT","OI_reconPatrol"
#define INFANTRY_STATIC "O_HMG_01_high_F","O_GMG_01_high_F"
#define INFANTRY_HOUSE "O_Soldier_AR_F","O_soldier_M_F","O_Soldier_TL_F"
#define INFANTRY_MOTORIZED "O_G_Offroad_01_armed_F"

// define all priviate variables
private ["_targets","_accepted","_distance","_briefing","_position","_city","_flatPos","_heliCoords","_mkrScout","_z","_fullyRandom","_heliObj",
         "_heliPos","_azimut","_x","_c","_ps","_chemPosRed","_chemlightRed","_houseList","_randNum","_scoutPos","_scoutBox","_chemPosBlue","_goodPos",
         "_dummy","_showGetdataMessage","_showSabotageMessage","_inHouse","_enemiesArray","_randomPos","_patrolGroup","_nearRoads","_roadSegment",
         "_direction","_x","_staticGroup","_static","_houseGroup","_technicalGroup","_technicalVehicle","_sniperGroup","_startPoint"];

_enemiesArray = [grpNull];

// init area coords - we use 3 "interesting" landing places in each city with 40% of luck. Other 60% are random.
// format: 
//  [city name,           [center coords x,y,z],   [heli 1 crash x,y,z,azimut], [heli 2 crash x,y,z,azimut], [heli 3 crash x,y,z,azimut]]
_targets = [
    ["Ореокастро",        [4549.12,21415.7,20000], [4538,21337,3.5,280],        [4593.12,21356.5,1.8,235],   [4526.5,21388,2,0]        ],
    ["Крия-Нера",         [9705.16,22267.7,20000], [9792,22377,3.5,200],        [9719,22283,3.3,100],        [9709.73,22309,5,10]      ],
    ["Фрини",             [14607.8,20773.2,20000], [14760,20783,1,90],          [14543.3,20798,1,327],       [14536.5,20725,4,0]       ],
    ["Атира",             [14020,18720,20000],     [14012,18586,1,200],         [14063.8,18617.8,2,350],     [14196.6,18688.6,1,320]   ],
    ["Галати",            [10311,19070,20000],     [10219.6,19162.6,1,202],     [10318.1,19063.6,4,193],     [10341.8,19089.9,3.5,120] ],
    ["Абдера",            [9423,20223,20000],      [9480.16,20214.5,3,337],     [9471.22,20285.9,2,100],     [9311.52,20220.9,0.5,46]  ],
    ["Сирта",             [8583.91,18270,20000],   [8609.19,18390.05,3.5,279],  [8409.48,18239,20,280],      [8573.47,18280.8,3.5,110] ],
    ["Айос-Константинос", [3844,17696,20000],      [3760,17805,4,345],          [3698.89,17832.2,7,270],     [3934.8,17628,1.5,150]    ],
    ["Айос-Константинос", [4239,16946,20000],      [4239.85,16946.6,4,10],      [4275.69,16940,1,130],       [4143.72,16921,3,140]     ],
    ["Негадес",           [4873.59,16148,20000],   [4972.88,16314,2,340],       [4802.61,16222.6,3,300],     [5051.19,16196,7,50]      ],
    ["Коре",              [7109.11,16436.2,20000], [7134.62,16453.3,2,10],      [7262.13,16510.3,8,80],      [7005,16599,4.5,210]      ],
    ["Айос-Дионисиос",    [9283.31,15856.3,20000], [9126,15820,6,200],          [9333.9,15746.2,2,270],      [9289.52,15785.4,6,80]    ],
    ["Лакка",             [12328.6,15681.4,20000], [12418.8,15576.6,2,310],     [12310.6,15643.5,4,10],      [12237,15788.4,2,68]      ],
    ["Неохори",           [12523.7,14378.8,20000], [12619.1,14465,5,2,180],     [12463.9,14220.1,7,160],     [12616.8,14339.5,2,140]   ],
    ["Аликампос",         [11132.3,14560.6,20000], [11122.9,14532.2,2,30],      [11168.2,14522.9,5,120],     [11232.7,14445,7,340]     ],
    ["Стройка",           [11380.6,14178.2,20000], [11380.6,14178.2,1,80],      [11440.3,14237.9,12,80],     [11324.7,14031.4,2,110]   ],
    ["Каталаки",          [11759.9,13702.4,20000], [11853.7,13583.4,2,320],     [11745.6,13604.4,2,70],      [11685.5,13632.6,8,120]   ],
    ["Полиакко",          [10977.8,13432.1,20000], [10967.4,13624.5,2,10],      [11015.9,13388,2,320],       [11029,13277,3,40]        ],
    ["Териса",            [10680.5,12271.3,20000], [10667.5,12326.4,3,60],      [10623.1,12193.6,8,320],     [10682.1,12088.1,2,300]   ],
    ["Зарос",             [9050,11977,20000],      [9119.58,11806.6,5,310],     [8939.59,11894.6,5,230],     [8946.28,12137,6,300]     ],
    ["Панохори",          [5090,11262,20000],      [5133.71,11172.9,4,180],     [5258.99,11327.9,10,180],    [4950.1,11453.7,10,15]    ],
    ["Атанос",            [3685.56,10236.7,20000], [3661.44,10147,5,290],       [3818,10266,2,150],          [3639.68,10159.6,4,280]   ],
    ["Нери",              [3710.22,11630.3,20000], [3709.55,11433.7,4,280],     [3755.29,11444.7,2,240],     [3689.52,11747.7,8,320]   ],
    ["Нери",              [4152,11745.9,20000],    [4147.16,11897.2,4,290],     [4290.54,11719.3,2,40],      [4110.68,11757.3,2,280]   ],
    ["Кавала",            [3612.34,13024,20000],   [3729.25,12978.1,20,320],    [3693.15,13158.4,18.5,140],  [3540.2,13006.8,18.5,240] ],
    ["Кавала",            [3659.82,13439.3,20000], [3717.69,13391.1,18.5,60],   [3797.11,13422.4,12,10],     [3748.91,13277.5,1,240]   ],
    ["Аггелохори",        [3869.5,13742.1,20000],  [3900,13775.7,3,200],        [4003.09,13600.9,4,320],     [3794.8,13568.5,4,20]     ],
    ["Антракия",          [16645,16163,20000],     [16816.2,16252.9,7,280],     [16566.7,16072.1,1,260],     [16581.5,16005,7,20]      ],
    ["Родополи",          [18813.8,16609.3,20000], [18750,16662.5,4,180],       [18852.4,16682,4,200],       [18859.7,16604.4,4,0]     ],
    ["Харкия",            [18109.8,15241.1,20000], [18123.9,15144,1,20],        [18070.1,15101.5,1,0],       [17932,15184.6,1,30]      ],
    ["Калохори",          [21365,16347,20000],     [21314.5,16358.4,3,180],     [21251.6,16221.5,4,60],      [21437.1,16369,2,100]     ],
    ["Парос",             [20931.3,16934,20000],   [20987.2,17042.6,5,290],     [20956.3,16833.5,5,70],      [20848.5,16092.1,5,220]   ],
    ["Иоанина",           [23187.5,19966.4,20000], [23318.1,19995,1,80],        [23145,20023,3,120],         [23271.5,19877.6,3,320]   ],
    ["София",             [25710,21363.4,20000],   [25741.8,21376.6,5,180],     [25563.5,21303.6,1,350],     [25635.6,21454,4,210]     ],
    ["Молос",             [27013.7,23224.3,20000], [26913.8,23188.9,2,320],     [27086.8,23137.5,7,0],       [27135.1,23271.9,5,20]    ],
    ["Дорида",            [19404,13247.3,20000],   [19329.1,13226.2,3,180],     [19409.4,13162.6,3,180],     [19404,13277.3,2,350]     ],
    ["Пиргос",            [16738.7,12796,20000],   [16729.3,12823,8,260],       [16576.9,12833.6,18,100],    [16624.3,12806,18,100]    ],
    ["Халкея",            [20251.8,11677.5,20000], [20205.1,11656.5,3,310],     [20183.6,11619,4,0],         [20272.2,11555.9,2,0]     ],
    ["Ферес",             [21695.2,7597.3,20000],  [21607.9,7581,2,120],        [21656,7552.8,2,100],        [21782.4,7529.32,4,350]   ],
    ["Селекано",          [20790.9,6740.9,20000],  [20723.3,6578,2,60],         [20824.4,6718.9,4,100],      [20748.4,6779.4,2,270]    ]
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

// spawn helicopter
if ((random 10) < 6) then {

	// we can't use safe positions here because nobody know where heli landed (but we need to avoid landing on roofs etc)
    _heliCoords = [(_flatPos select 0) + (random 190), (_flatPos select 1) + (random 190), 20, (round (random 360))];
    _fullyRandom = true;
} else {

    // choose one of 3 pre-selected interesting positions for landing
	_heliCoords = [_position select 2, _position select 3, _position select 4] call BIS_fnc_selectRandom;   
	_fullyRandom = false; 
};
_heliPos = [_heliCoords select 0, _heliCoords select 1, _heliCoords select 2];
_azimut  = _heliCoords select 3;

_heliObj = createVehicle ["O_Heli_Attack_02_F", [300,300,300], [], 0, "NONE"];  
waitUntil {!isNull _heliObj};
_heliObj allowDamage false;
_heliObj setDir _azimut;
_heliObj setPos _heliPos;
_heliObj setVehicleLock "LOCKED"; 
_heliObj lock true;
sleep 0.5;

_distance = [_heliPos, _startPoint] call BIS_fnc_distance2D;
if (_distance > 200) then {
    _fullyRandom = true; 
};

if (_fullyRandom) then {
    _z = (getPos _heliObj) select 2;
    while {_z < -1 || _z > 2} do {
        _heliPos = [(_flatPos select 0) + (random 160), (_flatPos select 1) + (random 160), 10];
        _heliObj setPos _heliPos;
        sleep 5;
        _z = (getPos _heliObj) select 2;
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
        _goodPos set [(count _goodPos), _x buildingPos _c];
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
            _goodPos set [(count _goodPos), _x buildingPos _c];
            _c = _c + 1;
        };
    } forEach _houseList;
    sleep 1;
};

if ((count _goodPos) > 0) then {

	// put it inside some house or building if possible
    _scoutPos = _goodPos call BIS_fnc_selectRandom;
    _fullyRandom = false;
} else {

    // no houses, no buildings - put it somewhere in 150m of area center
	_scoutPos = [(_flatPos select 0) + (random 150), (_flatPos select 1) + (random 150), 1];
	_fullyRandom = true;
};

_scoutBox = createVehicle ["Land_SatellitePhone_F", [20,20,20], [], 0, "NONE"];
waitUntil {!isNull _scoutBox};
_scoutBox allowDamage false;
_scoutBox setPos _scoutPos;

if (_fullyRandom) then {
    _z = (getPos _scoutBox) select 2;
    while {_z < -0.5 || _z > 1.5} do {
        _scoutPos = [(_flatPos select 0) + (random 150), (_flatPos select 1) + (random 150), 10];
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
    _patrolGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> [INFANTRY_PATROL] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
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
        _randomPos = _goodPos call BIS_fnc_selectRandom;
    } else {
        _randomPos = [_startPoint, 0, 180, 2, 0, 0.5, 0] call BIS_fnc_findSafePos;
    };
    ([INFANTRY_HOUSE] call BIS_fnc_selectRandom) createUnit [_randomPos, _houseGroup, "currentGuard = this"];  
    doStop currentGuard;
    commandStop currentGuard;
    currentGuard setPosASL _randomPos; 
    currentGuard setUnitPos (_unitPos call BIS_fnc_selectRandom);        
    currentGuard disableAI "MOVE";
};
_houseGroup setBehaviour "COMBAT";
_houseGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_houseGroup];

// spawn snipers
for "_x" from 1 to 2 do {
    _sniperGroup = createGroup EAST;
    _randomPos = [_startPoint, 800, 10, 50] call BIS_fnc_findOverwatch;
    _sniperGroup = [_randomPos, EAST,(configfile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
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
        _roadSegment = _nearRoads call BIS_fnc_selectRandom;
        _randomPos = getPos _roadSegment;
        _direction = getDir _roadSegment;
    } else {
        _randomPos = [_startPoint, 200, 10, 10] call BIS_fnc_findOverwatch;
        _direction = getDir random 360;
    };    
    _static = [INFANTRY_STATIC] call BIS_fnc_selectRandom createVehicle _randomPos;
    waitUntil{!isNull _static}; 
    _static setDir random 360;
    "O_support_MG_F" createUnit [_randomPos,_staticGroup];
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
        _roadSegment = _nearRoads call BIS_fnc_selectRandom;
        _randomPos = getPos _roadSegment;
        _direction = getDir _roadSegment;
    } else {
        _randomPos = [[[_startPoint, 200],[]],["water","out"]] call BIS_fnc_randomPos;
        _direction = getDir random 360;
    };    
    _technicalVehicle = [INFANTRY_MOTORIZED] call BIS_fnc_selectRandom createVehicle _randomPos;
    waitUntil{!isNull _technicalVehicle};
    "O_engineer_F" createUnit [_randomPos,_technicalGroup];
    "O_engineer_F" createUnit [_randomPos,_technicalGroup];
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

// set skills
[(units _patrolGroup)] call QS_fnc_setSkill3;
[(units _houseGroup)] call QS_fnc_setSkill3;
[(units _sniperGroup)] call QS_fnc_setSkill3;
[(units _staticGroup)] call QS_fnc_setSkill3;
[(units _technicalGroup)] call QS_fnc_setSkill3;

// show brief information
_city = _position select 0;
_briefing = format ["<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FF9999'>Прерванный полёт</t><br/>____________________<br/>Противник сбил наш вертолет разведки над %1. Пилоты спрятали блок с разведанными недалеко от места падения, после чего выдвинулись на точку эвакуации. Командование назначило пехотную спецоперацию<br/><br/>Ваша задача — выдвинуться в указанный район, обезвредить противника, найти данные разведки и уничтожить вертолет.</t>", _city];
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSideMission", "Прерванный полёт"]; publicVariable "showNotification";

sideMissionUp = true; publicVariable "sideMissionUp";
SM_SUCCESS_SABOTAGE = false; publicVariable "SM_SUCCESS_SABOTAGE";
SM_SUCCESS_GETDATA = false; publicVariable "SM_SUCCESS_GETDATA";
_showSabotageMessage = true;
_showGetdataMessage = true;
while { sideMissionUp } do {
    sleep 2;

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
  
    // All done, de-briefing
	if (SM_SUCCESS_SABOTAGE && SM_SUCCESS_GETDATA) exitWith {		
		sideMissionUp = false; publicVariable "sideMissionUp";        
		{ _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
		[] call QS_fnc_SMhintSUCCESS;	
        sleep 120;
        { [_x] spawn QS_fnc_SMdelete } forEach [_enemiesArray];		
        deleteVehicle _heliObj;	
	};
	sleep 3;
};