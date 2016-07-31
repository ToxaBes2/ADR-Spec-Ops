private ["_activeTimer", "_light", "_null"];

// Variables
_activeTimer = 600;	// How long will it remain active for, in seconds. 300 = 5 minutes

// Restrict use of this action while procedure is in progress
BASEPARTIZAN_SWITCH = true; publicVariable "BASEPARTIZAN_SWITCH";

sleep 1;
playSound3D ["A3\sounds_f\sfx\objects\upload_terminal\Terminal_antena_open.wss", partizan_ammo, false, getPosASL partizan_ammo, 2, 1, 100];
sleep 6;
playSound3D ["A3\sounds_f\sfx\radio\ambient_radio27.wss", partizan_ammo, false, getPosASL partizan_ammo, 5, 1, 300];
sleep 16;
playSound3D ["A3\sounds_f\sfx\radio\ambient_radio28.wss", partizan_ammo, false, getPosASL partizan_ammo, 5, 1, 300];
sleep 13;
playSound3D ["A3\sounds_f\sfx\radio\ambient_radio28.wss", partizan_ammo, false, getPosASL partizan_ammo, 5, 1, 300];
sleep 5;
_null = [] call QS_fnc_createPartizanBase;

//---------- Active time
uiSleep _activeTimer;
BASEPARTIZAN_SWITCH = false; publicVariable "BASEPARTIZAN_SWITCH";
