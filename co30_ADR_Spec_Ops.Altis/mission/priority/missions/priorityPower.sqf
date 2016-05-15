/*
Author:	Alex RUS (mission based on template from Quiksilver)
Description: search and destroy EW and communications center.
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
private ["_objPos", "_flatPos", "_accepted", "_position", "_randomDir", "_hangar", "_x", "_enemiesArray", "_briefing", "_fuzzyPos", "_unitsArray", "_dummy", "_object", "_tower1", "_tower2", "_tower3", "_light", "_EWCar", "_AwardCar", "_barrels", "_award"];

_c4Message = [
	"Дельта браво, это штаб, прием. Противнику не понравилось как вы обошлись с их РЭБ! По вам дали залп из РСЗО. У вас полторы минуты. Найдите укрытие!",
	"Дельта браво, это штаб, прием. Вы разворошили улей с их РЭБ! По вам дали залп из реактивной артиллерии. Полторы минуты до удара. Валите оттуда!",
	"Дельта браво, это штаб, прием. Лучше вам поторопиться, противник понял, что их РЭБ накрылась и данные похищены! По вам дали залп из РСЗО. У вас полторы минуты чтобы уйти."
] call BIS_fnc_selectRandom;

// FIND SAFE POSITION FOR OBJECTIVE
_flatPos = [0, 0, 0];
_accepted = false;
hqSideChat = "Эй, штаб, это Дельта-Браво у нас что-то странное происходит с оборудованием... Прием. "; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
sleep 5;

while {!_accepted} do {
	_position = [[[getMarkerPos currentAO, 2500]], ["water", "out"]] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty [5, 0, 0.2, sizeOf "Land_Communication_F", 0, false];
	while {(count _flatPos) < 2} do {
		_position = [[[getMarkerPos currentAO, 2500]], ["water", "out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5, 0, 0.2, sizeOf "Land_Communication_F", 0, false];
	};
	if ((_flatPos distance (getMarkerPos "respawn_west")) > 1800 && (_flatPos distance (getMarkerPos currentAO)) > 800) then {
		_accepted = true;
	};
};
_objPos = [_flatPos, 25, 35, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

// SPAWN OBJECTIVE
sideObj = "Land_Communication_F" createVehicle _flatPos;
waitUntil {!isNull sideObj};
sideObj setDir random 360;
house = "Land_Cargo_HQ_V3_F" createVehicle _objPos;
house setDir 180;
house allowDamage false;
hqSideChat = "Дельта браво, это штаб. Доложить обстановку, что именно происходит с оборудованием? Прием."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;//////////////////////////////
sleep 10;
_dummy = [explosivesDummy1,explosivesDummy2] call BIS_fnc_selectRandom;
sleep 0.3;
_object = [power1,power2] call BIS_fnc_selectRandom;
sleep 0.3;
{ _x enableSimulation true; } forEach [researchTable, _object];
sleep 0.3;
researchTable setPos [(getPos house select 0), (getPos house select 1), ((getPos house select 2) + 1)];
sleep 1;
[researchTable, _object, [0, 0, 0.9]] call BIS_fnc_relPosObject;
sleep 0.3;
_tower1 = [sideObj, 50, 0] call BIS_fnc_relPos;
_tower2 = [sideObj, 50, 120] call BIS_fnc_relPos;
_tower3 = [sideObj, 50, 240] call BIS_fnc_relPos;
_power = [sideObj, 2, 0 ] call BIS_fnc_relPos;
_light = [sideObj, 8, 0 ] call BIS_fnc_relPos;
_EWCar = [sideObj, 5, 120 ] call BIS_fnc_relPos;
_AwardCar = [sideObj, 5, 240 ] call BIS_fnc_relPos;
_barrels = [sideObj, 150, 240 + (random 200) ] call BIS_fnc_relPos;
_award = [sideObj, 180, (random 360) ] call BIS_fnc_relPos;
sleep 0.3;
tower1 = "Land_Cargo_Patrol_V3_F" createVehicle _tower1;
tower2 = "Land_Cargo_Patrol_V3_F" createVehicle _tower2;
tower3 = "Land_Cargo_Patrol_V3_F" createVehicle _tower3;
power = "Land_DieselGroundPowerUnit_01_F" createVehicle _power;
power setDamage 0.5;
light = "Land_PortableLight_double_F" createVehicle _light;
light setDir 0;
EWCar = "O_Truck_03_repair_F" createVehicle _EWCar;
EWCar setFuel 0;
AwardCar = "O_Truck_03_ammo_F" createVehicle _AwardCar;
AwardCar setFuel 0;
barrels = "CargoNet_01_barrels_F" createVehicle _barrels;
getpowerunit setPos [(getPos power select 0), (getPos power select 1), ((getPos power select 2) + 1)];
sleep 0.3;
tower1 setDir 180;
tower2 setDir 300;
tower3 setDir 60;
{ _x allowDamage false } forEach [tower1, tower2, tower3];
sleep 0.3;

// SPAWN FORCE PROTECTION
_enemiesArray = [sideObj] call QS_fnc_SMenemyEAST;
_fuzzyPos = [((_flatPos select 0) - 300) + (random 600), ((_flatPos select 1) - 300) + (random 600), 0];
_guardsGroup = [_fuzzyPos, 300, 15, ENEMY_SIDE] call QS_fnc_FillBots;
_enemiesArray = _enemiesArray + [_guardsGroup];

// BRIEF
hqSideChat = "Штаб, это Дельта-Браво, ни черта понять не можем, не работают тепловизоры, ночное видение, ПТ. Что-то мешает работе. Прием."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
sleep 5;
hqSideChat = "Дельта-Браво, вас поняли, ждем данные разведки, сразу вас оповестим. Конец связи. "; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
sleep 10;
{ _x setMarkerPos _fuzzyPos; } forEach ["priorityMarker", "priorityCircle"];
priorityTargetText = "Узел связи"; publicVariable "priorityTargetText";
"priorityMarker" setMarkerText "Приоритетная цель: Узел связи"; publicVariable "priorityMarker";
_briefing = "<t align='center'><t size='2.2'>Внимание</t><br/><t size='1.5' color='#F44336'>Узел связи и РЭБ</t><br/>____________________<br/>Разведка сообщает, что для поддержки своего наступления противник развернул полевой узел связи и РЭБ. Пока они работают - работа нашего электронного оборудования частично парализована.</t>";
GlobalHint = _briefing; hint parseText _briefing; publicVariable "GlobalHint";
showNotification = ["NewPriorityTarget", "Уничтожить Узел связи и РЭБ"]; publicVariable "showNotification";
SM_POWER = false; publicVariable "SM_POWER";
POWERFIX = false; publicVariable "POWERFIX";
EW_ATTACK = true; publicVariable "EW_ATTACK";
waitUntil{sleep 1; !isNil "EW_ATTACK"};
waitUntil{sleep 1; !isNil "currentAOUp"};
remoteExec ["QS_fnc_EWattack"];

// remove Nightvision and add ligthnings for guards
_bots = _fuzzyPos nearObjects ["Man", 600];
{
	if (side _x == ENEMY_SIDE) then {
        _x unassignItem "NVGoggles_OPFOR";
        _x removeItem "NVGoggles_OPFOR";
        _x addPrimaryWeaponItem "acc_flashlight";
	};
} forEach _bots;

// MAIN LOOP
while {currentAOUp} do {
	if ((!alive sideObj || !alive power || !alive EWCar) && currentAOUp) exitWith {
		_completeText = "<t align='center' size='2.2'>Внимание</t><br/><t size='1.5' color='#F44336'>Приоритетная цель провалена!</t><br/>____________________<br/>Данные невозможно перехватить т.к. оборудование потеряно.<br/><br/>Возвращайтесь к выполнению основной задачи.";
        GlobalHint = _completeText; hint parseText _completeText; publicVariable "GlobalHint";
        showNotification = ["CompletedPriorityTarget", "Приоритетная цель провалена!"]; publicVariable "showNotification";
        EW_ATTACK = false; publicVariable "EW_ATTACK";
	};

	if (SM_POWER && POWERFIX && currentAOUp) exitWith {
        _completeText = "<t align='center' size='2.2'>Внимание</t><br/><t size='1.5' color='#C6FF00'>РЭБ противника подавлена</t><br/>____________________<br/>Противник лишился РЭБ и узла связи, захвачены важные данные.<br/><br/>Возвращайтесь к выполнению основной задачи.";
        GlobalHint = _completeText; hint parseText _completeText; publicVariable "GlobalHint";
        showNotification = ["CompletedPriorityTarget", "РЭБ противника подавлена"]; publicVariable "showNotification";
        EW_ATTACK = false; publicVariable "EW_ATTACK";
        sleep 5;

		// BOOM!
		if (random 10 > 5) then {
		    hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
		    _dummy setPos [(getPos sideObj select 0), ((getPos sideObj select 1) +5), ((getPos sideObj select 2) + 0.5)];
		    sleep 0.1;
		    _object setPos [-10000, -10000, 0];
		    getpowerunit setPos [-10000, -10000, 0];
		    sleep 90;
		    "Bo_GBU12_LGB" createVehicle getPos _dummy;
		    sleep 2;
		    "Bo_GBU12_LGB" createVehicle getPos _dummy;
		    sleep 2;
		    "Bo_GBU12_LGB" createVehicle getPos _dummy;
		    _dummy setPos [-10000, -10000, 1];
		    researchTable setPos [-10000, -10000, 1];
		    sleep 0.1;
		};

        hqSideChat = "В захваченных данных говорится о технике недалеко от узла связи!"; publicVariable "hqSideChat"; [OUR_SIDE, "HQ"] sideChat hqSideChat;
        sleep 2;
        hqSideChat = "Обыщите местность в радиусе 200-300м пока противник не забрал ее."; publicVariable "hqSideChat"; [OUR_SIDE, "HQ"] sideChat hqSideChat;
		award = "O_MBT_02_cannon_F" createVehicle _award;
	};
	sleep 1;
};
EW_ATTACK = false; publicVariable "EW_ATTACK";
{ _x setMarkerPos [-10000, -10000, -10000] } forEach ["priorityMarker","priorityCircle"]; publicVariable "priorityMarker";

// DELETE
{ _x setPos [-10000, -10000, 0]; } forEach [_object, researchTable, _dummy];
sleep 30;
{ deleteVehicle _x } forEach [sideObj, house, tower1, tower2, tower3, power, barrels, light, EWCar, AwardCar];
deleteVehicle nearestObject [getPos sideObj, "Land_Communication_F"];
[_enemiesArray] call QS_fnc_TBdeleteObjects;
sleep 270;
[_fuzzyPos, 500] call QS_fnc_DeleteEnemyEAST;
