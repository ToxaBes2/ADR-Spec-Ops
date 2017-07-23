/*
Author:	malashin
Description: Tell player which vehicles are allowed for weapon loadout changing
*/
private ["_veh", "_vehType", "_allowedVehicles"];
_veh = _this select 0;
_vehType = typeOf _veh;
_allowedVehicles = ["O_Plane_CAS_02_dynamicLoadout_F ","B_Plane_CAS_01_dynamicLoadout_F","O_T_VTOL_02_infantry_dynamicLoadout_F",
"O_Heli_Light_02_dynamicLoadout_F","O_Heli_Attack_02_dynamicLoadout_F","B_Heli_Attack_01_dynamicLoadout_F","I_Plane_Fighter_04_F",
"B_Plane_Fighter_01_F","O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F","B_Plane_Fighter_01_Stealth_F","I_Plane_Fighter_03_dynamicLoadout_F",
"I_Heli_light_03_dynamicLoadout_F"];

//"B_UAV_05_F","B_UAV_02_dynamicLoadout_F",

if (!(_vehType in _allowedVehicles)) exitWith {
	_veh vehicleChat "Смена вооружения доступна только для:";
	{
	    _veh vehicleChat format ["  -  %1", getText(configFile >> "CfgVehicles" >> _x >> "displayName")];
	} forEach _allowedVehicles;
};

_player = objNull;
if (_veh isKindOf "UAV") then {
    if (isUAVConnected _veh) then {
        _player = (UAVControl _veh) select 0;
    };
} else {
	if (isPlayer (driver _veh)) then {
	    _player = driver _veh;
	};
};

if !(isNull _player) exitWith {
	_actId = _player addAction ["<t color='#48C9B0'>Смена вооружения</t>","scripts\dynamic_loadout\addAction.sqf",_veh,21,true,true,"","playerSide == west", 5];
	[_player, _actId] spawn {
	    _player = _this select 0;
	    _actId = _this select 1;
	    while {true} do {
	        sleep 2;
	        if (_player distance rearmTrigger > 10) exitWith {
                _player removeAction _actId;
            };
	    };               
    };
};