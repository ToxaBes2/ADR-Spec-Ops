/*
Author:	ToxaBes
Description: capture the enemy warehouse and neutralize barrels with gas
*/

// define some keywords
#define INFANTRY_MISSION "Спецоперация: Желтый туман (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_RANK "CAPTAIN","MAJOR","COLONEL"
#define INFANTRY_CARGO "Land_Cargo20_yellow_F","Land_Cargo20_white_F","Land_Cargo20_sand_F","Land_Cargo20_red_F","Land_Cargo20_orange_F","Land_Cargo20_military_green_F","Land_Cargo20_light_green_F","Land_Cargo20_light_blue_F","Land_Cargo20_grey_F","Land_Cargo20_cyan_F","Land_Cargo20_brick_red_F","Land_Cargo20_blue_F"
#define INFANTRY_BARRELS "Land_WaterBarrel_F","FlexibleTank_01_forest_F","FlexibleTank_01_sand_F","B_Slingload_01_Fuel_F","CargoNet_01_barrels_F"
#define INFANTRY_GUNNERS "O_T_Support_MG_F", "O_T_Support_GMG_F", "O_T_Support_AMG_F"
#define INFANTRY_STATIC "O_HMG_01_high_F"
#define INFANTRY_SUPPORT "O_T_Soldier_AR_F"
#define INFANTRY_RECONS "O_T_Recon_M_F","O_T_Recon_TL_F","O_T_Soldier_AAA_F","O_T_Soldier_AA_F"

// define private variables
private ["_targets","_accepted","_distance","_briefing","_position","_flatPos","_x","_enemiesArray","_startPoint"];

_enemiesArray = [grpNull];
_unitsArray = [];

// format: [[coords x,y],  [camp x,y,z],        [tower x,y,z]]
_targets = [
    [[3618,12974],         [3618,12974,0],      [3618,12974,0]  ],
    [[2159,8008],          [2159,8008,0],       [2159,8008,0]   ],
    [[1120,7433],          [1120,7433,0],       [1120,7433,0]   ],
    [[2030,6303],          [2030,6303,0],       [2030,6303,0]   ],
    [[3425,6339],          [3425,6339,0],       [3425,6339,0]   ],
    [[5200,4291],          [5200,4291,0],       [5200,4291,0]   ],
    [[2361,3274],          [2361,3274,0],       [2361,3274,0]   ],
    [[10836,5075],         [10836,5075,0],      [10836,5075,0]  ],
    [[12837,4508],         [12837,4508,0],      [12837,4508,0]  ],
    [[11615,2076],         [11615,2076,0],      [11615,2076,0]  ],
    [[13091,7593],         [13091,7593,0],      [13091,7593,0]  ],
    [[13010,10252],        [13010,10252,0],     [13010,10252,0] ],
    [[13378,11519],        [13378,11519,0],     [13378,11519,0] ],
    [[11711,12757],        [11711,12757,0],     [11711,12757,0] ],
    [[7543,13312],         [7543,13312,0],      [7543,13312,0]  ],
    [[5268,11320],         [5268,11320,0],      [5268,11320,0]  ],
    [[9047,10005],         [9047,10005,0],      [9047,10005,0]  ]
];

// select correct place for mission
_position = selectRandom _targets;
_flatPos  = _position select 0;

// set zone area
_startPoint = [(_flatPos select 0),(_flatPos select 1),1];
{ _x setMarkerPos _flatPos; } forEach ["sideMarker", "sideCircle"];
"sideCircle" setMarkerSize [200, 200]; publicVariable "sideCircle";
sideMarkerText = [INFANTRY_MISSION, true]; publicVariable "sideMarkerText";
"sideMarker" setMarkerText INFANTRY_MISSION; publicVariable "sideMarker";
SM_YELLOWFOG_SUCCESS = false; publicVariable "SM_YELLOWFOG_SUCCESS";
SM_YELLOWFOG_FAIL = false; publicVariable "SM_YELLOWFOG_FAIL";
SM_YELLOWFOG_STARTPOINT = _startPoint; publicVariable "SM_YELLOWFOG_STARTPOINT";

