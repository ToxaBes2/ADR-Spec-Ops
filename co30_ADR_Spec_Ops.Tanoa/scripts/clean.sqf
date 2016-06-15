/*
File: clean.sqf
Author:

	Quiksilver

Last modified:

	15/08/2015 ArmA 3 1.48 by Quiksilver

Description:

	Maintain healthy quantity of some mission objects created during scenarios, including some created by the engine.

	- Dead bodies
	- Dead vehicles
	- Craters
	- Weapon holders (ground garbage)
	- Mines
	- Static weapons
	- Ruins
	- Orphaned MP Triggers http://feedback.arma3.com/view.php?id=19231
	- Empty Groups

	* Ruins can be excluded by setPos [0,0,0] on them, this script will not touch them in that case. Could be done for JIP/locality reasons, since Ruins can be fiddly with JIP.
	* Note: Please do not place any triggers at nullPos [0,0,0]. This script by default removes all triggers at nullPos.

Instructions:

	ExecVM from initServer.sqf or init.sqf in your mission directory.

	[] execVM "clean.sqf";				// If you put the file in mission directory
	[] execVM "scripts\clean.sqf";		// If you put the file in a folder, in this case called "scripts"
_________________________________________________________________________*/

if (!isServer) exitWith {};							// Remove this line if executed from "initServer.sqf". Keep this line if executed from "init.sqf".

sleep 1;

private [
	"_isHidden","_checkPlayerCount","_checkFrequencyDefault","_checkFrequencyAccelerated","_playerThreshold","_deadMenLimit",
	"_deadMenDistCheck","_deadMenDist","_deadVehiclesLimit","_deadVehicleDistCheck","_deadVehicleDist","_craterLimit","_craterDistCheck",
	"_craterDist","_ruins","_ruinsLimit","_ruinsDistCheck","_ruinsDist","_weaponHolderLimit","_weaponHolderDistCheck","_weaponHolderDist",
	"_minesLimit","_minesDistCheck","_minesDist","_staticsLimit","_staticsDistCheck","_staticsDist","_orphanedTriggers","_emptyGroups",
	"_currentDeadMan"
];

//==================== HIDDEN-FROM-PLAYERS FUNCTION

_isHidden = {
	private ['_c'];
	_c = FALSE;
	if (({(((_this select 0) distance _x) < (_this select 1))} count (_this select 2)) isEqualTo 0) then {
		_c = TRUE;
	};
	_c;
};

//================================================================ CONFIG

deleteManagerPublic = TRUE;						// To terminate script via debug console
_checkPlayerCount = TRUE;						// dynamic sleep. Set TRUE to have sleep automatically adjust based on # of players.
_checkFrequencyDefault = 480;					// sleep default
_checkFrequencyAccelerated = 240;				// sleep accelerated
_playerThreshold = 24;							// How many players before accelerated cycle kicks in?

_deadMenLimit = 50;								// Bodies. Set -1 to disable.
_deadMenDistCheck = TRUE;						// TRUE to delete any bodies that are far from players.
_deadMenDist = 5000;							// Distance (meters) from players that bodies are not deleted if below max.
_currentDeadMan = objNull;						// Set dynamically, do not touch!
_deadVehiclesLimit = 10;						// Wrecks. Set -1 to disable.
_deadVehicleDistCheck = TRUE;					// TRUE to delete any destroyed vehicles that are far from players.
_deadVehicleDist = 5000;						// Distance (meters) from players that destroyed vehicles are not deleted if below max.
_craterLimit = 0;								// Craters. Set -1 to disable.
_craterDistCheck = FALSE;						// TRUE to delete any craters that are far from players.
_craterDist = 1000;								// Distance (meters) from players that craters are not deleted if below max.
_weaponHolderLimit = 30;						// Weapon Holders. Set -1 to disable.
_weaponHolderDistCheck = TRUE;					// TRUE to delete any weapon holders that are far from players.
_weaponHolderDist = 5000;						// Distance (meters) from players that ground garbage is not deleted if below max.
_minesLimit = -1;								// Land mines. Set -1 to disable.
_minesDistCheck = TRUE;							// TRUE to delete any mines that are far from ANY UNIT (not just players).
_minesDist = 5000;								// Distance (meters) from players that land mines are not deleted if below max.
_staticsLimit = 30;								// Static weapons. Set -1 to disable.
_staticsDistCheck = TRUE;						// TRUE to delete any static weapon that is far from ANY UNIT (not just players.
_staticsDist = 5000;							// Distance (meters) from players that static weapons are not deleted if below max.
_ruinsLimit = 10;								// Ruins. Set -1 to disable.
_ruinsDistCheck = TRUE;							// TRUE to delete any ruins that are far from players.
_ruinsDist = 5000;								// Distance (meters) from players that ruins are not deleted if below max.
_orphanedTriggers = TRUE;						// Clean orphaned triggers in MP.
_emptyGroups = TRUE;							// Set FALSE to not delete empty groups.

//================================================================ LOOP

