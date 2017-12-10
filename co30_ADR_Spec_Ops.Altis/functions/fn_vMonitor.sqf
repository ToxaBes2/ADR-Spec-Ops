/*
Credit: Tophe for earlier monitor script
Author:	Quiksilver
Description: Vehicle monitor. This code must be spawned, not called.
*/
if (!isServer) exitWith { /* GO AWAY PLAYER */ };
private ["_v", "_t", "_d", "_s", "_i", "_sd", "_sp", "_ti", "_u"];

#define DIST_FROM_SPAWN 100
#define DIST_FROM_SPAWN_QUADBIKE 5

_v = _this select 0;	// vehicle
_d = _this select 1;	// spawn delay
_s = _this select 2;	// respawn delay in air support cycles
_i = _this select 3;	// init
_score = param [4, 0];  // score base

_t = typeOf _v;			// type
_sd = getDir _v;		// spawn direction
_sp = getPosATL _v;		// spawn position

sleep 7;
[_v] call _i;
_v addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];

if (isNil "BLUFOR_BASE_SCORE") then {
    BLUFOR_BASE_SCORE = 1;
};

// MONITOR LOOP
while {true} do {
    if (BLUFOR_BASE_SCORE < _score) then {
        if (alive _v) then {
            deleteVehicle _v;
        };        
    } else {
	    _destroyed = _v getVariable ["AVANPOST_DESTROYED", false];
	    if (_destroyed) exitWith {
	    	deleteVehicle _v;
	    };
	    if (!alive _v) then {
            _startTime = SUPPORT_CYCLES;
            waitUntil {sleep 10; ((SUPPORT_CYCLES - _startTime) >= _s)};
	    	if (!isNull _v) then {
                deleteVehicle _v;
            };
	    	_v = createVehicle [_t,[(random 1000), (random 1000), (10000 + (random 20000))], [], 0, "NONE"];
	    	waitUntil {!isNull _v};
	    	_v setDir _sd;
	    	_v setPos [(_sp select 0), (_sp select 1), ((_sp select 2) + 0.1)];
	    	[_v] call _i;
	    	_v addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
	    } else {;
            if (isMultiplayer) then {_u = playableUnits;} else {_u = switchableUnits;};
            if (_v isKindOf "Quadbike_01_base_F") then {
                if ((_v distance _sp) > DIST_FROM_SPAWN_QUADBIKE) then {
                    if (({(_v distance _x) < 40} count _u) < 1) then {
                        if ((count (crew _v)) == 0) then {
                            _v lock 0;
                            _v setDir _sd;
                            _v setPos _sp;
                            _v allowDamage TRUE;
                            _v setDamage 0;
                            _v setVehicleAmmo 1;
                            _v setVelocity [0, 0, 0];
                            [[_v, 1],"setFuel", true, false] spawn BIS_fnc_MP;
                            [[_v, FALSE],"engineOn", true, false] spawn BIS_fnc_MP;
                            if (isCollisionLightOn _v) then {_v setCollisionLight FALSE;};
                            if (isLightOn _v) then {_v setPilotLight FALSE;};                            
                        };
                    };
                };
            } else {
        	    if ((_v distance _sp) > DIST_FROM_SPAWN) then {    	    	
        	    	if (({(_v distance _x) < PARAMS_VehicleRespawnDistance} count _u) < 1) then {
        	    		if ((count (crew _v)) == 0) then {
        	    			_v lock 0;
        	    			_v setDir _sd;
        	    			_v setPos _sp;
        	    			_v allowDamage TRUE;
        	    			_v setDamage 0;
        	    			_v setVehicleAmmo 1;
        	    			_v setVelocity [0, 0, 0];
        	    			[[_v, 1],"setFuel", true, false] spawn BIS_fnc_MP;
        	    			[[_v, FALSE],"engineOn", true, false] spawn BIS_fnc_MP;                        
        	    			if (isCollisionLightOn _v) then {_v setCollisionLight FALSE;};
        	    			if (isLightOn _v) then {_v setPilotLight FALSE;};
        	    		};
        	    	};
        	    };
            };
        };
    };
	sleep 30;
};