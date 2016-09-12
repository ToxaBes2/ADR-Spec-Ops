/*
Author: ToxaBes
Description: take control on command center
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
_points = 10;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
MAIN_AO_SUCCESS = true; publicVariable "MAIN_AO_SUCCESS";
[_object, 0] call BIS_fnc_dataTerminalAnimate;
["ScoreBonus", ["Командный пункт захвачен!", _points]] remoteExec ["BIS_fnc_showNotification", _player];
[_player, _points] remoteExec ["addScore", 2];
WinBunker = side _player; publicVariable "WinBunker";
if (WinBunker isEqualTo resistance) then {
    [1] call QS_fnc_partizanSUCCESS;
}; 
