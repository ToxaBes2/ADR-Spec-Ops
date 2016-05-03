private ["_veh"];
_veh = _this select 0;

if (!(_veh isKindOf "LandVehicle")) exitWith { _veh vehicleChat "Этот сервис только для наземной техники"; };

_veh vehicleChat "Сервис. Ожидайте...";

_veh setFuel 0;
_veh setDamage 0.3;

//---------- RE-ARMING
_veh vehicleChat "Перезарядка ...";

uiSleep 10;

_veh setVehicleAmmo 1;

// Rearm ammo trucks cargo ammo to 12 000 ammo (One full M5 Sandstorm MLRS rearm (12 rockets))
while {true} do {
    call {
        if ((typeOf _veh) in ["B_Truck_01_ammo_F", "O_Truck_02_Ammo_F", "I_Truck_02_ammo_F"]) exitWith {
            _veh setAmmoCargo 0.0000000121; // 12 000 ammo
        };
        if ((typeOf _veh) == "O_Truck_03_ammo_F") exitWith {
            _veh setAmmoCargo 0.41;        // 12 000 ammo
        };
    };
    if (getAmmoCargo _veh != 0) exitWith {}; // Due to very low values setAmmoCargo rounds to 0 on first try
};

//---------- REPAIRING

uiSleep 2;

_veh vehicleChat "Ремонт ...";

uiSleep 10;

_veh setDamage 0;

//---------- REFUELING

uiSleep 2;

_veh vehicleChat "Заправка ...";

uiSleep 10;

_veh setFuel 1;

//---------- FINISHED

_veh vehicleChat "Обслуживание завершено. Приятного путешествия!";
