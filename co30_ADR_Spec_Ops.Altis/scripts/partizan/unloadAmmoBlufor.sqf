/*
Author: ToxaBes
Description: unload ammo from blufor convoy.
*/
_veh = _this select 0;
_player = _this select 1;
_id = _this select 2;
if (vehicle _player != _player) exitWith {
    ["<t color='#F44336' size = '.48'>Действия по разгрузке доступны только вне техники.</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_veh removeAction _id;
if (typeOf _veh == "B_Truck_01_box_F") then {
    {
        _x action ["EJECT", _veh];
    } forEach (crew _veh);
};
deleteVehicle _veh;

hqSideChat = "Боеприпасы доставлены на базу!";
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat;  

ARSENAL_ENABLED = true;
publicVariable "ARSENAL_ENABLED";
ARSENAL_TIME = serverTime;
publicVariableServer "ARSENAL_TIME";    

