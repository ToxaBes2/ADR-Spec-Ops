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
#define INFANTRY_WRECKED_VECHICLES "Land_UWreck_FishingBoat_F","Land_UWreck_Heli_Attack_02_F","Land_UWreck_MV22_F","Land_Wreck_Heli_Attack_02_F","Land_Wreck_Plane_Transport_01_F","Land_Wreck_Traw_F","Land_Wreck_Traw2_F","Land_Cargo20_grey_F","Land_Cargo20_light_green_F","Land_Cargo20_military_green_F"

// define private variables
private ["_targets","_accepted","_distance","_briefing","_position","_flatPos","_x","_enemiesArray","_startPoint"];         

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
if (PARAMS_AO == 1) then {
    _accepted = false;
    while {!_accepted} do {    
        _position = _targets call BIS_fnc_selectRandom;
        _flatPos  = _position select 0;  
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
    _flatPos  = _position select 0;
};

// set zone area
_startPoint = [(_flatPos select 0),(_flatPos select 1),1];
{ _x setMarkerPos _flatPos; } forEach ["sideMarker", "sideCircle"];
"sideCircle" setMarkerSize [200, 200]; publicVariable "sideCircle";
sideMarkerText = [INFANTRY_MISSION, true]; publicVariable "sideMarkerText";
"sideMarker" setMarkerText INFANTRY_MISSION; publicVariable "sideMarker";
SM_SWORDFISH_SUCCESS = false; publicVariable "SM_SWORDFISH_SUCCESS";

// show brief information
_briefing = "<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FF9999'>Рыба-меч</t><br/>____________________<br/>Атомная подводная лодка класса Рыба-Меч терпит бедствие недалеко от нашей зоны ответственности. Есть информация что противник перехватил сигнал SOS и отправил группу захвата по полученным координатам. Командование назначило подводную спецоперацию.<br/><br/>Ваша задача: выдвинуться в указанный район, найти подводную лодку и оборонять ее до подхода спасателей.</t>";
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSideMission", "Рыба-меч"]; publicVariable "showNotification";
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
_mod = 1;
for "_c" from 0 to 4 do {
    _chemPos = [(_sub select 0) + (random 20) *_mod, (_sub select 1) + (random 20) * _mod, 10];
    _chemlight = createVehicle ["Chemlight_yellow", _chemPos, [], 0, "NONE"];
    _mod = _mod * -1;
    _unitsArray = _unitsArray + [_chemlight];
};

// spawn mines
for "_c" from 0 to 50 do {
    _minePos = [_subPos, 1, 180, 3, 2, 20, 0] call BIS_fnc_findSafePos;
    _height = random (floor ((getTerrainHeightASL _minePos) * -1));
    _pos = [_minePos select 0, _minePos select 1, (0 - _height)];
    _mine = createMine ["UnderwaterMine", _pos, [], 0];
};

//spawn wreck vehicles
for "_c" from 0 to 6 do {    
    _wreck = [INFANTRY_WRECKED_VECHICLES] call BIS_fnc_selectRandom;
    _wreckPos = [_subPos, 40, 120, 3, 2, 20, 0] call BIS_fnc_findSafePos;
    _wreckVeh = createVehicle [_wreck, [0,0,0], [], 0, "CAN_COLLIDE"];
    _wreckVeh setPos [_wreckPos select 0, _wreckPos select 1, getTerrainHeightASL _wreckPos];
    _wreckVeh setDir (random 360);
    _chemPos = [_wreckPos select 0, _wreckPos select 1, 10];
    _chemlight = createVehicle ["Chemlight_blue", _chemPos, [], 0, "NONE"];
    _unitsArray = _unitsArray + [_wreckVeh, _chemlight];
};

// spawn 2 devices
BLOCKED_DEVICES = 0; publicVariable "BLOCKED_DEVICES";
_devices = nearestObjects [[_startPoint select 0, _startPoint select 1], ["Land_Device_disassembled_F"], 200];
while {count _devices < 2} do {
    _safePos = [_subPos, 5, 50, 1, 2, 15, 0] call BIS_fnc_findSafePos;
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
};

// doublecheck devices
_devices = nearestObjects [[_startPoint select 0, _startPoint select 1], ["Land_Device_disassembled_F"], 200];
if (count _devices < 2) then {
    for "_c" from 0 to 1 do { 
        _safePos = [_subPos, 5, 150, 1, 2, 15, 0] call BIS_fnc_findSafePos;
        _devicePos = [_safePos select 0, _safePos select 1, getTerrainHeightASL _safePos];
        _device = createVehicle ["Land_Device_disassembled_F", _devicePos, [], 0, "NONE"];
        _device allowDamage false;
        _device setMass 1000;
        _device setDir (random 360);    
        [_device, "QS_fnc_addActionBlock", nil, true] spawn BIS_fnc_MP;
        _chemlight = createVehicle ["Chemlight_red", _devicePos, [], 0, "NONE"];
        _unitsArray = _unitsArray + [_device, _chemlight];
    };
};

// spawn 5 SDVs
for "_c" from 0 to 4 do { 
    _safePos = [_subPos, 2, 50, 2, 2, 5, 0] call BIS_fnc_findSafePos;
    _sdv = createVehicle [([INFANTRY_SDV] call BIS_fnc_selectRandom), [0,0,0], [], 0, "NONE"];
    waitUntil {alive _sdv}; 
    _sdv setPos [_safePos select 0, _safePos select 1, getTerrainHeightASL _safePos];
    _sdv setDir (random 360);
    _unitsArray = _unitsArray + [_sdv];
};

// spawn 5 lights
for "_c" from 0 to 4 do { 
_safePos = [_subPos, 15, 40, 4, 2, 20, 0] call BIS_fnc_findSafePos;
    _light = createVehicle [(["Land_PortableLight_double_F","Land_PortableLight_single_F"] call BIS_fnc_selectRandom), [0,0,0], [], 0, "NONE"];
    _light setPos [_safePos select 0, _safePos select 1, getTerrainHeightASL _safePos];
    _light setDir (([_light, _submarine] call BIS_fnc_dirTo) + 180);
    _light setMass 20;
    _unitsArray = _unitsArray + [_light];
};

// spawn 2 groups of single divers
_diversGroup1 = createGroup ENEMY_SIDE;
for "_c" from 0 to 15 do { 
    _safePos = [(_subPos select 0) + (random 40) - 20, (_subPos select 1) + (random 40) - 20, 0];
    _height = getTerrainHeightASL _safePos;
    _r = [0.1,1.1,2.1,3.1,4.1,5.1,6.1,7.1,8.1,9.1,10.1,11.1,12.1,13.1,14.1,15.1] call BIS_fnc_selectRandom;
    _height = _height + _r;
    _diverPos = [(_safePos select 0), (_safePos select 1), _height];
    ([INFANTRY_DIVERS] call BIS_fnc_selectRandom) createUnit [[0,0,0], _diversGroup1, "currentGuard = this", 0, ([INFANTRY_RANK] call BIS_fnc_selectRandom)];
    waitUntil {alive currentGuard}; 
    currentGuard setPos _diverPos;
    currentGuard setDir (random 360);
    [currentGuard,(["WATCH","WATCH1","WATCH2"] call BIS_fnc_selectRandom),"FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;  
    removeAllWeapons currentGuard; 
    currentGuard addWeapon "arifle_SDAR_F";
    currentGuard addmagazines["20Rnd_556x45_UW_mag", 10];
};
_diversGroup1 setBehaviour "SAFE";
_diversGroup1 setCombatMode "RED";
[(units _diversGroup1)] call QS_fnc_setSkill3;
_enemiesArray = _enemiesArray + (units _diversGroup1);

_diversGroup2 = createGroup ENEMY_SIDE;
for "_c" from 0 to 25 do { 
    _safePos = [(_subPos select 0) + (random 300) - 150, (_subPos select 1) + (random 300) - 150, 0];
    _height = getTerrainHeightASL _safePos;
    _r = [0.1,1.1,2.1,3.1,4.1,5.1,6.1,7.1,8.1,9.1,10.1,11.1,12.1,13.1,14.1,15.1] call BIS_fnc_selectRandom;
    _height = _height + _r;
    _diverPos = [(_safePos select 0), (_safePos select 1), _height];
    ([INFANTRY_DIVERS] call BIS_fnc_selectRandom) createUnit [[0,0,0], _diversGroup2, "currentGuard = this", 0, ([INFANTRY_RANK] call BIS_fnc_selectRandom)];
    waitUntil {alive currentGuard}; 
    currentGuard setPos _diverPos;
    currentGuard setDir (random 360);
    [currentGuard,(["WATCH","WATCH1","WATCH2"] call BIS_fnc_selectRandom),"FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;  
    removeAllWeapons currentGuard; 
    currentGuard addWeapon "arifle_SDAR_F";
    currentGuard addmagazines["20Rnd_556x45_UW_mag", 10];
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
        ([INFANTRY_DIVERS] call BIS_fnc_selectRandom) createUnit [[0,0,0], _patrolGroup, "currentGuard = this", 0, ([INFANTRY_RANK] call BIS_fnc_selectRandom)];
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
};

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
        [] call QS_fnc_SMhintSUCCESS;                     

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
            [_x] spawn QS_fnc_SMdelete;
        } forEach [_enemiesArray, _unitsArray];
    };
    sleep 3;
};