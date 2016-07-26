/*
Credit: Tophe and Quicksilver for earlier monitor script
Author: ToxaBes
Description: Vehicle monitor for partizans. This code must be spawned, not called.
*/
if (!isServer) exitWith { /* GO AWAY PLAYER */ };
private ["_v", "_t", "_d", "_s", "_i", "_sd", "_sp", "_ti", "_u"];
#define DIST_FROM_SPAWN 300
_v = _this select 0;	// vehicle
_d = _this select 1;	//spawn delay
_size = _this select 2;	// object size (radius in meters)
_distance = _this select 3;	// max distance from respawn (radius in meters)
_i = _this select 4;	// init
_t = typeOf _v;			// type
_sd = random 360;		// spawn direction
_sp = getPosATL _v;		// spawn position
_oldBase = getMarkerPos "respawn_guerrila";
sleep (5 + (random 5));
[_v] call _i;
while {true} do {
    _newBase = getMarkerPos "respawn_guerrila";
    if (_oldBase distance2D _newBase > 10) then {
    	_oldBase = getMarkerPos "respawn_guerrila";
        _sd = random 360;		// new spawn direction
        _accepted = false;
        while {!_accepted} do {
            _sp = [_newBase, 2, _distance, 2, 0,-1, 0] call BIS_fnc_findSafePos; // new spawn position
            if (_sp distance _newBase <= _distance) then {
                _accepted = true;
            };
        };
    };
    sleep 5;
	if (!alive _v) then {
		if (({((_sp distance _x) < 1.5)} count (entities "AllVehicles")) < 1) then {
			_ti = time + _d;
			waitUntil {sleep 5; (_ti < time)};
			if (!isNull _v) then {deleteVehicle _v;}; sleep 0.1;
			_sd = random 360;		// new spawn direction
            _accepted = false;
            while {!_accepted} do {
                _sp = [_newBase, 2, _distance, 2, 0,-1, 0] call BIS_fnc_findSafePos; // new spawn position
                if (_sp distance _newBase <= _distance) then {
                    _accepted = true;
                };
            };
			_v = createVehicle [_t,[(random 1000), (random 1000), (10000 + (random 20000))], [], 0, "NONE"]; sleep 0.1;
			waitUntil {!isNull _v}; sleep 0.1;
			_v setDir _sd; sleep 0.1;
			_v setPos [(_sp select 0), (_sp select 1), ((_sp select 2) + 0.1)]; sleep 0.1;
			[_v] call _i;
		};
	};
	sleep (5 + (random 5));
	if ((_v distance _sp) > DIST_FROM_SPAWN) then {
		_u = [];
		if (isMultiplayer) then {			
			{
                if (side _x == resistance) then {
                	_u pushBack _x;
                };
		    } forEach playableUnits;
		} else {
		    {
                if (side _x == resistance) then {
                	_u pushBack _x;
                };
		    } forEach switchableUnits;
	    };
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