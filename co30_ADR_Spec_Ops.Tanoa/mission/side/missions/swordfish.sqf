/*
Author:	ToxaBes
Description: Defend submarine.
*/

// define some keywords
#define INFANTRY_MISSION "Спецоперация: Рыба-меч (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_RANK "CAPTAIN","MAJOR","COLONEL"
#define INFANTRY_SDV "O_SDV_01_F"
#define INFANTRY_DIVERS "O_T_Diver_F","O_T_Diver_TL_F","O_T_Diver_Exp_F"
#define INFANTRY_HQ_GUARDS "O_T_Recon_TL_F","O_T_Recon_F","O_T_Recon_F","O_T_Recon_F","O_T_Recon_LAT_F","O_T_Recon_LAT_F","O_T_Recon_LAT_F","O_T_Recon_M_F","O_T_Recon_M_F","O_T_Recon_M_F","O_T_Recon_JTAC_F","O_T_Recon_JTAC_F","O_T_Recon_JTAC_F"
#define INFANTRY_WRECKED_VECHICLES "Land_Boat_06_wreck_F","Land_UWreck_FishingBoat_F","Land_Wreck_Traw2_F","Land_Wreck_Traw_F","Land_UWreck_Heli_Attack_02_F","Land_Wreck_Plane_Transport_01_F","Land_HistoricalPlaneWreck_01_F","Land_HistoricalPlaneWreck_03_F","Land_HistoricalPlaneWreck_02_front_F","Land_HistoricalPlaneWreck_02_wing_right_F","Land_UWreck_MV22_F","Land_Cargo20_grey_F","Land_Cargo20_light_green_F","Land_Cargo20_military_green_F"

// define private variables
private ["_enemiesArray", "_unitsArray", "_targets", "_position", "_flatPos", "_startPoint", "_briefing", "_sub", "_subPos", "_subDir", "_submarine", "_mod", "_chemPos", "_chemlight", "_minePos", "_height", "_mine", "_wreck", "_wreckPos", "_wreckVeh", "_devices", "_safePos", "_devicePos", "_device", "_sdv", "_light", "_diversGroup1", "_r", "_diverPos", "_diversGroup2", "_patrolGroup", "_boatPos1", "_dirBoat1", "_boat1", "_dirBoat2", "_botPos2", "_boat2", "_dirBoat3", "_botPos3", "_boat3", "_places", "_campPos", "_camo", "_hqGroup", "_guardPos", "_sniperPlaces", "_sniperPos", "_viperGroup", "_nearestMines"];

_enemiesArray = [grpNull];
_unitsArray = [];

