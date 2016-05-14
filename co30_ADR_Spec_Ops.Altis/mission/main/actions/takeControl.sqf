/*
Author: ToxaBes
Description: take control on command center
*/
#define ENEMY_SIDE EAST
private ["_object", "_time", "_step", "_failed", "_grp", "_units"];
_player = _this select 1;
_player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
sleep 1;
_object = _this select 0;
_points = 10;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
MAIN_AO_SUCCESS = true; publicVariable "MAIN_AO_SUCCESS";
[_object, 0] call BIS_fnc_dataTerminalAnimate;
["ScoreBonus", ["Захватил командный пункт!", _points]] remoteExec ["BIS_fnc_showNotification", _player];
[_player, _points] remoteExec ["addScore", 2];