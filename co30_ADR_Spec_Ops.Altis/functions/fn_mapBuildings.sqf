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
if (_ruin) then {
	RUINS pushBack [netid _object, netid _newobject];
};
