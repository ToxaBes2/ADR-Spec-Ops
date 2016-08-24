private ["_activeTimer", "_light", "_null"];

// Restrict use of this action while procedure is in progress
BASEPARTIZAN_SWITCH = true; publicVariable "BASEPARTIZAN_SWITCH";

sleep 1;
playSound3D ["A3\sounds_f\sfx\objects\upload_terminal\Terminal_antena_open.wss", partizan_ammo, false, getPosASL partizan_ammo, 2, 1, 100];
sleep 6;
_light = createVehicle ["Chemlight_green", [0, 0, 0], [], 0, 'NONE'];
_light attachTo [partizan_ammo, [0, 0, 0.81]];
detach _light;
playSound3D ["A3\sounds_f\sfx\radio\ambient_radio27.wss", partizan_ammo, false, getPosASL partizan_ammo, 5, 1, 300];
sleep 16;
playSound3D ["A3\sounds_f\sfx\radio\ambient_radio28.wss", partizan_ammo, false, getPosASL partizan_ammo, 5, 1, 300];
sleep 13;
playSound3D ["A3\sounds_f\sfx\radio\ambient_radio28.wss", partizan_ammo, false, getPosASL partizan_ammo, 5, 1, 300];
sleep 5;
if (!isNil {_light}) then {deleteVehicle _light};
_null = [] call QS_fnc_createPartizanBase;