// show brief information
_briefing = "<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FFC107'>Желтый туман</t><br/>____________________<br/>Нам поступила информация о странном складе ГСМ противника. Охрана склада часто ходит в противогазах и комплектах химзащиты. Есть подозрние что часть емкостей сожержит иприт. Командование назначило десантную спецоперацию.<br/><br/>Ваша задача: выдвинуться в указанный район, проникнуть на базу и обезвредить бочки с химоружием.</t>";
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSpecMission", "Желтый туман"]; publicVariable "showNotification";
sideMissionUp = true; publicVariable "sideMissionUp";

// spawn walls
_dir1 = 180;
_dir2 = 180;
_dir3 = 180;
for "_c" from 0 to 189 do {
    _pos = [_startPoint, 120, _dir1] call BIS_fnc_relPos;
    _wall = createVehicle ["Land_Mil_WallBig_4m_F", [_pos select 0, _pos select 1, 0], [], 0, "CAN_COLLIDE"];
    _wall setDir (_dir1 + 180);
    _wall setVectorUp (surfaceNormal (getPosATL _wall));
    _pos = getPosATL _wall;
    if (_pos select 2 > 0.2) then {
        _pos = [_pos select 0, _pos select 1, -0.1];
        _wall setPosATL _pos;
    };
    _dir1 = _dir1 + 1.9;
    sleep 0.01;
    if (_c < 95) then {
        _pos = [_startPoint, 125, _dir2] call BIS_fnc_relPos;
        _razor = createVehicle ["Land_Razorwire_F", [70,70,70], [], 0, "NONE"];
        waitUntil {alive _razor};
        _razor setDir (_dir2 + 180);
        _razor setPos [_pos select 0, _pos select 1, -0.1];
        _razor setVectorUp (surfaceNormal (getPosATL _razor));
        _dir2 = _dir2 + 3.8;
        _unitsArray = _unitsArray + [_razor];
    };
    sleep 0.01;
    if (_c < 103) then {
        _pos = [_startPoint, 130, _dir3] call BIS_fnc_relPos;
        _fence = createVehicle ["Land_Mil_WiredFence_F", [70,70,70], [], 0, "CAN_COLLIDE"];
        waitUntil {alive _fence};
        _fence setDir (_dir3 + 180);
        _fence setPos [_pos select 0, _pos select 1, -0.1];
        _fence setVectorUp (surfaceNormal (getPosATL _fence));
        _dir3 = _dir3 + 3.5;
        _unitsArray = _unitsArray + [_fence];
    };
    _unitsArray = _unitsArray + [_wall];
    sleep 0.01;
};

// spawn camp
_campPos  = _position select 1;
_camp = [_campPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "Empty" >> "Military" >> "Outposts" >> "OutpostA")] call BIS_fnc_spawnGroup;
sleep 0.1;

// spawn tower
_towerPos = _position select 2;
_tower = createVehicle ["Land_TTowerBig_2_F", _towerPos, [], 0, "CAN_COLLIDE"];
_tower setVectorUp [0, 0, 1];
_unitsArray = _unitsArray + [_tower];
sleep 0.1;

