/*
Author: ToxaBes
Description: deploy avanpost as additional respawn point for bluefor
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
_points = 10;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
[_object,"blue","blue","blue"] call BIS_fnc_DataTerminalColor;
[_object, 3] call BIS_fnc_dataTerminalAnimate;
["ScoreBonus", ["Аванпост противника захвачен!", _points]] remoteExec ["BIS_fnc_showNotification", _player];
[_player, _points] remoteExec ["addScore", 2];

// add respawn point
AVANPOST_RESPAWN = true; publicVariable "AVANPOST_RESPAWN";

// add guards
_staticGroup = createGroup west;
_turrets = nearestObjects [_object, ["StaticWeapon"], 20];
{
    _static = _x;
    "B_T_Support_AMG_F" createUnit [[1,1,1], _staticGroup, "currentGuard = this"];
    currentGuard setPos (getPos _static);
    currentGuard assignAsGunner _static;
    currentGuard moveInGunner _static;
    _static setVectorUp [0,0,1];
} forEach _turrets;