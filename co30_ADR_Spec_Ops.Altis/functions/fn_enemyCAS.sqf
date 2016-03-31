/*
@filename: aoReinforcementJet.sqf
Author:

	Quiksilver
	
Last modified:

	26/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Spawn an enemy CAS jet
______________________________________________________*/

private ["_aoPos", "_spawnPos", "_jetSelect", "_casArray", "_jetLimit", "_jetPilot", "_jetActual", "_new"];

_casArray = ["O_Plane_CAS_02_F","I_Plane_Fighter_03_AA_F"];

_jetLimit = 1;

_new = FALSE;

if ((count enemyCasArray) < _jetLimit) then {

	if ((count enemyCasArray) < 1) then {_new = TRUE;} else {_new = FALSE;};

	_spawnPos = [(random 30000), (random 30000), 3000];
	_aoPos = getMarkerPos currentAO;
	if (isNull enemyCasGroup) then {enemyCasGroup = createGroup EAST;};

	_jetPilot = enemyCasGroup createUnit ["O_pilot_F", [0, 0, (1000 + (random 1000))], [], 0, "NONE"];
	_jetSelect = _casArray select (floor (random (count _casArray)));
	_jetActual = createVehicle [_jetSelect, _spawnPos, [], 0, "NONE"];
	waitUntil {!isNull _jetActual};
	_jetActual engineOn TRUE;
	_jetActual allowCrewInImmobile TRUE;
	_jetActual flyInHeight 1000;
	_jetActual lock 2;
	_jetPilot assignAsDriver _jetActual;
	_jetPilot moveInDriver _jetActual;

	if (_new) then {_jetPilot setRank "COLONEL";} else {_jetPilot setRank "MAJOR";};
	enemyCasGroup setCombatMode "RED";
	enemyCasGroup setBehaviour "COMBAT";
	enemyCasGroup setSpeedMode "FULL";
	[(units enemyCasGroup)] call QS_fnc_setSkill2;
	[enemyCasGroup,_aoPos] call BIS_fnc_taskAttack;

	0 = enemyCasArray pushBack _jetActual;

	[_jetActual, _jetPilot] spawn {
		private ["_jetActual", "_jetPos", "_targetList"];
		_jetActual = _this select 0;
		_jetPilot = _this select 1;
		showNotification = ["EnemyJet", "Вражеский штурмовик"]; publicVariable "showNotification";
		while {(alive _jetActual)} do {
			_jetActual setVehicleAmmo 1;
			_jetActual flyInHeight (300 + (random 850));
			_jetPos = getPosATL _jetActual;
			_targetList = _jetPos nearEntities [["Air"], 4000];
			{enemyCasGroup reveal [_x,4];} count _targetList;
			sleep 180;
		};
		showNotification = ["EnemyJetDown", "Штурмовик сбит! Хорошая работа!"]; publicVariable "showNotification";
		enemyCasArray = enemyCasArray - [_jetActual];
		sleep 30;
		if (!isNull _jetActual) then {deleteVehicle _jetActual;};
		if (!isNull _jetPilot) then {deleteVehicle _jetPilot;};
	};
};