/*
Author: ToxaBes
Description: load box into vehicle.
*/
_box = _this select 0;
_player = _this select 1;
_id = _this select 2;
if (vehicle _player != _player) exitWith {
    ["<t color='#F44336' size = '.48'>Действия с ящиками доступны только вне техники.</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_veh = cursorObject;
_stop = false;
{
	_isBox = _x getVariable ["box", false];
    if (_isBox) then {
        _stop = true;
    };
} forEach attachedObjects _veh;
if (_stop) exitWith {
    ["<t color='#F44336' size = '.48'>Нельзя загрузить более одного ящика в технику.</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_player forceWalk false;
{
    _isBox = _x getVariable ["box", false];
    if (_isBox) then {    	
        detach _x;
        removeAllActions _x;
        _x attachTo [_veh, [0,0,0]];
        _x hideObjectGlobal true;    
    };
} forEach attachedObjects _player;
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
[_veh, "QS_fnc_addActionUnload", nil, true] spawn BIS_fnc_MP;
