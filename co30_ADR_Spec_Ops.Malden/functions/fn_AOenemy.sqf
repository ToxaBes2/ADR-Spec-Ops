/*
@file: QS_fnc_AOenemy.sqf
Author:	Quiksilver (credits: Ahoyworld.co.uk. Rarek et al for AW_fnc_spawnUnits.)
Description: Spawn enemies in the AO.
*/
#define INF_TYPE "OIA_InfSentry","OIA_InfSquad","OIA_InfSquad_Weapons","OIA_InfTeam","OIA_InfTeam_AA","OIA_InfTeam_AT","OI_reconPatrol","OI_reconSentry","OI_reconTeam"
#define INF_URBANTYPE "OIA_GuardSentry","OIA_GuardSquad","OIA_GuardTeam"
#define MRAP_TYPE "O_MRAP_02_gmg_F","O_MRAP_02_hmg_F"
#define VEH_TYPE "O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","O_MBT_04_cannon_F","O_MBT_04_command_F","I_LT_01_AT_F","I_LT_01_scout_F","I_LT_01_cannon_F"
#define AIR_TYPE "O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","I_Heli_light_03_F","O_Heli_Light_02_F"
#define STATIC_TYPE "O_HMG_01_F","O_HMG_01_high_F","O_Mortar_01_F"
#define ENEMY_SIDE EAST
#define ENEMY_SIDE_STR "EAST"

private ["_enemiesArray","_randomPos","_patrolGroup","_AOvehGroup","_AOveh","_AOmrapGroup","_AOmrap","_pos","_spawnPos","_overwatchGroup","_x","_staticGroup","_static","_aaGroup","_aa","_airGroup","_air","_sniperGroup","_staticDir","_currentGuard","_randPos"];

_pos = getMarkerPos (_this select 0);
_bunkerPos = _this select 1;
_flatPos = _this select 2;
_hasMines = _this select 3;
_bunkerType = _this select 4;
_avanpostPos = _this select 5;
_enemiesArray = [grpNull];

