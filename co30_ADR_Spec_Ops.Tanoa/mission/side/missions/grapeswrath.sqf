/*
Author:	ToxaBes
Description: download data from 3 data terminals in enemy town
*/

// define some keywords
#define INFANTRY_MISSION "Спецоперация: Гроздья Гнева (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_RANK "CAPTAIN","MAJOR","COLONEL"
#define INFANTRY_TERMINAL "Land_DataTerminal_01_F"
#define INFANTRY_VEHICLES "O_T_MRAP_02_hmg_ghex_F","O_T_MRAP_02_gmg_ghex_F","O_T_LSV_02_armed_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F","O_T_MBT_02_cannon_ghex_F"
#define INFANTRY_VEHICLE_CREW "O_T_Engineer_F"

// define private variables
private ["_enemiesArray", "_unitsArray", "_targets", "_position", "_flatPos", "_startPoint", "_briefing", "_goodPos", "_houseList", "_c", "_goodPoses", "_usedPoses", "_blackList", "_devicePos", "_nearestDevices", "_groundPos", "_dst", "_house", "_device", "_deviceDir", "_guardsCount", "_guardGroup", "_commonGroup", "_patrolGroup", "_vehGroup", "_randomPos", "_veh", "_viperSquadSpawned", "_showMarkers", "_markers", "_s", "_f", "_status", "_res", "_aliveBots", "_a", "_terPos", "_markerPos", "_markerName", "_marker", "_devicesLeft"];

_enemiesArray = [grpNull];
_unitsArray = [];

