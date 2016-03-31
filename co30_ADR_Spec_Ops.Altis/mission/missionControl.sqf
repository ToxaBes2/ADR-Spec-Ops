/*
Author: ToxaBes (based on mission control made by Quiksilver)
Description: Main AO and side objective mission control
*/
private ["_mission", "_script", "_missionList", "_currentMission", "_loopTimeout"];
_loopTimeout = 20;
sleep _loopTimeout;
_missionList = [
	//"destroyUrban",
	"HQcoast",
	"HQfia",
	"HQind",
	"HQresearch",
	//"priorityAA",
	//"priorityARTY",
	"secureChopper",
	"secureRadar",
	"heliCrash",
	"rescueHostages",
	"convoy",
	"snatch",
	//"swordfish",
	//"yellowfog",
	"grapeswrath"
];
while { true } do {
	if (PARAMS_AO == 1) then {
	    _currentMission = [] spawn {_this call compile preProcessFileLineNumbers "mission\main\missions\AOattack.sqf"};
	    waitUntil {
	    	sleep _loopTimeout;
	    	scriptDone _currentMission;
	    };
	    sleep _loopTimeout;
    };	
    if (PARAMS_SideObjectives == 1) then {
        hqSideChat = "Вторичная цель выявлена, ждите указаний!"; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
	    sleep 3;
	    _mission = _missionList call BIS_fnc_selectRandom;
	    _currentMission = [_mission] spawn {_this call compile preProcessFileLineNumbers format ["mission\side\missions\%1.sqf", _this select 0]};
	    waitUntil {
	    	sleep _loopTimeout;
	    	scriptDone _currentMission;
	    };
	    sleep _loopTimeout;
	};
};
