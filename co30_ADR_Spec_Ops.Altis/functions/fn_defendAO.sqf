/*
Author: ToxaBes (Based on EOS_Bastion by BangaBob)
Description: create reinforcements for defend AO.
Format: [marker, Number of Infantry groups (2 bots in group), [Number of Light vehicles groups, Cargo size], [Number of Armored vehicles groups], [Number of Helicopters groups, Cargo size], side] call QS_fnc_defendAO;
*/
if (!isServer) exitWith {};
private ["_startPoint","_infantry","_lightVehicles ","_lightVehiclesGroups","_lightVehiclesSize","_armoredVehicles","_helicopters","_helicopterGroups","_helicopterSize","_side","_enemyUnits","_group","_vehicles","_groundPos","_patrolGroup","_getToMarker","_bGroup","_vehType","_isWater","_vehicle","_cargoGrp","_emptySeats","_unitType","_unit","_null","_wp","_cGroup","_fGroup","_wp1","_curGroup"];

_startPoint = _this select 0;
_infantry = _this select 1;
_lightVehicles = _this select 2;
_lightVehiclesGroups = _lightVehicles select 0;
_lightVehiclesSize = _lightVehicles select 1;
_armoredVehicles = _this select 3;
_helicopters = _this select 4;
_helicopterGroups = _helicopters select 0;
_helicopterSize = _helicopters select 1;
_side = _this select 5;
_enemyUnits = ["O_Soldier_F", "O_Soldier_lite_F", "O_Soldier_GL_F", "O_Soldier_AR_F", "O_Soldier_SL_F", "O_Soldier_TL_F", "O_soldier_M_F", "O_Soldier_LAT_F", "O_medic_F", "O_Soldier_AA_F", "O_officer_F", "O_recon_F", "O_recon_LAT_F", "O_recon_medic_F", "O_recon_TL_F", "O_recon_M_F", "O_Sharpshooter_F", "O_HeavyGunner_F"];
_group = [];
_vehicles = [];

