private ["_units","_building","_unit","_bpA","_func","_firstWP","_stackPos","_targets","_fsm"];

_group = _this select 0;
_position = _this select 1;
_units = units _group;
_leader = leader _group;
_idx = currentWaypoint _group;
_building = nearestBuilding _position;
_locations = [_building] call BIS_fnc_buildingPositions;
_n = 0;
{
	_idx = _idx + 1;
	_pos = _x;
	_name = format ["wp_clear_%1", _idx];    
    _wp = _group addWaypoint [_pos, 0, 0, _name];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "AWARE";
    _wp setWaypointCombatMode "RED";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointFormation "STAG COLUMN";
    _wp setWaypointCompletionRadius 0;
    _wp setWaypointHousePosition _n;
    _wp waypointAttachObject _building;
    _wp setWaypointTimeout [2, 5, 7];
    _n = _n + 1;
} forEach _locations;
