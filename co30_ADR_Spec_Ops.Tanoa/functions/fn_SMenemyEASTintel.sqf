/*
@filename: QS_fnc_SMenemyEASTintel.sqf
Author:

	Quiksilver

Last modified:

	25/04/2014

Description:

	Spawn OPFOR enemy around intel objectives
	Enemy should have backbone AA/AT + random composition.
	Smaller number of enemy due to more complex objective.

___________________________________________*/

//---------- CONFIG
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INF_TEAMS "OIA_InfTeam", "OIA_InfTeam_AT", "OIA_InfTeam_AA", "OI_ReconPatrol","OIA_GuardTeam"
#define VEH_TYPES "O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F", "O_APC_Tracked_02_cannon_F"
private ["_x", "_pos", "_flatPos", "_randomPos", "_unitsArray", "_enemiesArray", "_infteamPatrol", "_SMvehPatrol", "_SMveh", "_SMaaPatrol", "_SMaa"];
_enemiesArray = [grpNull];
_x = 0;

//---------- INFANTRY

for "_x" from 0 to (1 + (random 3)) do {
	_infteamPatrol = createGroup ENEMY_SIDE;
	_randomPos = [[[getPos _intelObj, 300], []], ["water", "out"]] call QS_fnc_randomPos;
	_infteamPatrol = [_randomPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> selectRandom [INF_TEAMS])] call BIS_fnc_spawnGroup;
	[_infteamPatrol, getPos _intelObj, 100] call BIS_fnc_taskPatrol;
	[(units _infteamPatrol)] call QS_fnc_setSkill2;

	_enemiesArray = _enemiesArray + [_infteamPatrol];
};

//---------- RANDOM VEHICLE
_randomPos = [[[getPos _intelObj, 300], []], ["water", "out"]] call QS_fnc_randomPos;
_data = [_randomPos, (random 360), (selectRandom [VEH_TYPES]), ENEMY_SIDE] call BIS_fnc_spawnVehicle;
_SMveh = _data select 0;
_SMvehPatrol = _data select 2;
[_SMvehPatrol, getPos _intelObj, 150] call BIS_fnc_taskPatrol;
[(units _SMvehPatrol)] call QS_fnc_setSkill3;
_SMveh lock 0;

_enemiesArray = _enemiesArray + [_SMvehPatrol];
sleep 0.1;
_enemiesArray = _enemiesArray + [_SMveh];

_enemiesArray
