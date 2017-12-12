/*
Author: ToxaBes
Description: Catch ruins and their original objects for restoring
*/
private _object = _this select 0;
private _newobject = _this select 1;
private _ruin = _this select 2;
if (isNil "RUINS") then {
	RUINS = [];			
};
_towers = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"];
if (_ruin) then {
	if !((typeOf _object) in _towers) then {
	    RUINS pushBack [netid _object, netid _newobject];
	};	
};
