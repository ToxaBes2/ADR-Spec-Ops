/*
Author:	ToxaBes
Description: Secure helicopter crash area and find scout equipment.
*/

// define some keywords and definitions
#define INFANTRY_MISSION "Спецоперация: Прерванный полёт (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_PATROL "OIA_InfSquad","OIA_InfSquad_Weapons","OIA_InfTeam","OIA_InfTeam_AA","OIA_InfTeam_AT","OI_reconPatrol"
#define INFANTRY_STATIC "O_HMG_01_high_F","O_GMG_01_high_F"
#define INFANTRY_HOUSE "O_Soldier_AR_F","O_soldier_M_F","O_Soldier_TL_F"
#define INFANTRY_MOTORIZED "O_G_Offroad_01_armed_F"

// define all priviate variables
private ["_enemiesArray", "_targets", "_position", "_flatPos", "_startPoint", "_heliCoords", "_fullyRandom", "_heliPos", "_azimut", "_heliObj", "_distance", "_z", "_chemPosRed", "_chemlightRed", "_inHouse", "_goodPos", "_houseList", "_c", "_scoutPos", "_scoutBox", "_mkrScout", "_chemPosBlue", "_chemlightBlue", "_patrolGroup", "_randomPos", "_unitPos", "_houseGroup", "_sniperGroup", "_nearRoads", "_staticGroup", "_roadSegment", "_static", "_technicalGroup", "_technicalVehicle", "_guardsGroup", "_city", "_briefing", "_showSabotageMessage", "_showGetdataMessage", "_viperSquadSpawned"];

_enemiesArray = [grpNull];

// init area coords - we use 3 "interesting" landing places in each city with 40% of luck. Other 60% are random.
// format:
//  [city name,                          [center coords x,y,z],   [heli 1 crash x,y,z,azimut], [heli 2 crash x,y,z,azimut], [heli 3 crash x,y,z,azimut]]
_targets = [
    ["Заброшенная Военная База",         [6100.05,10761.3,20000], [6092.78,10767.3,0,190],     [6092.78,10767.3,0,190],     [6035.72,10778.6,12.6736,265]],
    ["Морэй",                            [920.701,11937.6,20000], [972.75,11963.9,0,336],      [942.895,11881.6,0,336],     [858.932,12000.1,0,336]], 
    ["Сент-Лиус",                        [7130.39,8962.39,20000], [7114.06,8914.95,0,262],     [7126.94,9086.02,0,262],     [7010.17,8962.38,0,262]],
    ["Ларше",                            [6047.04,8636.42,20000], [6039.61,8648.09,3.6,3],     [6009.04,8570.61,0,14],      [5956.93,8613.23,0,13]],
    ["Гуис",                             [3636.92,8688.72,20000], [3530.57,8531.13,0,13],      [3464.46,8545.77,0,120],     [3574.03,8431.82,0,120]],
    ["Эради",                            [5504.35,7010.48,20000], [5536.24,6889.69,1.75,307],  [5485.54,7080.56,0,150],     [5573.94,7002.3,0,307]],
    ["Ла Трините",                       [7275.07,7862.97,20000], [7184.85,7827.08,0,13],      [7330.82,7891,0,343],        [7196.36,8027.08,0,354]],
    ["Доурдан",                          [7041.61,7132.88,20000], [7059.04,7138.34,0,70],      [7148.94,7163.66,0,104],     [6984.49,7061.67,0,356]],
    ["Ла Пессане",                       [3103.38,6308.96,20000], [3169.21,6428.48,0,165],     [3222.45,6343.18,0,165],     [3146.83,6334.19,0,165]],
    ["Шапой",                            [5964.18,3516.45,20000], [5819.02,3600.61,0,165],     [5928.06,3489.86,0,165],     [5866.07,3624.32,0,227]],
    ["Порт",                             [8193.54,3191.24,20000], [8212,3162.36,0,165],        [8280.75,3203.33,0,82],      [8124.98,3201.18,0,165]],
    ["Ла Ривьер",                        [3725.69,3261.71,20000], [3805.67,3231.89,0,165],     [3697.62,3304.56,0,165],     [3799.52,3333.68,0,165]],
    ["Канкон",                           [5405.92,2802.72,20000], [5405.92,2802.72,0,170],     [5476.48,2792.24,0,170],     [5371.73,2838.72,0,128]],
    ["Военная База",                     [9724.35,3901.33,20000], [9739.51,3867.12,0,170],     [9708.67,3963.23,0,170],     [9765.16,3923.12,0,170]]
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
    _randomPos = [[[_startPoint, 200],[]],["water","out"]] call QS_fnc_randomPos;
    _patrolGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> selectRandom [INFANTRY_PATROL])] call BIS_fnc_spawnGroup;
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
        _randomPos = [_startPoint, 0, 180, 2, 0, 0.5, 0, [], [_startPoint]] call QS_fnc_findSafePos;
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
    _randomPos = [_startPoint, 800, 10, 50] call QS_fnc_findOverwatch;
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
        _roadSegment = selectRandom _nearRoads;
        _randomPos = getPos _roadSegment;
    } else {
        _randomPos = [_startPoint, 200, 10, 10] call QS_fnc_findOverwatch;
    };
    _static = selectRandom [INFANTRY_STATIC] createVehicle _randomPos;
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
        _roadSegment = selectRandom _nearRoads;
        _randomPos = getPos _roadSegment;
    } else {
        _randomPos = [[[_startPoint, 200],[]],["water","out"]] call QS_fnc_randomPos;
    };
    _technicalVehicle = selectRandom [INFANTRY_MOTORIZED] createVehicle _randomPos;
    waitUntil{!isNull _technicalVehicle};
    _technicalVehicle addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
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

// save info in DB
try {
    _position = format ["%1,%2", floor (_flatPos select 0), floor (_flatPos select 1)];
    ["setInfo",["spec_name", "Прерванный Полет"], 0] remoteExec ["sqlServerCall", 2];
    ["setInfo",["spec_position", _position], 0] remoteExec ["sqlServerCall", 2];
} catch {};

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
        deleteMarker _mkrScout;
    };
    sleep 1;

    // Spawn Viper group
    if (!_viperSquadSpawned) then {
        if (SM_SUCCESS_GETDATA) exitWith {
            _viperSquadSpawned = true;
            if (random 1 > 0.5) then {
                _enemiesArray pushBack ([_heliPos, 500, 500, 3000, false, ENEMY_SIDE] call QS_fnc_spawnViper);
            };
        };
        if (SM_SUCCESS_SABOTAGE or !alive _heliObj) exitWith {
            _viperSquadSpawned = true;
            if (random 1 > 0.5) then {
                _enemiesArray pushBack ([_scoutPos, 500, 500, 3000, false, ENEMY_SIDE] call QS_fnc_spawnViper);
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
        if (WIN_WEST > WIN_GUER) then {
            [4] spawn QS_fnc_bluforSUCCESS;
        } else {
            [4] spawn QS_fnc_partizanSUCCESS;
        };
        sleep 120;
        { [_x] call QS_fnc_TBdeleteObjects; } forEach [_enemiesArray, _guardsGroup];
        deleteMarker "scoutMarker";
        deleteVehicle _heliObj;
        [_startPoint, 500] call QS_fnc_DeleteEnemyEAST;
	};
	sleep 1;
};
