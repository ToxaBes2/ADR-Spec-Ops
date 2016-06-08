/*
Author:	malashin
Description: Repair, rearm and refuel a ground vehicle
*/

private ["_veh", "_fuel", "_dmgList", "_dmgSum", "_mags", "_ammo"];
_veh = _this;
_uavs = ["B_UAV_01_F","B_UAV_02_F","B_UAV_02_CAS_F","B_UGV_01_F","B_UGV_01_rcws_F","I_UAV_01_F","I_UAV_02_F","I_UAV_02_CAS_F","I_UGV_01_F","I_UGV_01_rcws_F",
"O_UAV_01_F","O_UAV_02_F","O_UAV_02_CAS_F","O_UGV_01_F","O_UGV_01_rcws_F"];

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};
if (!(_veh isKindOf "LandVehicle") or ((typeOf _veh) in _uavs)) exitWith {
    systemChat "Этот сервис только для наземной техники";
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
	uiSleep (5 + _dmgSum * 4);
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

// Rearm ammo trucks cargo ammo to 32 562 ammo (one full AA rearm)
while {true} do {
    call {
        if ((typeOf _veh) in ["B_Truck_01_ammo_F", "O_Truck_02_Ammo_F", "I_Truck_02_ammo_F"]) exitWith {
            _veh setAmmoCargo 0.000000032562; // 32 562 ammo
        };
        if ((typeOf _veh) == "O_Truck_03_ammo_F") exitWith {
            _veh setAmmoCargo 1.08538;        // 32 562 ammo
        };
    };
    if (getAmmoCargo _veh != 0) exitWith {}; // Due to very low values setAmmoCargo rounds to 0 on first try
};

//Refuel
systemChat "Заправка ...";
uiSleep (5 + (1 - _fuel) * 30);
_veh setFuel 1;

//Finished
systemChat "Обслуживание завершено. Приятного путешествия!";
