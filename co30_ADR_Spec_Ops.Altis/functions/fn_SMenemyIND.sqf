/*
Author:

	Quiksilver

Last modified:

	25/04/2014

Description:

	Spawn INDEPENDENT enemy around side objectives.
	Enemy should have backbone AA/AT + random composition.

___________________________________________*/

//---------- CONFIG
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INF_TEAMS "HAF_InfTeam", "HAF_InfTeam_AA", "HAF_InfTeam_AT", "HAF_InfSentry", "HAF_InfSquad"
#define VEH_TYPES "I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_MRAP_03_gmg_F", "I_MRAP_03_hmg_F"
private ["_x", "_pos", "_flatPos", "_randomPos", "_unitsArray", "_enemiesArray", "_infteamPatrol", "_SMvehPatrol", "_SMveh", "_SMaaPatrol", "_SMaa", "_indSniperTeam"];
_enemiesArray = [grpNull];
_x = 0;

//---------- CREATE GROUPS

_infteamPatrol = createGroup ENEMY_SIDE;
_indSniperTeam = createGroup ENEMY_SIDE;
_SMvehPatrol = createGroup ENEMY_SIDE;
//---------- INFANTRY

for "_x" from 0 to (2 + (random 4)) do {
	_randomPos = [[[getPos sideObj, 300], []], ["water", "out"]] call QS_fnc_randomPos;
	_infteamPatrol = [_randomPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> selectRandom [INF_TEAMS])] call BIS_fnc_spawnGroup;
	[_infteamPatrol, getPos sideObj, 100] call BIS_fnc_taskPatrol;

	_enemiesArray = _enemiesArray + [_infteamPatrol];

};

//---------- SNIPER

for "_x" from 0 to 1 do {
	_randomPos = [getPos sideObj, 500, 100, 20] call QS_fnc_findOverwatch;
	_indSniperTeam = [_randomPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")] call BIS_fnc_spawnGroup;
	_indSniperTeam setBehaviour "COMBAT";
	_indSniperTeam setCombatMode "RED";

	_enemiesArray = _enemiesArray + [_indSniperTeam];

};

//---------- RANDOM VEHICLE

_randomPos = [[[getPos sideObj, 300], []], ["water", "out"]] call QS_fnc_randomPos;
_SMveh = selectRandom [VEH_TYPES] createVehicle _randomPos;
waitUntil {sleep 0.5; !isNull _SMveh};
	"I_engineer_F" createUnit [_randomPos,_SMvehPatrol];
	"I_engineer_F" createUnit [_randomPos,_SMvehPatrol];
	"I_engineer_F" createUnit [_randomPos,_SMvehPatrol];
	((units _SMvehPatrol) select 0) assignAsDriver _SMveh;
	((units _SMvehPatrol) select 1) assignAsGunner _SMveh;
	((units _SMvehPatrol) select 2) assignAsCommander _SMveh;
	((units _SMvehPatrol) select 0) moveInDriver _SMveh;
	((units _SMvehPatrol) select 1) moveInGunner _SMveh;
	((units _SMvehPatrol) select 2) moveInCommander _SMveh;

_SMveh lock 0;
[_SMvehPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;

_enemiesArray = _enemiesArray + [_SMvehPatrol];
sleep 0.1;
_enemiesarray = _enemiesArray + [_SMveh];

//---------- AA VEHICLE

for "_x" from 0 to 1 do {
	_randomPos = [[[getPos sideObj, 300], []], ["water", "out"]] call QS_fnc_randomPos;
	_data = [_randomPos, (random 360), "O_APC_Tracked_02_AA_F", ENEMY_SIDE] call BIS_fnc_spawnVehicle;
    _SMaa = _data select 0;
    _SMaaPatrol = _data select 2;
	_SMaa lock 0;
	[_SMaaPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;

	_enemiesArray = _enemiesArray + [_SMaaPatrol];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_SMaa];

};

//---------- COMMON

[(units _infteamPatrol)] call QS_fnc_setSkill2;
[(units _indSniperTeam)] call QS_fnc_setSkill3;
[(units _SMvehPatrol)] call QS_fnc_setSkill2;
[(units _SMaaPatrol)] call QS_fnc_setSkill4;

//---------- GARRISON FORTIFICATIONS

	{
		_newGrp = [_x] call QS_fnc_garrisonFortIND;
		if (!isNull _newGrp) then {
			_enemiesArray = _enemiesArray + [_newGrp];
		};
	} forEach (getPos sideObj nearObjects ["House", 150]);

_enemiesArray
