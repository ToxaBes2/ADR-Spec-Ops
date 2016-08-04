private ["_ammoPos", "_vehiclePos", "_params", "_mode", "_class", "_diff"];

_ammoPos = getPos partizan_ammo;
_vehiclePos = [0,0,0];
_params = _this select 3;
_mode = _params select 0;
_class = "";

//Stop showing submenu actions on partizan arsenal box
adr_partizan_submenu = false;

switch (_mode) do {
	case "quadbike" : {
        if (worldName == "Tanoa") then {
            _class = "B_T_Quadbike_01_F";
        } else {
            _class = "B_Quadbike_01_F";
        };
        _vehiclePos = [_ammoPos, 3, 30, 2, 0, -1, 0] call QS_fnc_findSafePos;
    };
	case "suv" : {
        _class = "C_SUV_01_F";
        _vehiclePos = [_ammoPos, 10, 100, 3, 0, -1, 0] call QS_fnc_findSafePos;
    };
    case "offroad" : {
        _class = "I_G_Offroad_01_F";
        _vehiclePos = [_ammoPos, 10, 100, 3, 0, -1, 0] call QS_fnc_findSafePos;
    };
    case "jeep" : {
        _class = "C_Offroad_02_unarmed_F";
        _vehiclePos = [_ammoPos, 10, 100, 3, 0, -1, 0] call QS_fnc_findSafePos;
    };
    case "ship" : {
        _class = "I_C_Boat_Transport_02_F";
        _vehiclePos = [_ammoPos, 10, 200, 2, 2, -1, 0] call QS_fnc_findSafePos;
    };
};
if (isNil "PARTIZAN_VEHICLE_TIME") then {
    PARTIZAN_VEHICLE_TIME = time - 1; publicVariable "PARTIZAN_VEHICLE_TIME";
};
_diff = PARTIZAN_VEHICLE_TIME - time;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Вызов данной техники будет доступен через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
if ((_vehiclePos distance _ammoPos) > 200) exitWith {
    ["<t color='#F44336' size = '.48'>Нет места для данной техники</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
PARTIZAN_VEHICLE_TIME = time + 120; publicVariable "PARTIZAN_VEHICLE_TIME";
["<t color='#7FDA0B' size = '.48'>Вызываем технику...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
sleep 1;
[[_vehiclePos, _class], {_this call compile preProcessFileLineNumbers "scripts\misc\baseVehiclePartizan.sqf"}] remoteExec ["spawn", 2];