// enemies in bunker
if (_bunkerType == 1) then {
    _bunkerGroup = [_bunkerPos, 40, 15, ENEMY_SIDE] call QS_fnc_FillBots;
    _enemiesArray = _enemiesArray + [_bunkerGroup];

    for "_i" from 1 to 2 do {
        _groundPos = [_bunkerPos, 10, 50, 2, 0, 10, 0, [], [_bunkerPos]] call QS_fnc_findSafePos;
        _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> ENEMY_SIDE_STR >> "OPF_F" >> "UInfantry" >> "OIA_GuardSentry")] call BIS_fnc_spawnGroup;
        [_patrolGroup, true] call QS_fnc_moveToHC;
        {
            _currentGuard = _x;
            [_currentGuard,(selectRandom ["WATCH1","WATCH2"]),"FULL", {_currentGuard findNearestEnemy (getPos _currentGuard) != objNull || lifestate _currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
        } forEach (units _patrolGroup);
        _patrolGroup setBehaviour "COMBAT";
        _patrolGroup setCombatMode "RED";
        [(units _patrolGroup)] call QS_fnc_setSkill3;
        _enemiesArray = _enemiesArray + [_patrolGroup];
    };
} else {
	_staticObjects = nearestObjects [_bunkerPos, ["O_HMG_01_high_F"], 45];
    {
        _staticGroup = createGroup ENEMY_SIDE;
        "O_support_MG_F" createUnit [(getPos _x), _staticGroup, "[this] call QS_fnc_moveToHC;"];
        ((units _staticGroup) select 0) assignAsGunner _x;
        ((units _staticGroup) select 0) moveInGunner _x;
        _staticGroup setBehaviour "COMBAT";
    	_staticGroup setCombatMode "RED";
    	[(units _staticGroup)] call QS_fnc_setSkill3;
    	_enemiesArray = _enemiesArray + [_staticGroup];
    } forEach _staticObjects;
    _smallBunkers = nearestObjects [_bunkerPos, ["Land_BagBunker_Small_F"], 30];
    _bunkerGroup = [_bunkerPos, 10, 6, ENEMY_SIDE, false, _smallBunkers] call QS_fnc_FillBots;
    _enemiesArray = _enemiesArray + [_bunkerGroup];

    // add guards inside bunker
    //  ["unit class", distance from center, relative dir, eye dir, delta z]
    _units = [
        ["O_soldierU_TL_F", 25, 94, 90, 0],
        ["O_Urban_Sharpshooter_F", 25, 86, 90, 0],
        ["O_Urban_HeavyGunner_F", 16, 90, 90, 0],
        ["O_SoldierU_GL_F", 20, 330, 90, 0],
        ["O_Urban_Sharpshooter_F", 22, 230, 0, 0],
        ["O_Urban_HeavyGunner_F", 12, 230, 110, 0],
        ["O_Urban_Sharpshooter_F", 12, 140, 260, 0]
    ];
    _guardGroup = createGroup ENEMY_SIDE;
    {
        _unitType = _x select 0;
        _len = _x select 1;
        _dir = _x select 2;
        _unitDir = _x select 3;
        _deltaZ = _x select 4;
        _unitPos = [_bunkerPos, _len, _dir] call BIS_fnc_relPos;
        _unitPos set [2, _deltaZ];
        _unitType createUnit [_unitPos, _guardGroup, "[this] call QS_fnc_moveToHC;currentGuard = this;", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
        currentGuard setVariable ["BIS_enableRandomization", false];
        currentGuard allowDamage false;
        currentGuard setPos _unitPos;
        currentGuard setDir _unitDir;
        doStop currentGuard;
        currentGuard setUnitPos "UP";
        currentGuard setBehaviour "SAFE";
        currentGuard allowDamage true;
    } forEach _units;
    _guardGroup setBehaviour "COMBAT";
    _guardGroup setCombatMode "RED";
    [(units _guardGroup)] call QS_fnc_setSkill3;
    _enemiesArray = _enemiesArray + [_guardGroup];
    _guardGroup = [_bunkerPos, 50, ENEMY_SIDE] call QS_fnc_FillCargoPatrol;
    _enemiesArray = _enemiesArray + [_guardGroup];
};

// patrols (2x2 bots)
for "_i" from 1 to 2 do {
    _groundPos = [_bunkerPos, 40, 80, 2, 0, 10, 0, [], [_bunkerPos]] call QS_fnc_findSafePos;
    _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> ENEMY_SIDE_STR >> "OPF_F" >> "UInfantry" >> "OIA_GuardSentry")] call BIS_fnc_spawnGroup;
    [_patrolGroup, true] call QS_fnc_moveToHC;
    [_patrolGroup, _bunkerPos, 25] call BIS_fnc_taskPatrol;
    _patrolGroup setBehaviour "COMBAT";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill3;
    _enemiesArray = _enemiesArray + [_patrolGroup];
};

// enemies near radiotower
if (_hasMines) then {
    _campGroup = [_flatPos, 100, ENEMY_SIDE] call QS_fnc_FillCargoPatrol;
    _enemiesArray = _enemiesArray + [_campGroup];
	_campPatrolGroup = [_flatPos, 70, 5, ENEMY_SIDE] call QS_fnc_FillBots;
    _enemiesArray = _enemiesArray + [_campPatrolGroup];
} else {
    _campGroup = [_flatPos, 50, 10, ENEMY_SIDE] call QS_fnc_FillBots;
    _enemiesArray = _enemiesArray + [_campGroup];

    // patrols (2x2 bots)
    for "_i" from 1 to 2 do {
        _groundPos = [_flatPos, 0, 40, 2, 0, 10, 0, [], [_flatPos]] call QS_fnc_findSafePos;
        _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> ENEMY_SIDE_STR >> "OPF_F" >> "UInfantry" >> "OIA_GuardSentry")] call BIS_fnc_spawnGroup;
        [_patrolGroup, true] call QS_fnc_moveToHC;
        [_patrolGroup, _flatPos, 25] call BIS_fnc_taskPatrol;
        _patrolGroup setBehaviour "COMBAT";
        _patrolGroup setCombatMode "RED";
        [(units _patrolGroup)] call QS_fnc_setSkill3;
        _enemiesArray = _enemiesArray + [_patrolGroup];
    };
};

