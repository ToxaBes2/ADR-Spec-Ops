/*
Author: ToxaBes
Description: enable mobile EW.
*/
_veh = _this select 0;
_player = _this select 1;

// Determine what animation to play
// If player is prone play kneeling animation
_stance = "Pknl";
_raised = "Sras";
_weapon = "Wrfl";
if (stance _player == "STAND") then {
    _stance = "Perc";
};
if (weaponLowered _player) then {
    _raised = "Slow";
};
call {
    if ((currentWeapon _player == handgunWeapon _player) and (handgunWeapon _player != "")) exitWith {
        _weapon = "Wpst";
    };
    if ((currentWeapon _player == secondaryWeapon _player) and (secondaryWeapon _player != "")) exitWith {
        _weapon = "Wlnr";
    };
    if (currentWeapon _player == "") exitWith {
        _raised = "Snon";
        _weapon = "Wnon";
    };
};

// Play animation
_player playMove ("Ainv" + _stance + "Mstp" + _raised + _weapon + "Dnon_Putdown_Amov" + _stance + "Mstp" + _raised + _weapon + "Dnon");

sleep 1;
{
    _x action ["EJECT", _veh];
} forEach (crew _veh);
_veh setVariable ["EW_ENABLED", 1, true];
_veh lock 2;
_veh setFuel 0;
_veh setVelocity [0, 0, 0];
_vehPos = getPos _veh;
_randomPos = [[[_vehPos, 750], []], ["water", "out"]] call QS_fnc_randomPos;
_markerName = format ["mkr_%1", ceil time];
_marker = createMarker [_markerName, _randomPos];
_veh setVariable ["EW_MARKER", _markerName, true];
_radius = 1000;
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "SolidBorder";
_marker setMarkerColor "ColorOrange";
_marker setMarkerAlpha 0.5;
_marker setMarkerSize [_radius, _radius];

//EW logic
[_veh, _vehPos, _randomPos, _radius, _markerName] spawn {
    _veh = _this select 0;
    _vehPos = _this select 1;
    _randomPos = _this select 2; 
    _radius = _this select 3; 
    _marker = _this select 4;
    _working = true; 
    while {_working} do {
        if (!alive _veh || (_veh getVariable ["EW_ENABLED", 0]) == 0 || _vehPos distance2D _veh > 10) then {
            _working = false;
        };
        {
            if (_x distance2D _randomPos < _radius) then {
                _x setFuel 0;                
                [_x] spawn {
                    _v = _this select 0;
                    if (_v isKindOf "LandVehicle") then {
                        sleep 5;                    
                    } else {
                        sleep 60;
                    };
                    if (alive _v) then {
                        _v setDamage 1;
                    };                    
                };
            };
        } forEach allUnitsUAV;
        sleep 3;
    };
    try {
        deleteMarker _marker;
    } catch {};
};