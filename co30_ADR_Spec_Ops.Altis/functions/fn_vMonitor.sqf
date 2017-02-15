/*
Credit: Tophe for earlier monitor script
Author:	Quiksilver
Description: Vehicle monitor. This code must be spawned, not called.
*/
if (!isServer) exitWith { /* GO AWAY PLAYER */ };
private ["_v", "_t", "_d", "_s", "_i", "_sd", "_sp", "_ti", "_u"];

#define DIST_FROM_SPAWN 100

_v = _this select 0;	// vehicle
_d = _this select 1;	// spawn delay
_s = _this select 2;	// respawn delay in air support cycles
_i = _this select 3;	// init

_t = typeOf _v;			// type
_sd = getDir _v;		// spawn direction
_sp = getPosATL _v;		// spawn position

sleep 7;
[_v] call _i;
_v addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];

// MONITOR LOOP
while {true} do {
	_destroyed = _v getVariable ["AVANPOST_DESTROYED", false];
	if (_destroyed) exitWith {
		deleteVehicle _v;
	};
	if (!alive _v) then {
		//if (({((_sp distance _x) < 1.5)} count (entities "AllVehicles")) < 1) then {
            _startTime = SUPPORT_CYCLES;
            waitUntil {sleep 10; ((SUPPORT_CYCLES - _startTime) >= _s)};
			if (!isNull _v) then {deleteVehicle _v;};
			_v = createVehicle [_t,[(random 1000), (random 1000), (10000 + (random 20000))], [], 0, "NONE"];
			waitUntil {!isNull _v};
			_v setDir _sd;
			_v setPos [(_sp select 0), (_sp select 1), ((_sp select 2) + 0.1)];
			[_v] call _i;
			_v addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
		//};
	} else {;
    	if ((_v distance _sp) > DIST_FROM_SPAWN) then {
    		if (isMultiplayer) then {_u = playableUnits;} else {_u = switchableUnits;};
    		if (({(_v distance _x) < PARAMS_VehicleRespawnDistance} count _u) < 1) then {
    			if ((count (crew _v)) == 0) then {
    				//_v lock 2;
    				//_v allowDamage FALSE;
    				//_v setPos [(random 1000), (random 1000), (10000 + (random 20000))];
    				//_v enableSimulationGlobal FALSE;
    				//_v hideObjectGlobal TRUE;
    				//waitUntil {
    				//	sleep 5; 
    				//	(({(_sp distance _x) < 1.5} count (entities "AllVehicles")) < 1)
    				//};
    				//_v enableSimulationGlobal TRUE;
    				//_v hideObjectGlobal FALSE;
    				_v lock 0;
    				_v setDir _sd;
    				_v setPos _sp;
    				_v allowDamage TRUE;
    				_v setDamage 0;
    				_v setVehicleAmmo 1;
    				_v setVelocity [0, 0, 0];
    				if ((fuel _v) < 0.95) then {[[_v, 1],"setFuel", true, false] spawn BIS_fnc_MP;};
    				if (isEngineOn _v) then {_v engineOn FALSE;};
    				if (isCollisionLightOn _v) then {_v setCollisionLight FALSE;};
    				if (isLightOn _v) then {_v setPilotLight FALSE;};
    			};
    		};
    	};
    };
	sleep 30;
};