// add bots to buildings in zone
_blackList = [];
_objects = _flatPos nearObjects ["building", 65];
_blackList = _blackList + _objects;
_objects = _bunkerPos nearObjects ["building", 65];
_blackList = _blackList + _objects;
_buildingGroup = [_pos, (PARAMS_AOSize / 2), 30, ENEMY_SIDE, false, _blackList] call QS_fnc_FillBots;
_enemiesArray = _enemiesArray + [_buildingGroup];

// add units to avanpost
if (count _avanpostPos > 0) then {
    _staticGroup = createGroup ENEMY_SIDE;
    _avanpostTurrets = _avanpostPos nearObjects ["StaticWeapon", 50];
    {
        _static = _x;
        "O_support_MG_F" createUnit [[1,1,1], _staticGroup, "currentGuard = this;", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
        currentGuard setPos (getPos _static);
        currentGuard assignAsGunner _static;
        currentGuard moveInGunner _static;
        currentGuard doWatch ([_static, 200, direction _static] call BIS_fnc_relPos);
    } forEach _avanpostTurrets;
    _staticGroup setBehaviour "COMBAT";
    _staticGroup setCombatMode "RED";
    [(units _staticGroup)] call QS_fnc_setSkill4;   
    _enemiesArray = _enemiesArray + [_staticGroup];
    _guardGroup = [_avanpostPos, 50, ENEMY_SIDE] call QS_fnc_FillCargoPatrol;
    _enemiesArray = _enemiesArray + [_guardGroup];
    _smallBunkers = nearestObjects [_bunkerPos, ["Land_BagBunker_Small_F","Land_Cargo_Patrol_V1_F"], 50];
    _bunkerGroup = [_avanpostPos, 40, 5, ENEMY_SIDE, false, _smallBunkers] call QS_fnc_FillBots;
    _enemiesArray = _enemiesArray + [_bunkerGroup];
    _groundGroup = createGroup ENEMY_SIDE;
    for "_i" from 0 to 2 do {
        _groundPos = [_avanpostPos, 0, 20, 1, 0, 0, 0] call QS_fnc_findSafePos;
        _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> ENEMY_SIDE_STR >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
        if (random 10 > 7) then {
            [_patrolGroup, _avanpostPos, 10] call BIS_fnc_taskPatrol;
        } else {
            [_patrolGroup, _avanpostPos] call BIS_fnc_taskDefend;
        };        
        _patrolGroup setBehaviour "COMBAT";
        _patrolGroup setCombatMode "RED";
        [(units _patrolGroup)] call QS_fnc_setSkill4;
        _enemiesArray = _enemiesArray + [_patrolGroup];
    };
    _groundPos = [_avanpostPos, 0, 5, 1, 0, 0, 0] call QS_fnc_findSafePos;
    _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> ENEMY_SIDE_STR >> "OPF_F" >> "UInfantry" >> "OIA_GuardSentry")] call BIS_fnc_spawnGroup;
    _patrolGroup setBehaviour "COMBAT";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill4;
    _enemiesArray = _enemiesArray + [_patrolGroup];
};

// AA vehicles
for "_x" from 1 to PARAMS_AAPatrol do {
	_aaGroup = createGroup east;
	_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 2)], []], ["water", "out"]] call QS_fnc_randomPos;
    _randPos = _randomPos isFlatEmpty[3, 1, 0.3, 15, 0, false];
    _res = count _randPos;
    while {_res < 1} do {
        _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 2)], []], ["water", "out"]] call QS_fnc_randomPos;
        _randPos = _randomPos isFlatEmpty[3, 1, 0.3, 15, 0, false];
        _res = count _randPos;
    };
	_aa = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
    [_aa,"",["showCamonetHull",(selectRandom [0,1]),"showCamonetTurret",(selectRandom [0,1]),"showSLATHull",(selectRandom [0,1])]] call BIS_fnc_initVehicle;    
	waitUntil{!isNull _aa};
    _aa addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
	"O_engineer_F" createUnit [_randomPos,_aaGroup];
	"O_engineer_F" createUnit [_randomPos,_aaGroup];
	"O_engineer_F" createUnit [_randomPos,_aaGroup];
	((units _aaGroup) select 0) assignAsDriver _aa;
	((units _aaGroup) select 0) moveInDriver _aa;
	((units _aaGroup) select 1) assignAsGunner _aa;
	((units _aaGroup) select 1) moveInGunner _aa;
	((units _aaGroup) select 2) assignAsCommander _aa;
	((units _aaGroup) select 2) moveInCommander _aa;
	[_aaGroup, getMarkerPos currentAO, 500] call BIS_fnc_taskPatrol;
	[(units _aaGroup)] call QS_fnc_setSkill4;
	_aa lock false;
	_enemiesArray = _enemiesArray + [_aaGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_aa];

};

