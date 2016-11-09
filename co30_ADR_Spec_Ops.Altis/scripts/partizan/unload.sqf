/*
Author: ToxaBes
Description: unload box from vehicle or drop from player.
*/
_veh = _this select 0;
_player = _this select 1;
_id = _this select 2;
if (vehicle _player != _player) exitWith {
    ["<t color='#F44336' size = '.48'>Действия с ящиками доступны только вне техники.</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_player forceWalk false;
_remove = false;
{
    _isBox = _x getVariable ["box", false];
    if (_isBox) then {
        _remove = true;
    };
} forEach attachedObjects _player;
if (!_remove) then {
    _player removeAction (_player getVariable "load_box");
    _player removeAction (_player getVariable "drop_box");
    _player setVariable ["load_box", nil];
    _player setVariable ["drop_box", nil];
};
{
    _isBox = _x getVariable ["box", false];
    if (_isBox) then {
    	_pos = getPos _veh;
        _a = 8;
        _b = 3;
        if (_veh isKindOf "Man") then {
            _a = 2;
            _b = 1;
        };
    	_posX = (_pos select 0) + (random _a) - (random _b);
    	_posY = (_pos select 1) + (random _a) - (random _b);
    	_newPos = [_posX, _posY, 0];
        _x hideObjectGlobal false;
        detach _x;
        _x setPos _newPos;
        _x removeAction _id;
        _x addAction ["<t color='#EDBC64'>Взять ящик</t>","scripts\partizan\move.sqf",[],-100,true,true,"","playerSide == resistance", 3];        
    };
} forEach attachedObjects _veh;
_veh removeAction _id;