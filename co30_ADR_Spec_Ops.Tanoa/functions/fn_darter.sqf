/*
Author: ToxaBes
Description: spawn AR-2 darters via player request
*/
_cnt = 0;
_limit = 8;
_allUAVs = allMissionObjects "B_UAV_01_F";
{
    if (alive _x) then {
        _use = _x getVariable ["BLUFOR_UAV", false];
        if (_use) then {
           _cnt = _cnt + 1;
        };        
    };
} forEach _allUAVs;
if (_cnt >= _limit) exitWith {
   [format ["<t color='#F44336' size = '.48'>Достигнут лимит в %1 дартеров!</t>", _limit], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_groundPos = [[6950,7385,0], 0, 50, 1, 0, 0, 0] call QS_fnc_findSafePos;
_uav = createVehicle ["B_UAV_01_F", _groundPos, [], 0, "NONE"];
_uav setVariable ["BLUFOR_UAV", true];
createVehicleCrew _uav;
_uav addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
[_uav] spawn {
    _uav = _this select 0;
    while {alive _uav} do {
        sleep 30;
        if (fuel _uav <= 0.1) exitWith {
            _uav setDamage 1;
            deleteVehicle _uav;
        }; 
    };          
};
["<t color='#7FDA0B' size = '.48'>Дартер вызван и ожидает на базе.</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;