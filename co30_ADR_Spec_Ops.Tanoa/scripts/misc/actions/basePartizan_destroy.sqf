private ["_points", "_unit", "_smoke", "_light", "_fire", "_null"];

_points = 10;
_unit = _this select 1;
_unit addScore _points;
["ScoreBonus", ["База партизан уничтожена!", _points]] remoteExec ["BIS_fnc_showNotification", _unit];

sleep 1;
_smoke = createVehicle ["SmokeShell", [0, 0, 0], [], 0, 'NONE'];
_smoke attachTo [partizan_ammo, [0, 0, -0.8]];
_light = createVehicle ["Chemlight_red", [0, 0, 0], [], 0, 'NONE'];
_light attachTo [partizan_ammo, [0, 0, -0.8]];
_fire = createVehicle ["FirePlace_burning_F", [0, 0, 0], [], 0, 'NONE'];
_fire attachTo [partizan_ammo, [0, 0, -0.8]];
detach _smoke;
detach _light;
detach _fire;
playSound3D ["A3\sounds_f\sfx\special_sfx\sparkles_wreck_3.wss", partizan_ammo, false, getPosASL partizan_ammo, 2, 1, 100];
sleep 4;
playSound3D ["A3\sounds_f\sfx\fire2_loop.wss", partizan_ammo, false, getPosASL partizan_ammo, 5, 1, 300];
sleep 12;
playSound3D ["A3\sounds_f\sfx\fire2_loop.wss", partizan_ammo, false, getPosASL partizan_ammo, 5, 1, 300];

clearWeaponCargoGlobal partizan_ammo;
clearMagazineCargoGlobal partizan_ammo;
clearItemCargoGlobal partizan_ammo;

partizan_ammo addItemCargoGlobal ["U_I_Wetsuit", 4];
partizan_ammo addItemCargoGlobal ["V_RebreatherIA", 4];
partizan_ammo addItemCargoGlobal ["G_Diving", 4];
partizan_ammo addItemCargoGlobal ["U_I_Wetsuit", 4];
partizan_ammo addWeaponCargoGlobal ["arifle_SDAR_F", 4];
partizan_ammo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 7];
partizan_ammo addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Yellow", 7];
partizan_ammo addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Green", 7];
partizan_ammo addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Yellow", 7];
partizan_ammo addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 28];
partizan_ammo addMagazineCargoGlobal ["30Rnd_545x39_Mag_F", 7];
partizan_ammo addMagazineCargoGlobal ["30Rnd_545x39_Mag_Green_F", 7];
partizan_ammo addMagazineCargoGlobal ["30Rnd_545x39_Mag_Tracer_F", 7];
partizan_ammo addMagazineCargoGlobal ["30Rnd_545x39_Mag_Tracer_Green_F", 7];
partizan_ammo addItemCargoGlobal ["FirstAidKit", 20];
partizan_ammo addItemCargoGlobal ["Medikit", 2];
partizan_ammo addItemCargoGlobal ["ToolKit", 2];

PARTIZAN_REWARDS_LIST = []; publicVariable "PARTIZAN_REWARDS_LIST";
_null = [] call QS_fnc_createPartizanBase;

sleep 30;
if (!isNil {_smoke}) then {deleteVehicle _smoke};
if (!isNil {_light}) then {deleteVehicle _light};
if (!isNil {_fire}) then {deleteVehicle _fire};
