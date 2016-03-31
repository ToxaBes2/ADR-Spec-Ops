/*
Author:

	Quiksilver

Last modified:

	25/04/2014

Description:

	Destroy chopper
____________________________________*/

#define CHOPPER_TYPE "O_Heli_Attack_02_black_F","O_Heli_Light_02_unarmed_F", "B_Heli_Attack_01_F"
private ["_objPos", "_flatPos", "_accepted", "_position", "_randomDir", "_hangar", "_x", "_enemiesArray", "_briefing", "_fuzzyPos", "_unitsArray", "_dummy", "_object"];

_c4Message = [
	"Данные о вертолёте захвачены. Заряд установлен! 30 секунд до взрыва.",
	"Чертежи вертолёта у нас. Взрывчатка установлена! 30 секунд до взрыва.",
	"Данные прототипа захвачены. C-4 активирован! 30 секунд до детонации."
] call BIS_fnc_selectRandom;


//-------------------- FIND SAFE POSITION FOR OBJECTIVE
_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_position = [] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty [5, 0, 0.2, sizeOf "Land_TentHangar_V1_F", 0, false];

	while {(count _flatPos) < 2} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5, 0, 0.2, sizeOf "Land_TentHangar_V1_F", 0, false];
	};

	if ((_flatPos distance (getMarkerPos "respawn_west")) > 1000 && (_flatPos distance (getMarkerPos currentAO)) > 500) then {
		_accepted = true;
	};
};

_objPos = [_flatPos, 25, 35, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

//-------------------- SPAWN OBJECTIVE
_randomDir = (random 360);
_hangar = "Land_TentHangar_V1_F" createVehicle _flatPos;
waitUntil {!isNull _hangar};
_hangar setPos [(getPos _hangar select 0), (getPos _hangar select 1), ((getPos _hangar select 2) - 1)];
sideObj = [CHOPPER_TYPE] call BIS_fnc_selectRandom createVehicle _flatPos;
waitUntil {!isNull sideObj};
{_x setDir _randomDir} forEach [sideObj, _hangar];
sideObj lock 3;

house = "Land_Cargo_House_V3_F" createVehicle _objPos;
house setDir random 360;
house allowDamage false;

_object = [research1,research2] call BIS_fnc_selectRandom;
sleep 0.3;
_dummy = [explosivesDummy1, explosivesDummy2] call BIS_fnc_selectRandom;
sleep 0.3;
{ _x enableSimulation true } forEach [researchTable, _object];
sleep 0.3;
researchTable setPos [(getPos house select 0), (getPos house select 1), ((getPos house select 2) + 1)];
sleep 1;
[researchTable,_object,[0, 0, 0.82]] call BIS_fnc_relPosObject;

//-------------------- SPAWN FORCE PROTECTION
_enemiesArray = [sideObj] call QS_fnc_SMenemyEAST;

//-------------------- BRIEF
_fuzzyPos = [((_flatPos select 0) - 300) + (random 600), ((_flatPos select 1) - 300) + (random 600), 0];

{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
sideMarkerText = "Прототип"; publicVariable "sideMarkerText";
"sideMarker" setMarkerText "Допзадание: Прототип"; publicVariable "sideMarker";
publicVariable "sideObj";

_briefing = "<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#00B2EE'>Прототип</t><br/>____________________<br/>Вражеские силы взяли на испытание новый прототип боевого вертолёта, который они скрывают в одном из своих ангаров.<br/><br/>Ваша задача — выдвинуться в указанный район, захватить данные о вертолёте и уничтожить прототип.</t>";
GlobalHint = _briefing; hint parseText _briefing; publicVariable "GlobalHint";
showNotification = ["NewSideMission", "Прототип"]; publicVariable "showNotification";
sideMarkerText = "Прототип"; publicVariable "sideMarkerText";

sideMissionUp = true; publicVariable "sideMissionUp";
SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp } do {
	if (!alive sideObj) exitWith {
		//-------------------- DE-BRIEFING
		hqSideChat = "Данные о прототипе утеряны. Задание провалено!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		[] spawn QS_fnc_SMhintFAIL;
		{ _x setMarkerPos [-10000, -10000, -10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		sideMissionUp = false; publicVariable "sideMissionUp";
		
		//-------------------- DELETE
		{ _x setPos [-10000, -10000, 0]; } forEach [_object, researchTable, _dummy];			// hide objective pieces
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj, house];
		deleteVehicle nearestObject [getPos sideObj, "Land_TentHangar_V1_ruins_F"];
		[_enemiesArray] spawn QS_fnc_SMdelete;
	};
	
	if (SM_SUCCESS) exitWith {
		//-------------------- BOOM!
		hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
		_dummy setPos [(getPos sideObj select 0), ((getPos sideObj select 1) +3), ((getPos sideObj select 2) + 0.5)];
		sleep 0.1;
		_object setPos [-10000, -10000, 0];					// hide objective
		sleep 30;											// ghetto bomb timer
		"Bo_GBU12_LGB" createVehicle getPos _dummy; 		// default "Bo_Mk82"
		_dummy setPos [-10000, -10000, 1];					// hide dummy
		researchTable setPos [-10000, -10000, 1];			// hide research table
		sleep 0.1;
	
		//-------------------- DE-BRIEFING
		[] call QS_fnc_SMhintSUCCESS;
		{ _x setMarkerPos [-10000, -10000, -10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		sideMissionUp = false; publicVariable "sideMissionUp";

		//--------------------- DELETE
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj, house];
		deleteVehicle nearestObject [getPos sideObj, "Land_TentHangar_V1_ruins_F"];
		[_enemiesArray] spawn QS_fnc_SMdelete;
	};
};