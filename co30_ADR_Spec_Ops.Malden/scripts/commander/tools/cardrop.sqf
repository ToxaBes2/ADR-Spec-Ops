_center = _this select 0;
systemChat "Сброс техники...";
_height = 250;
_pos = [
	(_center select 0),
	(_center select 1),
	_height
];
_parachute = createVehicle ["B_Parachute_02_F", [100, 100, 200], [], 0, 'FLY'];
_parachute setPos _pos;
_parachute allowDamage false;
_cargo = createVehicle ["B_LSV_01_unarmed_F", position _parachute, [], 0, 'NONE'];
_color = "Sand";
if (worldName == "Altis") then {
    _color = "Black";

};
if (worldName == "Tanoa") then {
    _color = "Olive";
};
[
    _cargo,
    [_color,1], 
    ["HideDoor1",1,"HideDoor2",1,"HideDoor3",1,"HideDoor4",1]
] call BIS_fnc_initVehicle;
_cargo attachTo [_parachute, [0, 0, -0.4]];
_light = createVehicle ["Chemlight_blue", position _parachute, [], 0, 'NONE'];
_light attachTo [_cargo, [0, 0, 0]];
_smoke1 = "SmokeShellBlue" createVehicle [getPos _cargo select 0, getPos _cargo select 1, 3];
_smoke1 attachTo [_cargo, [0, 0, 0]];
clearWeaponCargoGlobal _cargo;
clearMagazineCargoGlobal _cargo;
[_cargo, _light, _smoke1] spawn {
    _cargo = _this select 0;
    _light = _this select 1;
    _smoke1 = _this select 2;
    sleep 5;
    hqSideChat = "Техника сброшена!"; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
    _smoke2 = createVehicle ["SmokeShellBlue", position _cargo, [], 0, 'NONE'];
    _smoke2 attachTo [_cargo, [0, 0, 0.5]];
	waitUntil {(getPos _cargo select 2) < 2};
    detach _cargo;
    detach _smoke1;
    detach _light;      
};

