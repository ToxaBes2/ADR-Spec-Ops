/*
Author: ToxaBes
Description: move box.
*/
_box = _this select 0;
_player = _this select 1;
_id = _this select 2;
if (vehicle _player != _player) exitWith {
    ["<t color='#F44336' size = '.48'>Действия с ящиками доступны только вне техники.</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_stop = false;
{
	_isBox = _x getVariable ["box", false];
    if (_isBox) then {
        _stop = true;
    };
} forEach attachedObjects _player;
if (_stop) exitWith {
    ["<t color='#F44336' size = '.48'>Нельзя нести больше одного ящика одновременно.</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_box removeAction _id;
_box attachTo [_player,[0,1,1]];
[_player, "QS_fnc_addActionUnload", nil, true] call BIS_fnc_MP;
[_player, "QS_fnc_addActionLoad", nil, true] call BIS_fnc_MP;
_player forceWalk true;
_player action ["SwitchWeapon", _player, _player, 100];
waitUntil {sleep 1; (vehicle _player != _player) || (!alive _player) || (!isPlayer _player) || count (attachedObjects _player) == 0};
_player forceWalk false;
if (count (attachedObjects _player) > 0) then {
    {
        detach _x;
        [_x, "QS_fnc_addActionMove", nil, true] call BIS_fnc_MP;
        _x setPosATL [getPosATL _box select 0,getPosATL _box select 1,0];
    } forEach attachedObjects _player;
};
_player removeAction _id;
_id1 = _player getVariable ["load_box", 0];
_id2 = _player getVariable ["drop_box", 0];
if (_id1 > 0) then {
   _player removeAction _id1;
};
if (_id2 > 0) then {
   _player removeAction _id2;
};
_player setVariable ["load_box", nil];
_player setVariable ["drop_box", nil];