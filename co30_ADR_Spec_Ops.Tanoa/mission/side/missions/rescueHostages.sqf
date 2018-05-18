/*
Author:	ToxaBes
Description: Secure area and rescue the hostages.
*/

// define some keywords
#define INFANTRY_MISSION "Спецоперация: Заложники (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_HOSTAGES "C_man_1_3_F","C_man_polo_1_F_afro","C_man_polo_2_F_euro"
#define INFANTRY_SUPPORT "O_T_Soldier_AR_F"
#define INFANTRY_PATROL "O_T_reconPatrol","O_T_InfTeam","O_T_InfTeam_AA","O_T_InfTeam_AT"
#define INFANTRY_STATIC "O_HMG_01_high_F","O_GMG_01_high_F"
#define INFANTRY_HOUSE "O_T_Soldier_AR_F","O_T_Soldier_M_F","O_T_Soldier_TL_F","O_T_Recon_LAT_F", "O_T_Recon_Medic_F", "O_T_Recon_JTAC_F"
#define INFANTRY_SNIPERS "O_T_ghillie_tna_F", "O_T_Recon_Exp_F", "O_T_Soldier_M_F", "O_T_Sniper_F"
#define INFANTRY_GUNNERS "O_T_Support_MG_F", "O_T_Support_GMG_F", "O_T_Support_AMG_F"
#define INFANTRY_OFFICER "O_T_Officer_F"

// define all priviate variables
private ["_enemiesArray", "_arr", "_cnt", "_targets", "_position", "_flatPos", "_startPoint", "_pos1", "_pos2", "_pos3", "_sign1", "_sign2", "_sign3", "_meters", "_unitsArray", "_minesArray", "_dir1", "_dir2", "_dir3", "_dir4", "_minePos", "_mine", "_height", "_c", "_cargoPos", "_cargoHQ", "_cargoHouses", "_cargoHouse", "_bunkerTowers", "_hostagesArray", "_houseGroup", "_hostagesGroup", "_hostagesPlaced", "_withHostages", "_unitPos", "_positions", "_holyRandom", "_commanderGroup", "_posATL", "_distance", "_staticGroup", "_static", "_y", "_patrolGroup", "_randomPos", "_initAngle", "_initDistance", "_startPos", "_i", "_newPos", "_wp", "_guardsGroup", "_bots", "_city", "_briefing", "_showHostagesMessage", "_showOfficerMessage", "_viperSquadSpawned", "_nearestMines"];

_enemiesArray = [grpNull];

// Thanks KK for fastest shuffle alghoritm
KK_fnc_arrayShufflePlus = {
    private ["_arr","_cnt"];
    _arr = _this select 0;
    _cnt = count _arr;
    for "_i" from 1 to (_this select 1) do {
        _arr pushBack (_arr deleteAt floor random _cnt);
    };
    _arr
};

