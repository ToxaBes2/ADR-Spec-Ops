private ["_cargo", "_crateType", "_smokeType", "_lightType", "_timereload", "_timedel", "_cargo_pos", "_chute", "_velocity", "_light1", "_light2", "_light3", "_Signal2", "_Signal"];

if (!(BACO_ammoSuppAvail2)) exitWith {
	hint "Модуль в данный момент не доступен!"
};

BACO_ammoSuppAvail2 = FALSE; publicVariable "BACO_ammoSuppAvail2";

//------------------------------------------------------- Переменные

_crateType =  "B_supplyCrate_F";
_smokeType =  "SmokeShellPurple";
_lightType =  "Chemlight_blue";
_timereload = 300;
_timedel = 600; // +timereload
_cargo_pos = [0,0,0];

//--------------------------------------------------------- Создание посылки

_cargo = _crateType createVehicle (getMarkerPos "Ammo_Supply_drop"); publicVariable "_cargo";
_cargo allowDamage false;

//---------------------------------------------------- Разгрузка посылки

clearWeaponCargoGlobal _cargo;
clearMagazineCargoGlobal _cargo;
clearItemCargoGlobal _cargo;
clearBackpackCargoGlobal _cargo;

//---------------------------------------------------- Загрузка посылки

_cargo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 10];
_cargo addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Green", 10];
_cargo addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 10];
_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 10]; 
_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 10]; 
_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer", 10]; 
_cargo addMagazineCargoGlobal ["5Rnd_127x108_Mag", 15]; 
_cargo addMagazineCargoGlobal ["7Rnd_408_Mag", 15]; 
_cargo addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 20]; 
_cargo addMagazineCargoGlobal ["10Rnd_127x54_Mag", 20]; 
_cargo addMagazineCargoGlobal ["10Rnd_338_Mag", 20]; 
_cargo addMagazineCargoGlobal ["20Rnd_762x51_Mag", 20]; 
_cargo addMagazineCargoGlobal ["10Rnd_762x54_Mag", 20]; 
_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 20]; 
_cargo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer", 10]; 
_cargo addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer", 10]; 
_cargo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 10]; 
_cargo addMagazineCargoGlobal ["150Rnd_93x64_Mag", 10]; 
_cargo addMagazineCargoGlobal ["130Rnd_338_Mag", 10]; 
_cargo addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2]; 
_cargo addMagazineCargoGlobal ["HandGrenade", 6]; 
_cargo addMagazineCargoGlobal ["MiniGrenade", 6]; 
_cargo addMagazineCargoGlobal ["SmokeShell", 6]; 
_cargo addMagazineCargoGlobal ["SmokeShellGreen", 6]; 
_cargo addMagazineCargoGlobal ["SmokeShellBlue", 6]; 
_cargo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 16]; 
_cargo addMagazineCargoGlobal ["RPG32_HE_F", 5]; 
_cargo addMagazineCargoGlobal ["RPG32_F", 7]; 
_cargo addMagazineCargoGlobal ["NLAW_F", 5]; 
_cargo addMagazineCargoGlobal ["Titan_AT", 3]; 
_cargo addMagazineCargoGlobal ["Titan_AA", 3];
_cargo addMagazineCargoGlobal ["Laserbatteries", 5];
_cargo addItemCargoGlobal ["FirstAidKit", 20]; 
_cargo addItemCargoGlobal ["Medikit", 1]; 
_cargo addItemCargoGlobal ["ToolKit", 1]; 
_cargo addBackpackCargoGlobal ["B_AssaultPack_rgr", 2];
_cargo addBackpackCargoGlobal ["B_Kitbag_mcamo", 2];

sleep 0.5;
waitUntil{!isNull (ropeAttachedTo _cargo)};
sleep 0.5;
waitUntil{isNull (ropeAttachedTo _cargo)};
sleep 2;
waitUntil{(getPos _cargo select 2)<=120};

_velocity = velocity _cargo;
_light1 = createVehicle [_lightType, position _cargo, [], 0, 'NONE'];
_light2 = createVehicle [_lightType, position _cargo, [], 0, 'NONE'];
_light3 = createVehicle [_lightType, position _cargo, [], 0, 'NONE'];
_light1 attachTo [_cargo, [-0.7, 0, 0.15]];
_light2 attachTo [_cargo, [0, 0.5, 0.15]];
_light3 attachTo [_cargo, [0.7, 0, 0.15]];
_Signal2 = createVehicle [_smokeType, position _cargo, [], 0, 'NONE'];
_Signal2 attachTo [_cargo, _cargo_pos];

_chute = createVehicle ["B_Parachute_02_F", position _cargo, [], 0, "CAN_COLLIDE"];
_cargo attachTo [_chute, _cargo_pos];
_chute setVelocity _velocity;

waitUntil {getPos _cargo select 2 < 4 || isNull _chute};
sleep 0.2;
detach _cargo;
sleep 10;
_Signal = _smokeType createVehicle [getPos _cargo select 0, getPos _cargo select 1,5];

sleep _timereload;
BACO_ammoSuppAvail2 = TRUE; publicVariable "BACO_ammoSuppAvail2";

//--------------------------------------------------------- Удаление контейнера

sleep _timedel;
deleteVehicle _cargo;