// Infantry patrols
for "_x" from 1 to PARAMS_GroupPatrol do {
	_patrolGroup = createGroup east;
	_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.5)], []], ["water", "out"]] call QS_fnc_randomPos;
	_patrolGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> selectRandom [INF_TYPE])] call BIS_fnc_spawnGroup;
	[_patrolGroup, true] call QS_fnc_moveToHC;
	[_patrolGroup, getMarkerPos currentAO, 400] call BIS_fnc_taskPatrol;
	[(units _patrolGroup)] call QS_fnc_setSkill3;
	_enemiesArray = _enemiesArray + [_patrolGroup];
};

// Static weapons
for "_x" from 1 to PARAMS_StaticMG do {
	_staticGroup = createGroup EAST;
	_randomPos = [getMarkerPos currentAO, 200, 10, 10] call QS_fnc_findOverwatch;
	_static = selectRandom [STATIC_TYPE] createVehicle _randomPos;
	waitUntil{!isNull _static};
	_static setDir random 360;
	"O_support_MG_F" createUnit [_randomPos,_staticGroup];
	((units _staticGroup) select 0) assignAsGunner _static;
	((units _staticGroup) select 0) moveInGunner _static;
	_staticGroup setBehaviour "COMBAT";
	_staticGroup setCombatMode "RED";
	[(units _staticGroup)] call QS_fnc_setSkill3;
	_static setVectorUp [0,0,1];
	_static lock false;
	_enemiesArray = _enemiesArray + [_staticGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_static];
};

// Infantry overwatch
for "_x" from 1 to PARAMS_Overwatch do {
	_overwatchGroup = createGroup east;
	_randomPos = [getMarkerPos currentAO, 600, 50, 10] call QS_fnc_findOverwatch;
	_overwatchGroup = [_randomPos, East, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> selectRandom [INF_URBANTYPE])] call BIS_fnc_spawnGroup;
	[_patrolGroup, true] call QS_fnc_moveToHC;
	[_overwatchGroup, _randomPos, 100] call BIS_fnc_taskPatrol;
	[(units _overwatchGroup)] call QS_fnc_setSkill3;
	_enemiesArray = _enemiesArray + [_overwatchGroup];
};

// MRAPs
for "_x" from 0 to 1 do {
	_AOmrapGroup = createGroup EAST;
	_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.6)], []], ["water", "out"]] call QS_fnc_randomPos;
	_randPos = _randomPos isFlatEmpty[3, 1, 0.5, 6, 0, false];
    _res = count _randPos;
    while {_res < 1} do {
        _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.6)], []], ["water", "out"]] call QS_fnc_randomPos;
        _randPos = _randomPos isFlatEmpty[3, 1, 0.5, 6, 0, false];
        _res = count _randPos;
    };
	_AOmrap = selectRandom [MRAP_TYPE] createVehicle _randomPos;
	waitUntil {!isNull _AOmrap};
    _AOmrap addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
	"O_engineer_F" createUnit [_randomPos,_AOmrapGroup];
	"O_engineer_F" createUnit [_randomPos,_AOmrapGroup];
	"O_engineer_F" createUnit [_randomPos,_AOmrapGroup];
	((units _AOmrapGroup) select 0) assignAsDriver _AOmrap;
	((units _AOmrapGroup) select 0) moveInDriver _AOmrap;
	((units _AOmrapGroup) select 1) assignAsGunner _AOmrap;
	((units _AOmrapGroup) select 1) moveInGunner _AOmrap;
	((units _AOmrapGroup) select 2) assignAsCargo _AOmrap;
	((units _AOmrapGroup) select 2) moveInCargo _AOmrap;
	[_AOmrapGroup, getMarkerPos currentAO, 600] call BIS_fnc_taskPatrol;
	_AOmrap lock false;
	_enemiesArray = _enemiesArray + [_AOmrapGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_AOmrap];
};