// format: [city name,    [coords x,y]]
_targets = [
    ["Туванака",          [1805.49,11987.9]],
    ["Бельфор",           [3071.17,11136.1]],
    ["Каткоула",          [5479.27,4053.19]],
    ["Янукка",            [3010.93,3395.25]],
    ["Модергат",          [9413.66,4021.67]],
    ["Лиджинхавен",       [11639.7,2722.74]],
    ["Лиджинхавен",       [11788.1,2291.44]],
    ["Харкорт",           [11212.3,5230.01]],
    ["Котомо",            [10876.4,6303.11]],
    ["Оумере",            [12839.7,7439.41]],
    ["Ла-Рошель",         [9738.04,13511]],
    ["Ла-Рошель",         [9537.64,13538.2]],
    ["Джорджтаун",        [5765.85,10603.3]],
    ["Джорджтаун",        [5717.94,10236.1]],
    ["Джорджтаун",        [5623.16,9940.89]],
    ["Регина",            [5105.03,8621.51]],
    ["Сахарный завод",    [8349.19,10323.5]],
    ["Таноука",           [8878.71,10204.9]]
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

// set razorwire circles and mines
// _pos1, _pos2, _pos3, _sign1, _sign2, _sign3,_pos, _meters
_unitsArray = [];
_minesArray = [];
_dir1 = 180;
_dir2 = 180;
_dir3 = 180;
_dir4 = 180;
for "_c" from 0 to 109 do {
    _pos1 = [_startPoint, 180, _dir1] call BIS_fnc_relPos;
    _sign1 = createVehicle ["Land_Razorwire_F", [70,70,70], [], 0, "CAN_COLLIDE"];
    waitUntil {alive _sign1};
    _sign1 allowDamage false;
    _sign1 setDir _dir1;
    _sign1 setPos [_pos1 select 0, _pos1 select 1, 0];
    _sign1 setVectorUp (surfaceNormal (getPosATL _sign1));
    _pos = getPosATL _sign1;
    if (_pos select 2 > 0.2) then {
        _pos = [_pos select 0, _pos select 1, 0];
        _sign1 setPosATL _pos;
    };
    if ((random 10) > 1) then {
        _minePos = [_startPoint, 179.8, (_dir1 + 2.2)] call BIS_fnc_relPos;
        if (surfaceIsWater _minePos) then {
            _minePos = [_minePos select 0, _minePos select 1, getTerrainHeightASL _minePos];
            _mine = createMine ["UnderwaterMinePDM", [_minePos select 0, _minePos select 1], [], 0];
            waitUntil {alive _mine};
            _mine setPosATL [_minePos select 0,_minePos select 1, (getPosATL _mine select 2) - 2];
        } else {
            _mine = createMine ["APERSTripMine", [_minePos select 0, _minePos select 1, 0.1], [], 0];
            waitUntil {alive _mine};
            _mine setDir (_dir1 + 0.8);
            _pos = getPosATL _mine;
            if (_pos select 2 > 0.2) then {
                _pos = [_pos select 0, _pos select 1, 0];
                _mine setPosATL _pos;
            };
        };
        if (!isNil "_mine") then {
            _minesArray = _minesArray + [_mine];
        };
    };
    _dir1 = _dir1 + 3.3;
    _unitsArray = _unitsArray + [_sign1];

    _pos3 = [_startPoint, 200, _dir3] call BIS_fnc_relPos;
    _sign3 = createVehicle ["Land_Sign_Mines_F", [70,70,70], [], 0, "CAN_COLLIDE"];
    waitUntil {alive _sign3};
    _sign3 allowDamage false;
    _sign3 setDir _dir3;
    _sign3 setPos [_pos3 select 0, _pos3 select 1, 0];
    _dir3 = _dir3 + 3.6;
    _sign3 setDir ((getDir _sign3) + 180);
    _pos = getPosATL _sign3;
    if (_pos select 2 > 0.2) then {
        _pos = [_pos select 0, _pos select 1, 0];
        _sign3 setPosATL _pos;
    };
    _unitsArray = _unitsArray + [_sign3];

    _minePos = [_startPoint, 190, _dir4] call BIS_fnc_relPos;
    if (surfaceIsWater _minePos) then {
        _height = random (floor ((getTerrainHeightASL _minePos) * -1));
        _pos = [_minePos select 0, _minePos select 1, (0 - _height)];
        _mine = createMine ["UnderwaterMine", _pos, [], 0];
    } else {
        _mine = createVehicle ["ATMine", [40,40,40], [], 0, "CAN_COLLIDE"];
        waitUntil {alive _mine};
        _mine setPos [_minePos select 0, _minePos select 1, 0];
        _pos = getPosATL _mine;
        if (_pos select 2 > 0.2) then {
            _pos = [_pos select 0, _pos select 1, 0];
            _mine setPosATL _pos;
        };
    };
    _dir4 = _dir4 + 3.45;
    if (!isNil "_mine") then {
        _minesArray = _minesArray + [_mine];
    };

    if (_c <= 56) then {
        _pos2 = [_flatPos, 90, _dir2] call BIS_fnc_relPos;
        _sign2 = createVehicle ["Land_Razorwire_F", [40,40,40], [], 0, "CAN_COLLIDE"];
        waitUntil {alive _sign2};
        _sign2 allowDamage false;
        _sign2 setDir _dir2;
        _sign2 setPos [_pos2 select 0, _pos2 select 1, 0];
        _sign2 setVectorUp (surfaceNormal (getPosATL _sign2));
        _pos = getPosATL _sign2;
        if (_pos select 2 > 0.2) then {
            _pos = [_pos select 0, _pos select 1, 0];
            _sign2 setPosATL _pos;
        };
        if ((random 10) > 2) then {
            _minePos = [_startPoint, 89.8, (_dir2 + 5)] call BIS_fnc_relPos;
            _mine = createMine ["APERSBoundingMine", [_minePos select 0, _minePos select 1, 0.1], [], 0];
            waitUntil {alive _mine};
            _mine setDir (_dir2 + 1.5);
            _pos = getPosATL _mine;
            if (_pos select 2 > 0.2) then {
                _pos = [_pos select 0, _pos select 1, 0];
                _mine setPosATL _pos;
            };
            if (!isNil "_mine") then {
                _minesArray = _minesArray + [_mine];
            };
        };
        _dir2 = _dir2 + 6.5;
        _unitsArray = _unitsArray + [_sign2];
        _sign2 enableSimulation false;
    };
    _sign1 enableSimulation false;
};
_unitsArray = _unitsArray + _minesArray;

// set Cargo HQ
_cargoPos = [_startPoint, 0, 85, 2, 0, 5, 0, [], [_startPoint]] call QS_fnc_findSafePos;
_cargoHQ = createVehicle ["Land_Cargo_HQ_V4_F", _cargoPos, [], 0, "CAN_COLLIDE"];
_unitsArray = _unitsArray + [_cargoHQ];

// set 3 Cargo Houses
_cargoHouses = [];
for "_i" from 1 to 3 do {
    _cargoPos = [_startPoint, 0, 85, 2, 0, 5, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    _cargoHouse = createVehicle ["Land_Cargo_House_V4_F", _cargoPos, [], 0, "CAN_COLLIDE"];
    _cargoHouses = _cargoHouses + [_cargoHouse];
};
_unitsArray = _unitsArray + _cargoHouses;

// Add cargo houses to Zeus
{
	_x addCuratorEditableObjects [_cargoHouses + [_cargoHQ], false];
} foreach allCurators;

// set 6 Bag Bunkers for static guards
_bunkerTowers = [];
for "_i" from 1 to 6 do {
    _cargoPos = [_startPoint, 100, 170, 3, 0, 2, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    _cargoHouse = createVehicle ["Land_BagBunker_01_small_green_F", _cargoPos, [], 0, "CAN_COLLIDE"];
    _cargoHouse setDir ([_cargoHouse, _startPoint] call BIS_fnc_dirTo);
    _bunkerTowers = _bunkerTowers + [_cargoHouse];
};
_unitsArray = _unitsArray + _bunkerTowers;

// spawn enemies and hostages
_enemiesArray = [grpNull];
_hostagesArray = [grpNull];

// hostages with guards
_houseGroup = createGroup ENEMY_SIDE;
_hostagesGroup = createGroup Civilian;
_hostagesPlaced = 0;
_withHostages = false;
_unitPos = ["UP", "MIDDLE"];
{
    _positions = [([_x] call QS_fnc_FindPosBuilding), 7] call KK_fnc_arrayShufflePlus;
    {
        _pos = [(_x select 0), (_x select 1), (_x select 2)];
        _holyRandom = floor random 10;
        if (_hostagesPlaced < 4) then {
            (selectRandom [INFANTRY_HOSTAGES]) createUnit [_pos, _hostagesGroup, "currentHostage = this"];            
            currentHostage allowDamage false;
            currentHostage setVariable ["NOAI", true, true];
            currentHostage setVariable ["zbe_cacheDisabled", true, true];
            doStop currentHostage;
            commandStop currentHostage;
            currentHostage setPosASL _pos;
            currentHostage setDir (_x select 3);
            currentHostage setCaptive true;
            currentHostage setUnitPos (selectRandom _unitPos);
            currentHostage disableAI "ANIM";
            currentHostage disableAI "MOVE";
            currentHostage addEventHandler ["killed", {SM_FAIL_RESCUE = SM_FAIL_RESCUE + 1;publicVariable "SM_FAIL_RESCUE";[(_this select 0),"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;(_this select 0) removeWeapon "hgun_Rook40_F";}];
            [currentHostage, "QS_fnc_addActionRescue",nil,true] spawn BIS_fnc_MP;
            _hostagesPlaced = _hostagesPlaced + 1;
            _withHostages = true;
        } else {
            if (_holyRandom > 3 || _withHostages) then {
                (selectRandom [INFANTRY_SUPPORT]) createUnit [_pos, _houseGroup, "currentGuard = this"];
                currentGuard allowDamage false;
                currentGuard setVariable ["NOAI", true, true];
                currentGuard setVariable ["zbe_cacheDisabled", true, true];
                doStop currentGuard;
                commandStop currentGuard;
                currentGuard setPosASL _pos;
                currentGuard setDir (_x select 3);
                currentGuard setUnitPos (selectRandom _unitPos);
                currentGuard disableAI "MOVE";
                currentGuard addEventHandler ["hit", {(_this select 0) enableAI "MOVE";}];
                _withHostages = false;
                currentGuard allowDamage true;
            };
        };
    } forEach _positions;
} forEach _cargoHouses;

// officer
_commanderGroup = createGroup ENEMY_SIDE;

_posATL = _cargoHQ buildingPos (selectRandom [1,6]);
_posATL = [(_posATL select 0), (_posATL select 1), ((_posATL select 2) + 0.2)];
(selectRandom [INFANTRY_OFFICER]) createUnit [[1,1,0], _commanderGroup, "officer = this"];
waitUntil{!isNull officer};
officer allowDamage false;
officer setVariable ["NOAI", true, true];
officer setVariable ["zbe_cacheDisabled", true, true];
officer setPos _posATL;
doStop officer;
commandStop officer;
officer disableAI "MOVE";
officer addEventHandler ["hit", {(_this select 0) enableAI "MOVE";}];
officer setDir (random 360);
officer setUnitPos (selectRandom _unitPos);
removeHeadgear officer;
officer addHeadgear "H_Cap_red";
sleep 0.5;
_distance = [_posATL, getPos officer] call BIS_fnc_distance2D;
if (_distance > 100) then {
    _posATL = [(getPos _cargoHQ), 0, 20, 3, 0, 15, 0, [], [(getPos _cargoHQ)]] call QS_fnc_findSafePos;
    officer setPos _posATL;
};
officer allowDamage true;

//damage trigger
CAN_DAMAGE_HOSTAGES = false; publicVariable "CAN_DAMAGE_HOSTAGES";
_triggerPos = getPosATL ((units _hostagesGroup) select 0);
_triggerPos set [2,0];
_trig1 = createTrigger ["EmptyDetector", _triggerPos, true];
_trig1 setTriggerArea [40, 40, 0, false, 20];
_trig1 setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trig1 setTriggerStatements ["this", "[] call QS_fnc_enableHostagesDamage", ""];

[_hostagesGroup, officer] spawn {
    _hostagesGroup = _this select 0;
    _officer = _this select 1;
    while {!CAN_DAMAGE_HOSTAGES && alive _officer} do {
        sleep 5;
    };
    {
        _x allowDamage true;
        _x enableAI "ANIM";
    } forEach (units _hostagesGroup);
};

// guards with static weapons on cargoHQ
_staticGroup = createGroup ENEMY_SIDE;
{
    _posATL = _cargoHQ buildingPos _x;
    _posATL = [(_posATL select 0), (_posATL select 1), ((_posATL select 2) + 0.2)];
    _static = (selectRandom [INFANTRY_STATIC]) createVehicle [10,10,10];
    waitUntil{!isNull _static};
    _static allowDamage false;
    _static setPos _posATL;
    _static setDir (random 360);
    (selectRandom [INFANTRY_GUNNERS]) createUnit [[10,10,10], _staticGroup, "currentGuard = this"];
    currentGuard allowDamage false;
    sleep 0.2;
    currentGuard assignAsGunner _static;
    currentGuard moveInGunner _static;
    _static setVectorUp [0,0,1];
    _static lock 3;
    _enemiesArray = _enemiesArray + [_static];
    currentGuard allowDamage true;
    _static allowDamage true;
    _static = nil;
} forEach [5,7];

// other guards in cargoHQ
{
    _y = 0;
    _posATL = _cargoHQ buildingPos _x;
    _posATL = [(_posATL select 0), (_posATL select 1), (_posATL select 2) + 0.3];
    (selectRandom [INFANTRY_HOUSE]) createUnit [[10,10,10], _houseGroup, "currentGuard = this"];
    currentGuard allowDamage false;
    currentGuard setVariable ["NOAI", true, true];
    currentGuard setVariable ["zbe_cacheDisabled", true, true];
    sleep 0.1;
    currentGuard setPos _posATL;
    doStop currentGuard;
    commandStop currentGuard;
    currentGuard disableAI "MOVE";
    currentGuard addEventHandler ["hit", {(_this select 0) enableAI "MOVE";}];
    if (_x == 0) then {
        _y = 180;
    };
    if (_x == 2 || _x == 11) then {
        _y = -20;
    };
    currentGuard setDir (([currentGuard, _cargoHQ] call BIS_fnc_dirTo) + _y);
    currentGuard setUnitPos (selectRandom _unitPos);
    currentGuard allowDamage true;
} forEach [0,2,3,4,8,9,10,11];

// guards in small bunkers
{
    _posATL = getPos _x;
    _posATL = [(_posATL select 0), (_posATL select 1), (_posATL select 2) + 0.2];
    _static = (selectRandom [INFANTRY_STATIC]) createVehicle [10,10,10];
    waitUntil{!isNull _static};
    _static allowDamage false;
    _static setPos _posATL;
    _static setDir (([_static, _startPoint] call BIS_fnc_dirTo) + 180);
    (selectRandom [INFANTRY_GUNNERS]) createUnit [[10,10,10], _staticGroup, "currentGuard = this"];
    currentGuard allowDamage false;
    sleep 0.1;
    currentGuard assignAsGunner _static;
    currentGuard moveInGunner _static;
    _static setVectorUp [0,0,1];
    _static lock 3;
    _enemiesArray = _enemiesArray + [_static];
    currentGuard allowDamage true;
    _static allowDamage true;
    _static = nil;
} forEach _bunkerTowers;

// spawn infantry patrols inside second wire level
for "_x" from 1 to 2 do {
    _patrolGroup = createGroup ENEMY_SIDE;
    _randomPos = [[[_startPoint, 80],[]],["water","out"]] call QS_fnc_randomPos;
    _patrolGroup = [_randomPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> selectRandom [INFANTRY_PATROL])] call BIS_fnc_spawnGroup;
    _patrolGroup setBehaviour "COMBAT";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill3;
    [_patrolGroup, _startPoint, 150] call BIS_fnc_taskPatrol;
    _enemiesArray = _enemiesArray + [_patrolGroup];
    {
        _x addItem "MineDetector";
    } forEach (units _patrolGroup);
};

// spawn infantry patrols between wire levels
for "_x" from 1 to 2 do {
    _patrolGroup = createGroup ENEMY_SIDE;
    _initAngle = (random 360);
    _initDistance = 135;
    if (_x == 2) then {
        _initDistance = _initDistance + 30;
    };
    _startPos = [_startPoint, _initDistance, _initAngle] call BIS_fnc_relPos;
    _patrolGroup = [_startPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> selectRandom [INFANTRY_PATROL])] call BIS_fnc_spawnGroup;
    _patrolGroup setBehaviour "COMBAT";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill3;
    _enemiesArray = _enemiesArray + [_patrolGroup];
    {
        _x addItem "MineDetector";
    } forEach (units _patrolGroup);
    for "_i" from 0 to 6 do
    {
        if (_i == 1) then {
            _initAngle = _initAngle + 45;
        } else {
            _initAngle = _initAngle - 45;
        };
        _newPos = [_startPoint, _initDistance, _initAngle] call BIS_fnc_relPos;
        _wp = _patrolGroup addWaypoint [_newPos, 0];
        _wp setWaypointType "MOVE";
        _wp setWaypointCompletionRadius 15;
        if (_i == 0) then
        {
            _wp setWaypointSpeed "LIMITED";
            _wp setWaypointFormation "STAG COLUMN";
        };
    };
    _wp = _patrolGroup addWaypoint [_startPos, 0];
    _wp setWaypointType "CYCLE";
    _wp setWaypointCompletionRadius 15;
};

// set all mines positions as "known" for enemies
{
    if ((typeOf _x) isKindOf "TimeBombCore") then {
        ENEMY_SIDE revealMine _x;
    };
} forEach _minesArray;

// set skills and behaviour
_hostagesArray = _hostagesArray + [_hostagesGroup];

_commanderGroup setBehaviour "COMBAT";
_commanderGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_commanderGroup];

_staticGroup setBehaviour "COMBAT";
_staticGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_staticGroup];

_houseGroup setBehaviour "COMBAT";
_houseGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_houseGroup];

[(units _commanderGroup)] call QS_fnc_setSkill3;
[(units _houseGroup)] call QS_fnc_setSkill3;
[(units _staticGroup)] call QS_fnc_setSkill3;
[(units _hostagesGroup)] call QS_fnc_setSkill3;

_guardsGroup = [_startPoint, 350, 40, ENEMY_SIDE] call QS_fnc_FillBots;

// add NV googles to all bots
_bots = _startPoint nearObjects ["Man", 400];
{
    if (side _x == ENEMY_SIDE) then {
        if !("NVGoggles_OPFOR" in (assignedItems _x)) then {
            _x addItem "NVGoggles_OPFOR";
            _x assignItem "NVGoggles_OPFOR";
        };
    };
} forEach _bots;

// show brief information
_city = _position select 0;
_briefing = format ["<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FFC107'>Заложники</t><br/>____________________<br/>Отряд противника занял %1 и превратил его в укрепрайон. По приказу командира отряда часть местного населения была взята в заложники. Мы также получили ультиматум - покинуть остров в следующие 24 часа, в противном случае заложники будут убиты. Командование назначило пехотную спецоперацию<br/><br/>Ваша задача — выдвинуться в указанный район, обезвредить противника и освободить заложников. Будьте осторожны - противник имеет приказ уничтожить заложников в случае ликвидации командира.</t>", _city];
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSpecMission", "Заложники"]; publicVariable "showNotification";

sideMissionUp = true; publicVariable "sideMissionUp";
SM_FAIL = false; publicVariable "SM_FAIL";
SM_FAIL_RESCUE = 0; publicVariable "SM_FAIL_RESCUE";
SM_SUCCESS_RESCUE = 0; publicVariable "SM_SUCCESS_RESCUE";
SM_SUCCESS_HOSTAGES = false; publicVariable "SM_SUCCESS_HOSTAGES";
SM_SUCCESS_OFFICER = false; publicVariable "SM_SUCCESS_OFFICER";
_showHostagesMessage = true;
_showOfficerMessage = true;
_viperSquadSpawned = false;
[_startPoint, 200, ["vehicles", "fire"]] call QS_fnc_addHades;

// save info in DB
try {
    _position = format ["%1,%2", floor (_flatPos select 0), floor (_flatPos select 1)];
    ["setInfo",["spec_name", "Заложники"], 0] remoteExec ["sqlServerCall", 2];
    ["setInfo",["spec_position", _position], 0] remoteExec ["sqlServerCall", 2];
} catch {};

if !(isNil "PARTIZAN_BASE_SCORE") then {
    if (PARTIZAN_BASE_SCORE > 33) then {
        _taskMarker1 = createMarker ["TASK_MARKER1", [0,0]];
        _taskMarker1 setMarkerColor "ColorRed";
        _taskMarker1 setMarkerType "mil_dot";
        [_taskMarker1, 0] remoteExec ["setMarkerAlphaLocal", west, true];
        [_taskMarker1, 1] remoteExec ["setMarkerAlphaLocal", resistance, true];
        _taskMarker1 setMarkerPos (getPos officer);

        _taskMarker2 = createMarker ["TASK_MARKER2", [0,0]];
        _taskMarker2 setMarkerColor "ColorRed";
        _taskMarker2 setMarkerType "mil_dot";
        [_taskMarker2, 0] remoteExec ["setMarkerAlphaLocal", west, true];
        [_taskMarker2, 1] remoteExec ["setMarkerAlphaLocal", resistance, true];
        _taskMarker2 setMarkerPos (getPos (leader _hostagesGroup));
    };
};

while { sideMissionUp } do {
    // hostages done
    if (_showHostagesMessage && {(SM_FAIL_RESCUE + SM_SUCCESS_RESCUE) == 4}) then {
        if (SM_SUCCESS_RESCUE >= 2) then {
            SM_SUCCESS_HOSTAGES = true;
            if (SM_SUCCESS_OFFICER) then {
                hqSideChat = format ["%1 из 4х заложников спасены!", SM_SUCCESS_RESCUE];
            } else {
                hqSideChat = format ["%1 из 4х заложников спасены! Уничтожьте вражеского командира.", SM_SUCCESS_RESCUE];
            };
            publicVariable "hqSideChat"; [OUR_SIDE,"HQ"] sideChat hqSideChat;
        };
        if (SM_FAIL_RESCUE > 2) then {
            hqSideChat = format ["%1 из 4х заложников погибли!", SM_FAIL_RESCUE];
            publicVariable "hqSideChat"; [OUR_SIDE,"HQ"] sideChat hqSideChat;
            SM_FAIL = true; publicVariable "SM_FAIL";
        };
        _showHostagesMessage = false;
    };
    sleep 1;

    if (count units _hostagesGroup == 0) then {
        if ((SM_FAIL_RESCUE + SM_SUCCESS_RESCUE) < 4) then {
            SM_FAIL_RESCUE = 4 - SM_SUCCESS_RESCUE;
            publicVariable "SM_FAIL_RESCUE";
        };
    };
    sleep 1;

    // officer killed
    if ((!alive officer || (lifeState officer == "DEAD")) && _showOfficerMessage) then {
        SM_SUCCESS_OFFICER = true; publicVariable "SM_SUCCESS_OFFICER";
        if (SM_SUCCESS_HOSTAGES) then {
            hqSideChat = "Вражеский командир уничтожен!";
        } else {
            hqSideChat = "Вражеский командир уничтожен. Противник пытается ликвидировать заложников!";
            {
                _x setCaptive false;
                _x addRating -10000;
                _x addWeapon "hgun_Rook40_F";
            } foreach (units _hostagesGroup);
        };
        publicVariable "hqSideChat"; [OUR_SIDE,"HQ"] sideChat hqSideChat;
        _showOfficerMessage = false;

        // kill order
        sleep 5;
        {
            ENEMY_SIDE setFriend [CIVILIAN, 0];
            sleep 1;
            _x enableAI "AUTOTARGET";
            _x enableAI "MOVE";
        } foreach (units _houseGroup);
    };
    sleep 1;

    // Spawn Viper group
    if (!_viperSquadSpawned) then {
        if ((!alive officer) or (SM_FAIL_RESCUE > 0) or (SM_SUCCESS_RESCUE > 0)) then {
            _viperSquadSpawned = true;
            if (random 1 > 0.5) then {
                _enemiesArray pushBack ([(getPos _cargoHQ), 500, 500, 3000, true, ENEMY_SIDE] call QS_fnc_spawnViper);
            };
        };
    };
    sleep 1;

    // de-briefing
    if ((SM_SUCCESS_HOSTAGES && SM_SUCCESS_OFFICER) || SM_FAIL) exitWith {
        sideMissionUp = false; publicVariable "sideMissionUp";
        { _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
        if (SM_FAIL) then {
            [true] call QS_fnc_SMhintFAIL;
        } else {
            if (WIN_WEST > WIN_GUER) then {
                [4] spawn QS_fnc_bluforSUCCESS;
            } else {
                [4] spawn QS_fnc_partizanSUCCESS;
            };
        };

        // delete mines
        {
            if (_x distance _startPoint < 300) then {
               deleteVehicle _x;
            };
        } forEach allMines;
        _nearestMines = nearestObjects [_startPoint, ["ATMine","APERSTripMine","APERSBoundingMine","UnderwaterMinePDM","UnderwaterMine"], 300];
        {
            deleteVehicle _x;
        } forEach _nearestMines;
        deleteMarker "TASK_MARKER1";
        deleteMarker "TASK_MARKER2";
        sleep 120;
        { [_x] call QS_fnc_TBdeleteObjects; } forEach [_enemiesArray, _unitsArray, _guardsGroup];
        [_startPoint, 500] call QS_fnc_DeleteEnemyEAST;
    };
    sleep 1;
    deleteVehicle _trig1;
};
