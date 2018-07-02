/*
Author:	Quiksilver,	Rarek [AW]
Description: find and destriy enemy artillery
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
private ["_flatPos", "_accepted", "_position", "_flatPos1", "_flatPos2", "_flatPos3", "_PTdir", "_unitsArray", "_priorityGroup", "_distance", "_dir", "_c", "_pos", "_barrier", "_enemiesArray", "_radius", "_unit", "_targetPos", "_firingMessages", "_fuzzyPos", "_briefing", "_completeText", "_priorityMan1", "_priorityMan2", "_guardsGroup"];

// 1. FIND POSITION
_flatPos = [0, 0, 0];
if (isNil "currentAO") then {
   currentAO = "aoMarker";
};
_accepted = false;
while {!_accepted} do {
	_position = [[[getMarkerPos currentAO, 2500]], ["water", "out"]] call QS_fnc_randomPos;
	_flatPos = _position isFlatEmpty [10, 0, 0.2, 5, 0, false];
	while {(count _flatPos) < 2} do {
		_position = [[[getMarkerPos currentAO, 2500]], ["water", "out"]] call QS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10, 0, 0.2, 5, 0, false];
	};
	if ((_flatPos distance (getMarkerPos "respawn_west")) > 1800 && (_flatPos distance (getMarkerPos currentAO)) > 800) then {
		_accepted = true;
	};
};
_flatPos1 = [(_flatPos select 0) - 4, (_flatPos select 1) - 4, 1];
_flatPos2 = [(_flatPos select 0) + 4, (_flatPos select 1) + 4, 1];
_flatPos3 = [(_flatPos select 0) + 24, (_flatPos select 1) + 24, 1];

// 2. SPAWN OBJECTIVES
_PTdir = random 360;
sleep 0.3;
priorityObj1 = "O_MBT_02_arty_F" createVehicle [0,0,100];
waitUntil {!isNull priorityObj1};
priorityObj1 allowDamage false;
priorityObj1 setPos _flatPos1;
priorityObj1 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
priorityObj1 setDir _PTdir;
sleep 0.3;
priorityObj2 = "O_MBT_02_arty_F" createVehicle [0,0,120];
waitUntil {!isNull priorityObj2};
priorityObj2 allowDamage false;
priorityObj2 setPos _flatPos2;
priorityObj2 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
priorityObj2 setDir _PTdir;
sleep 0.3;
priorityObj1 addEventHandler ["Fired", {if (!isPlayer (gunner priorityObj1)) then { priorityObj1 setVehicleAmmo 1; }; }];
priorityObj2 addEventHandler ["Fired", {if (!isPlayer (gunner priorityObj2)) then { priorityObj2 setVehicleAmmo 1; }; }];

// SPAWN AMMO TRUCK (for ambiance and plausibiliy of unlimited ammo)
ammoTruck = "O_Truck_03_ammo_F" createVehicle [0,0,140];
waitUntil {!isNull ammoTruck};
ammoTruck allowDamage false;
ammoTruck setPos _flatPos3;
ammoTruck addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
ammoTruck setDir random 360;
{_x lock 0;} forEach [priorityObj1, priorityObj2, ammoTruck];

// 3. SPAWN CREW
sleep 1;
_unitsArray = [objNull];
_priorityGroup = createGroup ENEMY_SIDE;
"O_officer_F" createUnit [_flatPos, _priorityGroup];
"O_officer_F" createUnit [_flatPos, _priorityGroup];
"O_engineer_F" createUnit [_flatPos, _priorityGroup];
"O_engineer_F" createUnit [_flatPos, _priorityGroup];
priorityGunner1 = ((units _priorityGroup) select 2);
priorityGunner2 = ((units _priorityGroup) select 3);
((units _priorityGroup) select 0) assignAsCommander priorityObj1;
((units _priorityGroup) select 0) moveInCommander priorityObj1;
((units _priorityGroup) select 1) assignAsCommander priorityObj2;
((units _priorityGroup) select 1) moveInCommander priorityObj2;
((units _priorityGroup) select 2) assignAsGunner priorityObj1;
((units _priorityGroup) select 2) moveInGunner priorityObj1;
((units _priorityGroup) select 3) assignAsGunner priorityObj2;
((units _priorityGroup) select 3) moveInGunner priorityObj2;
[(units _priorityGroup)] call QS_fnc_setSkill4;
_priorityGroup setVariable ["zbe_cacheDisabled", true];
_priorityGroup setBehaviour "COMBAT";
_priorityGroup setCombatMode "RED";
_priorityGroup allowFleeing 0;
_unitsArray = _unitsArray + [_priorityGroup];

// 4. SPAWN H-BARRIER RING
sleep 1;
_distance = 18;
_dir = 0;
for "_c" from 0 to 7 do {
	_pos = [_flatPos, _distance, _dir] call BIS_fnc_relPos;
	_barrier = "Land_HBarrierBig_F" createVehicle _pos;
	waitUntil {alive _barrier};
	_barrier setDir _dir;
	_dir = _dir + 45;
	_barrier allowDamage false;
	_barrier enableSimulation false;
	_unitsArray = _unitsArray + [_barrier];
};

// 5. SPAWN FORCE PROTECTION
sleep 1;
_enemiesArray = [priorityObj1] call QS_fnc_PTenemyEAST;

// 6. Fill bots in radius
_fuzzyPos = [((_flatPos select 0) - 300) + (random 600), ((_flatPos select 1) - 300) + (random 600), 0];
_guardsGroup = [_fuzzyPos, 300, 15, ENEMY_SIDE] call QS_fnc_FillBots;
_enemiesArray = _enemiesArray + [_guardsGroup];

// 7. BRIEF
{ _x setMarkerPos _fuzzyPos; } forEach ["priorityMarker", "priorityCircle"];
priorityTargetText = "Артиллерия"; publicVariable "priorityTargetText";
"priorityMarker" setMarkerText "Приоритетная цель: Артиллерия"; publicVariable "priorityMarker";
_briefing = "<t align='center' size='2.2'>Внимание</t><br/><t size='1.5' color='#F44336'>Артиллерия</t><br/>____________________<br/>Обнаружена точка укрепления артиллерийских орудий противника. Её близлежащее расположение от района дислокации грозит всей нашей наземной группировке.<br/><br/>Первый залп ожидается уже через 5 минут.";
GlobalHint = _briefing; hint parseText _briefing; publicVariable "GlobalHint";
showNotification = ["NewPriorityTarget", ["Уничтожить артиллерию врага", "\a3\ui_f\data\gui\cfg\hints\artillerycall_ca.paa"]]; publicVariable "showNotification";
_firingMessages = [
	"Противник выпустил артиллерийский залп. По укрытиям!",
	"Наши позиции обстреливает артиллерия врага. Ищите укрытие!",
	"Враг начал прицельный артиллерийский огонь. Укройтесь!",
	"Враг ведёт стрельбу из артиллерийских орудий. Пригнитесь!",
	"Противник начал артобстрел наших позиций. В укрытие!"
];

priorityObj1 allowDamage true;
priorityObj2 allowDamage true;
ammoTruck allowDamage true;

// start Red Queen
_txid = [_flatPos, 400] call QS_fnc_startRQ;

// save info in DB
try {
    _position = format ["%1,%2", floor (_fuzzyPos select 0), floor (_fuzzyPos select 1)];
    ["setInfo",["prio_name", "Артиллерия"], 0] remoteExec ["sqlServerCall", 2];
    ["setInfo",["prio_position", _position], 0] remoteExec ["sqlServerCall", 2];
} catch {};

if !(isNil "PARTIZAN_BASE_SCORE") then {
    if (PARTIZAN_BASE_SCORE > 33) then {
        _taskMarker = createMarker ["TASK_MARKER1", [0,0]];
        _taskMarker setMarkerColor "ColorRed";
        _taskMarker setMarkerType "mil_dot";
        [_taskMarker, 0] remoteExec ["setMarkerAlphaLocal", west, true];
        [_taskMarker, 1] remoteExec ["setMarkerAlphaLocal", resistance, true];
        _taskMarker setMarkerPos (getPos priorityObj1);
    };
};

// FIRING SEQUENCE LOOP
_radius = 30;
waitUntil{sleep 1; !isNil "currentAOUp"};
while {(canMove priorityObj1 || canMove priorityObj2) && currentAOUp} do {
	if (!currentAOUp) then {
        {
	    	if (side _x == east || side _x == sideEmpty) then {
                deleteVehicle _x;
            };
        } forEach [priorityObj1, priorityObj2];
	} else {
	    _accepted = false;
	    _unit = objNull;
	    _targetPos = [0, 0, 0];
	    while {!_accepted} do {
	    	_targetPos = [0,0,0];
	    	_delta1 = _targetPos distance2D (getMarkerPos "respawn_west");
            {
                if (side _x isEqualTo WEST) then  {
                	_tmpPos = getPos _x;                                       
                    if ((_tmpPos distance2D (getMarkerPos "respawn_west")) > 300 && vehicle _x == _x) then {
	    			    _delta2 = _tmpPos distance2D (getMarkerPos "respawn_west");
                        if (_delta2 < _delta1) then {
                            _delta1 = _delta2;
                        	_targetPos = _tmpPos;
                        	_accepted = true;
                        };	    			 
	    		    };
	    		};
            } forEach AllPlayers;
	    	sleep 10;
	    };
	    if (PARAMS_ArtilleryTargetTickWarning == 1) then {
	    	hqSideChat = selectRandom _firingMessages; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	    };
	    //_dir = [_flatPos, _targetPos] call BIS_fnc_dirTo;
	    //{ _x setDir _dir; } forEach [priorityObj1, priorityObj2];
	    sleep 5;
	    {
	    	if (alive _x) then {
	    		for "_c" from 0 to 4 do {
	    		_pos =
	    		[
	    			(_targetPos select 0) - _radius + (2 * random _radius),
	    			(_targetPos select 1) - _radius + (2 * random _radius),
	    			0
	    		];
	    			_x doArtilleryFire [_pos, "32Rnd_155mm_Mo_shells", 1];
	    			sleep 8;
	    		};
	    	};
	    } forEach [priorityObj1, priorityObj2];
	    if (_radius > 10) then {
	    	_radius = _radius - 10;
	    };
	    if (PARAMS_ArtilleryTargetTickTimeMax <= PARAMS_ArtilleryTargetTickTimeMin) then {
	    	sleep PARAMS_ArtilleryTargetTickTimeMin;
	    } else {
	    	sleep (PARAMS_ArtilleryTargetTickTimeMin + (random (PARAMS_ArtilleryTargetTickTimeMax - PARAMS_ArtilleryTargetTickTimeMin)));
	    };
	};
};

// DE-BRIEF
_completeText = "<t align='center' size='2.2'>Внимание</t><br/><t size='1.5' color='#C6FF00'>Артиллерия подавлена</t><br/>____________________<br/>Противник лишился артиллерийских орудий.<br/><br/>Возвращайтесь к выполнению основной задачи.";
GlobalHint = _completeText; hint parseText _completeText; publicVariable "GlobalHint";
showNotification = ["CompletedPriorityTarget", ["Артиллерия нейтрализована", "\a3\ui_f\data\gui\cfg\hints\artillerycall_ca.paa"]]; publicVariable "showNotification";
{ _x setMarkerPos [-10000, -10000, -10000] } forEach ["priorityMarker","priorityCircle"]; publicVariable "priorityMarker";

// stop Red Queen
[_txid] call QS_fnc_stopRQ;

deleteMarker "TASK_MARKER1";

// DELETE
{ _x removeEventHandler ["Fired", 0]; } forEach [priorityObj1, priorityObj2];
{
    if (side _x == east || side _x == sideEmpty) then {
        deleteVehicle _x;
    };
} forEach [priorityObj1, priorityObj2, ammoTruck];
sleep 60;
{[_x] call QS_fnc_TBdeleteObjects;} forEach [_enemiesArray, _unitsArray];
[_fuzzyPos, 500] call QS_fnc_DeleteEnemyEAST;
