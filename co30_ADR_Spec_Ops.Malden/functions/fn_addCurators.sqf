/*
Author: ToxaBes
Description: add players into left column of Zeus interface
*/
_player = _this select 0;
{
	_x removeCuratorEditableObjects [[_player],true];
	_x addCuratorEditableObjects [[_player], false];
} forEach allCurators;
