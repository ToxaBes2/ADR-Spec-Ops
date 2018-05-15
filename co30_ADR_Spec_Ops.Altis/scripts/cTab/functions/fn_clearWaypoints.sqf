if (isNil "cTabWaypointGroups") then {
    cTabWaypointGroups = [];
};
_uid = getPlayerUID player;
_group = group player;
{
    _commanderUid = _x select 0;
    if (_commanderUid == _uid) then {
    	_grp = _x select 1;
    	(units _grp) joinSilent _group;
    	deleteGroup _grp;
    };
} forEach cTabWaypointGroups;

cTabWaypointIcons = [];
