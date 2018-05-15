if (isNil "cTabWaypointIcons") then {
    cTabWaypointIcons = [];
};

if (isNil "cTabWaypointGroups") then {
    cTabWaypointGroups = [];
};

_group = group player;
_grp = createGroup (side player);
{
    if !(isPlayer _x) then {
        [_x] joinSilent _grp;
    };
} forEach units _group;

if (count units _grp == 0) exitWith {
	systemChat format ["Нет AI бойцов для отдельной группы!"];
};

_idx = 0;
_radius = 0;
{
	_center = _x select 0;
    _type = _x select 1;
	_mode = _x select 3;
    _behaviour = _x select 4;
    _speed = _x select 5;
    _name = format ["wp_%1", _idx];    
    _wp = _grp addWaypoint [_center, _radius, _idx, _name];
    _wp setWaypointType _type;    
    if (_type == "Scripted") then {
        _wp setWaypointScript "scripts\cTab\shared\cTab_clearBuilding.sqf";
    };
    if !(_behaviour == "UNCHANGED") then {
        _wp setWaypointBehaviour _behaviour;
    };
    if !(_mode == "UNCHANGED") then {
        _wp setWaypointCombatMode _mode;
    };
    if !(_speed == "UNCHANGED") then {
        _wp setWaypointSpeed _speed;
    };
    //_wp setWaypointStatements ["true","deleteWaypoint [group this, currentWaypoint (group this)]; cTabWaypointIcons deleteAt 0;"];
    _wp setWaypointVisible false;
    _idx = _idx + 1;
} forEach cTabWaypointIcons;
_grp setCurrentWaypoint [_grp, 0];
_grp deleteGroupWhenEmpty true;
_data = [getPlayerUID player, _grp];
cTabWaypointGroups pushBack _data;