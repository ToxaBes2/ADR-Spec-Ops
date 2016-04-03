private ["_crateType", "_smokeType", "_lightType", "_reloadtime", "_timedel", "_cargo", "_light", "_smoke", "_chute"];

if (!(BACO_ammoSuppAvail)) exitWith {
	hint "Модуль в данный момент не доступен!"
};
BACO_ammoSuppAvail = FALSE; publicVariable "BACO_ammoSuppAvail";

//------------------------------------------------------- Переменные

_crateType =  "Land_Pod_Heli_Transport_04_covered_F";// Транспортный контейнер для Тару
_smokeType =  "SmokeShellPurple";
_lightType =  "Chemlight_blue";
_reloadtime = 60;									// Время до повторного вызова
_timedel = 600;										// Время до удаления

//------------------------------------------------------- Создание посылки

_cargo = _crateType createVehicle (getMarkerPos "Ammo_Supply_drop"); publicVariable "Supply_Ammo"; 
_cargo allowDamage false;

//------------------------------------------------------- Действие с парашютом и контейнером
sleep 0.1;
waitUntil {!isNull (ropeAttachedTo _cargo)};
sleep 0.5;
waitUntil {isNull (ropeAttachedTo _cargo)};
if (getPos _cargo select 2 < 50) then {hint 'Модуль сброшен без парашюта    (малая высота)'} else {
sleep 3;
waitUntil {getPos _cargo select 2 <= 120};
_light = createVehicle [_lightType, position _cargo, [], 0, 'NONE'];
_light attachTo [_cargo, [0, 2, 0.15]];

_chute = createVehicle ["B_Parachute_02_F", position _cargo, [], 0, "CAN_COLLIDE"];
_cargo attachTo [_chute, [0, 0, 0]];

waitUntil {getPos _cargo select 2 < 4 || isNull _chute};
sleep 0.2;
detach _cargo;
sleep 10;
_smoke = _smokeType createVehicle [getPos _cargo select 0, getPos _cargo select 1,5];
};
sleep _reloadtime; BACO_ammoSuppAvail = TRUE; publicVariable "BACO_ammoSuppAvail";
//--------------------------------------------------------- Удаление контейнера

sleep _timedel;
deleteVehicle Supply_Ammo;