private ["_veh"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};

if (!(_veh isKindOf "B_UAV_02_CAS_F")) exitWith { 
	_veh vehicleChat "Эта площадка для БПЛА!"; 
};

_veh vehicleChat "Обслуживание займет 30 секунд.";

_veh setFuel 0;

//---------- RE-ARMING

_veh vehicleChat "Перезарядка ...";

uiSleep 10;

_veh setVehicleAmmo 1;
_veh vehicleChat "Заряжен.";

//---------- REPAIRING

uiSleep 2;

_veh vehicleChat "Ремонт ...";

uiSleep 10;

_veh setDamage 0;
_veh vehicleChat "Отремонтирован.";

//---------- REFUELING

uiSleep 2;

_veh vehicleChat "Заправка ...";

uiSleep 10;

_veh setFuel 1;
_veh vehicleChat "Заправлен.";

//---------- FINISHED
_veh vehicleChat "Обслуживание завершено. Приятного полета!";