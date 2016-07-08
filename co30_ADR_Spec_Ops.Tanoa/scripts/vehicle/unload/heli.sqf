/*
Author: ToxaBes (Based on EOS_Bastion by BangaBob)
Description: unload cargo group near destination point
*/
private ["_startPoint","_getToMarker","_cargoGrp","_vehicle","_grp","_pos","_wp1","_wp2","_wp2_pos"];
_startPoint = _this select 0;
_vehicle = _this select 1;
_grp = _this select 2;
_cargoGrp = _this select 3;
_pos = [_startPoint, 150, 300, 1, 0, 10, 0, [], _startPoint] call BIS_fnc_findSafePos;
{_x allowFleeing 0} forEach units _grp;
{_x allowFleeing 0} forEach units _cargoGrp;
{_x addBackpack "B_Parachute"} forEach units _cargoGrp;
_vehicle flyinheight 200;
_wp1 = _grp addWaypoint [_pos, 0];
_wp1 setWayPointSpeed "FULL";
_wp1 setWayPointType "MOVE";
_wp1 setWayPointCombatMode "BLUE";
waituntil {sleep 1; [_vehicle, _pos] call BIS_fnc_distance2D < 1000};

waituntil {sleep 0.2; [_vehicle, _pos] call BIS_fnc_distance2D < 350};
{
	unassignVehicle _x;
	_x action ["getOut", _vehicle];
	sleep 0.2;
} forEach units _cargoGrp;
_getToMarker = _cargoGrp addWaypoint [_startPoint, 50];
_getToMarker setWaypointType "SAD";
_getToMarker setWaypointSpeed "FULL";
_getToMarker setWaypointBehaviour "AWARE";
_getToMarker setWayPointCombatMode "RED";
_getToMarker setWaypointFormation "NO CHANGE";
sleep 3;
_vehicle flyinheight 200;
_wp2_pos = [_startPoint, 3000, random 360] call BIS_fnc_relPos;
_wp2 = _grp addWaypoint [_wp2_pos, 50];
_wp2 setWaypointSpeed "FULL";
_wp2 setWaypointType "MOVE";
_wp2 setWayPointCombatMode "BLUE";
_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew (vehicle this) + [vehicle this];"];
