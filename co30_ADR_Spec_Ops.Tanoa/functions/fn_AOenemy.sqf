/*
@file: QS_fnc_AOenemy.sqf
Author:	Quiksilver (credits: Ahoyworld.co.uk. Rarek et al for AW_fnc_spawnUnits.)
Description: Spawn enemies in the AO.
*/
#define INF_TYPE "O_T_InfSentry","O_T_InfSquad","O_T_InfSquad_Weapons","O_T_InfTeam","O_T_InfTeam_AA","O_T_InfTeam_AT","O_T_reconPatrol","O_T_reconSentry","O_T_reconTeam"
#define INF_URBANTYPE "OIA_GuardSentry","OIA_GuardSquad","OIA_GuardTeam"
#define MRAP_TYPE "O_T_MRAP_02_hmg_ghex_F","O_T_MRAP_02_gmg_ghex_F","O_T_LSV_02_armed_F"
#define VEH_TYPE "O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_MBT_02_cannon_ghex_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F"
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
_enemiesArray = [grpNull];

// enemies in bunker
if (_bunkerType == 1) then {
    _bunkerGroup = [_bunkerPos, 40, 15, ENEMY_SIDE] call QS_fnc_FillBots;
    _enemiesArray = _enemiesArray + [_bunkerGroup];

    for "_i" from 1 to 2 do {
        _groundPos = [_bunkerPos, 10, 50, 2, 0, 10, 0, [], [_bunkerPos]] call BIS_fnc_findSafePos;
        _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> ENEMY_SIDE_STR >> "OPF_T_F" >> "Infantry" >> "O_T_InfSentry")] call BIS_fnc_spawnGroup;
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
        "O_T_support_MG_F" createUnit [(getPos _x), _staticGroup, "[this] call QS_fnc_moveToHC;"];
        ((units _staticGroup) select 0) assignAsGunner _x;
        ((units _staticGroup) select 0) moveInGunner _x;
        _staticGroup setBehaviour "COMBAT";
    	_staticGroup setCombatMode "RED";
    	[(units _staticGroup)] call QS_fnc_setSkill3;
    	_enemiesArray = _enemiesArray + [_staticGroup];
    } forEach _staticObjects;
    _smallBunkers = nearestObjects [_bunkerPos, ["Land_BagBunker_01_small_green_F"], 30];
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
    _groundPos = [_bunkerPos, 40, 80, 2, 0, 10, 0, [], [_bunkerPos]] call BIS_fnc_findSafePos;
    _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> ENEMY_SIDE_STR >> "OPF_T_F" >> "Infantry" >> "O_T_InfSentry")] call BIS_fnc_spawnGroup;
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
	_campPatrolGroup = [_flatPos, 70, 6, ENEMY_SIDE] call QS_fnc_FillBots;
    _enemiesArray = _enemiesArray + [_campPatrolGroup];
} else {
    _campGroup = [_flatPos, 50, 10, ENEMY_SIDE] call QS_fnc_FillBots;
    _enemiesArray = _enemiesArray + [_campGroup];

    // patrols (2x2 bots)
    for "_i" from 1 to 2 do {
        _groundPos = [_flatPos, 0, 40, 2, 0, 10, 0, [], [_flatPos]] call BIS_fnc_findSafePos;
        _patrolGroup = [_groundPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> ENEMY_SIDE_STR >> "OPF_T_F" >> "Infantry" >> "O_T_InfSentry")] call BIS_fnc_spawnGroup;
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
_buildingGroup = [_pos, (PARAMS_AOSize / 2), 40, ENEMY_SIDE, false, _blackList] call QS_fnc_FillBots;
_enemiesArray = _enemiesArray + [_buildingGroup];

// AA vehicles
for "_x" from 1 to PARAMS_AAPatrol do {
	_aaGroup = createGroup east;
	_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 2)], []], ["water", "out"]] call BIS_fnc_randomPos;
    _randPos = _randomPos isFlatEmpty[3, 1, 0.3, 15, 0, false];
    _res = count _randPos;
    while {_res < 1} do {
        _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 2)], []], ["water", "out"]] call BIS_fnc_randomPos;
        _randPos = _randomPos isFlatEmpty[3, 1, 0.3, 15, 0, false];
        _res = count _randPos;
    };
	_aa = "O_T_APC_Tracked_02_AA_ghex_F" createVehicle _randomPos;
	waitUntil{!isNull _aa};
	"O_T_Engineer_F" createUnit [_randomPos,_aaGroup];
	"O_T_Engineer_F" createUnit [_randomPos,_aaGroup];
	"O_T_Engineer_F" createUnit [_randomPos,_aaGroup];
	((units _aaGroup) select 0) assignAsDriver _aa;
	((units _aaGroup) select 0) moveInDriver _aa;
	((units _aaGroup) select 1) assignAsGunner _aa;
	((units _aaGroup) select 1) moveInGunner _aa;
	((units _aaGroup) select 2) assignAsCommander _aa;
	((units _aaGroup) select 2) moveInCommander _aa;
	[_aaGroup, getMarkerPos currentAO, 500] call BIS_fnc_taskPatrol;
	[(units _aaGroup)] call QS_fnc_setSkill4;
	_aa lock 0;
	if (random 1 >= 0.3) then {
		_aa allowCrewInImmobile true;
	};
	_enemiesArray = _enemiesArray + [_aaGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_aa];

};

