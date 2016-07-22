/*
	Description:
	Create a random patrol of several waypoints around a given position.
    Unlike BIS_fnc_taskPatrol all positions are less then _maxDist away from _pos, instead of _prevPos.

	Parameter(s):
	_this select 0: the group to which to assign the waypoints (Group)
	_this select 1: the position on which to base the patrol (Array)
	_this select 2: the maximum distance between waypoints (Number)
	_this select 3: (optional) blacklist of areas (Array)

	Returns:
	Boolean - success flag
*/

//Validate parameter count
if ((count _this) < 3) exitWith {debugLog "Log: [taskPatrol] Function requires at least 3 parameters!"; false};

private ["_grp", "_pos", "_maxDist", "_blacklist"];
_grp = _this select 0;
_pos = _this select 1;
_maxDist = _this select 2;

_blacklist = [];
if ((count _this) > 3) then {_blacklist = _this select 3};

//Validate parameters
if ((typeName _grp) != (typeName grpNull)) exitWith {debugLog "Log: [taskPatrol] Group (0) must be a Group!"; false};
if ((typeName _pos) != (typeName [])) exitWith {debugLog "Log: [taskPatrol] Position (1) must be an Array!"; false};
if ((typeName _maxDist) != (typeName 0)) exitWith {debugLog "Log: [taskPatrol] Maximum distance (2) must be a Number!"; false};
if ((typeName _blacklist) != (typeName [])) exitWith {debugLog "Log: [taskPatrol] Blacklist (3) must be an Array!"; false};

_grp setBehaviour "SAFE";

//Create a string of randomly placed waypoints that are _maxDist away from the center position (_pos).
private ["_prevPos"];
_prevPos = _pos;
for "_i" from 0 to (2 + (floor (random 3))) do
{
	private ["_wp", "_newPos"];
    for "_i" from 0 to 1000 do {
        _newPos = [_prevPos, 50, _maxDist, 1, 0, 60 * (pi / 180), 0, _blacklist, [_pos]] call BIS_fnc_findSafePos;
        if ((_newPos distance2D _pos) <= _maxDist) exitWith {};
    };
	_prevPos = _newPos;

	_wp = _grp addWaypoint [_newPos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 20;

	//Set the group's speed and formation at the first waypoint.
	if (_i == 0) then
	{
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointFormation "STAG COLUMN";
	};
};

//Cycle back to the first position.
private ["_wp"];
_wp = _grp addWaypoint [_pos, 0];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 20;

true
