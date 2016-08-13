/*
Author:

	Quiksilver

Description:

	Object is teleported to side mission location
	addAction on object executes this script
	when script is done, spawn explosion and teleport object away

	Modified for simplicity and other applications (non-destroy missions).
	BIS_fnc_MP/BIS_fnc_spawn/BIS_fnc_timetostring are all performance hogs.

To do:

	Needs re-framing for 'talk to contact' type missions [DONE]

	This code is now just a variable switch, to be sent back in order that the mission script can continue.

	Does it allow for possibility of failure? I dont know, too tired at the moment.

_______________________________________________________*/

private ["_stance", "_raised", "_weapon"];

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

//-------------------- Send hint to player that he's done something...
hint "Вы приказали ему сдаться";

sleep 1;

//---------- Send notice to all players that something has been done.
HE_SURRENDERS = true; publicVariable "HE_SURRENDERS";
