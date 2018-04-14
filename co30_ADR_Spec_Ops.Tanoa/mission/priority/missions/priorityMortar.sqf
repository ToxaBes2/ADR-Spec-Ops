/*
Author:	ToxaBes
Description: find and destroy enemy mortars
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
private ["_flatPos", "_accepted", "_position", "_flatPos1", "_flatPos2", "_flatPos3", "_PTdir", "_unitsArray", "_priorityGroup", "_distance", "_dir", "_c", "_pos", "_barrier", "_enemiesArray", "_radius", "_unit", "_targetPos", "_firingMessages", "_fuzzyPos", "_briefing", "_completeText", "_priorityMan1", "_priorityMan2", "_guardsGroup"];

// 1. FIND POSITION
_basepos = getMarkerPos "respawn_west";
_flatPos = [0, 0, 0];
if (isNil "currentAO") then {
   currentAO = "aoMarker";
};
_accepted = false;
while {!_accepted} do {
	_flatPos = [[[_basepos, 2500]], ["water", "out"]] call QS_fnc_randomPos;
	if ((_flatPos distance _basepos) > 1200) then {
		if ((_flatPos distance _basepos) < 3500) then {
			if ((_flatPos distance (getMarkerPos currentAO)) > 500) then {
				_accepted = true;
			};
		};
	};
};
_flatPos set [2,0];

_unitTypes = ["O_support_Mort_F","O_support_AMG_F"];
_objs = [	
	["Land_HBarrier_3_F",[-1.21191,-1.74805,0],0,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_3_F",[-1.10742,1.78418,0],0,1,0,[0,0],"","",true,false],	
	["Land_BagFence_Round_F",[2.34424,-1.82617,0],3.854,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-2.48145,2.0188,0],186.328,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[2.8042,1.76685,0],186.957,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-2.95752,-1.80151,0],4.48306,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[4.37744,-0.322266,0],276.328,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-4.5708,0.445801,0],96.9569,1,0,[0,0],"","",true,false],
    ["Box_East_AmmoVeh_F",[0,0,0],0,1,0,[0,0],"","",true,false], 
    ["O_Mortar_01_F",[2.2,0,0],90,1,0,[0,0],"","",true,false], 
	["O_Mortar_01_F",[-2.2,0,0],270,1,0,[0,0],"","",true,false]
];
if (worldName == "Tanoa") then {
	_unitTypes = ["O_T_Support_Mort_F","O_T_Support_AMort_F"];
    _objs = [	
    	["Land_HBarrier_01_line_3_green_F",[-1.21191,-1.74805,0],0,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_01_line_3_green_F",[-1.10742,1.78418,0],0,1,0,[0,0],"","",true,false],	
    	["Land_BagFence_01_round_green_F",[2.34424,-1.82617,0],3.854,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_01_round_green_F",[-2.48145,2.0188,0],186.328,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_01_round_green_F",[2.8042,1.76685,0],186.957,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_01_round_green_F",[-2.95752,-1.80151,0],4.48306,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_01_round_green_F",[4.37744,-0.322266,0],276.328,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_01_round_green_F",[-4.5708,0.445801,0],96.9569,1,0,[0,0],"","",true,false],
        ["Box_East_AmmoVeh_F",[0,0,0],0,1,0,[0,0],"","",true,false], 
        ["O_Mortar_01_F",[2.2,0,0],90,1,0,[0,0],"","",true,false], 
    	["O_Mortar_01_F",[-2.2,0,0],270,1,0,[0,0],"","",true,false]
    ];
};

_position = [[[_flatPos, 300]], ["water", "out"]] call QS_fnc_randomPos;
_pos = _position isFlatEmpty [6, 0, 0.2, 5, 0, false];
while {(count _pos) < 2} do {
	_position = [[[_flatPos, 300]], ["water", "out"]] call QS_fnc_randomPos;
    _pos = _position isFlatEmpty [6, 0, 0.2, 5, 0, false];
};
_pos set [2,0];

// 2. SPAWN OBJECTIVES
_newObjs = [];
_multiplyMatrixFunc =
{
	private ["_array1", "_array2", "_result"];
	_array1 = _this select 0;
	_array2 = _this select 1;
	_result = [
		(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
		(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
	];
	_result
};
_n = 0;
_staticGroup = createGroup east;
if (format ["%1", _pos] != "[0,0,0]") then {    
    _azi = 0; 
    _posX = _pos select 0;
    _posY = _pos select 1;
    {		
    	_type = _x select 0;
    	_relPos = _x select 1;
    	_azimuth = _x select 2;
    	if ((count _x) > 3) then {_fuel = _x select 3};
    	if ((count _x) > 4) then {_damage = _x select 4};
    	if ((count _x) > 5) then {_orientation = _x select 5};
    	if ((count _x) > 6) then {_varName = _x select 6};
    	if ((count _x) > 7) then {_init = _x select 7};
    	if ((count _x) > 8) then {_simulation = _x select 8};
    	if ((count _x) > 9) then {_ASL = _x select 9};
    	private ["_rotMatrix", "_newRelPos", "_newPos"];
    	_rotMatrix =
    	[
    		[cos _azi, sin _azi],
    		[-(sin _azi), cos _azi]
    	];
    	_newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;	
    	private ["_z"];
    	if ((count _relPos) > 2) then {_z = _relPos select 2} else {_z = 0};
    	_newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), _z];
    	_newObj = _type createVehicle _newPos;
    	_newObj setDir (_azi + _azimuth);
    	_newObj setPos _newPos;		
    	if (!isNil "_fuel") then {_newObj setFuel _fuel};
    	if (!isNil "_damage") then {_newObj setDamage _damage;};
    	if (!isNil "_orientation") then 
    	{
    		if ((count _orientation) > 0) then 
    		{
    			([_newObj] + _orientation) call BIS_fnc_setPitchBank;
    		};
    	};
    	if (!isNil "_varName") then {
    		if (_varName != "") then {
        		_newObj setVehicleVarName _varName;
        		call (compile (_varName + " = _newObj;"));
        	};
        };
        if (!isNil "_init") then {_newObj call (compile ("this = _this; " + _init));};
        if (!isNil "_simulation") then {_newObj enableSimulation _simulation; _newObj setVariable ["BIS_DynO_simulation", _simulation];};

        // 3. SPAWN CREW  
        if (typeOf _newObj in ["Box_East_AmmoVeh_F"]) then {
            priorityObj3 = _newObj;
        };
        if (typeOf _newObj in ["O_Mortar_01_F"]) then {
        	if (_n == 0) then {
        		priorityObj1 = _newObj;
        	} else {
                priorityObj2 = _newObj;
            };            
            _unitType = selectRandom _unitTypes;
            _unitType createUnit [[0,0,0], _staticGroup, "currentGunner = this", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
            currentGunner assignAsGunner _newObj;
            currentGunner moveInGunner _newObj;
            _n = _n + 1;
        };            
        _newObjs pushBack _newObj;
    } forEach _objs;                                
};

_staticGroup setBehaviour "COMBAT";
_staticGroup setCombatMode "RED";
[(units _staticGroup)] call QS_fnc_setSkill4;
_staticGroup setBehaviour "COMBAT";
_staticGroup setCombatMode "RED";
_staticGroup allowFleeing 0;
_staticGroup setVariable ["zbe_cacheDisabled", true];
_unitsArray = [objNull];
_unitsArray = _unitsArray + [_staticGroup];

// 4. SPAWN FORCE PROTECTION
sleep 1;
_enemiesArray = [priorityObj1] call QS_fnc_PTenemyEAST;

// 5. Fill bots in radius
_guardsGroup = [_flatPos, 300, 15, ENEMY_SIDE] call QS_fnc_FillBots;
_enemiesArray = _enemiesArray + [_guardsGroup];

// 6. BRIEF
waitUntil{sleep 1; !isNil "currentAOUp"};
{ _x setMarkerPos _flatPos; } forEach ["priorityMarker", "priorityCircle"];
priorityTargetText = "Минометы"; publicVariable "priorityTargetText";
"priorityMarker" setMarkerText "Приоритетная цель: Минометный расчет"; publicVariable "priorityMarker";
_briefing = "<t align='center' size='2.2'>Внимание</t><br/><t size='1.5' color='#F44336'>Минометный расчет</t><br/>____________________<br/>Обнаружен минометный расчет противника. Его расположение позволяет прицельно работать по нашей базе.<br/><br/>Первый залп ожидается уже через пару минут.";
GlobalHint = _briefing; hint parseText _briefing; publicVariable "GlobalHint";
showNotification = ["NewPriorityTarget", ["Уничтожить минометный расчет", "\a3\ui_f\data\gui\cfg\hints\artillerycall_ca.paa"]]; publicVariable "showNotification";
_firingMessages = [
	"Противник выпустил минометный залп по базе. По укрытиям!",
	"Нашу базу обстреливают минометы врага. Ищите укрытие!",
	"Враг начал прицельный минометный огонь по базе. Укройтесь!",
	"Враг ведёт стрельбу из минометов по базе. Пригнитесь!",
	"Противник начал минометный обстрел нашей базы. В укрытие!"
];

// save info in DB
try {
    _position = format ["%1,%2", floor (_flatPos select 0), floor (_flatPos select 1)];
    ["setInfo",["prio_name", "Минометный расчет"], 0] remoteExec ["sqlServerCall", 2];
    ["setInfo",["prio_position", _position], 0] remoteExec ["sqlServerCall", 2];
} catch {};

// FIRING SEQUENCE LOOP
_radius = 10;
_basePosition = [15164,17282];
if (worldName == "Malden") then {
    _basePosition = [8082,10115];
};
if (worldName == "Tanoa") then {
    _basePosition = [6857,7280];
};
while {(canFire priorityObj1 || canFire priorityObj2) && currentAOUp} do {
    waitUntil {sleep 10; (count allPlayers) > 0};    
	if (!currentAOUp) then {
		{
	    	if (side _x == east || side _x == sideEmpty) then {
                deleteVehicle _x;
            };
        } forEach [priorityObj1, priorityObj2];
	} else {
	    _accepted = false;
	    _unit = objNull;	    
	    if (PARAMS_ArtilleryTargetTickWarning == 1) then {
	    	hqSideChat = selectRandom _firingMessages; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	    };
	    sleep 2;
	    {  
	        _targetPos = [[[_basePosition, 120]]] call QS_fnc_randomPos;       
	    	if (alive _x) then {
	    		    for "_c" from 0 to 2 do {
	    		    _pos =
	    		    [
	    		    	(_targetPos select 0) - (random _radius) + (random _radius),
	    		    	(_targetPos select 1) - (random _radius) + (random _radius),
	    		    	0
	    		    ];
	    			_x commandArtilleryFire [_pos, "8Rnd_82mm_Mo_shells", 1];
	    			sleep 6;
	    		};
	    	};
	    } forEach [priorityObj1, priorityObj2];	 
	    if (alive priorityObj3) then {
	    	priorityObj1 setVehicleAmmo 1;
	    	priorityObj2 setVehicleAmmo 1;
	    };
	    if (PARAMS_ArtilleryTargetTickTimeMax <= PARAMS_ArtilleryTargetTickTimeMin) then {
	    	sleep (PARAMS_ArtilleryTargetTickTimeMin * 1.5);
	    } else {
	    	sleep (PARAMS_ArtilleryTargetTickTimeMin + (random (PARAMS_ArtilleryTargetTickTimeMax - PARAMS_ArtilleryTargetTickTimeMin)));
	    };
	};
};

// DE-BRIEF
_completeText = "<t align='center' size='2.2'>Внимание</t><br/><t size='1.5' color='#C6FF00'>Минометы подавлены</t><br/>____________________<br/>Противник лишился минометной поддержки.<br/><br/>Возвращайтесь к выполнению основной задачи.";
GlobalHint = _completeText; hint parseText _completeText; publicVariable "GlobalHint";
showNotification = ["CompletedPriorityTarget", ["Минометы нейтрализованы", "\a3\ui_f\data\gui\cfg\hints\artillerycall_ca.paa"]]; publicVariable "showNotification";
{ _x setMarkerPos [-10000, -10000, -10000] } forEach ["priorityMarker","priorityCircle"]; publicVariable "priorityMarker";

// DELETE
{
    if (side _x == east || side _x == sideEmpty) then {
        deleteVehicle _x;
    };
} forEach [priorityObj1, priorityObj2, priorityObj3];
sleep 60;
{[_x] call QS_fnc_TBdeleteObjects;} forEach [_enemiesArray, _unitsArray];
[_flatPos, 500] call QS_fnc_DeleteEnemyEAST;
