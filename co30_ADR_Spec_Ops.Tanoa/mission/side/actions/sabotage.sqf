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

//-------------------- Wait for player to action
[[player, "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon"], "QS_fnc_switchMoveMP", nil, false] spawn BIS_fnc_MP;

sleep 1;

//-------------------- Send hint to player that he's planted the bomb
hint "Заряд установлен. Ожидайте...";

sleep 1;

SM_SUCCESS = true; publicVariable "SM_SUCCESS";