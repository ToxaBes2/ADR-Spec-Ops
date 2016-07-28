private ["_points", "_unit", "_smoke", "_light", "_fire", "_null"];

_points = 10;
_unit = _this select 1;
_unit addScore _points;
["ScoreBonus", ["База партизан уничтожена!", _points]] remoteExec ["BIS_fnc_showNotification", _unit];

sleep 1;
_smoke = createVehicle ["SmokeShell", [0, 0, 0], [], 0, 'NONE'];
_smoke attachTo [partizan_flag, [-0.1, -0.4, -3.9]];
_light = createVehicle ["Chemlight_red", [0, 0, 0], [], 0, 'NONE'];
_light attachTo [partizan_flag, [-0.1, -0.4, -3.9]];
_fire = createVehicle ["FirePlace_burning_F", [0, 0, 0], [], 0, 'NONE'];
_fire attachTo [partizan_flag, [-0.1, -0.4, -3.9]];
detach _smoke;
detach _light;
detach _fire;
playSound3D ["A3\sounds_f\sfx\special_sfx\sparkles_wreck_3.wss", partizan_flag, false, getPosASL partizan_flag, 2, 1, 100];
sleep 4;
playSound3D ["A3\sounds_f\sfx\fire2_loop.wss", partizan_flag, false, getPosASL partizan_flag, 5, 1, 300];
sleep 12;
playSound3D ["A3\sounds_f\sfx\fire2_loop.wss", partizan_flag, false, getPosASL partizan_flag, 5, 1, 300];

clearWeaponCargoGlobal partizan_ammo;
clearMagazineCargoGlobal partizan_ammo;
clearItemCargoGlobal partizan_ammo;

_null = [] call QS_fnc_createPartizanBase;

sleep 30;
if (!isNil {_smoke}) then {deleteVehicle _smoke};
if (!isNil {_light}) then {deleteVehicle _light};
if (!isNil {_fire}) then {deleteVehicle _fire};
