/*
Author: ToxaBes
Description: defuse the bomb
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
if (BLOCKED_DEVICES == 0) then {
	hqSideChat = "Отключено устройств: 1 из 2х";
} else {
	hqSideChat = "Отключено устройств: 2 из 2х";
};
BLOCKED_DEVICES = BLOCKED_DEVICES + 1; publicVariable "BLOCKED_DEVICES";
sleep 2;
publicVariable "hqSideChat";
[WEST, "HQ"] sideChat hqSideChat;
deleteVehicle _object;
