_center = _this select 0;
systemChat "Сброс модуля...";
_radius = 100;
_height = 200;
_pos = [
	(_center select 0),
	(_center select 1),
	_height
];
_parachute = createVehicle ["B_Parachute_02_F", [100, 100, 200], [], 0, 'FLY'];
_parachute setPos _pos;
_parachute allowDamage false;
_cargo = createVehicle ["B_Slingload_01_Fuel_F", position _parachute, [], 0, 'NONE'];
_cargo attachTo [_parachute, [0, 0, -0.4]];
_cargo allowDamage false;
_light = createVehicle ["Chemlight_blue", position _parachute, [], 0, 'NONE'];
_light attachTo [_cargo, [0, 0, 0]];
_smoke1 = "SmokeShellBlue" createVehicle [getPos _cargo select 0, getPos _cargo select 1, 3];
_smoke1 attachTo [_cargo, [0, 0, 0]];
clearWeaponCargoGlobal _cargo;
clearMagazineCargoGlobal _cargo;
_cargo addAction ["<t color='#7F0000'>Уничтожить модуль</t>","mission\main\actions\destroyCargo.sqf",[],-21,true,true,"","", 5]; 
[_cargo, "QS_fnc_addActionDestroy", nil, true] spawn BIS_fnc_MP; 
[_cargo, _light, _smoke1] spawn {
    _cargo = _this select 0;
    _light = _this select 1;
    _smoke1 = _this select 2;
    _smoke2 = _this select 3;
    sleep 15;
    hqSideChat = "Модуль сброшен!"; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
    _smoke2 = createVehicle ["SmokeShellBlue", position _cargo, [], 0, 'NONE'];
    _smoke2 attachTo [_cargo, [0, 0, 0.5]];
	waitUntil {(getPos _cargo select 2) < 3};
    detach _cargo;
    sleep 5;
    _cargo allowDamage true;
    _smoke3 = createVehicle ["SmokeShellBlue", position _cargo, [], 0, 'NONE'];
    _smoke3 attachTo [_cargo, [0, 0, 0.5]];
    sleep 1800;
    if (!isNil {_cargo}) then {deleteVehicle _cargo};
    if (!isNil {_light}) then {deleteVehicle _light};
    if (!isNil {_smoke1}) then {deleteVehicle _smoke1};
    if (!isNil {_smoke2}) then {deleteVehicle _smoke2};
    if (!isNil {_smoke3}) then {deleteVehicle _smoke3};
};
