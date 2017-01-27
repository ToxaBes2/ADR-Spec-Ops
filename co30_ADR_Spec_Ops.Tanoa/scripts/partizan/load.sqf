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
_class = typeOf _veh;
_attachCoords = [0,0,0];
switch (_class) do { 
    case "B_T_Quadbike_01_F";
    case "B_Quadbike_01_F" : { _attachCoords = [0,-1,-0.3]; }; 
    case "C_SUV_01_F" : { _attachCoords = [0,-2.7,-0.5]; }; 
    case "I_G_Offroad_01_F" : { _attachCoords = [0,-2.5,-0.5]; }; 
    case "C_Offroad_02_unarmed_F" : { _attachCoords = [0,-1.5,-0.05]; }; 
    case "I_C_Boat_Transport_02_F" : { _attachCoords = [0,0.5,-0.5]; }; 
    case "B_LSV_01_unarmed_F";
    case "B_LSV_01_armed_F";
    case "B_T_LSV_01_unarmed_F";
    case "B_T_LSV_01_armed_F";
    case "O_LSV_02_unarmed_F";
    case "O_LSV_02_armed_F";
    case "O_T_LSV_02_unarmed_F";
    case "O_T_LSV_02_armed_F" : { _attachCoords = [0,-1.1,-0.7]; };
    case "B_MRAP_01_F";
    case "B_MRAP_01_hmg_F";
    case "B_MRAP_01_gmg_F";
    case "B_T_MRAP_01_F";
    case "B_T_MRAP_01_hmg_F";
    case "B_T_MRAP_01_gmg_F" : { _attachCoords = [0,-3,0]; };
    case "I_MRAP_03_F";
    case "I_MRAP_03_gmg_F";
    case "I_MRAP_03_hmg_F" : { _attachCoords = [0,-2.7,0]; };
    case "O_MRAP_02_ghex_F";
    case "O_MRAP_02_gmg_ghex_F";
    case "O_MRAP_02_hmg_ghex_F";
    case "O_MRAP_02_ghex_F";
    case "O_MRAP_02_gmg_ghex_F";
    case "O_MRAP_02_hmg_ghex_F" : { _attachCoords = [0,-4,-1]; };
    case "I_C_Van_01_transport_F" : { _attachCoords = [0,-3,-0.4]; };
    default { _attachCoords = [0,0,0]; }; 
};
_player forceWalk false;
{
    _isBox = _x getVariable ["box", false];
    if (_isBox) then {    	
        detach _x;
        removeAllActions _x;
        _x attachTo [_veh, _attachCoords];
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
