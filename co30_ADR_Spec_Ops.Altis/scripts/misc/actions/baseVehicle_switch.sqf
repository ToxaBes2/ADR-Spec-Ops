private ["_ammoPos", "_vehiclePos", "_params", "_mode", "_class", "_dist", "_accepted", "_diff"];

_box = _this select 0;
_ammoPos = getPos _box;
_vehiclePos = [0,0,0];
_params = _this select 3;
_mode = _params select 0;
_class = "";

// Stop showing submenu actions on partizan arsenal box
adr_partizan_submenu = false;

// Tell player if vehicle can not be spawned at the moment
if (isNil "PARTIZAN_VEHICLE_TIME") then {
    PARTIZAN_VEHICLE_TIME = time - 1; publicVariable "PARTIZAN_VEHICLE_TIME";
};
_diff = PARTIZAN_VEHICLE_TIME - time;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Вызов данной техники будет доступен через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

// Determine class of the vehicle that player wants to spawn
switch (_mode) do {
	case "quadbike" : {
        if (worldName == "Tanoa") then {
            _class = "B_T_Quadbike_01_F";
        } else {
            _class = "B_Quadbike_01_F";
        };
    };
	case "suv" : {
        _class = "C_SUV_01_F";
    };
    case "offroad" : {
        _class = "I_G_Offroad_01_F";
    };
    case "jeep" : {
        _class = "C_Offroad_02_unarmed_F";
    };
    case "hatchback" : {
        _class = "C_Hatchback_01_sport_F";
    };
    case "ship" : {
        _class = "I_C_Boat_Transport_02_F";
    };
    case "truck" : {
        _class = "I_G_Van_01_transport_F";
    };
    case "van" : {
        _class = "I_G_Van_02_transport_F";
    };
};

// Find suitable position
if (_class == "I_C_Boat_Transport_02_F") then {
	_dist = 100;
	_accepted = false;
	_vehiclePos = [_ammoPos, 3, _dist, 0.1, 2, -1, 0] call QS_fnc_findSafePos;
	if !(_vehiclePos isEqualTo [0,0,0]) then {
		_vehiclePos = _vehiclePos findEmptyPosition [0, 5, _class];
		if (count _vehiclePos > 0) then {
		    if (_vehiclePos distance2D _ammoPos <= _dist) then {
		        _accepted = true;
		    };
		};
	};
	while {!_accepted and (_dist <= 200)} do {
	    _dist = _dist + 10;
	    _vehiclePos = [_ammoPos, 3, _dist, 0.5, 2, -1, 0] call QS_fnc_findSafePos;
		if !(_vehiclePos isEqualTo [0,0,0]) then {
		    _vehiclePos = _vehiclePos findEmptyPosition [0, 5, _class];
		    if (count _vehiclePos > 0) then {
		        if (_vehiclePos distance2D _ammoPos <= _dist) then {
		            _accepted = true;
		        };
		    };
		};
	};
} else {
	_dist = 10;
	_accepted = false;
	_vehiclePos = [_ammoPos, 3, _dist, 0.5, 0, 1, 0] call QS_fnc_findSafePos;
	if !(_vehiclePos isEqualTo [0,0,0]) then {
		_vehiclePos = _vehiclePos findEmptyPosition [0, 5, _class];
		if (count _vehiclePos > 0) then {
		    if (_vehiclePos distance2D _ammoPos <= _dist) then {
		        _accepted = true;
		    };
		};
	};
	while {!_accepted and (_dist <= 200)} do {
	    _dist = _dist + 10;
	    _vehiclePos = [_ammoPos, 3, _dist, 0.5, 0, 1, 0] call QS_fnc_findSafePos;
		if !(_vehiclePos isEqualTo [0,0,0]) then {
		    _vehiclePos = _vehiclePos findEmptyPosition [0, 5, _class];
		    if (count _vehiclePos > 0) then {
		        if (_vehiclePos distance2D _ammoPos <= _dist) then {
		            _accepted = true;
		        };
		    };
		};
	};
};

// Tell player if there is no suitalbe position to spawn the vehicle
if ((_vehiclePos distance _ammoPos) > 200) exitWith {
    ["<t color='#F44336' size = '.48'>Нет места для данной техники</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

// Update vehicle spawn cooldown
PARTIZAN_VEHICLE_TIME = time + 120; publicVariable "PARTIZAN_VEHICLE_TIME";

// Spawn the vehicle
["<t color='#7FDA0B' size = '.48'>Вызываем технику...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
sleep 1;
[_vehiclePos, _class] remoteExec ["QS_fnc_baseVehiclePartizan", 2];
