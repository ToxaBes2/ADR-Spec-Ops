/*
Author:	malashin
Description: Repair, rearm and refuel a helicopter
*/

private ["_veh", "_fuel", "_dmgList", "_dmgSum", "_mags", "_ammo"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};
if (!(_veh isKindOf "helicopter")) exitWith {
	_veh vehicleChat "Эта площадка только для вертолетов";
};

//Start the procedure
_veh vehicleChat "Обслуживание. Пожалуйста ждите ...";
_fuel = fuel _veh;
_veh setFuel 0;
uiSleep 2;

//Repair
_dmgList = getAllHitPointsDamage _veh;
_dmgSum = 0;
{_dmgSum = _dmgSum + _x;} forEach (_dmgList select 2);
if (_dmgSum > 0) then {
	_veh vehicleChat "Ремонт ...";
	uiSleep (5 + _dmgSum * 4);
};
_veh setDamage 0;

//Rearming
_mags = magazinesAllTurrets _veh;
_ammo = 0;
{_ammo = _ammo + (_x select 2) / (getNumber (configFile >> "CfgMagazines" >> (_x select 0) >> "count"));} forEach _mags;
_ammo = _ammo / (count _mags);
if (_ammo < 1) then {
	_veh vehicleChat "Перезарядка ...";
	uiSleep (5 + (1 - _ammo) * 30);
};
_veh setVehicleAmmo 1;

//Refuel
_veh vehicleChat "Заправка ...";
uiSleep (5 + (1 - _fuel) * 30);
_veh setFuel 1;

//Finished
_veh vehicleChat "Обслуживание завершено. Приятного полета!";
