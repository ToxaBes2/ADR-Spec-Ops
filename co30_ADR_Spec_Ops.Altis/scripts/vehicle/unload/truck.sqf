/*
Author: ToxaBes (Based on EOS_Bastion by BangaBob)
Description: unload cargo group near destination point
*/
private ["_startPoint","_getToMarker","_cargoGrp","_vehicle","_bGroup","_pos","_wp1","_wp2","_isWater"];
_startPoint = _this select 0;
_vehicle = _this select 1;
_bGroup = _this select 2;
_cargoGrp = _this select 3;
_isWater = _this select 4;
if (_isWater) then {
	_pos = [_startPoint, 250, 600, 5, 1, 5, 1, [], [_startPoint]] call BIS_fnc_findSafePos;
} else {
	_pos = [_startPoint, 400, 600, 5, 0, 5, 0, [], [_startPoint]] call BIS_fnc_findSafePos;
};
if (count _pos == 2) then {
	_pos set [2,0];
};
{_x allowFleeing 0} forEach units _bGroup;
{_x allowFleeing 0} forEach units _cargoGrp;
_wp1 = _bGroup addWaypoint [_pos, 0];
_wp1 setWaypointType "UNLOAD";
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointBehaviour "AWARE";
_wp1 setWaypointFormation "NO CHANGE";
waituntil {sleep 1; ([_vehicle, _pos] call BIS_fnc_distance2D < 50) and (speed _vehicle < 2)};
{
	unassignVehicle _x;
	_x action ["getOut", _vehicle];
	sleep 0.3;
} forEach units _cargoGrp;
_getToMarker = _cargoGrp addWaypoint [_startPoint, 50];
_getToMarker setWaypointType "SAD";
_getToMarker setWaypointSpeed "FULL";
_getToMarker setWaypointBehaviour "AWARE";
_getToMarker setWaypointFormation "NO CHANGE";
waitUntil {sleep 0.2; {_x in _vehicle} count units _cargoGrp == 0};
sleep 5;
_wp2 = _bGroup addWaypoint [_startPoint, 50];
_wp2 setWaypointType "SAD";
_wp2 setWaypointSpeed "FULL";
_wp2 setWaypointBehaviour "AWARE";
_wp2 setWaypointFormation "NO CHANGE";
