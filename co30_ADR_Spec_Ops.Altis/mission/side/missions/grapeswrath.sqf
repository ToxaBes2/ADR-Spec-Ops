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
#define INFANTRY_VEHICLES "O_MRAP_02_hmg_F","O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F","O_MBT_02_cannon_F"
#define INFANTRY_VEHICLE_CREW "O_engineer_F"

// define private variables
private ["_targets","_accepted","_distance","_briefing","_position","_flatPos","_x","_enemiesArray","_startPoint"];         

_enemiesArray = [grpNull];
_unitsArray = [];

// format: [[zone x,y]]
_targets = [
    [[3617,12848]],
    [[3587,13180]],
    [[3801,13711]],
    [[9023,12038]],
    [[10949,13424]],
    [[12505,14329]],
    [[14003,18694]],
    [[18098,15256]],
    [[20952,16961]],
    [[16812,12709]]
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
SM_GRAPESWRATH_SUCCESS = false; publicVariable "SM_GRAPESWRATH_SUCCESS";
SM_GRAPESWRATH_FAIL = false; publicVariable "SM_GRAPESWRATH_FAIL";

// show brief information
_briefing = "<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FF9999'>Гроздья Гнева</t><br/>____________________<br/>Противник получил контроль над нашим ударным орбитальным комплексом ""Гроздья Гнева"". Комплекс состоит из трех спутников, каждый имеет на вооружении волоконный лазер мощностью до 500 кВт способный уничтожать ракеты, БПЛА и пехоту. Вернуть контроль над спутниками можно только взломав терминалы управления. Командование назначило поисковую спецоперацию.<br/><br/>Ваша задача: выдвинуться в указанный район, провести поисковую операцию и взломать три терминала управления спутниками.</t>";
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSideMission", "Гроздья Гнева"]; publicVariable "showNotification";
sideMissionUp = true; publicVariable "sideMissionUp";

// prepare positions
_goodPos = [];
_houseList = _flatPos nearObjects ["building", 190];
{
    _c = 0;
    while { format ["%1", _x buildingPos _c] != "[0,0,0]" } do { 
        _goodPos set [(count _goodPos), [_x, _x buildingPos _c]];
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
    _groundPos = _goodPoses call BIS_fnc_selectRandom; 
    _dst = _devicePos distance (_groundPos select 1);    
    _dst = _dst + (floor (random 70));
    while {_dst < 30} do {
        _groundPos = _goodPoses call BIS_fnc_selectRandom;                
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
    _device allowDamage false;
    _unitsArray = _unitsArray + [_device];
    _nearestDevices = _flatPos nearObjects [INFANTRY_TERMINAL, 200];    

    // protect device with guards
    _guardsCount = [3,4,5,6] call BIS_fnc_selectRandom;
    _guardGroup = [(getPos _house), 8, _guardsCount, ENEMY_SIDE] call QS_fnc_FillBots;
    _enemiesArray = _enemiesArray + [_guardGroup];
};

// spawn house guards
_commonGroup = [_startPoint, 200, 50, ENEMY_SIDE, false, _blackList] call QS_fnc_FillBots;
_enemiesArray = _enemiesArray + [_commonGroup];

// patrols (2 bots)
for "_c" from 1 to 4 do { 
    _groundPos = [_startPoint, 0, 10, 2, 0, 10, 0] call BIS_fnc_findSafePos;
    _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSentry")] call BIS_fnc_spawnGroup;
    [_patrolGroup, _startPoint, 90] call BIS_fnc_taskPatrol;
    _patrolGroup setBehaviour "SAFE";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill4;
    _enemiesArray = _enemiesArray + [_patrolGroup];
};

// patrols (4 bots)
for "_c" from 1 to 2 do { 
    _groundPos = [_startPoint, 10, 110, 2, 0, 10, 0] call BIS_fnc_findSafePos;
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
while { sideMissionUp } do {
    sleep 3;
    
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
    };
    
    // de-briefing
    if (SM_GRAPESWRATH_SUCCESS || SM_GRAPESWRATH_FAIL) exitWith {  
        sideMissionUp = false; publicVariable "sideMissionUp";
        { _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
        if (SM_GRAPESWRATH_FAIL) then {
            [] call QS_fnc_SMhintFAIL;            
        } else {
            [] call QS_fnc_SMhintSUCCESS;                     
        };                  

        sleep 120;
        {
            deleteVehicle _x;
        } forEach _unitsArray;
        sleep 2;                
        { 
            [_x] spawn QS_fnc_SMdelete;
        } forEach [_enemiesArray];
    };
    sleep 3;
};
