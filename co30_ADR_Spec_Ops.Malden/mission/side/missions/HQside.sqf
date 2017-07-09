/*
Author:	ToxaBes
Description: random call HQ missions
*/
private ["_mission", "_missionList", "_loopTimeout"];
_loopTimeout = 20;
_missionList = [
    "HQcoast",
    "HQfia",
    "HQind",
    "HQresearch"
];
_mission = selectRandom _missionList;
currentHQ = [_mission] spawn {_this call compile preProcessFileLineNumbers format ["mission\side\missions\%1.sqf", _this select 0]};
waitUntil {
	sleep _loopTimeout;
	scriptDone currentHQ;
};
true