// Ground vehicles
for "_x" from 0 to 1 do {
	_AOvehGroup = createGroup EAST;
	_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.6)], []], ["water", "out"]] call QS_fnc_randomPos;
	_randPos = _randomPos isFlatEmpty[3, 1, 0.5, 10, 0, false];
    _res = count _randPos;
    while {_res < 1} do {
        _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.6)], []], ["water", "out"]] call QS_fnc_randomPos;
        _randPos = _randomPos isFlatEmpty[3, 1, 0.5, 10, 0, false];
        _res = count _randPos;
    };
	_AOveh = selectRandom [VEH_TYPE] createVehicle _randomPos;
    [_AOveh,"",["showCamonetHull",(selectRandom [0,1]),"showCamonetTurret",(selectRandom [0,1]),"showSLATHull",(selectRandom [0,1])]] call BIS_fnc_initVehicle;    
	waitUntil{!isNull _AOveh};
    _AOveh addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
	"O_engineer_F" createUnit [_randomPos,_AOvehGroup];
	"O_engineer_F" createUnit [_randomPos,_AOvehGroup];
	"O_engineer_F" createUnit [_randomPos,_AOvehGroup];
	((units _AOvehGroup) select 0) assignAsDriver _AOveh;
	((units _AOvehGroup) select 0) moveInDriver _AOveh;
	((units _AOvehGroup) select 1) assignAsGunner _AOveh;
	((units _AOvehGroup) select 1) moveInGunner _AOveh;
	((units _AOvehGroup) select 2) assignAsCommander _AOveh;
	((units _AOvehGroup) select 2) moveInCommander _AOveh;
	[_AOvehGroup, getMarkerPos currentAO, 400] call BIS_fnc_taskPatrol;
	[(units _AOvehGroup)] call QS_fnc_setSkill3;
	_AOveh lock false;
	_enemiesArray = _enemiesArray + [_AOvehGroup,_AOveh];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_AOveh];
};

// Helicopters
if((random 10 <= PARAMS_AirPatrol)) then {
	_airGroup = createGroup EAST;
	_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize], _dt], ["water", "out"]] call QS_fnc_randomPos;
	_air = selectRandom [AIR_TYPE] createVehicle [_randomPos select 0, _randomPos select 1, 1000];
	waitUntil{!isNull _air};
    _air addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
	_air engineOn true;
	_air setPos [_randomPos select 0, _randomPos select 1, 300];
	_air spawn {
		private["_x"];
		for [{_x=0}, {_x<=200}, {_x=_x+1}] do {
			_this setVelocity [0, 0, 0];
			sleep 0.1;
		};
	};
	"O_helipilot_F" createUnit [_randomPos,_airGroup];
	((units _airGroup) select 0) assignAsDriver _air;
	((units _airGroup) select 0) moveInDriver _air;
    _excludeList = ["O_Heli_Light_02_F", "I_Heli_light_03_F"];
    if !((typeOf _air) in _excludeList) then {
        "O_Helicrew_F" createUnit [_randomPos,_airGroup];
        ((units _airGroup) select 1) assignAsGunner _air;
        ((units _airGroup) select 1) moveInGunner _air;
    };	
	[_airGroup, getMarkerPos currentAO, 800] call BIS_fnc_taskPatrol;
	[(units _airGroup)] call QS_fnc_setSkill4;
	_air flyInHeight 450;
	_airGroup setCombatMode "RED";
    _airGroup setVariable ["zbe_cacheDisabled", true];
	_air lock false;
	_enemiesArray = _enemiesArray + [_airGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_air];
};

