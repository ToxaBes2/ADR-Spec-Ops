/*
Author:	malashin
Description: Repair, rearm and refuel a plane
*/

private ["_veh", "_fuel", "_dmgList", "_dmgSum", "_mags", "_ammo"];
_veh = _this;
_uavs = ["B_UAV_01_F","B_UAV_02_F","B_UAV_05_F","B_UAV_02_CAS_F","B_UGV_01_F","B_UGV_01_rcws_F","I_UAV_01_F","I_UAV_02_F","I_UAV_02_CAS_F","I_UGV_01_F","I_UGV_01_rcws_F",
"O_UAV_01_F","O_UAV_02_F","O_UAV_02_CAS_F","O_UGV_01_F","O_UGV_01_rcws_F","B_T_UAV_03_F","O_T_UAV_04_CAS_F","B_UAV_02_dynamicLoadout_F","B_T_UAV_03_dynamicLoadout_F"];

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};
if (!(_veh isKindOf "Plane") or ((typeOf _veh) in _uavs)) exitWith {
	systemChat "Эта площадка только для самолетов";
};

//Start the procedure
systemChat "Обслуживание. Пожалуйста ждите ...";
_fuel = fuel _veh;
_veh setFuel 0;
uiSleep 2;

//Repair
_dmgList = getAllHitPointsDamage _veh;
_dmgSum = 0;
{_dmgSum = _dmgSum + _x;} forEach (_dmgList select 2);
if (_dmgSum > 0) then {
	systemChat "Ремонт ...";
	uiSleep (5 + _dmgSum * 5);
};
_veh setDamage 0;

//Rearming
_mags = magazinesAllTurrets _veh;
if (count _mags != 0) then {
    _ammo = 0;
    {_ammo = _ammo + (_x select 2) / (getNumber (configFile >> "CfgMagazines" >> (_x select 0) >> "count"));} forEach _mags;
    _ammo = _ammo / (count _mags);
    if (_ammo < 1) then {
    	systemChat "Перезарядка ...";
    	uiSleep (5 + (1 - _ammo) * 30);
    };
};
_veh setVehicleAmmo 1;

//Refuel
systemChat "Заправка ...";
uiSleep (5 + (1 - _fuel) * 60);
_veh setFuel 1;

//Finished
systemChat "Обслуживание завершено. Приятного полета!";