// Infantry patrols
for "_x" from 1 to PARAMS_GroupPatrol do {
	_patrolGroup = createGroup east;
	_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.5)], []], ["water", "out"]] call BIS_fnc_randomPos;
	_patrolGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> selectRandom [INF_TYPE])] call BIS_fnc_spawnGroup;
	[_patrolGroup, true] call QS_fnc_moveToHC;
	[_patrolGroup, getMarkerPos currentAO, 400] call BIS_fnc_taskPatrol;
	[(units _patrolGroup)] call QS_fnc_setSkill3;
	_enemiesArray = _enemiesArray + [_patrolGroup];
};

// Static weapons
for "_x" from 1 to PARAMS_StaticMG do {
	_staticGroup = createGroup EAST;
	_randomPos = [getMarkerPos currentAO, 200, 10, 10] call BIS_fnc_findOverwatch;
	_static = selectRandom [STATIC_TYPE] createVehicle _randomPos;
	waitUntil{!isNull _static};
	_static setDir random 360;
	"O_T_Support_MG_F" createUnit [_randomPos,_staticGroup];
	((units _staticGroup) select 0) assignAsGunner _static;
	((units _staticGroup) select 0) moveInGunner _static;
	_staticGroup setBehaviour "COMBAT";
	_staticGroup setCombatMode "RED";
	[(units _staticGroup)] call QS_fnc_setSkill3;
	_static setVectorUp [0,0,1];
	_static lock 0;
	_enemiesArray = _enemiesArray + [_staticGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_static];
};

// Infantry overwatch
for "_x" from 1 to PARAMS_Overwatch do {
	_overwatchGroup = createGroup east;
	_randomPos = [getMarkerPos currentAO, 600, 50, 10] call BIS_fnc_findOverwatch;
	_overwatchGroup = [_randomPos, East, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> selectRandom [INF_URBANTYPE])] call BIS_fnc_spawnGroup;
	[_patrolGroup, true] call QS_fnc_moveToHC;
	[_overwatchGroup, _randomPos, 100] call BIS_fnc_taskPatrol;
	[(units _overwatchGroup)] call QS_fnc_setSkill3;
	_enemiesArray = _enemiesArray + [_overwatchGroup];
};