// spawn cargo HQ
_cargoPos = [_startPoint, 0, 90, 5, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
while {surfaceIsWater _cargoPos} do {
    _cargoPos = [_startPoint, 0, 90, 5, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
};
_cargoHQ = createVehicle ["Land_Cargo_HQ_V4_F", _cargoPos, [], 0, "CAN_COLLIDE"];
_unitsArray = _unitsArray + [_cargoHQ];
sleep 0.1;

// spawn several metal barells
for "_i" from 1 to 5 do {
    _barrelPos = [_startPoint, 0, 90, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    _barrel = createVehicle ["Land_MetalBarrel_F", _barrelPos, [], 0, "CAN_COLLIDE"];
    _unitsArray = _unitsArray + [_barrel];
    sleep 0.1;
};

// spawn one metal barell with gas
_barrelPos = [_startPoint, 0, 70, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
while {surfaceIsWater _barrelPos} do {
    _barrelPos = [_startPoint, 0, 70, 8, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
};
_barrel = createVehicle ["Land_MetalBarrel_F", _barrelPos, [], 0, "NONE"];
[_barrel, "QS_fnc_addActionNeutralize", nil, true] spawn BIS_fnc_MP;
SM_YELLOWFOG_POS = getPos _barrel;
SM_YELLOWFOG_POS set [2, ((SM_YELLOWFOG_POS select 2) + 1)];
publicVariable "SM_YELLOWFOG_POS";
_unitsArray = _unitsArray + [_barrel];
_gasPos = getPos _barrel;
sleep 0.1;

// spawn cargo houses
for "_i" from 1 to 8 do {
    _cargoPos = [_startPoint, 0, 100, 10, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    while {surfaceIsWater _cargoPos || _cargoPos distance _gasPos < 2} do {
        _cargoPos = [_startPoint, 0, 100, 8, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    };
    _cargoHouse = createVehicle ["Land_Cargo_House_V4_F", _cargoPos, [], 0, "NONE"];
    _unitsArray = _unitsArray + [_cargoHouse];
    sleep 0.1;
};

// spawn some cargo boxes
for "_i" from 1 to 5 do {
    _pos1 = [_startPoint, 0, 120, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    while {_pos1 distance _startPoint > 120 || _pos1 distance _gasPos < 8} do {
        _pos1 = [_startPoint, 0, 120, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    };
    _dir = random 360;
    _cargo1 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos1, [], 0, "CAN_COLLIDE"];
    _cargo1 setDir _dir;
    _pos2 = [(_pos1 select 0) + 5, (_pos1 select 1) + 5, 0];
    _cargo2 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos2, [], 0, "CAN_COLLIDE"];
    _cargo2 setDir _dir;
    _pos3 = [(_pos1 select 0) + 2.5, (_pos1 select 1) + 2.5, 4];
    _cargo3 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos3, [], 0, "CAN_COLLIDE"];
    _cargo3 setDir (_dir + 90);
    _unitsArray = _unitsArray + [_cargo1, _cargo2, _cargo3];
    sleep 0.1;
};
for "_i" from 1 to 5 do {
    _pos1 = [_startPoint, 0, 120, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    while {_pos1 distance _startPoint > 120 || _pos1 distance _gasPos < 8} do {
        _pos1 = [_startPoint, 0, 120, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    };
    _dir = 0;
    _cargo1 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos1, [], 0, "CAN_COLLIDE"];
    _cargo1 setDir _dir;
    _pos2 = [_pos1 select 0, (_pos1 select 1) + 5, 0];
    _cargo2 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos2, [], 0, "CAN_COLLIDE"];
    _cargo2 setDir _dir;
    _pos3 = [(_pos1 select 0) - 1.5, (_pos1 select 1) + 2.5, 4];
    _cargo3 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos3, [], 0, "CAN_COLLIDE"];
    _cargo3 setDir (_dir + 90);
    _unitsArray = _unitsArray + [_cargo1, _cargo2, _cargo3];
    sleep 0.1;
};
for "_i" from 1 to 5 do {
    _pos1 = [_startPoint, 0, 120, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    while {_pos1 distance _startPoint > 120 || _pos1 distance _gasPos < 8} do {
        _pos1 = [_startPoint, 0, 120, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    };
    _dir = 0;
    _cargo1 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos1, [], 0, "CAN_COLLIDE"];
    _cargo1 setDir _dir;
    _pos2 = [_pos1 select 0, (_pos1 select 1) + 5, 0];
    _cargo2 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos2, [], 0, "CAN_COLLIDE"];
    _cargo2 setDir _dir;
    _pos3 = [(_pos1 select 0) - 2, (_pos1 select 1) + 2.5, 4];
    _cargo3 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos3, [], 0, "CAN_COLLIDE"];
    _cargo3 setDir (_dir + 90);
    _pos4 = [(_pos1 select 0) + 2, (_pos1 select 1) + 2.5, 4];
    _cargo3 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos4, [], 0, "CAN_COLLIDE"];
    _cargo3 setDir (_dir + 90);
    _unitsArray = _unitsArray + [_cargo1, _cargo2, _cargo3];
    sleep 0.1;
};
for "_i" from 1 to 5 do {
    _pos1 = [_startPoint, 0, 120, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    while {_pos1 distance _startPoint > 120 || _pos1 distance _gasPos < 8} do {
        _pos1 = [_startPoint, 0, 120, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    };
    _dir = random 360;
    _cargo1 = createVehicle [(selectRandom [INFANTRY_CARGO]), _pos1, [], 0, "CAN_COLLIDE"];
    _cargo1 setDir _dir;
    _unitsArray = _unitsArray + [_cargo1];
    sleep 0.1;
};

// spawn misc barrels
for "_i" from 1 to 20 do {
    _pos1 = [_startPoint, 0, 120, 5, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    while {surfaceIsWater _pos1 || _pos1 distance _gasPos < 8 || _startPoint distance _pos1 > 120} do {
        _pos1 = [_startPoint, 0, 110, 3, 0, 15, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    };
   _barrel1 = createVehicle [(selectRandom [INFANTRY_BARRELS]), _pos1, [], 0, "NONE"];
   _unitsArray = _unitsArray + [_barrel1];
   sleep 0.1;
};

// add fog event
_barrel addEventHandler ["HandleDamage", {
    if (!SM_YELLOWFOG_FAIL) then {
        if ((_this select 2) > 0.2) then {
            (_this select 0) removeEventHandler ['HandleDamage', 0];
            [[[SM_YELLOWFOG_POS, 120], "scripts\fog.sqf"], "BIS_fnc_execVM", true, false] spawn BIS_fnc_MP;
            [] spawn {
                _n = 0;
                _nearestTargets = nearestObjects [SM_YELLOWFOG_STARTPOINT, ["Man"], 130];
                while {_n <= 120} do {
                    {
                        _x setDamage 0.1 * _n / 10;
                    } forEach _nearestTargets;
                    _n = _n + 10;
                    sleep 10;
                };
            };
            _nearbyPlayers = [];
            {
                if ((_x distance SM_YELLOWFOG_STARTPOINT) < 500) then {
                    _nearbyPlayers = _nearbyPlayers pushBack _x;
                };
            } forEach allPlayers;
            [{
                for "_x" from 1 to 20 do {
                    uiSleep 3;
                    playSound "Alarm";
                };
            },"BIS_fnc_spawn", _nearbyPlayers, false] spawn BIS_fnc_MP;
            [_this select 3] spawn {
                _swearWords = selectRandom ["Черт побери", "Крейсер мне в бухту", "Японский городовой", "Екарный бабай", "Едрить-колотить", "Ешкин кот", "Калаш мне в зад"];
                if (isNull (_this select 0)) then {
                    hqSideChat = format ["%1! Бочка с ипритом повреждена. Срочная эвакуация!", _swearWords];
                } else {
                    hqSideChat = format ["%1! %2 повредил бочку с ипритом. Срочная эвакуация!", _swearWords, name (_this select 0)];
                };
                publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
                sleep 10;
                SM_YELLOWFOG_FAIL = true; publicVariable "SM_YELLOWFOG_FAIL";
            };
        };
    };
}];
sleep 0.1;

// spawn guards
_hqGroup = createGroup ENEMY_SIDE;
_nearestHQ = nearestObjects [_startPoint, ["Land_Cargo_HQ_V4_F"], 130];
{
    _cargoHQ = _x;

    // guards with static weapons on cargoHQ
    {
        _posATL = _cargoHQ buildingPos _x;
        _posATL = [(_posATL select 0), (_posATL select 1), ((_posATL select 2) + 0.2)];
        _static = INFANTRY_STATIC createVehicle [10,10,10];
        waitUntil{!isNull _static};
        _static allowDamage false;
        _static setPos _posATL;
        _static setDir (random 360);
        (selectRandom [INFANTRY_GUNNERS]) createUnit [[10,10,10], _hqGroup, "currentGuard = this", 0, (selectRandom [INFANTRY_RANK])];
        currentGuard allowDamage false;
        sleep 0.2;
        currentGuard assignAsGunner _static;
        currentGuard moveInGunner _static;
        _static setVectorUp [0,0,1];
        _static lock 3;
        _unitsArray = _unitsArray + [_static];
        _enemiesArray = _enemiesArray + [currentGuard];
        currentGuard allowDamage true;
        _static allowDamage true;
        _static = nil;
        sleep 0.1;
    } forEach [5];

    // other guards
    {
        _posHQ = _cargoHQ buildingPos _x;
        (selectRandom [INFANTRY_SUPPORT]) createUnit [_posHQ, _hqGroup, "currentGuard = this", 0, (selectRandom [INFANTRY_RANK])];
        currentGuard allowDamage false;
        sleep 0.2;
        currentGuard setPosASL _posHQ;
        currentGuard setDir (random 360);
        currentGuard setUnitPos "UP";
        currentGuard allowDamage true;
        [currentGuard,(selectRandom ["WATCH","WATCH1","WATCH2"]),"FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
        _enemiesArray = _enemiesArray + [currentGuard];
        sleep 0.1;
    } forEach [1,3,6,7,9];

sleep 0.1;
} forEach _nearestHQ;

// house guards
_houseGroup = createGroup ENEMY_SIDE;
_nearestCargo = nearestObjects [_startPoint, ["Land_Cargo_House_V4_F"], 130];
{
    _house = _x;
    _posHouse = _house buildingPos (selectRandom [1,2,3]);
    (selectRandom [INFANTRY_SUPPORT]) createUnit [_posHouse, _houseGroup, "currentGuard = this", 0, (selectRandom [INFANTRY_RANK])];
    currentGuard allowDamage false;
    sleep 0.2;
    currentGuard setPosASL _posHouse;
    currentGuard setDir (random 360);
    currentGuard setUnitPos "UP";
    currentGuard allowDamage true;
    [currentGuard,(selectRandom ["WATCH","WATCH1","WATCH2"]),"FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
    _enemiesArray = _enemiesArray + [currentGuard];
    sleep 0.1;
} forEach _nearestCargo;

//  Spawn snipers
_sniperGroup = createGroup ENEMY_SIDE;
_nearestPatrolHouse = nearestObjects [_startPoint, ["Land_Cargo_Patrol_V4_F"], 130];
{
    _patrolHouse = _x;
    {
        _posPatrolHouse = _patrolHouse buildingPos _x;
        (selectRandom [INFANTRY_RECONS]) createUnit [_posPatrolHouse, _sniperGroup, "currentGuard = this", 0, (selectRandom [INFANTRY_RANK])];
        currentGuard allowDamage false;
        sleep 0.2;
        currentGuard setPosASL _posPatrolHouse;
        currentGuard setDir (random 360);
        currentGuard setUnitPos "UP";
        currentGuard allowDamage true;
        [currentGuard,(selectRandom ["WATCH","WATCH1","WATCH2"]),"FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
        _enemiesArray = _enemiesArray + [currentGuard];
        sleep 0.1;
    } forEach [1,2,3];
    sleep 0.1;
} forEach _nearestPatrolHouse;

// ground guards
_groundGroup  = createGroup ENEMY_SIDE;
for "_c" from 1 to 10 do {
    _groundPos = [_startPoint, 0, 110, 2, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    (selectRandom [INFANTRY_RECONS]) createUnit [_groundPos, _groundGroup, "currentGuard = this", 0, (selectRandom [INFANTRY_RANK])];
    currentGuard allowDamage false;
    sleep 0.2;
    currentGuard setDir (random 360);
    currentGuard setUnitPos "UP";
    currentGuard allowDamage true;
    [currentGuard,(selectRandom ["WATCH","WATCH1","WATCH2"]),"FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
    _enemiesArray = _enemiesArray + [currentGuard];
    sleep 0.1;
};

// patrols (2 bots)
_groundPos1 = [_startPoint, 0, 110, 2, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
_patrolGroup1 = [_groundPos1, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfSentry")] call BIS_fnc_spawnGroup;
[_patrolGroup1, _startPoint, 90] call BIS_fnc_taskPatrol;
_enemiesArray = _enemiesArray + (units _patrolGroup1);
sleep 0.1;

//patrol (4 bots)
_groundPos2 = [_startPoint, 0, 90, 2, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
_patrolGroup2 = [_groundPos2, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam")] call BIS_fnc_spawnGroup;
[_patrolGroup2, _startPoint, 60] call BIS_fnc_taskPatrol;
_enemiesArray = _enemiesArray + (units _patrolGroup2);
sleep 0.1;

// patrol (8 bots)
_groundPos3 = [_startPoint, 0, 30, 2, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
_patrolGroup3 = [_groundPos3 , ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfSquad")] call BIS_fnc_spawnGroup;
[_patrolGroup3, _startPoint, 20] call BIS_fnc_taskPatrol;
_enemiesArray = _enemiesArray + (units _patrolGroup3);
sleep 0.1;

// Set skills and behaviour
{
    _x setBehaviour "SAFE";
    _x setCombatMode "RED";
    [(units _x)] call QS_fnc_setSkill3;
} forEach [_hqGroup, _houseGroup, _sniperGroup, _groundGroup, _patrolGroup1, _patrolGroup2, _patrolGroup3];
[_startPoint, 200, ["vehicles", "fire"]] call QS_fnc_addHades;

// save info in DB
try {
    _position = format ["%1,%2", floor (_flatPos select 0), floor (_flatPos select 1)];
    ["setInfo",["spec_name", "Желтый туман"], 0] remoteExec ["sqlServerCall", 2];
    ["setInfo",["spec_position", _position], 0] remoteExec ["sqlServerCall", 2];
} catch {};

if !(isNil "PARTIZAN_BASE_SCORE") then {
    if (PARTIZAN_BASE_SCORE > 33) then {
        _taskMarker = createMarker ["TASK_MARKER1", [0,0]];
        _taskMarker setMarkerColor "ColorRed";
        _taskMarker setMarkerType "mil_dot";
        [_taskMarker, 0] remoteExec ["setMarkerAlphaLocal", west, true];
        [_taskMarker, 1] remoteExec ["setMarkerAlphaLocal", resistance, true];
        _taskMarker setMarkerPos SM_YELLOWFOG_POS;
    };
};

while { sideMissionUp } do {
    sleep 2;

    // de-briefing
    if (SM_YELLOWFOG_SUCCESS || SM_YELLOWFOG_FAIL) exitWith {
        sideMissionUp = false; publicVariable "sideMissionUp";
        { _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
        if (SM_YELLOWFOG_FAIL) then {
            [true] call QS_fnc_SMhintFAIL;
        } else {
            _stomper = false;
            if (WIN_WEST > WIN_GUER) then {
                _successSide = west;
                [4] call QS_fnc_bluforSUCCESS;
                _stomper = "B_UGV_01_rcws_F";
            } else {
                _successSide = resistance;
                [4] call QS_fnc_partizanSUCCESS;
                _stomper = "I_UGV_01_rcws_F";
            };

            // spawn stomper
            if (random 10 > 5) then {
                hqSideChat = ["Разведка сообщила о пустом БПА Стомпер недалеко от зоны спецоперации!", _successSide]; publicVariable "hqSideChat";
                [_successSide, "HQ"] sideChat (hqSideChat select 0);
                _stomperPos = [_startPoint, 135, 200, 3, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
                _uavGroup = createGroup _successSide;
                _spawn = [_stomperPos, (random 360), _stomper, [_uavGroup]] call BIS_fnc_spawnVehicle;
                _uav = (_spawn select 0);
                _uav addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
                _uav addWeapon "missiles_titan";
                _uav addMagazine "2Rnd_GAT_missiles";
                _uav addWeapon "Missile_AA_03_Plane_CAS_02_F";
                _uav addMagazine "2Rnd_Missile_AA_03_F";
            };
        };
        deleteMarker "TASK_MARKER1";
        sleep 60;
        {
            deleteVehicle _x;
        } forEach _unitsArray;
        sleep 2;
        _nearestTargets = nearestObjects [_startPoint, [INFANTRY_CARGO], 200];
        {
            deleteVehicle _x;
        } foreach _nearestTargets;
        sleep 2;
        _nearestTargets = nearestObjects [_campPos, ["All"], 40];
        {
            deleteVehicle _x;
        } foreach _nearestTargets;
        sleep 2;
        deleteGroup _camp;
        {
            [_x] call QS_fnc_TBdeleteObjects;
        } forEach [_enemiesArray];
        [_startPoint, 500] call QS_fnc_DeleteEnemyEAST;
    };
    sleep 3;
};