// format: [[zone x,y]]
_targets = [
    [[5479,4053]],
    [[11667,2694]],
    [[11273,5220]],
    [[12826,7414]],
    [[9553,13508]],
    [[5811,10489]],
    [[5710,10121]],
    [[8845,10207]],
    [[1837,11964]]
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
SM_GRAPESWRATH_SUCCESS = false; publicVariable "SM_GRAPESWRATH_SUCCESS";
SM_GRAPESWRATH_FAIL = false; publicVariable "SM_GRAPESWRATH_FAIL";

// show brief information
_briefing = "<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FFC107'>Гроздья Гнева</t><br/>____________________<br/>Противник получил контроль над нашим ударным орбитальным комплексом ""Гроздья Гнева"". Комплекс состоит из трех спутников, каждый имеет на вооружении волоконный лазер мощностью до 500 кВт способный уничтожать ракеты, БПЛА и пехоту. Вернуть контроль над спутниками можно только взломав терминалы управления. Командование назначило поисковую спецоперацию.<br/><br/>Ваша задача: выдвинуться в указанный район, провести поисковую операцию и взломать три терминала управления спутниками.</t>";
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSpecMission", "Гроздья Гнева"]; publicVariable "showNotification";
sideMissionUp = true; publicVariable "sideMissionUp";

// prepare positions
_goodPos = [];
_houseList = _flatPos nearObjects ["building", 190];
{
    _c = 0;
    while { format ["%1", _x buildingPos _c] != "[0,0,0]" } do {
        if (((_x buildingPos _c) select 2 < 2.5) and !(surfaceIsWater (_x buildingPos _c))) then {
            _goodPos set [(count _goodPos), [_x, _x buildingPos _c]];
        };
        _c = _c + 1;
    };
} forEach _houseList;
_goodPoses = _goodPos call QS_fnc_TBshuffle;
_usedPoses = [];
_blackList = [];
_devicePos = [0,0,0];
_nearestDevices = _flatPos nearObjects [INFANTRY_TERMINAL, 200];

// spawn 3 devices
while {count _nearestDevices < 3} do {
    _groundPos = selectRandom _goodPoses;
    _dst = _devicePos distance (_groundPos select 1);
    _dst = _dst + (floor (random 70));
    while {_dst < 30} do {
        _groundPos = selectRandom _goodPoses;
    };
    _house = _groundPos select 0;
    _devicePos = _groundPos select 1;
    _usedPoses pushBack _groundPos;
    _blackList pushBack _house;
    _device = createVehicle [INFANTRY_TERMINAL, [0,0,0], [], 0, "CAN_COLLIDE"];
    _device setPosATL _devicePos;
    _deviceDir = [_house, _device] call BIS_fnc_dirTo;
    _device setDir _deviceDir;
    _device setVariable ["GRAPESWRATH_HACKED", "", true];
    [_device,"blue","purple","orange"] call BIS_fnc_DataTerminalColor;
    [_device, "QS_fnc_addActionHack", nil, true] spawn BIS_fnc_MP;
    _device addMPEventHandler ["MPKilled", {
        SM_GRAPESWRATH_FAIL = true;
        publicVariable "SM_GRAPESWRATH_FAIL";
    }];
    _unitsArray = _unitsArray + [_device];
    _nearestDevices = _flatPos nearObjects [INFANTRY_TERMINAL, 200];

    // protect device with guards
    _guardsCount = selectRandom [3,4,5,6];
    _guardGroup = [(getPos _house), 8, _guardsCount, ENEMY_SIDE] call QS_fnc_FillBots;
    _enemiesArray = _enemiesArray + [_guardGroup];
    {
        _x addCuratorEditableObjects [[_device], true];
    } forEach allCurators;
};

// spawn house guards
_commonGroup = [_startPoint, 200, 50, ENEMY_SIDE, false, _blackList] call QS_fnc_FillBots;
_enemiesArray = _enemiesArray + [_commonGroup];

// patrols (2 bots)
for "_c" from 1 to 4 do {
    _groundPos = [_startPoint, 0, 10, 1, 0, 20, 0, [], [_startPoint]] call BIS_fnc_findSafePos;
    _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSentry")] call BIS_fnc_spawnGroup;
    [_patrolGroup, _startPoint, 90] call BIS_fnc_taskPatrol;
    _patrolGroup setBehaviour "SAFE";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill4;
    _enemiesArray = _enemiesArray + [_patrolGroup];
};

// patrols (4 bots)
for "_c" from 1 to 2 do {
    _groundPos = [_startPoint, 10, 110, 1, 0, 20, 0, [], [_startPoint]] call BIS_fnc_findSafePos;
    _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam")] call BIS_fnc_spawnGroup;
    [_patrolGroup, _startPoint, 50] call BIS_fnc_taskPatrol;
    _patrolGroup setBehaviour "SAFE";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill4;
    _enemiesArray = _enemiesArray + [_patrolGroup];
};

// spawn vehicles
{
    _vehGroup = createGroup ENEMY_SIDE;
    _randomPos = [[[_startPoint, 100], []], ["water", "out"]] call BIS_fnc_randomPos;
    _veh = _x createVehicle _randomPos;
    waitUntil{ !isNull _veh };
    INFANTRY_VEHICLE_CREW createUnit [_randomPos, _vehGroup];
    INFANTRY_VEHICLE_CREW createUnit [_randomPos, _vehGroup];
    INFANTRY_VEHICLE_CREW createUnit [_randomPos, _vehGroup];
    ((units _vehGroup) select 0) assignAsDriver _veh;
    ((units _vehGroup) select 0) moveInDriver _veh;
    ((units _vehGroup) select 1) assignAsGunner _veh;
    ((units _vehGroup) select 1) moveInGunner _veh;
    ((units _vehGroup) select 2) assignAsCommander _veh;
    ((units _vehGroup) select 2) moveInCommander _veh;
    _veh lock 3;
    [_vehGroup, _startPoint, 60] call BIS_fnc_taskPatrol;
    if (random 1 >= 0.3) then {
        _veh allowCrewInImmobile true;
    };
    _vehGroup setBehaviour "SAFE";
    _vehGroup setCombatMode "RED";
    [(units _vehGroup)] call QS_fnc_setSkill4;
    _enemiesArray = _enemiesArray + [_vehGroup];
} forEach [INFANTRY_VEHICLES];

_nearestDevices = _flatPos nearObjects [INFANTRY_TERMINAL, 200];
[_startPoint, 200, ["vehicles", "fire"]] call QS_fnc_addHades;

_viperSquadSpawned = false;
_showMarkers = false;
_markers = [];
while { sideMissionUp } do {
    if (!SM_GRAPESWRATH_SUCCESS && !SM_GRAPESWRATH_FAIL) then {
        _s = 0;
        _f = 0;
        {
            _status = _x getVariable "GRAPESWRATH_HACKED";
            switch (_status) do {
                case "hacked" : { _s = _s + 1; };
                case "failed" : { _f = _f + 1; };
                default {};
            };
            _res = _s + _f;
            if (_res == 3) then {
                if (_s > _f) then {
                    SM_GRAPESWRATH_SUCCESS = true;
                    publicVariable "SM_GRAPESWRATH_SUCCESS";
                } else {
                    SM_GRAPESWRATH_FAIL = true;
                    publicVariable "SM_GRAPESWRATH_FAIL";
                };
            };
        } forEach _nearestDevices;
        sleep 5;
        _aliveBots = 0;
        {
            if (side _x == ENEMY_SIDE) then {
                {
                    if (_startPoint distance2D _x <= 200) then {
                        _aliveBots = _aliveBots + 1;
                    };
                } forEach (units _x);
            };
        } forEach allGroups;
        if (_aliveBots < 6 && !_showMarkers) then {
            _a = 1;
            _showMarkers = true;
            {
                _terPos = getPos _x;
                _markerPos = [(_terPos select 0) + (random 30) - (random 30), (_terPos select 1) + (random 30) - (random 30)];
                _markerName = "markerT_" + (str _a);
                _marker = createMarker[_markerName, _markerPos];
                _markerName setMarkerColor "colorRed";
                _markerName setMarkerAlpha 0.5;
                _markerName setMarkerShape "ELLIPSE";
                _markerName setMarkerBrush "DIAGGRID";
                _markerName setMarkerSize [50, 50];
                _markers = _markers + [_markerName];
                _a = _a + 1;
            } forEach _nearestDevices;
            hqSideChat = "Проверьте карту - разведка обновила данные по терминалам"; publicVariable "hqSideChat"; [OUR_SIDE, "HQ"] sideChat hqSideChat;
        };
        sleep 5;
    };
    sleep 1;

    // Spawn Viper group
    if (!_viperSquadSpawned) then {
        if (!SM_GRAPESWRATH_SUCCESS and !SM_GRAPESWRATH_FAIL) then {
            {
                if (_x getVariable "GRAPESWRATH_HACKED" != "") exitWith {
                    _viperSquadSpawned = true;
                    if (random 1 > 0.5) then {
                        _devicesLeft = [];
                        {

                            _status = _x getVariable "GRAPESWRATH_HACKED";
                            if (_status == "") then {
                                _devicesLeft pushBack _x;
                            };
                        } forEach _nearestDevices;
                        _enemiesArray pushBack ([(getPos (selectRandom _devicesLeft)), 500, 500, 3000, true, ENEMY_SIDE] call QS_fnc_spawnViper);
                    };
                };
            } forEach _nearestDevices;
        };
    };
    sleep 1;

    // de-briefing
    if (SM_GRAPESWRATH_SUCCESS || SM_GRAPESWRATH_FAIL) exitWith {
        sideMissionUp = false; publicVariable "sideMissionUp";
        { _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
        if (SM_GRAPESWRATH_FAIL) then {
            [true] call QS_fnc_SMhintFAIL;
        } else {
            [true] call QS_fnc_SMhintSUCCESS;
        };
        if (_showMarkers) then {
            {
                deleteMarker _x;
            } forEach _markers;
        };
        sleep 120;
        {
            deleteVehicle _x;
        } forEach _unitsArray;
        sleep 2;
        {
            [_x] call QS_fnc_TBdeleteObjects;
        } forEach [_enemiesArray];
        [_startPoint, 500] call QS_fnc_DeleteEnemyEAST;
    };
    sleep 1;
};
