private ["_vehiclePos", "_class", "_veh"];

_vehiclePos = _this select 0;
_class = _this select 1;
_veh = createVehicle [_class, _vehiclePos, [], 0, "NONE"];
_veh setDir (random 360);
_veh lock 0;
_veh setVariable ["irTarget", false, true];

// Delete vehicle if there are no palyers nearby
0 = [_veh, _vehiclePos] spawn {
    private ["_veh", "_vehiclePos", "_u"];
    _veh = _this select 0;
    _vehiclePos = _this select 1;
    while {true} do {
        sleep 60;
        if (_vehiclePos distance2D _veh > 100) then {
            _u = [];
            if (isMultiplayer) then {
                {
                    _u pushBack _x;
                } forEach playableUnits;
            } else {
                {
                    _u pushBack _x;
                } forEach switchableUnits;
            };
            _remove = true;
            {            
                if (_remove && {(_veh distance2D _x) < 150}) then {
                    _remove = false;                    
                };
            } forEach _u;
            if (_remove && {count (crew _veh) == 0}) then {
                deleteVehicle _veh;
            };
        };
    };
};

// Delete attached objects from destroyed vehicle
_veh addEventHandler ["Killed",{{deleteVehicle _x;} forEach attachedObjects (_this select 0);}];
_veh addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
true
