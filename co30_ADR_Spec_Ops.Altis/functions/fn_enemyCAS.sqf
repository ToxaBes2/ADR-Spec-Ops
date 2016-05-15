/*
Author:
	Quiksilver

Last modified:
	14/05/2015 ArmA 1.58 by malashin

Description:
	Spawn an enemy CAS
*/

private ["_casArray", "_casLimit", "_aoPos", "_basePos", "_spawnPos", "_players", "_minDist", "_distance", "_casSelect", "_casVehicle", "_casCrew"];

//Array of possible enemy CAS vehicles
_casArray = ["O_Plane_CAS_02_F", "I_Plane_Fighter_03_AA_F", "O_Heli_Attack_02_F", "O_Heli_Light_02_F"];

//Limit of how many CAS vehicles are allowed to operate at the same time
_casLimit = 1;

//Spawn new CAS vehicle if number of number of current vehicles is lower then the limit
if ((count enemyCasArray) < _casLimit) then {

	_aoPos = getMarkerPos currentAO;
	_basePos = getMarkerPos "safezone_marker";

	//Create random spawn point that is more then 5000 meters away from players, player base and current AO
	while {true} do {
	    _spawnPos = [(random 30000), (random 30000), 0];
		_players = allPlayers;
		_minDist = 1e39;
		{
			_distance = _spawnPos distance2D _x;
		    if (_distance < _minDist) then {
		        _minDist = _distance;
		    };
		} forEach _players;
		if ((_minDist > 5000) and ((_spawnPos distance2D _aoPos) > 5000) and ((_spawnPos distance2D _basePos) > 5000)) exitWith {};
	};

	//Create new group if there is no CAS group present
	if (isNull enemyCasGroup) then {enemyCasGroup = createGroup EAST;};

	//Select vehicle from possible enemy CAS vehicles array and spawn on it on _spawnPos
	_casSelect = _casArray select (floor (random (count _casArray)));
	_casVehicle = createVehicle [_casSelect, _spawnPos, [], 0, "FLY"];
	waitUntil {!isNull _casVehicle};
	_casVehicle setPos [_spawnPos select 0, _spawnPos select 1, 400];
	_casVehicle setDir ([_casVehicle, _aoPos] call BIS_fnc_dirTo);
	_casVehicle allowCrewInImmobile true;
	if (_casVehicle isKindOf "Plane") then {
	    _casVehicle flyInHeight 1000;
	} else {
		_casVehicle flyInHeight 400;
	};
	_casVehicle lock 2;
	createVehicleCrew _casVehicle;
	_casCrew = crew _casVehicle;
	_casCrew join enemyCasGroup;

	//Delete previous waypoints if present
	while {(count (waypoints enemyCasGroup)) > 0} do {
		deleteWaypoint ((waypoints enemyCasGroup) select 0);
	};

	//Create new waypoint
	enemyCasGroup setCombatMode "RED";
	enemyCasGroup setBehaviour "AWARE";
	enemyCasGroup setSpeedMode "FULL";
	[(units enemyCasGroup)] call QS_fnc_setSkill3;
	[enemyCasGroup, _aoPos] call BIS_fnc_taskAttack;

	//Add vehicle to array to check how many vehciles are currently alive, notify the players that CAS was spawned
	0 = enemyCasArray pushBack _casVehicle;
	showNotification = ["EnemyCas", "Вражеская авиаподдержка"]; publicVariable "showNotification";

	//Rearm CAS and reveal air targets once every 5 minutes
	[_casVehicle, _casCrew] spawn {
		private ["_casVehicle", "_casCrew", "_casPos", "_targetList"];
		_casVehicle = _this select 0;
		_casCrew = _this select 1;

		while {(alive _casVehicle)} do {
			sleep 300;
			_casVehicle setVehicleAmmo 1;
			_casPos = getPos _casVehicle;
			_targetList = _casPos nearEntities [["Air"], 4000];
			{enemyCasGroup reveal [_x, 4];} count _targetList;
		};
	};

	//Once CAS is destroyed, remove vehicle from the array and notify the players
	waitUntil {sleep 30; not alive _casVehicle};
	sleep 30;
	enemyCasArray = enemyCasArray - [_casVehicle];
	showNotification = ["EnemyCasDown", "Авиаподдержка уничтожена! Хорошая работа!"]; publicVariable "showNotification";
	sleep 30;
	if (!isNil {_casVehicle}) then {deleteVehicle _casVehicle;};
	if (!isNil {_casCrew}) then {{deleteVehicle _x;} forEach _casCrew;};
};
