/*
Author:	Quiksilver
    (credit to Jester [AW] for initial build)
	(credit to chucky [allFPS] for initial help with addAction)
	(credit to BangaBob [EOS] for EOS)
Description:
	Objective appears in urban area, with selection of OPFOR Uinfantry, and civilians.
	Inf and civs spawn in foot patrols and randomly placed in and around buildings.
	Vehicle spawning can be unstable and the veh can spawn into buildings.
	Good CQB mission and players seem to enjoy it.
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define CIV_SIDE CIVILIAN

private ["_object", "_briefing", "_smPos", "_c4Message", "_sideGroup1", "_sideGroup2", "_sideGroup3"];

// PREPARE MISSION. SELECT OBJECT, POSITION AND MESSAGES FROM ARRAYS
_object = selectRandom [crate1,crate2];

currentSM = selectRandom [
	"sm1", "sm2", "sm3", "sm4", "sm5", "sm6", "sm7", "sm8", "sm9", "sm10", "sm11",
	"sm12", "sm13", "sm14", "sm15", "sm16", "sm17", "sm18", "sm19", "sm20",	"sm21",
	"sm22", "sm23", "sm24", "sm25", "sm26", "sm27", "sm28", "sm29", "sm30",	"sm31",
	"sm32", "sm33", "sm34", "sm35", "sm36", "sm37", "sm38", "sm39"
];

_c4Message = selectRandom [
	"Заряд установлен! 30 секунд до взрыва. В укрытие!",
	"C-4 активирован! 30 секунд до детонации. Пригнитесь!",
	"Взрывчатка на месте! 30 секунд до взрыва. Уходим!"
];

// SPAWN OBJECTIVE
_smPos = getMarkerPos currentSM;
sleep 1;
_object setPosATL _smPos;

_sideGroup1 = [_smPos, 50, 20, ENEMY_SIDE] call QS_fnc_FillBots;
_sideGroup2 = [_smPos, 350, 40, ENEMY_SIDE] call QS_fnc_FillBots;
sleep 1;
_sideGroup3 = [_smPos, 100, 15, CIV_SIDE] call QS_fnc_FillBots;

// BRIEFING
"sideMarker" setMarkerPos (getMarkerPos currentSM);
sideMarkerText = "Склад"; publicVariable "sideMarkerText";
"sideMarker" setMarkerText "Допзадание: Склад"; publicVariable "sideMarker";
_briefing = "<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#FFC107'>Склад</t><br/>____________________<br/>Враг поставляет боевикам современное оружие и взрывчатые вещества. Экипируйтесь с расчётом на ближний бой!<br/><br/>Ваша задача — выдвинуться в указанный район и уничтожить складируемый боезапас противника.</t>";
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSideMission", "Склад"]; publicVariable "showNotification";

sideMissionUp = true; publicVariable "sideMissionUp";
SM_SUCCESS = false;	publicVariable "SM_SUCCESS";

// WAIT UNTIL OBJECTIVE COMPLETE: Sent to sabotage.sqf to wait for SM_SUCCESS var.
waitUntil { sleep 3; SM_SUCCESS };

// BROADCAST BOMB PLANTED
hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;

// BOOM!
sleep 30;
"M_NLAW_AT_F" createVehicle getPos _object;
_object setPos [-10000, -10000, 0];
sleep 1;

// DE-BRIEFING
sideMissionUp = false; publicVariable "sideMissionUp";
if (WIN_WEST > WIN_GUER) then {
    [3] spawn QS_fnc_bluforSUCCESS;
} else {
    [3] spawn QS_fnc_partizanSUCCESS;
};
"sideMarker" setMarkerPos [-10000, -10000, -10000]; publicVariable "sideMarker";

// DELETE, DESPAWN, HIDE and RESET
SM_SUCCESS = false; publicVariable "SM_SUCCESS";
sleep 120;
[_sideGroup1] call QS_fnc_TBdeleteObjects;
[_sideGroup2] call QS_fnc_TBdeleteObjects;
[_sideGroup3] call QS_fnc_TBdeleteObjects;
[_smPos, 500] call QS_fnc_DeleteEnemyEAST;