// Snipers
for "_x" from 1 to PARAMS_SniperTeamsPatrol do {
	_sniperGroup = createGroup EAST;
	_randomPos = [getMarkerPos currentAO, 1200, 100, 10] call QS_fnc_findOverwatch;
	_sniperGroup = [_randomPos, EAST,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
	[_sniperGroup, true] call QS_fnc_moveToHC;
	_sniperGroup setBehaviour "COMBAT";
	_sniperGroup setCombatMode "RED";
	[(units _sniperGroup)] call QS_fnc_setSkill4;
	_enemiesArray = _enemiesArray + [_sniperGroup];
};

// Spawn AT/AA patrols (40%)
if (random 10 > 6) then {
    _mediana = ((getMarkerPos "respawn_west") distance2D (getMarkerPos currentAO)) / 2;
    _medianaRes = 0;
    if (_mediana <= 1000) then {
    	_medianaRes = _mediana + (random 150) - (random 150);
    } else {
        _medianaRes = _mediana + (random 1000) - (random 1000);
    };
    if (_medianaRes < 800) then {
        _medianaRes = 800;
    };
    _direction = [(getMarkerPos "respawn_west"), (getMarkerPos currentAO)] call BIS_fnc_dirTo;
    _targetPos = [(getMarkerPos "respawn_west"), _medianaRes, _direction] call BIS_fnc_relPos;
    _atPos = [_targetPos, 1, 500, 2, 0, 2, 0, [], [_targetPos]] call QS_fnc_findSafePos;
    if (random 10 > 5) then {
        _null = [_atPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AT")] call BIS_fnc_spawnGroup;
    } else {
    	_null = [_atPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
    };
    _atUnits = ["O_soldier_TL_F","O_soldier_AA_F","O_soldier_AAA_F","O_soldier_TL_F","O_soldier_AT_F","O_soldier_AAT_F"];
    _nearestUnits = nearestObjects [_atPos, _atUnits, 50];
    _ATGroup = createGroup EAST;
    {
        [_x] joinSilent _ATGroup;
    } forEach _nearestUnits;
    _ATGroup setBehaviour "COMBAT";
    _ATGroup setCombatMode "RED";
    [(units _ATGroup)] call QS_fnc_setSkill3;
    [_ATGroup, _atPos, 200] call BIS_fnc_taskPatrol;
    _enemiesArray = _enemiesArray + [_ATGroup];
};

// Spawn UAV groups
_numUAVs = selectRandom [1,2];
for "_x" from 0 to _numUAVs do {
    _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.6)], []], ["water", "out"]] call QS_fnc_randomPos;
    _randPos = _randomPos isFlatEmpty[3, 1, 0.3, 15, 0, false];
    _res = count _randPos;
    while {_res < 1} do {
        _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.2)], []], ["water", "out"]] call QS_fnc_randomPos;
        _randPos = _randomPos isFlatEmpty[3, 1, 0.3, 10, 0, false];
        _res = count _randPos;
    };
    _uavGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_AttackTeam_UGV")] call BIS_fnc_spawnGroup;
    _uavGroup setBehaviour "COMBAT";
    _uavGroup setCombatMode "RED";
    [(units _uavGroup)] call QS_fnc_setSkill4;
    [_uavGroup, getMarkerPos currentAO, 500] call BIS_fnc_taskPatrol;
    _enemiesArray = _enemiesArray + [_uavGroup];    
    {
        if !(vehicle _x == _x) then {
            _enemiesArray = _enemiesArray + [vehicle _x];
        };
    } forEach units _uavGroup;
    _ugvs = nearestObjects [_randomPos, ["O_UGV_01_rcws_F", "O_T_UGV_01_rcws_ghex_F"], 50, true];
    if (count _ugvs > 0) then {
        _ugv = _ugvs select 0;    
        if !(isNull _ugv) then {
            [_ugv] spawn {
                _ugv = _this select 0;
                sleep 10;
                _leader = leader (group _ugv);
                while {alive _ugv} do {
                    sleep 180;
                    _ugv setFuel 1;
                    _pos = getPos _ugv;
                    _targetsArray = nearestObjects [_pos, ["Man","Car","Tank"], 300, true];
                    {
                        if !(side _x == ENEMY_SIDE) then {
                            _leader reveal [_x, 4];
                        };
                    } forEach _targetsArray;                            
                };   
            };
        };
    };
};

