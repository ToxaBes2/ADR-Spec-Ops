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
_randomPos = [[[getPos _veh, 750], []], ["water", "out"]] call QS_fnc_randomPos;
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
