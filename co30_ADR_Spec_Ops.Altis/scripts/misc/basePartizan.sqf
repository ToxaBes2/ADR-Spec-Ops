private ["_activeTimer"];

// Variables
_activeTimer = 900;	// How long will it remain active for, in seconds. 300 = 5 minutes

// Restrict use of this action while procedure is in progress
BASEPARTIZAN_SWITCH = true; publicVariable "BASEPARTIZAN_SWITCH";
sleep 1;

_null = [] call QS_fnc_createPartizanBase;

//---------- Active time
sleep _activeTimer;
BASEPARTIZAN_SWITCH = nil; publicVariable "BASEPARTIZAN_SWITCH";