// darter units
_numUAVs = selectRandom [1,2,3];
_bridges = ["Land_Bridge_HighWay_PathLod_F","Land_Bridge_Concrete_PathLod_F","Land_Bridge_Asphalt_PathLod_F","Land_Bridge_01_PathLod_F"];
for "_x" from 0 to _numUAVs do {
    _darterGroup = createGroup ENEMY_SIDE;
    _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 2)], []], ["water", "out"]] call QS_fnc_randomPos;    
    _objects = _randomPos nearObjects ["building", 150];
    _goodPos = [];
    if (count _objects > 0) then {
        _houseList = _objects call QS_fnc_TBshuffle;
        _house = selectRandom _houseList;
        if !(typeOf _house in _bridges) then {
            _c = 0;
            while { format ["%1", _house buildingPos _c] != "[0,0,0]" } do {
                _buildingPos = _house buildingPos _c;
                _nearMan = nearestObject [_buildingPos, "Man"];
                _skip = false;
                if (_nearMan != objNull) then {
                    if (_nearMan distance2D _buildingPos < 2) then {
                        _skip = true;
                    };
                };            
                if !(_skip) then {
                    _goodPos pushBack _buildingPos;
                };
                _c = _c + 1;
            };
        };
    };
    _cntPos = count _goodPos;
    if (_cntPos > 0) then {
        _randomPos = selectRandom _goodPos;
    };
    "O_soldier_UAV_F" createUnit [_randomPos, _darterGroup];
    _darterGroup setBehaviour "COMBAT";
    _darterGroup setCombatMode "RED";
    [(units _darterGroup)] call QS_fnc_setSkill4;
    [_darterGroup, true] call QS_fnc_moveToHC;
    if (_cntPos > 0) then {
        _unit = leader _darterGroup;
        _unit setUnitPos "MIDDLE";
        removeBackpack _unit;
        _height = (random 100) + 80;
        _posSpawn = [_randomPos select 0, _randomPos select 1, _height];
        _uavData = [_posSpawn, 90, "O_UAV_01_F", ENEMY_SIDE] call BIS_fnc_spawnVehicle;
        _uav = _uavData select 0;
        _uavGroup = _uavData select 2;
        _uav addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
        _uavGroup setBehaviour "SAFE";
        _uavGroup setCombatMode "RED";
        [(units _uavGroup)] call QS_fnc_setSkill4;
        [_uavGroup, _posSpawn, (150 + (random 150))] call BIS_fnc_taskPatrol;
        _enemiesArray = _enemiesArray + [_uav];
        _enemiesArray = _enemiesArray + [_uavGroup];
        [_uav, _unit] spawn {
            sleep 10;
            _uav = _this select 0;
            _unit = _this select 1;
            while {alive _unit && alive _uav} do {
                sleep 240;
                _uav setFuel 1;
                _pos = getPos _uav;
                _targetsArray = nearestObjects [_pos, ["Man","Car","Tank"], 350, true];
                _targets = [];
                {
                    if !(side _x == ENEMY_SIDE) then {                        
                        _targets pushBack _x;
                    };
                } forEach _targetsArray;
                _leaders = [];
                if (count _targets > 0) then {
                    {
                        if (side _x == ENEMY_SIDE) then {
                            _groupPos = getPos (leader _x);
                            if (_pos distance2D _groupPos < 400) then {
                                _leaders pushBack (leader _x);
                            };
                        };
                    } forEach allGroups;
                };
                if (count _leaders > 0) then {
                    {
                        _leader = _x;
                        {
                            _leader reveal [_x, 4];
                        } forEach _targets;
         
                    } forEach _leaders;
                };
            };   
        };
    } else {
        [_darterGroup, getMarkerPos currentAO, 500] call BIS_fnc_taskPatrol;
    };
    _enemiesArray = _enemiesArray + [_darterGroup];
};

_enemiesArray;