// spawn patrols
for "_counter" from 1 to _infantry do {
    _groundPos = [_startPoint, 500, 600, 2, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    _patrolGroup = [_groundPos, _side, (configfile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSentry")] call BIS_fnc_spawnGroup;
    [_patrolGroup, true] call QS_fnc_moveToHC;
    [_patrolGroup, _startPoint] call BIS_fnc_taskAttack;
    _patrolGroup setBehaviour "COMBAT";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill3;
    _group set [count _group, _patrolGroup];

    _getToMarker = _patrolGroup addWaypoint [_startPoint, 50];
	_getToMarker setWaypointType "SAD";
	_getToMarker setWaypointSpeed "FULL";
	_getToMarker setWaypointBehaviour "AWARE";
	_getToMarker setWaypointFormation "NO CHANGE";
};

// spawn trucks with infantry or light vehicles
for "_counter" from 1 to _lightVehiclesGroups do {
	_bGroup = createGroup _side;
	_groundPos = [_startPoint, 600, 750, 2, 1, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
	if (surfaceiswater _groundPos) then {
		_vehType = "O_Boat_Armed_01_hmg_F";
		_isWater = true;
	} else {
	    _vehType = selectRandom ["O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F", "O_Truck_02_covered_F", "O_Truck_03_covered_F"];
	    _isWater = false;
	};
    _vehicle = createVehicle [_vehType, _groundPos, [], 0, "CAN_COLLIDE"];
    _vehicle addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    _vehicles = _vehicles + [_vehicle];
    createVehicleCrew _vehicle;
    (crew _vehicle) join _bGroup;
    _bGroup setBehaviour "COMBAT";
    _bGroup setCombatMode "RED";
    _group set [count _group, _bGroup];
    [(units _bGroup)] call QS_fnc_setSkill3;
	if (_lightVehiclesSize > 0) then {
		_cargoGrp = createGroup _side;
		_emptySeats = _vehicle emptyPositions "cargo";
        if (_emptySeats > 0) then {
	        if (_lightVehiclesSize > _emptySeats) then {
	        	_lightVehiclesSize = _emptySeats;
	        };
         	for "_x" from 1 to _lightVehiclesSize do {
	        	_unitType = _enemyUnits select (floor(random(count _enemyUnits)));
	        	_unit = _unitType createUnit [getPos _vehicle, _cargoGrp];
	        };
	        {
	            _x moveincargo _vehicle
	        } forEach units _cargoGrp;
        };
        _cargoGrp setBehaviour "COMBAT";
        _cargoGrp setCombatMode "RED";
        [(units _cargoGrp)] call QS_fnc_setSkill3;
        _group set [count _group, _cargoGrp];
		_null = [_startPoint, _vehicle, _bGroup, _cargoGrp, _isWater] spawn {_this call compile preProcessFileLineNumbers "scripts\vehicle\unload\truck.sqf";};
	} else {
		_wp = _bGroup addWaypoint [_startPoint, 50];
		_wp setWaypointType "SAD";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointFormation "NO CHANGE";
	};
	sleep 1;
};

// spawn armored vehicles
for "_counter" from 1 to _armoredVehicles do {
	_cGroup = createGroup _side;
    _groundPos = [_startPoint, 700, 1000, 2, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    _vehType = selectRandom ["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_MBT_02_cannon_F", "O_APC_Tracked_02_AA_F"];
    _vehicle = createVehicle [_vehType, _groundPos, [], 0, "CAN_COLLIDE"];
    _vehicle addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    _vehicles = _vehicles + [_vehicle];
    createVehicleCrew _vehicle;
    (crew _vehicle) join _cGroup;
    _cGroup setBehaviour "COMBAT";
    _cGroup setCombatMode "RED";
    [(units _cGroup)] call QS_fnc_setSkill3;
	_group set [count _group, _cGroup];

	_getToMarker = _cGroup addWaypoint [_startPoint, 50];
	_getToMarker setWaypointType "SAD";
	_getToMarker setWaypointSpeed "FULL";
	_getToMarker setWaypointBehaviour "AWARE";
	_getToMarker setWaypointFormation "NO CHANGE";
	sleep 1;
};

// spawn helicopters with descent
for "_counter" from 1 to _helicopterGroups do {
	_fGroup = createGroup _side;
	if (_helicopterSize > 0) then {
		_vehType = "O_Heli_Transport_04_covered_F";
	} else {
	    _vehType = selectRandom ["O_Heli_Attack_02_F", "I_Heli_light_03_F", "O_Heli_Light_02_F"];
    };
	_groundPos = [_startPoint, 2000, 3000, 1, 0, 10, 0, [], [_startPoint]] call QS_fnc_findSafePos;
    _vehicle = createVehicle [_vehType, _groundPos, [], 0, "FLY"];
    _vehicle addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    _vehicles = _vehicles + [_vehicle];
    createVehicleCrew _vehicle;
    (crew _vehicle) join _fGroup;
    _fGroup setBehaviour "COMBAT";
    _fGroup setCombatMode "RED";
    [(units _fGroup)] call QS_fnc_setSkill3;
	_group set [count _group, _fGroup];
	if (_helicopterSize > 0) then {
		_cargoGrp = createGroup _side;
		_emptySeats = _vehicle emptyPositions "cargo";
        if (_emptySeats > 0) then {
	        if (_helicopterSize > _emptySeats) then {
	        	_helicopterSize = _emptySeats;
	        };
         	for "_x" from 1 to _helicopterSize do {
	        	_unitType = _enemyUnits select (floor(random(count _enemyUnits)));
	        	_unit = _unitType createUnit [getPos _vehicle, _cargoGrp];
	        };
	        {
	            _x moveincargo _vehicle
	        } forEach units _cargoGrp;
        };
        _cargoGrp setBehaviour "COMBAT";
        _cargoGrp setCombatMode "RED";
        [(units _cargoGrp)] call QS_fnc_setSkill3;
        _group set [count _group, _cargoGrp];
		_null = [_startPoint, _vehicle, _fGroup, _cargoGrp] spawn {_this call compile preProcessFileLineNumbers "scripts\vehicle\unload\heli.sqf";};
	} else {
		_wp1 = _fGroup addWaypoint [_startPoint, 0];
		_wp1 setWaypointSpeed "FULL";
		_wp1 setWaypointType "SAD";
	};
	sleep 1;
};
DEFEND_AO_VEHICLES = _vehicles;
publicVariable "DEFEND_AO_VEHICLES";
_group
