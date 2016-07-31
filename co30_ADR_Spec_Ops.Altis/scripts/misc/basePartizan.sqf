private ["_activeTimer", "_light", "_null"];

// Variables
_activeTimer = 900;	// How long will it remain active for, in seconds. 300 = 5 minutes

// Restrict use of this action while procedure is in progress
BASEPARTIZAN_SWITCH = true; publicVariable "BASEPARTIZAN_SWITCH";

sleep 1;
_light = createVehicle ["Chemlight_green", [0, 0, 0], [], 0, 'NONE'];
_light attachTo [partizan_flag, [-0.1, -0.4, -3.9]];
detach _light;
playSound3D ["A3\sounds_f\sfx\objects\upload_terminal\Terminal_antena_open.wss", partizan_flag, false, getPosASL partizan_flag, 2, 1, 100];
sleep 6;
playSound3D ["A3\sounds_f\sfx\radio\ambient_radio27.wss", partizan_flag, false, getPosASL partizan_flag, 5, 1, 300];
sleep 16;
playSound3D ["A3\sounds_f\sfx\radio\ambient_radio28.wss", partizan_flag, false, getPosASL partizan_flag, 5, 1, 300];
sleep 13;
playSound3D ["A3\sounds_f\sfx\radio\ambient_radio28.wss", partizan_flag, false, getPosASL partizan_flag, 5, 1, 300];
sleep 15;
if (!isNil {_light}) then {deleteVehicle _light};

_null = [] call QS_fnc_createPartizanBase;


//---------- Active time
uiSleep _activeTimer;
BASEPARTIZAN_SWITCH = false; publicVariable "BASEPARTIZAN_SWITCH";