for '_x' from 0 to 1 step 0 do {

	//================================= DEAD MEN
	if (!(_deadMenLimit isEqualTo -1)) then {
		if ((count allDeadMen) > _deadMenLimit) then {
			while {(((count allDeadMen) - _deadMenLimit) > 0)} do {
				_currentDeadMan = allDeadMen select 0;
				detach (allDeadMen select 0);
				deleteVehicle (allDeadMen select 0);
				sleep 0.5;
				if ((allDeadMen select 0) isEqualTo _currentDeadMan) then {
					{
						deleteVehicle _x;
					} count allDeadMen;
				};
			};
		} else {
			if (_deadMenDistCheck) then {
				{
					if ([_x,_deadMenDist,allPlayers] call _isHidden) then {
						detach _x;
						deleteVehicle _x;
					};
				} count allDeadMen;
			};
		};
	};
	sleep 1;
	//================================= VEHICLES
	if (!(_deadVehiclesLimit isEqualTo -1)) then {
		if ((count (allDead - allDeadMen)) > _deadVehiclesLimit) then {
			while {(((count (allDead - allDeadMen)) - _deadVehiclesLimit) > 0)} do {
				deleteVehicle ((allDead - allDeadMen) select 0);
				sleep 0.5;
			};
		} else {
			if (_deadVehicleDistCheck) then {
				{
					if ([_x,_deadVehicleDist,allPlayers] call _isHidden) then {
						deleteVehicle _x;
					};
				} count (allDead - allDeadMen);
			};
		};
	};
	sleep 1;
	//================================= CRATERS
	if (!(_craterLimit isEqualTo -1)) then {
		if ((count (allMissionObjects "CraterLong")) > _craterLimit) then {
			while {(((count (allMissionObjects "CraterLong")) - _craterLimit) > 0)} do {
				deleteVehicle ((allMissionObjects "CraterLong") select 0);
				sleep 0.5;
			};
		} else {
			if (_craterDistCheck) then {
				{
					if ([_x,_craterDist,allPlayers] call _isHidden) then {
						deleteVehicle _x;
					};
				} count (allMissionObjects "CraterLong");
			};
		};
	};
	sleep 1;
	//================================= WEAPON HOLDERS
	if (!(_weaponHolderLimit isEqualTo -1)) then {
		if ((count (allMissionObjects "WeaponHolder")) > _weaponHolderLimit) then {
			while {(((count (allMissionObjects "WeaponHolder")) - _weaponHolderLimit) > 0)} do {
				deleteVehicle ((allMissionObjects "WeaponHolder") select 0);
				sleep 0.5;
			};
		} else {
			if (_weaponHolderDistCheck) then {
				{
					if ([_x,_weaponHolderDist,allPlayers] call _isHidden) then {
						deleteVehicle _x;
					};
				} count (allMissionObjects "WeaponHolder");
			};
		};
	};
	sleep 1;
	//================================= MINES
	if (!(_minesLimit isEqualTo -1)) then {
		if ((count allMines) > _minesLimit) then {
			while {(((count allMines) - _minesLimit) > 0)} do {
				deleteVehicle (allMines select 0);
				sleep 0.5;
			};
		} else {
			if (_minesDistCheck) then {
				{
					if ([_x,_minesDist,allUnits] call _isHidden) then {
						deleteVehicle _x;
					};
				} count allMines;
			};
		};
	};
	sleep 1;
	//================================= STATIC WEAPONS
	if (!(_staticsLimit isEqualTo -1)) then {
		if ((count (allMissionObjects "StaticWeapon")) > _staticsLimit) then {
			while {(((count (allMissionObjects "StaticWeapon")) - _staticsLimit) > 0)} do {
				deleteVehicle ((allMissionObjects "StaticWeapon") select 0);
				sleep 0.5;
			};
		} else {
			if (_staticsDistCheck) then {
				{
					if ([_x,_staticsDist,allUnits] call _isHidden) then {
						deleteVehicle _x;
					};
				} count (allMissionObjects "StaticWeapon");
			};
		};
	};
	sleep 1;
	//================================= RUINS
	if (!(_ruinsLimit isEqualTo -1)) then {
		_ruins = [];
		{
			if ((_x distance [0,0,0]) > 100) then {
				0 = _ruins pushBack _x;
				sleep 0.1;
			};
		} count (allMissionObjects "Ruins");
		if ((count _ruins) > _ruinsLimit) then {
			while {(((count _ruins) - _ruinsLimit) > 0)} do {
				_ruins resize (count _ruins - 1);
				deleteVehicle (_ruins select 0);
				sleep 0.5;
			};
		} else {
			if (_ruinsDistCheck) then {
				{
					if ([_x,_ruinsDist,allPlayers] call _isHidden) then {
						deleteVehicle _x;
					};
				} count (allMissionObjects "Ruins");
			};
		};
	};
	sleep 1;
	//================================= ORPHANED MP TRIGGERS.
	if (_orphanedTriggers) then {
		{
			if ((_x distance [0,0,0]) < 1) then {
				deleteVehicle _x;
			};
		} count (allMissionObjects "EmptyDetector");
	};
	sleep 1;
	//================================= EMPTY GROUPS
	if (_emptyGroups) then {
		{
			if ((count units _x) isEqualTo 0) then {
				deleteGroup _x;
			};
		} count allGroups;
	};
    sleep 1;
	//================================= SLEEP
	if (_checkPlayerCount) then {
		if ((count allPlayers) >= _playerThreshold) then {
			sleep _checkFrequencyAccelerated;
		} else {
			sleep _checkFrequencyDefault;
		};
	} else {
		sleep _checkFrequencyDefault;
	};
};
