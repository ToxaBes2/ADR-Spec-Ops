/*
Author: ToxaBes (based on regions made by Quiksilver)
Description: All main AO's in one file
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define ENEMY_SIDE_STR "EAST"
#define RADIO_TOWERS "Land_TTowerBig_1_F","Land_TTowerBig_2_F"
#define ALLOWED_EXPLOSIVES "IEDUrbanBig_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo","IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo","SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo",""

private ["_nameAO", "_positionAO", "_serviceMarkers", "_dt", "_chance", "_bunkerType", "_bunkerPos", "_distance", "_flatPos", "_res", "_null", "_obj", "_bunkerObjects", "_bunkerPositions", "_bunkerPosition", "_smallZ", "_bigZ", "_anotherChance", "_uav", "_uavPos", "_position", "_tower", "_allowedExplosives", "_tower_dmg", "_points", "_unit", "_campPos", "_hasMines", "_groundPos", "_minesArray", "_newPos", "_cargo", "_campObjects", "_type", "_nearestObject", "_enemiesArray", "_targetStartText", "_showTowerMessage", "_showBunkerMessage", "_viperSquadSpawned", "_radioTowerDownText", "_bunkerText", "_targetCompleteText", "_aliveBots", "_chanceDefend", "_vehicles", "_curVeh", "_isReward", "_unitTypes"];

WinRadiotower = false; publicVariable "WinRadiotower";
WinBunker = false; publicVariable "WinBunker";
eastSide = createCenter ENEMY_SIDE;
_target = [] call QS_fnc_getMainAO;
if !(isNil "LAST_MAIN_MISSION") then {
    while {(_target select 0) == LAST_MAIN_MISSION} do {
        _target = [] call QS_fnc_getMainAO;
    };
};
LAST_MAIN_MISSION = _target select 0;
publicVariable "LAST_MAIN_MISSION";
_nameAO = _target select 0;
_positionAO = _target select 1;

// Edit and place markers for new target
{_x setMarkerPos _positionAO;} forEach ["aoCircle", "aoMarker"];
"aoMarker" setMarkerText format["Захватить: %1", _nameAO];
sleep 1;

// Color nearby vehicle service markers in grey(inactive) while AO is up
CURRENT_AO_POSITION = _positionAO; publicVariable "CURRENT_AO_POSITION";
_serviceMarkers = [];
{
    if (markerText _x == "Сервис техники") then {
        if ((getMarkerPos _x) distance2D _positionAO < 2500) then {
            if ((getMarkerPos _x) distance2D (getMarkerPos "Side") > 1000) then {
                _x setMarkerColor "ColorGrey";
                _serviceMarkers pushBackUnique _x;
            };
        };
    };
} forEach allMapMarkers;

// Create AO detection trigger
_dt = createTrigger ["EmptyDetector", _positionAO];
_dt setTriggerArea [PARAMS_AOSize, PARAMS_AOSize, 0, false];
_dt setTriggerActivation [ENEMY_SIDE_STR, "PRESENT", false];
_dt setTriggerStatements ["this", "", ""];

// spawn bunker or tower outpost
_chance = random 10;
if (_chance < 5) then {
    _bunkerType = 1;
    _bunkerPos = [_positionAO, 1, (PARAMS_AOSize/2), 30, 0, 4, 0, [], [_positionAO]] call QS_fnc_findSafePos;
    _distance = _positionAO distance2D _bunkerPos;
    _flatPos = _bunkerPos isFlatEmpty [5, 1, 0.3, 30, 0, false];
    _res = count _flatPos;
    while {_distance > (PARAMS_AOSize/1.5) || _res == 0} do {
        _bunkerPos = [_positionAO, 1, (PARAMS_AOSize/2), 20, 0, 3, 0, [], [_positionAO]] call QS_fnc_findSafePos;
        _distance = _positionAO distance2D _bunkerPos;
        _flatPos = _bunkerPos isFlatEmpty [5, 1, 0.3, 15, 0, false];
        _res = count _flatPos;
    };
    _null = [_bunkerPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "Empty" >> "Military" >> "Outposts" >> "OutpostB")] call BIS_fnc_spawnGroup;
    _bunkerPos set [2, 0];
    _obj = _bunkerPos nearestObject "Land_Cargo_Tower_V1_F";
    {
        _x addCuratorEditableObjects [[_obj], true];
    } forEach allCurators;
    _obj allowDamage false;
    _obj addEventHandler ["HandleDamage", {0}];
    _obj addMPEventHandler ["MPKilled", {MAIN_AO_SUCCESS = true; publicVariable "MAIN_AO_SUCCESS";}];
    _bunkerObjects = [_obj] call QS_fnc_addFurniture;
} else {
    _bunkerType = 2;
    _bunkerPositions = _target select 2;
    _bunkerPosition = selectRandom _bunkerPositions;
    _bunkerPos = [_bunkerPosition select 0, _bunkerPosition select 1, 0];
    _smallZ = _bunkerPosition select 2;
    _bigZ = _bunkerPosition select 3;
    _bunkerObjects = [_bunkerPos, _smallZ, _bigZ] call QS_fnc_createBunker;
};

// add UAV with MK200
_anotherChance = random 10;
_uav = objNull;
_uavPos = [0,0,0];
if (_anotherChance < 4) then {
    _uavPos = [_bunkerPos, 40, 200, 3, 0, 20, 0, [], [_bunkerPos]] call QS_fnc_findSafePos;
    _uav = createVehicle ["B_UAV_01_F", _uavPos, [], 0, "NONE"];
    _uav addWeapon ("LMG_Mk200_F");
    _uav addMagazine ("200Rnd_65x39_cased_Box_Tracer");
    createVehicleCrew _uav;
};

// Spawn radiotower
_position = [[[_positionAO, (PARAMS_AOSize/3)], _dt], ["water", "out"]] call QS_fnc_randomPos;
_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
_res = count _flatPos;
while {_res < 1} do {
	_position = [[[_positionAO, (PARAMS_AOSize/3)], _dt], ["water", "out"]] call QS_fnc_randomPos;
	_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
    _distance = _bunkerPos distance _position;
    _res = count _flatPos;
    if (_distance < 500) then {
        _res = 0;
    };
};
_tower = selectRandom [RADIO_TOWERS];
radioTower = _tower createVehicle _flatPos;
waitUntil { sleep 0.5; alive radioTower };
radioTower setVectorUp [0, 0, 1];
radioTowerAlive = true; publicVariable "radioTowerAlive";
radioTower addEventHandler
[
	"HandleDamage",
	{
	    _allowedExplosives = [ALLOWED_EXPLOSIVES];
		_tower_dmg = damage (_this select 0);
		if ((_this select 4) in _allowedExplosives) then {
			_tower_dmg = (_this select 2);
		};
		_tower_dmg;
	}
];
radioTower addEventHandler
[
	"Killed",
	{
	    _points = 10;
        _unit = _this select 1;
        _unit addScore _points;
		["ScoreBonus", ["Радиовышка уничтожена!", _points]] remoteExec ["BIS_fnc_showNotification", _unit];
        WinRadiotower = side _unit; publicVariable "WinRadiotower";
        if (side _unit == resistance) then {
            [2] call QS_fnc_partizanSUCCESS;
        };
	}
];

// Spawn minefield
_campPos = _flatPos;
_hasMines = false;
_groundPos = [0,0,0];
if (_chance < PARAMS_RadioTowerMineFieldChance) then {
    _hasMines = true;
	_minesArray = [_flatPos] call QS_fnc_AOminefield;
	for "_i" from 1 to 3 do {
        _newPos = [_campPos, 35, 65, 3, 0, 15, 0, [], [_campPos]] call QS_fnc_findSafePos;
        while {_groundPos distance _newPos < 30} do {
            _newPos = [_campPos, 40, 60, 3, 0, 15, 0, [], [_campPos]] call QS_fnc_findSafePos;
        };
        _cargo = createVehicle ["Land_Cargo_Patrol_V3_F", [0,0,0], [], 0, "NONE"];
        _groundPos = _newPos;
        _cargo setPos _groundPos;
        _campObjects = ["Land_Cargo_Patrol_V3_F"];
	};
} else {
    _type = selectRandom ["OutpostA", "OutpostE"];
	if (_type == "OutpostE") then {
        _campPos = [(_flatPos select 0) - 2, (_flatPos select 1) + 10, _flatPos select 2];
        _campObjects = ["Land_HBarrier_5_F","Land_Cargo_House_V1_F","Land_Razorwire_F","Land_HBarrier_1_F","Land_HBarrier_3_F","Land_PortableLight_double_F","Land_PaperBox_closed_F","Land_WaterTank_F","Land_ToiletBox_F","Land_TTowerSmall_2_F","Land_GarbageBarrel_01_F","Land_Cargo_Patrol_V1_F"];
    };
    _null = [_campPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "Empty" >> "Military" >> "Outposts" >> _type)] call BIS_fnc_spawnGroup;
    if (_type == "OutpostA") then {
        _nearestObject = nearestObject [_campPos, "Land_BagBunker_Large_F"];
        deleteVehicle _nearestObject;
        _campObjects = ["Land_HBarrierBig_F","Land_BagBunker_Large_F","Land_HBarrier_5_F","Land_PortableLight_double_F","Land_ToiletBox_F","Land_Cargo20_military_green_F","Land_WaterTank_F","Land_WaterBarrel_F","Land_Cargo_Patrol_V1_F","Land_Pallets_F","Land_PaperBox_closed_F","Land_MetalBarrel_F","Land_BarrelEmpty_grey_F","Land_BarrelTrash_grey_F","Land_Pallets_stack_F"];
    };
};
publicVariable "radioTower";
{
	_x addCuratorEditableObjects [[radioTower], false];
} foreach allCurators;

// Spawn avanpost
_avanpostObjects = [];
_avanpostPos = [];
if (_positionAO distance2D (getMarkerPos "respawn_west") > 2500) then {
    _avanpostData = [_positionAO] call QS_fnc_createAvanpost;
    _avanpostPos = _avanpostData select 0;
    _avanpostObjects = _avanpostData select 1;
};

// Spawn enemies
sleep 1;
currentAO = "aoMarker";
_enemiesArray = [currentAO, _bunkerPos, _flatPos, _hasMines, _bunkerType, _avanpostPos] call QS_fnc_AOenemy;

// Set target start text
_targetStartText = format
[
	"<t align='center' size='2.2'>Захватить</t><br/><t size='1.5' align='center' color='#FFC107'>%1</t><br/>____________________<br/>Начинайте наступление.<br/><br/>Захватите командный пункт и уничтожьте радиовышку чтобы лишить противника авиаподдержки.",
	_nameAO
];

// Show global target start hint
GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
showNotification = ["NewMain", _nameAO]; publicVariable "showNotification";
showNotification = ["NewSub", ["Уничтожить радиовышку противника", "\a3\ui_f\data\gui\cfg\hints\mines_ca.paa"]]; publicVariable "showNotification";
showNotification = ["NewSub", ["Захватить командный пункт", "\a3\ui_f\data\gui\cfg\hints\commanding_ca.paa"]]; publicVariable "showNotification";
sleep 2;
MAIN_AO_SUCCESS = false; publicVariable "MAIN_AO_SUCCESS";

// CORE LOOP
currentAOUp = true; publicVariable "currentAOUp";
if (PARAMS_AOReinforcementCas == 1) then {
	[] spawn {
		sleep (30 + (random 180));
		if (alive radioTower) then {
			while {(alive radioTower)} do {
				[] call QS_fnc_enemyCAS;
				sleep (240 + (random 600));
			};
		};
	};
};
_showTowerMessage = false;
_showBunkerMessage = false;
_viperSquadSpawned = false;
while {alive radioTower || !MAIN_AO_SUCCESS || !_showTowerMessage || !_showBunkerMessage} do {
    sleep 3;
    if (!alive radioTower && !_showTowerMessage) then {
        _showTowerMessage = true;

        // RADIO TOWER DESTROYED
        if (WinRadiotower == west) then {
            radioTowerAlive = false; publicVariable "radioTowerAlive";
            _radioTowerDownText = "<t align='center' size='2.2'>Радиовышка</t><br/><t size='1.5' color='#C6FF00' align='center'>Уничтожена</t><br/>____________________<br/>Теперь противник не сможет вызвать авиаподдержку.";
            GlobalSideHint = [west, _radioTowerDownText]; publicVariable "GlobalSideHint";
            showNotification = ["CompletedSub", ["Радиовышка уничтожена!", "\a3\ui_f\data\gui\cfg\hints\mines_ca.paa"], west]; publicVariable "showNotification";
        };
    };
    sleep 3;
    if (MAIN_AO_SUCCESS && !_showBunkerMessage) then {
        _showBunkerMessage = true;

        // BUNKER UNDER OUR CONTROL
        if (WinBunker == west) then {
            _bunkerText = "<t align='center' size='2.2'>Командный пункт</t><br/><t size='1.5' color='#C6FF00' align='center'>Захвачен</t><br/>____________________<br/>Противник дезорганизован.";
            GlobalSideHint = [west, _bunkerText]; publicVariable "GlobalSideHint";
            showNotification = ["CompletedSub", ["Командный пункт захвачен!", "\a3\ui_f\data\gui\cfg\hints\commanding_ca.paa"], west]; publicVariable "showNotification";
        };
    };
    sleep 3;
    // Spawn Viper group
    if ((MAIN_AO_SUCCESS and !_viperSquadSpawned) or (!alive radioTower and !_viperSquadSpawned)) then {
        _viperSquadSpawned = true;
        if (random 1 > 0.5) then {
            _enemiesArray pushBack ([(_bunkerPos getPos [(_bunkerPos distance2D _flatPos) / 2, _bunkerPos getDir _flatPos]), 500, 500, 3000, false, ENEMY_SIDE] call QS_fnc_spawnViper);
        };
    };
};
currentAOUp = false; publicVariable "currentAOUp";

// DE-BRIEF 1
sleep 3;
_targetCompleteText = format ["<t align='center' size='2.2'>Захватили</t><br/><t size='1.5' align='center' color='#FFC107'>%1</t><br/>", _nameAO];
{ _x setMarkerPos [-10000, -10000, -10000];} forEach ["aoCircle", "aoMarker"];
GlobalHint = _targetCompleteText; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["CompletedMain", _nameAO]; publicVariable "showNotification";

// DEFEND AO
if (PARAMS_DefendAO == 1) then {

    // check bots count
    _aliveBots = 0;
    {
        if (side _x == EAST) then {
            {
                if (_positionAO distance2D _x <= 500) then {
                    _aliveBots = _aliveBots + 1;
                };
            } forEach (units _x);
        };
    } forEach allGroups;
    _chanceDefend = random 10;
    if (_chanceDefend > 5 && _aliveBots > 25) then {
        sleep 3;
	    _null = [_target] spawn {_this call compile preProcessFileLineNumbers "mission\main\missions\AOdefend.sqf";};
        waitUntil {sleep 10; !isNil "DEFEND_AO_VICTORY"};
    } else {
        DEFEND_AO_VICTORY = true; publicVariable "DEFEND_AO_VICTORY";
    };
};

{ _x setMarkerPos [-10000, -10000, -10000]; } forEach ["aoCircle_2", "aoMarker_2"];

// DE-BRIEF
if (DEFEND_AO_VICTORY) then {
    _targetCompleteText = format ["<t align='center' size='2.2'>Удержали</t><br/><t size='1.5' align='center' color='#C6FF00'>%1</t><br/>____________________<br/>Хорошая работа! Возвращайтесь на базу для перегруппировки на следующее задание.", _nameAO];
} else {
    _targetCompleteText = format ["<t align='center' size='2.2'>Отступление</t><br/><t size='1.5' align='center' color='#F44336'>%1</t><br/>____________________<br/>Мы отступаем! Возвращайтесь на базу для перегруппировки на следующее задание.<br/><br/>Командование перебросило Вашу наградную технику более результативным подразделениям.", _nameAO];

    // delete reward vehicles
    _vehicles = nearestObjects [[14714,16710], ["LandVehicle","Air","Ship"], 150];
    {
        _curVeh = _x;
        _isReward = _curVeh getVariable ["IS_REWARD", false];
        if (_isReward) then {
            if (count (crew _curVeh) > 0) then {
                {
                    _x action ["EJECT", _curVeh];
                } forEach (crew _curVeh);
            };
            deleteVehicle _curVeh;
        };
    } forEach _vehicles;
};
DEFEND_AO_VICTORY = nil; publicVariable "DEFEND_AO_VICTORY";
GlobalSideHint = [west, _targetCompleteText]; publicVariable "GlobalSideHint";

// hide avanpost respawn
missionNamespace setVariable ["AVANPOST_COORDS", false];
missionNamespace setVariable ["AVANPOST_RESPAWN", false];

// Restore yellow color of nearby vehicle service markers
CURRENT_AO_POSITION = nil; publicVariable "CURRENT_AO_POSITION";
{_x setMarkerColor "ColorUNKNOWN";} forEach _serviceMarkers;
sleep 120;
deleteVehicle _dt;
deleteVehicle radioTower;
if (_chance < PARAMS_RadioTowerMineFieldChance) then {
    [_minesArray] call QS_fnc_TBdeleteObjects;
};
if (_anotherChance < 4) then {
    if (_uav distance _uavPos < 5) then {
        deleteVehicle _uav;
    };
};
_units = nearestObjects [_campPos, _campObjects, 50];
{
    deleteVehicle _x;
} foreach _units;
_units = nearestObjects [_bunkerPos, _bunkerObjects, 50];
{
    deleteVehicle _x;
} foreach _units;
if (count _avanpostPos > 0) then {
    _classes = ["B_support_MG_F"];
    {
        _type = typeOf _x;
        if !(_type in _classes) then {
            _classes pushBack _type;
        };
    } foreach _avanpostObjects;
    _units = nearestObjects [_avanpostPos, _classes, 50];
    {
        deleteVehicle _x;
    } foreach _units;
};
[_enemiesArray] call QS_fnc_TBdeleteObjects;
sleep 10;
_unitTypes = ["O_Soldier_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_TL_F","O_soldier_M_F","O_Soldier_LAT_F",
"O_medic_F","O_soldier_repair_F","O_soldier_exp_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_soldier_PG_F","O_recon_F",
"O_recon_M_F","O_recon_LAT_F","O_recon_medic_F","O_recon_TL_F","O_Soldier_AAT_F","O_soldierU_M_F","O_SoldierU_GL_F",
"O_HeavyGunner_F","O_Urban_HeavyGunner_F","O_support_MG_F","O_soldierU_F","O_soldierU_AR_F","O_soldierU_AAR_F","O_soldierU_LAT_F",
"O_soldierU_AT_F","O_soldierU_AAT_F","O_soldierU_AA_F","O_soldierU_AAA_F","O_soldierU_TL_F","O_SoldierU_SL_F","O_soldierU_medic_F",
"O_soldierU_repair_F","O_soldierU_exp_F","O_engineer_U_F","O_soldierU_A_F","O_Sharpshooter_F","O_Urban_Sharpshooter_F","O_sniper_F"];
_units = nearestObjects [_positionAO, _unitTypes, PARAMS_AOSize];
{
    deleteVehicle _x;
} foreach _units;
true
