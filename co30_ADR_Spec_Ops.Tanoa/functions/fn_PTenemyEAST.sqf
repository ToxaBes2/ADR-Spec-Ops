/*
Author:

	Quiksilver

Last modified:

	25/04/2014

Description:

	Spawn BLUFOR enemy around side objectives.
	Enemy should have backbone AA/AT + random composition.

___________________________________________*/

//---------- CONFIG
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INF_TEAMS "OIA_InfTeam","OIA_InfTeam_AT","OIA_InfTeam_AA","OI_reconPatrol","OIA_GuardTeam"
#define VEH_TYPES "O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F","O_MBT_04_cannon_F","O_MBT_04_command_F","I_LT_01_AT_F","I_LT_01_scout_F","I_LT_01_cannon_F"
private ["_x", "_pos", "_flatPos", "_randomPos", "_enemiesArray", "_infteamPatrol", "_SMvehPatrol", "_SMveh", "_SMaaPatrol", "_SMaa", "_smSniperTeam"];
_enemiesArray = [grpNull];
_x = 0;

//---------- GROUPS

_infteamPatrol = createGroup ENEMY_SIDE;
_smSniperTeam = createGroup ENEMY_SIDE;

//---------- INFANTRY RANDOM

for "_x" from 0 to (3 + (random 4)) do {
	_randomPos = [[[getPos priorityObj1, 300], []], ["water", "out"]] call QS_fnc_randomPos;
	_infteamPatrol = [_randomPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> selectRandom [INF_TEAMS])] call BIS_fnc_spawnGroup;
	[_infteamPatrol, getPos priorityObj1, 100] call BIS_fnc_taskPatrol;

	_enemiesArray = _enemiesArray + [_infteamPatrol];
};

//---------- SNIPER

for "_x" from 0 to 1 do {
	_randomPos = [getPos priorityObj1, 500, 100, 20] call QS_fnc_findOverwatch;
	_smSniperTeam = [_randomPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
	_smSniperTeam setBehaviour "COMBAT";
	_smSniperTeam setCombatMode "RED";

	_enemiesArray = _enemiesArray + [_smSniperTeam];
};

//---------- VEHICLE RANDOM

_randomPos = [[[getPos priorityObj1, 300], []], ["water", "out"]] call QS_fnc_randomPos;
_data = [_randomPos, (random 360), (selectRandom [VEH_TYPES]), ENEMY_SIDE] call BIS_fnc_spawnVehicle;
_SMveh1 = _data select 0;
_SMvehPatrol = _data select 2;
[_SMveh1,"",["showCamonetHull",(selectRandom [0,1]),"showCamonetTurret",(selectRandom [0,1]),"showSLATHull",(selectRandom [0,1])]] call BIS_fnc_initVehicle;
_SMveh1 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
_SMveh1 lock 0;
[_SMvehPatrol, getPos priorityObj1, 75] call BIS_fnc_taskPatrol;
sleep 0.1;

_enemiesArray = _enemiesArray + [_SMveh1];
sleep 0.1;
_enemiesArray = _enemiesArray + [_SMvehPatrol];
//---------- VEHICLE RANDOM

_randomPos = [[[getPos priorityObj1, 300], []], ["water", "out"]] call QS_fnc_randomPos;
_data = [_randomPos, (random 360), (selectRandom [VEH_TYPES]), ENEMY_SIDE] call BIS_fnc_spawnVehicle;
_SMveh2 = _data select 0;
_SMvehPatrol = _data select 2;
[_SMveh2,"",["showCamonetHull",(selectRandom [0,1]),"showCamonetTurret",(selectRandom [0,1]),"showSLATHull",(selectRandom [0,1])]] call BIS_fnc_initVehicle;
_SMveh2 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
_SMveh2 lock 0;
[_SMvehPatrol, getPos priorityObj1, 150] call BIS_fnc_taskPatrol;
sleep 0.1;

_enemiesArray = _enemiesArray + [_SMveh2];
sleep 0.1;
_enemiesArray = _enemiesArray + [_SMvehPatrol];

//---------- VEHICLE AA

_randomPos = [[[getPos priorityObj1, 300], []], ["water", "out"]] call QS_fnc_randomPos;
_data = [_randomPos, (random 360), "O_APC_Tracked_02_AA_F", ENEMY_SIDE] call BIS_fnc_spawnVehicle;
_SMaa = _data select 0;
_SMaaPatrol = _data select 2;
[_SMaa,"",["showCamonetHull",(selectRandom [0,1]),"showCamonetTurret",(selectRandom [0,1]),"showSLATHull",(selectRandom [0,1])]] call BIS_fnc_initVehicle;
_SMaa addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
_SMaa lock 0;
[_SMaaPatrol, getPos priorityObj1, 150] call BIS_fnc_taskPatrol;

_enemiesArray = _enemiesArray + [_SMaaPatrol];
sleep 0.1;
_enemiesArray = _enemiesArray + [_SMaa];

//---------- COMMON

[(units _infteamPatrol)] call QS_fnc_setSkill2;
[(units _smSniperTeam)] call QS_fnc_setSkill3;
[(units _SMaaPatrol)] call QS_fnc_setSkill4;
[(units _SMvehPatrol)] call QS_fnc_setSkill2;

//---------- GARRISON FORTIFICATIONS

{
	_newGrp = [_x] call QS_fnc_garrisonFortEAST;
	if (!isNull _newGrp) then {
		_enemiesArray = _enemiesArray + [_newGrp];
	};
} forEach (getPos priorityObj1 nearObjects ["House", 150]);

_enemiesArray
