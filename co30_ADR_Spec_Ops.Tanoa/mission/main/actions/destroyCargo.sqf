/*
Author: ToxaBes
Description: destroy cargo
*/
#define ENEMY_SIDE EAST
private ["_player", "_stance", "_raised", "_weapon", "_object", "_points"];
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
_object = _this select 0;
_object removeAction 0;
_object removeAction 1;
_smoke = createVehicle ["SmokeShell", [0, 0, 0], [], 0, 'NONE'];
_smoke attachTo [_object, [0, 0, -0.2]];
_light = createVehicle ["Chemlight_red", [0, 0, 0], [], 0, 'NONE'];
_light attachTo [_object, [0, 0, -0.2]];
detach _smoke;
detach _light;
playSound3D ["A3\sounds_f\sfx\special_sfx\sparkles_wreck_3.wss", _object, false, getPosASL _object, 2, 1, 100];
sleep 4;
playSound3D ["A3\sounds_f\sfx\fire2_loop.wss", _object, false, getPosASL _object, 5, 1, 300];
sleep 6;
deleteVehicle _object;
sleep 2;
if (!isNil {_smoke}) then {deleteVehicle _smoke};
if (!isNil {_light}) then {deleteVehicle _light};
