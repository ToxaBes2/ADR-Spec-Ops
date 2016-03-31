/*
@file: destroyUrban.sqf
Author:

	Quiksilver 	(credit to Jester [AW] for initial build)
				(credit to chucky [allFPS] for initial help with addAction)
				(credit to BangaBob [EOS] for EOS)
Last modified:

	29/04/2014

Description:

	Objective appears in urban area, with selection of OPFOR Uinfantry, and civilians.
	Inf and civs spawn in foot patrols and randomly placed in and around buildings.
	Vehicle spawning can be unstable and the veh can spawn into buildings.
	Good CQB mission and players seem to enjoy it.

_____________________________________________________________________*/

private ["_object", "_briefing", "_smPos", "_c4Message"];

//-------------------- PREPARE MISSION. SELECT OBJECT, POSITION AND MESSAGES FROM ARRAYS
_object = [crate1,crate2] call BIS_fnc_selectRandom;

currentSM = [
	"sm1", "sm2", "sm3", "sm4", "sm5", "sm6", "sm7", "sm8", "sm9", "sm10", "sm11",
	"sm12", "sm13", "sm14", "sm15", "sm16", "sm17", "sm18", "sm19", "sm20",	"sm21",
	"sm22", "sm23", "sm24", "sm25", "sm26", "sm27", "sm28", "sm29", "sm30",	"sm31",
	"sm32", "sm33", "sm34", "sm35", "sm36", "sm37", "sm38", "sm39"
] call BIS_fnc_selectRandom;

_c4Message = [
	"Заряд установлен! 30 секунд до взрыва. В укрытие!",
	"C-4 активирован! 30 секунд до детонации. Пригнитесь!",
	"Взрывчатка на месте! 30 секунд до взрыва. Уходим!"
] call BIS_fnc_selectRandom;

//-------------------- SPAWN OBJECTIVE (okay okay, setPos not spawn/create)
_smPos = getMarkerPos currentSM;
sleep 1;
_object setPosATL _smPos;

//-------------------- SPAWN GUARDS and CIVILIANS
//[[currentSM], [6, 1], [7, 1], [0, 0], [0], [0], [0, 0], [5, 1, 1200, EAST, FALSE, FALSE]] call EOS_Spawn; //guards
sleep 1;
//[[currentSM], [3, 1], [4, 1], [0, 0], [0], [0], [0, 0], [3, 1, 1100, EAST, FALSE, FALSE]] call EOS_Spawn; //civs

//-------------------- BRIEFING
"sideMarker" setMarkerPos (getMarkerPos currentSM);
sideMarkerText = "Склад"; publicVariable "sideMarkerText";
"sideMarker" setMarkerText "Допзадание: Склад"; publicVariable "sideMarker";
_briefing = "<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#00B2EE'>Склад</t><br/>____________________<br/>Враг поставляет боевикам современное оружие и взрывчатые вещества. Экипируйтесь с расчётом на ближний бой!<br/><br/>Ваша задача — выдвинуться в указанный район и уничтожить складируемый боезапас противника.</t>";
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSideMission", "Склад"]; publicVariable "showNotification";

sideMissionUp = true; publicVariable "sideMissionUp";
SM_SUCCESS = false;	publicVariable "SM_SUCCESS";

//--------------------- WAIT UNTIL OBJECTIVE COMPLETE: Sent to sabotage.sqf to wait for SM_SUCCESS var.
waitUntil { sleep 3; SM_SUCCESS };

//--------------------- BROADCAST BOMB PLANTED
hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;

//-------------------- BOOM!
sleep 30;											// ghetto bomb timer
"M_NLAW_AT_F" createVehicle getPos _object; 		// default "Bo_Mk82"
_object setPos [-10000, -10000, 0];					// hide objective
sleep 1;

//-------------------- DE-BRIEFING
sideMissionUp = false; publicVariable "sideMissionUp";
[] call QS_fnc_SMhintSUCCESS;
"sideMarker" setMarkerPos [-10000, -10000, -10000]; publicVariable "sideMarker";

//--------------------- DELETE, DESPAWN, HIDE and RESET
SM_SUCCESS = false; publicVariable "SM_SUCCESS";	// reset var for next cycle
sleep 120;											// sleep to hide despawns from players. default 120, 1 for testing
currentSM setmarkercolor "colorblack";
currentSM setmarkerAlpha 0;
