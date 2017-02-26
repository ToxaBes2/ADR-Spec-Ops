/*
Author: ToxaBes
Description: move vehicle to rewards list
*/
_player = _this select 0;
_vehicle = vehicle _player;
if (_vehicle == _player) exitWith {
    ["<t color='#F44336' size = '.48'>Нет техники для постановки в гараж</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
if !(driver _vehicle == _player) exitWith {
    ["<t color='#F44336' size = '.48'>Это действие доступно только для водителя техники</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_side = side _player;
_auto = false;
_list = [];
if (_side == west) then {
    _auto = _vehicle getVariable ["AUTOSPAWNED", false];
    _list = BLUFOR_REWARDS_LIST;
};
if (_side == resistance) then {
    _auto = _vehicle getVariable ["PARTIZANSPAWNED", false];
    _list = PARTIZAN_REWARDS_LIST;
};
if (_auto) exitWith {
    ["<t color='#F44336' size = '.48'>Данную технику невозможно поставить в гараж</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_class = typeOf _vehicle;
_name = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
_present = 0;
{
	_arr = _x select 1;
    if (_class == _arr select 0) then {
        _present = _present + 1;
    };
} forEach _list;
if (_present > 1) exitWith {
    ["<t color='#F44336' size = '.48'>В гараже не может быть более двух одинаковых вариантов техники</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
{
    _x action ["EJECT", _vehicle];
} forEach (crew _vehicle);
deleteVehicle _vehicle;
if (_side == west) then {
    BLUFOR_REWARDS_LIST pushBack [_name, [_class], false]; publicVariable "BLUFOR_REWARDS_LIST";
};
if (_side == resistance) then {
    PARTIZAN_REWARDS_LIST pushBack [_name, [_class], false]; publicVariable "PARTIZAN_REWARDS_LIST";
};