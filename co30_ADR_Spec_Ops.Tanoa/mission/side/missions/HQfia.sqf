/*
Author:	Quiksilver
Description:
	Secure HQ supplies before destroying it.
	Enemy type is FIA resistance who are hostile to blufor.
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST

private ["_flatPos", "_accepted", "_position", "_enemiesArray", "_fuzzyPos", "_x", "_briefing", "_unitsArray", "_object", "_SMveh", "_SMaa", "_tower1", "_tower2", "_tower3", "_c4Message"];

_c4Message = selectRandom [
	"Оперативный боезапас захвачен. C-4 активирован! 30 секунд до детонации.",
	"Оружие боевиков перехвачено. Взрывчатка установлена! 30 секунд до взрыва.",
	"Боезапас террористов захвачен. Заряд установлен! 30 секунд до взрыва."
];

// FIND POSITION FOR OBJECTIVE
_flatPos = [0, 0, 0];
_accepted = false;
while {!_accepted} do {
	_position = [] call QS_fnc_randomPos;
	_flatPos = _position isFlatEmpty [10, 1, 0.2, sizeOf "Land_Dome_Small_F", 0, false];

	while {(count _flatPos) < 2} do {
		_position = [] call QS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10, 1, 0.2, sizeOf "Land_Dome_Small_F", 0, false];
	};

	if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700) then {
		_accepted = true;
	};
};

// SPAWN OBJECTIVE
sideObj = "Land_Cargo_HQ_V2_F" createVehicle _flatPos;
waitUntil {alive sideObj};
sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), (getPos sideObj select 2)];
sideObj setVectorUp [0, 0, 1];

_object = selectRandom [crate3, crate4];
_object setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) + 2)];
sleep 0.3;
_tower1 = [sideObj, 50, 0] call BIS_fnc_relPos;
_tower2 = [sideObj, 50, 120] call BIS_fnc_relPos;
_tower3 = [sideObj, 50, 240] call BIS_fnc_relPos;
sleep 0.3;
tower1 = "Land_Cargo_Patrol_V2_F" createVehicle _tower1;
tower2 = "Land_Cargo_Patrol_V2_F" createVehicle _tower2;
tower3 = "Land_Cargo_Patrol_V2_F" createVehicle _tower3;
sleep 0.3;
tower1 setDir 180;
tower2 setDir 300;
tower3 setDir 60;

{ _x allowDamage false } forEach [tower1, tower2, tower3];
sleep 0.3;

// SPAWN FORCE PROTECTION
_enemiesArray = [sideObj] call QS_fnc_SMenemyFIA;
_fuzzyPos = [((_flatPos select 0) - 300) + (random 600), ((_flatPos select 1) - 300) + (random 600), 0];
_guardsGroup = [_fuzzyPos, 400, 50, ENEMY_SIDE] call QS_fnc_FillBots;

// SPAWN BRIEFING
{ _x setMarkerPos _fuzzyPos;} forEach ["sideMarker", "sideCircle"];
sideMarkerText = "Лагерь"; publicVariable "sideMarkerText";
"sideMarker" setMarkerText "Допзадание: Лагерь"; publicVariable "sideMarker";
publicVariable "sideObj";

_briefing = "<t align='center'><t size='2.2'>Новое допзадание</t><br/><t size='1.5' color='#FFC107'>Лагерь</t><br/>____________________<br/>Противник проводит подготовку боевиков на территории острова.<br/><br/>Ваша задача — выдвинуться в указанный район, найти и уничтожить врага и захватить их боезапас.</t>";
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSideMission", "Лагерь"]; publicVariable "showNotification";
sideMarkerText = "Лагерь"; publicVariable "sideMarkerText";

// [ CORE LOOPS ]
sideMissionUp = true; publicVariable "sideMissionUp";
SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp } do {

	// IF PACKAGE DESTROYED [FAIL]
	if (!alive sideObj) exitWith {

		// DE-BRIEFING
		sideMissionUp = false; publicVariable "sideMissionUp";
		hqSideChat = "Цель уничтожена преждевременно. Задание провалено!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		[false] spawn QS_fnc_SMhintFAIL;
		{ _x setMarkerPos [-10000, -10000, -10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";

		// DELETE
		_object setPos [-10000, -10000, 0];
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj, tower1, tower2, tower3];
		deleteVehicle nearestObject [getPos sideObj, "Land_Cargo_HQ_V2_ruins_F"];
		{ [_x] call QS_fnc_TBdeleteObjects; } forEach [_enemiesArray, _guardsGroup];
		[_fuzzyPos, 500] call QS_fnc_DeleteEnemyEAST;
	};

	// IF PACKAGE SECURED [SUCCESS]
	if (SM_SUCCESS) exitWith {

		// BOOM!
		hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
		sleep 30;
		"Bo_Mk82" createVehicle getPos _object;
		sleep 0.1;
		_object setPos [-10000, -10000, 0];

		// DE-BRIEFING
		sideMissionUp = false; publicVariable "sideMissionUp";
		if (WIN_WEST > WIN_GUER) then {
            [3] spawn QS_fnc_bluforSUCCESS;
        } else {
            [3] spawn QS_fnc_partizanSUCCESS;
        };
		{ _x setMarkerPos [-10000, -10000, -10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";

		// DELETE
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj, tower1, tower2, tower3];
		deleteVehicle nearestObject [getPos sideObj, "Land_Cargo_HQ_V2_ruins_F"];
		[_enemiesArray] call QS_fnc_TBdeleteObjects;
		[_guardsGroup] call QS_fnc_TBdeleteObjects;
		{ [_x] call QS_fnc_TBdeleteObjects; } forEach [_enemiesArray, _guardsGroup];
		[_fuzzyPos, 500] call QS_fnc_DeleteEnemyEAST;
	};
};
