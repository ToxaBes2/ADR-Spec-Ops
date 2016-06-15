/*
Author:	ToxaBes
Description: random call secure missions
*/
private ["_mission", "_missionList", "_loopTimeout"];
_loopTimeout = 20;
_missionList = [
    "secureChopper",
	"secureRadar"
];
_mission = _missionList call BIS_fnc_selectRandom;
currentSecure = [_mission] spawn {_this call compile preProcessFileLineNumbers format ["mission\side\missions\%1.sqf", _this select 0]};
waitUntil {
	sleep _loopTimeout;
	scriptDone currentSecure;
};
true