// format: [[coords x,y,z],  [submarine x,y,z,dir]]
_targets = [
    [[2741,10063,-20],   [2743,10083,-37,132] ],
    [[1629,9573,-20],    [1640,9542,-40,230]  ],
    [[6055,13726,-30],   [6060,13771,-20,41]  ],
    [[10571,14073,-35],  [10512,14075,-25,169]],
    [[13884,13100,-45],  [13908,13122,-40,146]],
    [[14518,8200,-25],   [14537,8204,-23,344] ],
    [[13485,6435,-20],   [13515,6479,-22,354] ],
    [[5885,2975,-75],    [5909,2954,-50,172]  ],
    [[7174,5140,-40],    [7205,5146,-40,82]   ],
    [[9403,5321,-35],    [9403,5321,-23,163]  ],
    [[10799,5639,-30],   [10800,5647,-25,151] ],
    [[3509,4352,-35],    [3488,4362,-28,291]  ]
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
SM_SWORDFISH_SUCCESS = false; publicVariable "SM_SWORDFISH_SUCCESS";

// show brief information
_briefing = "<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FFC107'>Рыба-меч</t><br/>____________________<br/>Атомная подводная лодка класса Рыба-Меч терпит бедствие недалеко от нашей зоны ответственности. Есть информация что противник перехватил сигнал SOS и отправил группу захвата по полученным координатам. Командование назначило подводную спецоперацию.<br/><br/>Ваша задача: выдвинуться в указанный район, найти подводную лодку и оборонять ее до подхода спасателей.</t>";
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSpecMission", "Рыба-меч"]; publicVariable "showNotification";
sideMissionUp = true; publicVariable "sideMissionUp";

// spawn submarine
_sub = _position select 1;
_subPos = [_sub select 0, _sub select 1, (_sub select 2) + 10];
_subDir = _sub select 3;
_submarine = createVehicle ["Submarine_01_F", [0,0,0], [], 0, "NONE"];
_submarine setMass 9999999;
_submarine setPos _subPos;
_submarine setDir _subDir;
_unitsArray = _unitsArray + [_submarine];
sleep 3;
_mod = 1;
for "_c" from 0 to 4 do {
    _chemPos = [(_sub select 0) + (random 20) *_mod, (_sub select 1) + (random 20) * _mod, 10];
    _chemlight = createVehicle ["Chemlight_yellow", _chemPos, [], 0, "NONE"];
    _mod = _mod * -1;
    _unitsArray = _unitsArray + [_chemlight];
    sleep 0.1;
};

// spawn mines
for "_c" from 0 to 50 do {
    _minePos = [_subPos, 1, 180, 3, 2, 20, 0, [], [_subPos]] call QS_fnc_findSafePos;
    _height = random (floor ((getTerrainHeightASL _minePos) * -1));
    _pos = [_minePos select 0, _minePos select 1, (0 - _height)];
    _mine = createMine ["UnderwaterMine", _pos, [], 0];
    sleep 0.1;
};

//spawn wreck vehicles
for "_c" from 0 to 6 do {
    _wreck = selectRandom [INFANTRY_WRECKED_VECHICLES];
    _wreckPos = [_subPos, 40, 120, 5, 2, 20, 0, [], [_subPos]] call QS_fnc_findSafePos;
    _wreckVeh = createVehicle [_wreck, [0,0,0], [], 0, "CAN_COLLIDE"];
    _wreckVeh setPos [_wreckPos select 0, _wreckPos select 1, getTerrainHeightASL _wreckPos];
    _wreckVeh setDir (random 360);
    _chemPos = [_wreckPos select 0, _wreckPos select 1, 10];
    _chemlight = createVehicle ["Chemlight_blue", _chemPos, [], 0, "NONE"];
    _unitsArray = _unitsArray + [_wreckVeh, _chemlight];
    sleep 0.1;
};

// spawn 2 devices
BLOCKED_DEVICES = 0; publicVariable "BLOCKED_DEVICES";
_devices = nearestObjects [[_startPoint select 0, _startPoint select 1], ["Land_Device_disassembled_F"], 200];
while {count _devices < 2} do {
    _safePos = [_subPos, 5, 50, 1, 2, 15, 0, [], [_subPos]] call QS_fnc_findSafePos;
    _devicePos = [_safePos select 0, _safePos select 1, getTerrainHeightASL _safePos];
    _device = createVehicle ["Land_Device_disassembled_F", [0,0,0], [], 0, "NONE"];
    waitUntil {alive _device};
    _device allowDamage false;
    _device setPos _devicePos;
    _device setDir (random 360);
    _device setMass 1000;
    sleep 2;
    _device setPos _devicePos;
    [_device, "QS_fnc_addActionBlock", nil, true] spawn BIS_fnc_MP;
    _chemlight = createVehicle ["Chemlight_red", _devicePos, [], 0, "NONE"];
    _unitsArray = _unitsArray + [_device, _chemlight];
    _devices = nearestObjects [[_startPoint select 0, _startPoint select 1], ["Land_Device_disassembled_F"], 200];
    sleep 0.1;
};

// doublecheck devices
_devices = nearestObjects [[_startPoint select 0, _startPoint select 1], ["Land_Device_disassembled_F"], 200];
if (count _devices < 2) then {
    for "_c" from 0 to 1 do {
        _safePos = [_subPos, 5, 150, 1, 2, 15, 0, [], [_subPos]] call QS_fnc_findSafePos;
        _devicePos = [_safePos select 0, _safePos select 1, getTerrainHeightASL _safePos];
        _device = createVehicle ["Land_Device_disassembled_F", _devicePos, [], 0, "NONE"];
        _device allowDamage false;
        _device setMass 1000;
        _device setDir (random 360);
        [_device, "QS_fnc_addActionBlock", nil, true] spawn BIS_fnc_MP;
        _chemlight = createVehicle ["Chemlight_red", _devicePos, [], 0, "NONE"];
        _unitsArray = _unitsArray + [_device, _chemlight];
        sleep 0.1;
    };
};
sleep 1;

// spawn 5 SDVs
for "_c" from 0 to 4 do {
    _safePos = [_subPos, 2, 50, 2, 2, 5, 0, [], [_subPos]] call QS_fnc_findSafePos;
    _sdv = createVehicle [(selectRandom [INFANTRY_SDV]), [0,0,0], [], 0, "NONE"];
    waitUntil {alive _sdv};
    _sdv setPos [_safePos select 0, _safePos select 1, getTerrainHeightASL _safePos];
    _sdv setDir (random 360);
    _unitsArray = _unitsArray + [_sdv];
    sleep 0.1;
};

// spawn 5 lights
for "_c" from 0 to 4 do {
_safePos = [_subPos, 15, 40, 4, 2, 20, 0, [], [_subPos]] call QS_fnc_findSafePos;
    _light = createVehicle [(selectRandom ["Land_PortableLight_double_F","Land_PortableLight_single_F"]), [0,0,0], [], 0, "NONE"];
    _light setPos [_safePos select 0, _safePos select 1, getTerrainHeightASL _safePos];
    _light setDir (([_light, _submarine] call BIS_fnc_dirTo) + 180);
    _light setMass 20;
    _unitsArray = _unitsArray + [_light];
    sleep 0.1;
};

// spawn 2 groups of single divers
_diversGroup1 = createGroup ENEMY_SIDE;
for "_c" from 0 to 15 do {
    _safePos = [(_subPos select 0) + (random 40) - 20, (_subPos select 1) + (random 40) - 20, 0];
    _height = getTerrainHeightASL _safePos;
    _r = selectRandom [0.1,1.1,2.1,3.1,4.1,5.1,6.1,7.1,8.1,9.1,10.1,11.1,12.1,13.1,14.1,15.1];
    _height = _height + _r;
    _diverPos = [(_safePos select 0), (_safePos select 1), _height];
    (selectRandom [INFANTRY_DIVERS]) createUnit [[0,0,0], _diversGroup1, "currentGuard = this", 0, (selectRandom [INFANTRY_RANK])];
    waitUntil {alive currentGuard};
    currentGuard setPos _diverPos;
    currentGuard setDir (random 360);
    doStop currentGuard;
    commandStop currentGuard;
    //[currentGuard,(selectRandom ["WATCH","WATCH1","WATCH2"]),"FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
    removeAllWeapons currentGuard;
    currentGuard addWeapon "arifle_SDAR_F";
    currentGuard addmagazines["20Rnd_556x45_UW_mag", 10];
    sleep 0.1;
};
_diversGroup1 setBehaviour "SAFE";
_diversGroup1 setCombatMode "RED";
[(units _diversGroup1)] call QS_fnc_setSkill3;
_enemiesArray = _enemiesArray + (units _diversGroup1);

_diversGroup2 = createGroup ENEMY_SIDE;
for "_c" from 0 to 25 do {
    _safePos = [(_subPos select 0) + (random 300) - 150, (_subPos select 1) + (random 300) - 150, 0];
    _height = getTerrainHeightASL _safePos;
    _r = selectRandom [0.1,1.1,2.1,3.1,4.1,5.1,6.1,7.1,8.1,9.1,10.1,11.1,12.1,13.1,14.1,15.1];
    _height = _height + _r;
    _diverPos = [(_safePos select 0), (_safePos select 1), _height];
    (selectRandom [INFANTRY_DIVERS]) createUnit [[0,0,0], _diversGroup2, "currentGuard = this", 0, (selectRandom [INFANTRY_RANK])];
    waitUntil {alive currentGuard};
    currentGuard setPos _diverPos;
    currentGuard setDir (random 360);
    [currentGuard,(selectRandom ["WATCH","WATCH1","WATCH2"]),"FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
    removeAllWeapons currentGuard;
    currentGuard addWeapon "arifle_SDAR_F";
    currentGuard addmagazines["20Rnd_556x45_UW_mag", 10];
    sleep 0.1;
};
_diversGroup2 setBehaviour "SAFE";
_diversGroup2 setCombatMode "RED";
[(units _diversGroup2)] call QS_fnc_setSkill3;
_enemiesArray = _enemiesArray + (units _diversGroup2);

// spawn 4 patrol groups
for "_c" from 0 to 3 do {
    _safePos = [(_subPos select 0) + (random 150) - 70, (_subPos select 1) + (random 150) - 70, 0];
    _height = getTerrainHeightASL _safePos;
    _diverPos = [_safePos select 0, _safePos select 1, ((_height + 10) - (random 5))];
    _patrolGroup = createGroup ENEMY_SIDE;
    for "_c" from 0 to 1 do {
        (selectRandom [INFANTRY_DIVERS]) createUnit [[0,0,0], _patrolGroup, "currentGuard = this", 0, (selectRandom [INFANTRY_RANK])];
        waitUntil {alive currentGuard};
        currentGuard setPos _diverPos;
        currentGuard setDir (random 360);
        removeAllWeapons currentGuard;
        currentGuard addWeapon "arifle_SDAR_F";
        currentGuard addmagazines["20Rnd_556x45_UW_mag", 10];
        _diverPos set [0, (_diverPos select 0) + 4];
        _diverPos set [1, (_diverPos select 1) + 4];
    };
    _patrolGroup setBehaviour "SAFE";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill3;
    [_patrolGroup, _subPos, 40] call BIS_fnc_taskPatrol;
    _enemiesArray = _enemiesArray + (units _patrolGroup);
    sleep 0.1;
};

// HQ: boats
_boatPos1 = [_startPoint, [400, 1000], 5, 0.2] call QS_fnc_getShorePos;
_dirBoat1 = random 360;
_boat1 = createVehicle ["O_T_Boat_Transport_01_F", _boatPos1, [], 0, "CAN_COLLIDE"];
_boat1 setDir _dirBoat1;
sleep 0.1;
_dirBoat2 = _dirBoat1 + (random 15) - (random 15);
_botPos2 = [((getPos _boat1) select 0) + random 3, ((getPos _boat1) select 1) + random 3, 0.3];
_boat2 = createVehicle ["O_T_Boat_Transport_01_F", _botPos2, [], 0, "CAN_COLLIDE"];
_boat2 setDir _dirBoat2;
sleep 0.1;
_dirBoat3 = _dirBoat2 + (random 15) - (random 15);
_botPos3 = [((getPos _boat2) select 0) + random 3, ((getPos _boat2) select 1) + random 3, 0.3];
_boat3 = createVehicle ["O_T_Boat_Transport_01_F", _botPos3, [], 0, "CAN_COLLIDE"];
_boat3 setDir _dirBoat3;
_unitsArray = _unitsArray + [_boat1, _boat2, _boat3];
sleep 0.1;

// HQ: camonet
_places = selectBestPlaces [_boatPos1, 300, "forest + trees", 1, 1];
_campPos = (_places select 0) select 0;
if (_campPos distance _boatPos1 > 301) then {
    _campPos = [_boatPos1, 50, 300, 6, 0, 0.4, 0, [], [_boatPos1]] call QS_fnc_findSafePos;
};
_camo = createVehicle ["CamoNet_ghex_F", _campPos, [], 0, "CAN_COLLIDE"];
_camo setDir (random 360);
_unitsArray = _unitsArray + [_camo];
sleep 0.1;

// HQ: commander
_hqGroup = createGroup EAST;
"O_T_Officer_F" createUnit [_campPos, _hqGroup, "currentOfficier = this"];
doStop currentOfficier;
commandStop currentOfficier;
currentOfficier addPrimaryWeaponItem "muzzle_snds_H";
currentOfficier setUnitPos "MIDDLE";
sleep 0.1;

// HQ: add action
[currentOfficier, "QS_fnc_addActionRetreat", nil, true] spawn BIS_fnc_MP;

// HQ: guards
{
   _guardPos = [_campPos, 2, 100, 2, 0, 0.4, 0, [], [_campPos]] call QS_fnc_findSafePos;
   _x createUnit [_guardPos, _hqGroup, "currentGuard = this"];
   currentGuard setDir (([currentOfficier, currentGuard] call BIS_fnc_dirTo) + 180);
   currentGuard setUnitPos "AUTO";
   sleep 0.1;
} forEach [INFANTRY_HQ_GUARDS];

// HQ: sniper
// Arma developers broke QS_fnc_findOverwatch function so we can't use it
_sniperPlaces = selectBestPlaces [_campPos, 600, "hills", 1, 1];
_sniperPos = (_sniperPlaces select 0) select 0;
if (_sniperPos distance _campPos > 600) then {
    _sniperPos = [_campPos, 80, 600, 2, 0, 0.4, 0, [], [_campPos]] call QS_fnc_findSafePos;
};
"O_T_ghillie_tna_F" createUnit [_sniperPos, _hqGroup, "currentSniper = this"];
currentSniper setDir ([currentOfficier, currentSniper] call BIS_fnc_dirTo);
currentSniper setUnitPos "DOWN";
sleep 0.1;

// HQ: group settings
_hqGroup setBehaviour "STEALTH";
_hqGroup setCombatMode "RED";
[(units _hqGroup)] call QS_fnc_setSkill4;
[_hqGroup, _campPos] call bis_fnc_taskDefend;
_enemiesArray = _enemiesArray + (units _hqGroup);

// HQ: Viper group
if (random 1 > 0.5) then {
    _viperGroup = [_campPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "EAST" >> "OPF_T_F" >> "SpecOps" >> "O_T_ViperTeam")] call BIS_fnc_spawnGroup;
    [_viperGroup, _campPos, 300] call BIS_fnc_taskPatrol;
    _viperGroup setCombatMode "RED";
    _viperGroup setBehaviour "STEALTH";
    [(units _viperGroup)] call QS_fnc_setSkill4;
};

[_startPoint, 200, ["vehicles", "fire"]] call QS_fnc_addHades;
while { sideMissionUp } do {
    sleep 2;

    // both devices deactivated, attack submarine with rest of enemy forces
    if (BLOCKED_DEVICES > 1 && !SM_SWORDFISH_SUCCESS) then {
        BLOCKED_DEVICES = 0; publicVariable "BLOCKED_DEVICES";
        SM_SWORDFISH_SUCCESS = true; publicVariable "SM_SWORDFISH_SUCCESS";
    };

    // de-briefing
    if (SM_SWORDFISH_SUCCESS) exitWith {
        sideMissionUp = false; publicVariable "sideMissionUp";
        { _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
        if (WIN_WEST > WIN_GUER) then {
            [true] spawn QS_fnc_SMhintSUCCESS;
        } else {
            [4] spawn QS_fnc_partizanSUCCESS;
        };

        // delete mines
        {
            if (_x distance _startPoint < 300) then {
               deleteVehicle _x;
            };
        } forEach allMines;
        _nearestMines = nearestObjects [_startPoint, ["UnderwaterMine"], 300];
        {
            deleteVehicle _x;
        } forEach _nearestMines;

        sleep 120;
        {
            [_x] call QS_fnc_TBdeleteObjects;
        } forEach [_enemiesArray, _unitsArray];
        [_startPoint, 500] call QS_fnc_DeleteEnemyEAST;
    };
    sleep 3;
};
