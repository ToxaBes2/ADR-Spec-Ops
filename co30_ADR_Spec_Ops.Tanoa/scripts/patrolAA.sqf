/*
Author:	ToxaBes
Description: patrol AA bots on map
*/
_dist = 3000;
_name = worldName;
_team = "";
if (_name == "Altis") then {
    _dist = 10000;
    _team = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA");
};
if (_name == "Tanoa") then {
    _dist = 8000;   
    _team = (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam_AA");
};
while {true} do {
    _groups = [];
    for "_i" from 0 to 3 do {	
        _groundPos = [(getMarkerPos "respawn_west"), 2000, _dist, 2, 0, 0, 0, []] call QS_fnc_findSafePos;
        _targetPos = [(getMarkerPos "respawn_west"), 1000, _dist, 2, 0, 2, 0, []] call QS_fnc_findSafePos;        
        _group = [_groundPos, EAST, _team] call BIS_fnc_spawnGroup;
        _group setBehaviour "COMBAT";
        _group setCombatMode "RED";
        _group setVariable ["zbe_cacheDisabled", true];
        [(units _group)] call QS_fnc_setSkill4;
        [_group, _targetPos, 1000] call BIS_fnc_taskPatrol;
        _groups = _groups + [_group];
    };
    sleep 1800;
    {
        _gr = _x;
        {
            deleteVehicle _x;
        } forEach (units _gr);
        deleteGroup _gr;
    } forEach _groups;
};