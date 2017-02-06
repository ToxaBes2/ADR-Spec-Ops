/*
Author:	Quiksilver (credit Rarek [AW] for initial design)
Description:
	Secure explosives crate on coastal HQ.
	Destroying the HQ first yields failure.
	Securing the weapons first yields success.
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST

private ["_flatPos", "_accepted", "_position", "_randomDir", "_x", "_briefing", "_enemiesArray", "_unitsArray", "_c4Message", "_object", "_secondary1", "_secondary2", "_secondary3", "_secondary4", "_secondary5", "_boatPos", "_trawlerPos", "_assaultBoatPos"];

// FIND SAFE POSITION FOR MISSION
_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_position = [[[] call BIS_fnc_worldArea], ["water", "out"]] call QS_fnc_randomPos;
	_flatPos = _position isFlatEmpty [2, 0, 0.3, 1, 1, true];

	while {(count _flatPos) < 2} do {
		_position = [[[] call BIS_fnc_worldArea], ["water", "out"]] call QS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [2, 0, 0.3, 1, 1, true];
	};

	if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700) then {
        _accepted = true;
	};
};

// SPAWN OBJECTIVE AND AMBIENCE
_smuggleGroup = createGroup EAST;

_randomDir = (random 360);
sideObj = "Land_Cargo_HQ_V1_F" createVehicle _flatPos;
waitUntil {alive sideObj};
sideObj setDir _randomDir;
sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2))];
sideObj setVectorUp [0, 0, 1];

_object = selectRandom [crate3,crate4];
_object setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) + 5)];

// BOAT POSITIONS
_boatPos = [_flatPos, 50, 150, 10, 2, 1, 0, [], [_flatPos]] call QS_fnc_findSafePos;
_trawlerPos = [_flatPos, 200, 300, 10, 2, 1, 0, [], [_flatPos]] call QS_fnc_findSafePos;
_assaultBoatPos = [_flatPos, 15, 25, 10, 0, 1, 0, [], [_flatPos]] call QS_fnc_findSafePos;

// ENEMY HMG BOAT (SEEMS RIGHT SINCE ITS BY THE COAST)
boat = "O_Boat_Armed_01_hmg_F" createVehicle _boatPos;
waitUntil {sleep 0.3; alive boat};
boat addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
boat setDir random 360;

"B_diver_TL_F" createUnit [_boatPos, _smuggleGroup];
"B_diver_F" createUnit [_boatPos, _smuggleGroup];
"B_diver_F" createUnit [_boatPos, _smuggleGroup];
"B_diver_F" createUnit [_boatPos, _smuggleGroup];
"B_diver_F" createUnit [_boatPos, _smuggleGroup];

((units _smuggleGroup) select 0) assignAsCommander boat;
((units _smuggleGroup) select 0) moveInCommander boat;
((units _smuggleGroup) select 1) assignAsDriver boat;
((units _smuggleGroup) select 1) moveInDriver boat;
((units _smuggleGroup) select 2) assignAsGunner boat;
((units _smuggleGroup) select 2) moveInGunner boat;
((units _smuggleGroup) select 3) assignAsCargo boat;
((units _smuggleGroup) select 3) moveInCargo boat;
((units _smuggleGroup) select 4) assignAsCargo boat;
((units _smuggleGroup) select 4) moveInCargo boat;

[(units _smuggleGroup)] call QS_fnc_setSkill4;

_unitsArray = [_smuggleGroup];

// SHIPPING TRAWLER AND INFLATABLE BOAT FOR AMBIENCE
trawler = "C_Boat_Civil_04_F" createVehicle _trawlerPos;
trawler setDir random 360;
trawler allowDamage false;

assaultBoat = "O_Boat_Transport_01_F" createVehicle _assaultBoatPos;
assaultBoat addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
assaultBoat setDir random 360;
assaultBoat allowDamage false;

{ _x lock 0 } forEach [boat, assaultBoat];

// POS FOR SECONDARY EXPLOSIONS, create a function for this?
_secondary1 = [sideObj, random 30, random 360] call BIS_fnc_relPos;
_secondary2 = [sideObj, random 30, random 360] call BIS_fnc_relPos;
_secondary3 = [sideObj, random 30, random 360] call BIS_fnc_relPos;
_secondary4 = [sideObj, random 50, random 360] call BIS_fnc_relPos;
_secondary5 = [sideObj, random 70, random 360] call BIS_fnc_relPos;

// SPAWN FORCE PROTECTION
_enemiesArray = [sideObj] call QS_fnc_SMenemyEAST;
_fuzzyPos = [((_flatPos select 0) - 300) + (random 600), ((_flatPos select 1) - 300) + (random 600), 0];
_guardsGroup = [_fuzzyPos, 400, 50, ENEMY_SIDE] call QS_fnc_FillBots;

// BRIEFING
{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
sideMarkerText = "Тайник"; publicVariable "sideMarkerText";
"sideMarker" setMarkerText "Допзадание: Тайник";
publicVariable "sideMarker";
publicVariable "sideObj";

_c4Message = selectRandom ["Заряд установлен! 30 секунд до взрыва.", "C-4 активирован! 30 секунд до детонации.", "Взрывчатка на месте! 30 секунд до взрыва."];
_briefing = "<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#FFC107'>Тайник</t><br/>____________________<br/>Противник тайно переправляет и складирует значительное количество взрывчатых веществ близи своего прибрежного лагеря.<br/><br/>Ваша задача — выдвинуться в указанный район, найти и обезвредить текущую партию взрывчатки.</t>";
GlobalHint = _briefing; publicVariable "GlobalHint"; hint parseText GlobalHint;
showNotification = ["NewSideMission", "Тайник"]; publicVariable "showNotification";
sideMarkerText = "Тайник"; publicVariable "sideMarkerText";

// [CORE LOOPS]
sideMissionUp = true; publicVariable "sideMissionUp";
SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp } do {
	sleep 0.3;

	// IF HQ IS DESTROYED [FAIL]
	if (!alive sideObj) exitWith {
		// DE-BRIEFING
		sideMissionUp = false; publicVariable "sideMissionUp";
		hqSideChat = "Цель уничтожена преждевременно. Задание провалено!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		[false] spawn QS_fnc_SMhintFAIL;
		{ _x setMarkerPos [-10000, -10000, -10000]; } forEach ["sideMarker", "sideCircle"];
		publicVariable "sideMarker";

		// DELETE
		_object setPos [-10000, -10000, 0];
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj, boat, trawler, assaultBoat];
		deleteVehicle nearestObject [getPos sideObj, "Land_Cargo_HQ_V1_ruins_F"];
		{ [_x] call QS_fnc_TBdeleteObjects; } forEach [_unitsArray, _enemiesArray, _guardsGroup];
		[_fuzzyPos, 500] call QS_fnc_DeleteEnemyEAST;
	};

	// IF WEAPONS ARE DESTROYED [SUCCESS]
	if (SM_SUCCESS) exitWith {
		//-------------------- BOOM!
		hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		sleep 30;											// ghetto bomb timer
		"Bo_GBU12_LGB" createVehicle getPos _object; 		// default "Bo_Mk82"
		sleep 0.1;
		_object setPos [-10000, -10000, 0];					// hide objective

		// DE-BRIEFING
		sideMissionUp = false; publicVariable "sideMissionUp";
		if (WIN_WEST > WIN_GUER) then {
            [3] spawn QS_fnc_bluforSUCCESS;
        } else {
            [3] spawn QS_fnc_partizanSUCCESS;
        };
		{ _x setMarkerPos [-10000, -10000, -10000];} forEach ["sideMarker", "sideCircle"];
		publicVariable "sideMarker";

		// SECONDARY EXPLOSIONS, create a function for this?
		sleep 10 + (random 10);
		"SmallSecondary" createVehicle _secondary1;
		"SmallSecondary" createVehicle _secondary2;
		sleep 5 + (random 5);
		"SmallSecondary" createVehicle _secondary3;
		sleep 2 + (random 2);
		"SmallSecondary" createVehicle _secondary4;
		"SmallSecondary" createVehicle _secondary5;

		// DELETE, DESPAWN, HIDE and RESET
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj, boat, trawler, assaultBoat];
		deleteVehicle nearestObject [getPos sideObj, "Land_Cargo_HQ_V1_ruins_F"];
		{ [_x] call QS_fnc_TBdeleteObjects; } forEach [_unitsArray, _enemiesArray, _guardsGroup];
		[_fuzzyPos, 500] call QS_fnc_DeleteEnemyEAST;
	};
};
