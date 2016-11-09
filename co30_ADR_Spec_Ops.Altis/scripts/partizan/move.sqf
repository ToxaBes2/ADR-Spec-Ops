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
_action1 = _player addAction ["<t color='#EDBC64'>Поставить ящик</t>","scripts\partizan\unload.sqf",[],-100,true,true,"","playerSide == resistance"];
_player setVariable ["drop_box",_action1];
_action2 = _player addAction ["<t color='#EDBC64'>Загрузить ящик в технику</t>","scripts\partizan\load.sqf",[],-100,true,true,"",'playerSide == resistance && (_this distance cursorTarget) < 5 && cursorTarget isKindOf "Car"'];
_player setVariable ["load_box",_action2];
_player forceWalk true;
_player action ["SwitchWeapon", _player, _player, 100];
waitUntil {sleep 1; (vehicle _player != _player) || (!alive _player) || (!isPlayer _player) || count (attachedObjects _player) == 0};
_player forceWalk false;
if (count (attachedObjects _player) > 0) then {
    {
       detach _x;
       _x addAction ["<t color='#EDBC64'>Взять ящик</t>","scripts\partizan\move.sqf",[],-100,true,true,"","playerSide == resistance", 3];
       _x setPosATL [getPosATL _box select 0,getPosATL _box select 1,0];
    } forEach attachedObjects _player;
};
_player removeAction (_player getVariable "drop_box");
_player setVariable ["drop_box", nil];
_player removeAction (_player getVariable "load_box");
_player setVariable ["load_box", nil];