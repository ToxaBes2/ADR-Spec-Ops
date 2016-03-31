/*
@filename: fn_vMonitor.sqf
Credit: Tophe for earlier monitor script
Author:

	Quiksilver
	
Last modified:

	23/10/2014 ArmA 1.32
	
Description:

	Vehicle monitor. This code must be spawned, not called. Ex. 

______________________________________________________*/

if (!isServer) exitWith { /* GO AWAY PLAYER */ };

//======================================== CONFIG

private ["_v", "_t", "_d", "_s", "_i", "_sd", "_sp", "_ti", "_u"];

#define DIST_FROM_SPAWN 300

_v = _this select 0;	// vehicle
_d = _this select 1;	//spawn delay
_s = _this select 2;	// setup
_i = _this select 3;	// init

_t = typeOf _v;			// type
_sd = getDir _v;		// spawn direction
_sp = getPosATL _v;		// spawn position

sleep (5 + (random 5));

[_v] call _i;

//======================================== MONITOR LOOP

while {true} do {

	//======================================== IF DESTROYED

	if (!alive _v) then {
		if (({((_sp distance _x) < 1.5)} count (entities "AllVehicles")) < 1) then {
			_ti = time + _d;
			waitUntil {sleep 5; (_ti < time)};
			if (!isNull _v) then {deleteVehicle _v;}; sleep 0.1;
			_v = createVehicle [_t,[(random 1000), (random 1000), (10000 + (random 20000))], [], 0, "NONE"]; sleep 0.1;
			waitUntil {!isNull _v}; sleep 0.1;
			_v setDir _sd; sleep 0.1;
			_v setPos [(_sp select 0), (_sp select 1), ((_sp select 2) + 0.1)]; sleep 0.1;
			[_v] call _i;
		};
	};

	sleep (5 + (random 5));

	//======================================== IF ABANDONED

	if ((_v distance _sp) > DIST_FROM_SPAWN) then {
		if (isMultiplayer) then {_u = playableUnits;} else {_u = switchableUnits;};
		if (({(_v distance _x) < PARAMS_VehicleRespawnDistance} count _u) < 1) then {
			if ((count (crew _v)) == 0) then {
				_v lock 2;
				_v allowDamage FALSE;
				_v setPos [(random 1000), (random 1000), (10000 + (random 20000))];
				_v enableSimulationGlobal FALSE;
				_v hideObjectGlobal TRUE;
				waitUntil {
					sleep (5 + (random 5)); 
					(({(_sp distance _x) < 1.5} count (entities "AllVehicles")) < 1)
				};
				_v enableSimulationGlobal TRUE;
				_v hideObjectGlobal FALSE;
				_v allowDamage TRUE;
				_v lock 0;
				_v setDir _sd; sleep 0.1;
				_v setPos _sp; sleep 0.1;
				_v setDamage 0; sleep 0.1;
				_v setVehicleAmmo 1; sleep 0.1;
				if ((fuel _v) < 0.95) then {[[_v, 1],"setFuel", true, false] spawn BIS_fnc_MP;};
				if (isEngineOn _v) then {_v engineOn FALSE;}; sleep 0.1;
				if (isCollisionLightOn _v) then {_v setCollisionLight FALSE;}; sleep 0.1;
				if (isLightOn _v) then {_v setPilotLight FALSE;}; sleep 0.1;
			};
		};
	};
	sleep (20 + (random 20));
};