/*
Author: ToxaBes
Description: neutralize gas barrel
*/
private ["_stance", "_raised", "_weapon", "_object"];

// Determine what animation to play
// If player is prone play kneeling animation
_stance = "Pknl";
_raised = "Sras";
_weapon = "Wrfl";
if (stance player == "STAND") then {
    _stance = "Perc";
};
if (weaponLowered player) then {
    _raised = "Slow";
};
call {
    if ((currentWeapon player == handgunWeapon player) and (handgunWeapon player != "")) exitWith {
        _weapon = "Wpst";
    };
    if ((currentWeapon player == secondaryWeapon player) and (secondaryWeapon player != "")) exitWith {
        _weapon = "Wlnr";
    };
    if (currentWeapon player == "") exitWith {
        _raised = "Snon";
        _weapon = "Wnon";
    };
};

// Play animation
player playMove ("Ainv" + _stance + "Mstp" + _raised + _weapon + "Dnon_Putdown_Amov" + _stance + "Mstp" + _raised + _weapon + "Dnon");

_object = _this select 0;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
hqSideChat = "Отравляющее вещество обнаружено и нейтрализовано!";
SM_YELLOWFOG_SUCCESS = true; publicVariable "SM_YELLOWFOG_SUCCESS";
if (side player == west) then {
    WIN_WEST = WIN_WEST + 1; publicVariable "WIN_WEST";
} else {
    WIN_GUER = WIN_GUER + 1; publicVariable "WIN_GUER";
};
sleep 2;
publicVariable "hqSideChat";
[playerSide, "HQ"] sideChat hqSideChat;
deleteVehicle _object;
