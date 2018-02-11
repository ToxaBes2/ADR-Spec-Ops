/*
Author: ToxaBes
Description: helicopter with descent
*/
_center = _this select 0;
_units = ["B_Soldier_SL_F","B_Soldier_GL_F","B_soldier_AT_F","B_medic_F","B_soldier_AR_F","B_HeavyGunner_F","B_soldier_AAR_F","B_soldier_M_F",
"B_Sharpshooter_F","B_soldier_LAT_F","B_sniper_F","B_ghillie_ard_F","B_ghillie_lsh_F","B_ghillie_sard_F"];
["<t color='#7FDA0B' size = '.48'>Запрос десанта...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
_posHeli = [(_center select 0) + 1000 + (random 500) - (random 500), (_center select 1) + 1000 + (random 500) - (random 500), 300];
_heli = createVehicle ["B_Heli_Transport_03_unarmed_F", _posHeli, [], 0, "FLY"];
createVehicleCrew _heli;
_group = group (driver _heli);
[(units _group)] call QS_fnc_setSkill4;

_backpack = "B_Parachute";
_cargoGrp = createGroup WEST;
_emptySeats = _heli emptyPositions "cargo";
if (_emptySeats > 0) then {
    if (_emptySeats > 12) then {
        _emptySeats = 12;
    };
    for "_x" from 1 to _emptySeats do {
        _unitType = selectRandom _units;
        _unit = _unitType createUnit [getPos _heli, _cargoGrp];
    };
    {
        _x moveincargo _heli;
        _x allowFleeing 0;
        removeBackpack _x;
        _x addBackpackGlobal _backpack;
    } forEach units _cargoGrp;
};
_cargoGrp setBehaviour "COMBAT";
_cargoGrp setCombatMode "RED";
[(units _cargoGrp)] call QS_fnc_setSkill3;
_heli flyInHeight 250;
_wp1 = _group addWaypoint [_center, 0];
_wp1 setWayPointSpeed "FULL";
_wp1 setWayPointType "MOVE";
_wp1 setWayPointCombatMode "BLUE";
_wp1 setWaypointVisible false;
_delta = 2000;
_finish = [(_center select 0) + _delta, (_center select 1) + _delta, 1000];
_wp2 = _group addWaypoint [_finish, 1];
_wp2 setWaypointSpeed "FULL";
_wp2 setWaypointType "MOVE";
_wp2 setWayPointCombatMode "BLUE";
_wp2 setWaypointStatements ["true", "cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew cleanUpveh + [cleanUpveh];"];
_wp2 setWaypointVisible false;
[_heli, _center, _group, _cargoGrp] spawn {
    _heli  = _this select 0;
    _center   = _this select 1;
    _group = _this select 2;
    _cargoGrp = _this select 3;
    waitUntil {sleep 1; [_heli, _center] call BIS_fnc_distance2D < 400};
    _heli animateDoor ["Door_rear_source", 1];
    {
        unassignVehicle _x;
        _x action ["getOut", _heli];
        sleep 0.25;
    } forEach units _cargoGrp;
    _heli animateDoor ["Door_rear_source", 0];
    _getToMarker = _cargoGrp addWaypoint [_center, 50];
    _getToMarker setWaypointType "SAD";
    _getToMarker setWaypointSpeed "FULL";
    _getToMarker setWaypointBehaviour "AWARE";
    _getToMarker setWayPointCombatMode "RED";
    _getToMarker setWaypointFormation "NO CHANGE";
    _getTomarker setWaypointVisible false;
    
    sleep 900;
    {
        deleteVehicle _x;
    } forEach (units _cargoGrp);
};
