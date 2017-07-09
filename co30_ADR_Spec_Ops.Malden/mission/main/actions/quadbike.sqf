/*
Author: ToxaBes
Description: quadbike call on avanpost
*/
// Tell player if vehicle can not be spawned at the moment
_vehiclePos = [0,0,0];
if (isNil "AVANPOST_VEHICLE_TIME") then {
    AVANPOST_VEHICLE_TIME = time - 1; publicVariable "AVANPOST_VEHICLE_TIME";
};
_diff = AVANPOST_VEHICLE_TIME - time;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Вызов техники будет доступен через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_class = "B_Quadbike_01_F";
if (worldName == "Tanoa") then {
    _class = "B_T_Quadbike_01_F";
};

_dist = 10;
_accepted = false;
_vehiclePos = [AVANPOST_COORDS, 3, _dist, 0.5, 0, 1, 0] call QS_fnc_findSafePos;
if !(_vehiclePos isEqualTo [0,0,0]) then {
	_vehiclePos = _vehiclePos findEmptyPosition [0, 5, _class];
	if (count _vehiclePos > 0) then {
	    if (_vehiclePos distance2D AVANPOST_COORDS <= _dist) then {
	        _accepted = true;
	    };
	};
};
while {!_accepted and (_dist <= 20)} do {
    _dist = _dist + 5;
    _vehiclePos = [AVANPOST_COORDS, 3, _dist, 0.5, 0, 1, 0] call QS_fnc_findSafePos;
	if !(_vehiclePos isEqualTo [0,0,0]) then {
	    _vehiclePos = _vehiclePos findEmptyPosition [0, 5, _class];
	    if (count _vehiclePos > 0) then {
	        if (_vehiclePos distance2D AVANPOST_COORDS <= _dist) then {
	            _accepted = true;
	        };
	    };
	};
};

// Tell player if there is no suitable position to spawn the vehicle
if ((_vehiclePos distance AVANPOST_COORDS) > 25) exitWith {
    ["<t color='#F44336' size = '.48'>Нет места для данной техники</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

// Update vehicle spawn cooldown
AVANPOST_VEHICLE_TIME = time + 120; publicVariable "AVANPOST_VEHICLE_TIME";

// Spawn the vehicle
["<t color='#7FDA0B' size = '.48'>Техника появилась в радиусе 20м</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
sleep 1;
[_vehiclePos, _class] remoteExec ["QS_fnc_baseVehicleAvanpost", 2];