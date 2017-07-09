/*
Author:	ToxaBes
Description: Defend submarine.
*/

// define some keywords
#define INFANTRY_MISSION "Спецоперация: Рыба-меч (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_RANK "CAPTAIN","MAJOR","COLONEL"
#define INFANTRY_SDV "O_SDV_01_F","I_SDV_01_F"
#define INFANTRY_DIVERS "O_diver_F","O_diver_TL_F","O_diver_exp_F","I_diver_F","I_diver_exp_F","I_diver_TL_F"
#define INFANTRY_HQ_GUARDS "O_recon_TL_F","O_recon_F","O_recon_F","O_recon_F","O_recon_LAT_F","O_recon_LAT_F","O_recon_LAT_F","O_recon_M_F","O_recon_M_F","O_recon_M_F","O_recon_JTAC_F","O_recon_JTAC_F","O_recon_JTAC_F"
#define INFANTRY_WRECKED_VECHICLES "Land_UWreck_FishingBoat_F","Land_UWreck_Heli_Attack_02_F","Land_UWreck_MV22_F","Land_Wreck_Heli_Attack_02_F","Land_Wreck_Plane_Transport_01_F","Land_Wreck_Traw_F","Land_Wreck_Traw2_F","Land_Cargo20_grey_F","Land_Cargo20_light_green_F","Land_Cargo20_military_green_F"

// define private variables
private ["_enemiesArray", "_unitsArray", "_targets", "_position", "_flatPos", "_startPoint", "_briefing", "_sub", "_subPos", "_subDir", "_submarine", "_mod", "_chemPos", "_chemlight", "_minePos", "_height", "_mine", "_wreck", "_wreckPos", "_wreckVeh", "_devices", "_safePos", "_devicePos", "_device", "_sdv", "_light", "_diversGroup1", "_r", "_diverPos", "_diversGroup2", "_patrolGroup", "_boatPos1", "_dirBoat1", "_boat1", "_dirBoat2", "_botPos2", "_boat2", "_dirBoat3", "_botPos3", "_boat3", "_places", "_campPos", "_camo", "_hqGroup", "_guardPos", "_sniperPlaces", "_sniperPos", "_viperGroup", "_nearestMines"];

_enemiesArray = [grpNull];
_unitsArray = [];

// format: [[coords x,y,z],  [submarine x,y,z,dir]]
_targets = [
    [[23012,27040.8,-190],   [23057.7,27067.2,-180,297]],
    [[17810.5,21459,-59],    [17819.5,21501.2,-60,171]],
    [[21202.3,20740.1,-20],  [21185.9,20704.7,-20,208]],
    [[23121.8,24026.7,-46],  [23142.2,24019,-40,256]],
    [[27448.7,25764.9,-48],  [27444.7,25762.6,-48.9868,308]],
    [[28520.6,26085.8,-31],  [28489.4,26058.3,-39.6076,361]],
    [[28852.9,25259.5,-53],  [28897.6,25276.3,-69.011,323]],
    [[28545.7,23471.5,-77],  [28529.3,23465,-73.7381,245]],
    [[28334.6,21541.4,-80],  [28329.7,21543.4,-73.8916,241]],
    [[22848.4,14666.3,-78],  [22863.2,14672.3,-77.2059,90]],
    [[22490.8,6468.93,-44],  [22478.3,6481.4,-42.2196,219]],
    [[14755.6,6369.84,-45],  [14763.8,6390.11,-51.0581,41]],
    [[14374,7698.5,-153],    [14376.9,7698.66,-146.276,453]],
    [[13107.4,9499.57,-73],  [13077.6,9512.78,-59.9711,10]],
    [[13070.8,12564.8,-42],  [13090.4,12553.4,-37.7012,313]],
    [[14436.5,12255.3,-74],  [14432.3,12235.6,-64.8667,241]],
    [[14118.7,14094.1,-74],  [14096.1,14102.7,-63.7279,116]],
    [[15811.7,14022.6,-97],  [15799.4,14024.3,-82.9026,264]],
    [[8974.37,7057.67,-31],  [8978.68,7072.51,-16.9993,357]],
    [[8015.85,7773.47,-47],  [8015.81,7778.07,-36.4197,2]],
    [[9310.77,10253.8,-32],  [9300.13,10261,-19.9662,44]],
    [[3181.39,10971.6,-37],  [3149.79,10945.4,-24.1112,255]],
    [[2978.73,13744.2,-50],  [2984.06,13724.3,-31.6172,143]],
    [[2187.96,21443.1,-101], [2200.74,21441.1,-88.3547,107]],
    [[7667.65,23994.2,-116], [7677.23,24006.8,-108.926,33]]
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
    _sdv addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
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
_boat1 = createVehicle ["O_Boat_Transport_01_F", _boatPos1, [], 0, "CAN_COLLIDE"];
_boat1 setDir _dirBoat1;
sleep 0.1;
_dirBoat2 = _dirBoat1 + (random 15) - (random 15);
_botPos2 = [((getPos _boat1) select 0) + random 3, ((getPos _boat1) select 1) + random 3, 0.3];
_boat2 = createVehicle ["O_Boat_Transport_01_F", _botPos2, [], 0, "CAN_COLLIDE"];
_boat2 setDir _dirBoat2;
sleep 0.1;
_dirBoat3 = _dirBoat2 + (random 15) - (random 15);
_botPos3 = [((getPos _boat2) select 0) + random 3, ((getPos _boat2) select 1) + random 3, 0.3];
_boat3 = createVehicle ["O_Boat_Transport_01_F", _botPos3, [], 0, "CAN_COLLIDE"];
_boat3 setDir _dirBoat3;
_unitsArray = _unitsArray + [_boat1, _boat2, _boat3];
sleep 0.1;

// HQ: camonet
_places = selectBestPlaces [_boatPos1, 300, "forest + trees", 1, 1];
_campPos = (_places select 0) select 0;
if (_campPos distance _boatPos1 > 301) then {
    _campPos = [_boatPos1, 50, 300, 6, 0, 0.4, 0, [], [_boatPos1]] call QS_fnc_findSafePos;
};
_camo = createVehicle ["CamoNet_OPFOR_F", _campPos, [], 0, "CAN_COLLIDE"];
_camo setDir (random 360);
_unitsArray = _unitsArray + [_camo];
sleep 0.1;

// HQ: commander
_hqGroup = createGroup EAST;
"O_officer_F" createUnit [_campPos, _hqGroup, "currentOfficier = this"];
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
"O_ghillie_ard_F" createUnit [_sniperPos, _hqGroup, "currentSniper = this"];
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
    _viperGroup = [_campPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "SpecOps" >> "OI_ViperTeam")] call BIS_fnc_spawnGroup;
    [_viperGroup, _campPos, 300] call BIS_fnc_taskPatrol;
    _viperGroup setCombatMode "RED";
    _viperGroup setBehaviour "STEALTH";
    [(units _viperGroup)] call QS_fnc_setSkill4;
};

[_startPoint, 200, ["vehicles", "fire"]] call QS_fnc_addHades;

// save info in DB
try {
    _position = format ["%1,%2", floor (_flatPos select 0), floor (_flatPos select 1)];
    ["setInfo",["spec_name", "Рыба-меч"], 0] remoteExec ["sqlServerCall", 2];
    ["setInfo",["spec_position", _position], 0] remoteExec ["sqlServerCall", 2];
} catch {};

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
            [4] spawn QS_fnc_bluforSUCCESS;
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
