private ["_crateType", "_smokeType", "_lightType", "_reloadtime", "_timedel", "_cargo", "_light1", "_light2", "_light3", "_smoke1", "_smoke2", "_chute"];

if (!(BACO_ammoSuppAvail)) exitWith {
	hint "Модуль в данный момент не доступен!"
};
BACO_ammoSuppAvail = FALSE; publicVariable "BACO_ammoSuppAvail";

//------------------------------------------------------- Переменные

_crateType =  "Land_Pod_Heli_Transport_04_ammo_F";	// Контейнер с боеприпасами для Тару
_smokeType =  "SmokeShellPurple";
_lightType =  "Chemlight_blue";
_reloadtime = 60;									// Время до повторного вызова
_timedel = 600;										// Время до удаления

//------------------------------------------------------- Создание посылки

_cargo = _crateType createVehicle (getMarkerPos "Ammo_Supply_drop"); publicVariable "Supply_Ammo"; 

//------------------------------------------------------- Действие с парашютом и контейнером
sleep 0.1;
waitUntil {!isNull (ropeAttachedTo _cargo)};
sleep 0.5;
waitUntil {isNull (ropeAttachedTo _cargo)};
if (getPos _cargo select 2 < 50) then {hint 'Модуль сброшен без парашюта    (малая высота)'} else {
sleep 3;
waitUntil {getPos _cargo select 2 <= 120};
_light1 = createVehicle [_lightType, position _cargo, [], 0, 'NONE'];
_light2 = createVehicle [_lightType, position _cargo, [], 0, 'NONE'];
_light3 = createVehicle [_lightType, position _cargo, [], 0, 'NONE'];
_light1 attachTo [_cargo, [-1, 0, 0.15]];
_light2 attachTo [_cargo, [0, 1, 0.15]];
_light3 attachTo [_cargo, [1, 0, 0.15]];
_smoke1 = createVehicle [_smokeType, position _cargo, [], 0, 'NONE'];
_smoke1 attachTo [_cargo, [0, 2, 0]];

_chute = createVehicle ["B_Parachute_02_F", position _cargo, [], 0, "CAN_COLLIDE"];
_cargo attachTo [_chute, [0, 0, 0]];

waitUntil {getPos _cargo select 2 < 4 || isNull _chute};
sleep 0.2;
detach _cargo;
sleep 10;
_smoke2 = _smokeType createVehicle [getPos _cargo select 0, getPos _cargo select 1,5];
};
sleep _reloadtime; BACO_ammoSuppAvail = TRUE; publicVariable "BACO_ammoSuppAvail";
//--------------------------------------------------------- Удаление контейнера

sleep _timedel;
deleteVehicle Supply_Ammo;