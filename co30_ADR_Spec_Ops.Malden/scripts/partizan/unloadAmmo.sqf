/*
Author: ToxaBes
Description: unload ammo from blufor convoy.
*/
_veh = _this select 0;
_player = _this select 1;
_id = _this select 2;
_newVeh = "B_Truck_01_mover_F"; // B_T_Truck_01_mover_F
if (vehicle _player != _player) exitWith {
    ["<t color='#F44336' size = '.48'>Действия по разгрузке доступны только вне техники.</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_veh removeAction _id;
{
    _x action ["EJECT", _veh];
} forEach (crew _veh);

_dir = getDir _veh;
_pos = getPos _veh;
deleteVehicle _veh;

_veh1 = createVehicle [_newVeh, [1,1,450], [], 0, "NONE"];
_veh1 setDir _dir;
_veh1 setPos _pos;

_boxes = ["Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_NATO_Ammo_F","Box_NATO_WpsLaunch_F","B_supplyCrate_F","Box_NATO_WpsLaunch_F","C_supplyCrate_F","C_T_supplyCrate_F"];
{
    _boxPos = [_pos, 2, 25, 2, 0, 0, 0] call QS_fnc_findSafePos;
    _box = createVehicle [_x, _boxPos, [], 0, "NONE"];
} forEach _boxes;