// MRAPs
for "_x" from 0 to 1 do {
	_AOmrapGroup = createGroup EAST;
	_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.6)], []], ["water", "out"]] call BIS_fnc_randomPos;
	_randPos = _randomPos isFlatEmpty[3, 1, 0.5, 6, 0, false];
    _res = count _randPos;
    while {_res < 1} do {
        _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.6)], []], ["water", "out"]] call BIS_fnc_randomPos;
        _randPos = _randomPos isFlatEmpty[3, 1, 0.5, 6, 0, false];
        _res = count _randPos;
    };
	_AOmrap = selectRandom [MRAP_TYPE] createVehicle _randomPos;
	waitUntil {!isNull _AOmrap};
	"O_T_Engineer_F" createUnit [_randomPos,_AOmrapGroup];
	"O_T_Engineer_F" createUnit [_randomPos,_AOmrapGroup];
	"O_T_Engineer_F" createUnit [_randomPos,_AOmrapGroup];
	((units _AOmrapGroup) select 0) assignAsDriver _AOmrap;
	((units _AOmrapGroup) select 0) moveInDriver _AOmrap;
	((units _AOmrapGroup) select 1) assignAsGunner _AOmrap;
	((units _AOmrapGroup) select 1) moveInGunner _AOmrap;
	((units _AOmrapGroup) select 2) assignAsCargo _AOmrap;
	((units _AOmrapGroup) select 2) moveInCargo _AOmrap;
	[_AOmrapGroup, getMarkerPos currentAO, 600] call BIS_fnc_taskPatrol;
	_AOmrap lock 0;
	if (random 1 >= 0.5) then {
		_AOmrap allowCrewInImmobile true;
	};
	_enemiesArray = _enemiesArray + [_AOmrapGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_AOmrap];
};

// Ground vehicles
for "_x" from 0 to (1 + (random 1)) do {
	_AOvehGroup = createGroup EAST;
	_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.6)], []], ["water", "out"]] call BIS_fnc_randomPos;
	_randPos = _randomPos isFlatEmpty[3, 1, 0.5, 10, 0, false];
    _res = count _randPos;
    while {_res < 1} do {
        _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.6)], []], ["water", "out"]] call BIS_fnc_randomPos;
        _randPos = _randomPos isFlatEmpty[3, 1, 0.5, 10, 0, false];
        _res = count _randPos;
    };
	_AOveh = selectRandom [VEH_TYPE] createVehicle _randomPos;
	waitUntil{!isNull _AOveh};
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
	_AOveh lock 0;
	if (random 1 >= 0.4) then {
		_AOveh allowCrewInImmobile true;
	};
	_enemiesArray = _enemiesArray + [_AOvehGroup,_AOveh];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_AOveh];
};

// Helicopters
if((random 10 <= PARAMS_AirPatrol)) then {
	_airGroup = createGroup EAST;
	_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize], _dt], ["water", "out"]] call BIS_fnc_randomPos;
	_air = selectRandom [AIR_TYPE] createVehicle [_randomPos select 0, _randomPos select 1, 1000];
	waitUntil{!isNull _air};
	_air engineOn true;
	_air setPos [_randomPos select 0, _randomPos select 1, 300];
	_air spawn {
		private["_x"];
		for [{_x=0}, {_x<=200}, {_x=_x+1}] do {
			_this setVelocity [0, 0, 0];
			sleep 0.1;
		};
	};
	"O_T_Helipilot_F" createUnit [_randomPos,_airGroup];
	((units _airGroup) select 0) assignAsDriver _air;
	((units _airGroup) select 0) moveInDriver _air;
	"O_T_Helicrew_F" createUnit [_randomPos,_airGroup];
	((units _airGroup) select 1) assignAsGunner _air;
	((units _airGroup) select 1) moveInGunner _air;
	[_airGroup, getMarkerPos currentAO, 800] call BIS_fnc_taskPatrol;
	[(units _airGroup)] call QS_fnc_setSkill4;
	_air flyInHeight 300;
	_airGroup setCombatMode "RED";
	_air lock 0;
	_enemiesArray = _enemiesArray + [_airGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_air];
};

// Snipers
for "_x" from 1 to PARAMS_SniperTeamsPatrol do {
	_sniperGroup = createGroup EAST;
	_randomPos = [getMarkerPos currentAO, 1200, 100, 10] call BIS_fnc_findOverwatch;
	_sniperGroup = [_randomPos, EAST,(configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_SniperTeam")] call BIS_fnc_spawnGroup;
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
    _atPos = [_targetPos, 1, 500, 2, 0, 2, 0, [], [_targetPos]] call BIS_fnc_findSafePos;
    if (random 10 > 5) then {
        _null = [_atPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam_AT")] call BIS_fnc_spawnGroup;
    } else {
    	_null = [_atPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam_AA")] call BIS_fnc_spawnGroup;
    };
    _atUnits = ["O_T_soldier_TL_F","O_T_soldier_AA_F","O_T_soldier_AAA_F","O_T_soldier_AT_F","O_T_soldier_AAT_F"];
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

_enemiesArray;
