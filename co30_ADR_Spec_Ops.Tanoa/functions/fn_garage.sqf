/*
Author: ToxaBes
Description: move vehicle to rewards list
*/
_player = _this select 0;
_vehicle = vehicle _player;
_side = side _player;
_auto = false;
_list = [];

if (_side == west) then {
    if (_vehicle == _player) exitWith {
        ["<t color='#F44336' size = '.48'>Нет техники для постановки в гараж</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };
    if !(driver _vehicle == _player) exitWith {
        ["<t color='#F44336' size = '.48'>Это действие доступно только для водителя техники</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };
    _auto = _vehicle getVariable ["AUTOSPAWNED", false];
    _list = BLUFOR_REWARDS_LIST;
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
    BLUFOR_REWARDS_LIST pushBack [_name, [_class], false]; publicVariable "BLUFOR_REWARDS_LIST";
};

if (_side == resistance) then {    
    _list = PARTIZAN_REWARDS_LIST;
    _vehs = nearestObjects [getPos _player, ["LandVehicle", "Air", "Ship"], 30];
    _total = 0;
    { 
        _vehicle = _x;
        _class = typeOf _vehicle;
        _name = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
        _auto = _vehicle getVariable ["PARTIZANSPAWNED", false];
        if (_auto) then {
            [resistance, "HQ"] sideChat format ["%1 невозможно поставить в гараж", _name];
        } else {
            _present = 0;
            {
                _arr = _x select 1;
                if (_class == _arr select 0) then {
                    _present = _present + 1;
                };
            } forEach _list;
            if (_present > 1) then {
                [resistance, "HQ"] sideChat format ["В гараже уже есть более 2х %1", _name];
            } else {
                {
                    _x action ["EJECT", _vehicle];
                } forEach (crew _vehicle);
                deleteVehicle _vehicle;
                PARTIZAN_REWARDS_LIST pushBack [_name, [_class], false]; publicVariable "PARTIZAN_REWARDS_LIST";
                [resistance, "HQ"] sideChat format ["%1 поставлен в гараж", _name];
                _total = _total + 1;
            };
        };
    } forEach _vehs;
    if (_total == 0) exitWith {
        ["<t color='#F44336' size = '.48'>Нет техники для постановки в гараж</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };
};