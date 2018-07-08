/*
Author: ToxaBes
Description: attack base
*/
_side = _this select 0;
_dist = 750;
if (_side == resistance) then {
	_dist = 450;
};
sleep 10;
_name = worldName;
_team = "";
_veh1 = "";
_veh2 = "";
if (_name == "Altis") then {
	if (_side == west) then {
	    _team = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "O_InfTeam_AT_Heavy");
	    _veh1 = selectRandom ["O_LSV_02_armed_F", "O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F"];
        _veh2 = selectRandom ["O_APC_Wheeled_02_rcws_v2_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F"];
	} else {
        _team = (configfile >> "CfgGroups" >> "East" >> "OPF_G_F" >> "Infantry" >> "O_G_InfTeam_Light");
        _veh1 = selectRandom ["O_G_Offroad_01_AT_F", "O_G_Offroad_01_armed_F"];
        _veh2 = selectRandom ["I_C_Offroad_02_AT_F", "I_C_Offroad_02_LMG_F"];
    };    
};
if (_name == "Tanoa") then {
	if (_side == west) then {
	    _team = (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam_AT_Heavy");
	    _veh1 = selectRandom ["O_T_LSV_02_armed_F", "O_T_MRAP_02_hmg_ghex_F", "O_T_MRAP_02_gmg_ghex_F"];
        _veh2 = selectRandom ["O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_v2_ghex_F", "O_T_APC_Tracked_02_AA_ghex_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F"];
	} else {
        _team = (configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "BanditShockTeam");
        _veh1 = selectRandom ["I_C_Offroad_02_AT_F", "I_C_Offroad_02_LMG_F"];
        _veh2 = selectRandom ["O_G_Offroad_01_AT_F", "O_G_Offroad_01_armed_F"];
    };    
};
if (_name == "Malden") then {
	if (_side == west) then {
	    _team = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "O_InfTeam_AT_Heavy");
	    _veh1 = selectRandom ["O_LSV_02_armed_F", "O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F"];
        _veh2 = selectRandom ["O_APC_Wheeled_02_rcws_v2_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F"];
	} else {
        _team = (configfile >> "CfgGroups" >> "East" >> "OPF_G_F" >> "Infantry" >> "O_G_InfTeam_Light");
        _veh1 = selectRandom ["O_G_Offroad_01_AT_F", "O_G_Offroad_01_armed_F"];
        _veh2 = selectRandom ["I_C_Offroad_02_AT_F", "I_C_Offroad_02_LMG_F"];
    };    
};

_groups = [];
_vehs = [];
_score = BLUFOR_BASE_SCORE;
_basePos = getMarkerPos "respawn_west";
if (_side == resistance) then {
    _score = PARTIZAN_BASE_SCORE;
    _basePos = getMarkerPos "respawn_guerrila";
};
_groundPos = [_basePos, 300, _dist, 2, 0, 0, 0, []] call QS_fnc_findSafePos;
if (_score > 9) then {        
    _group = [_groundPos, EAST, _team] call BIS_fnc_spawnGroup;
    _group setBehaviour "COMBAT";
    _group setCombatMode "RED";
    _group setVariable ["zbe_cacheDisabled", true];
    [(units _group)] call QS_fnc_setSkill4;
    [_group, _basePos, 150] call BIS_fnc_taskPatrol;
    _group deleteGroupWhenEmpty true;
    _groups = _groups + [_group];
};
if (_score > 19) then {
	_veh1Group = createGroup east;
    _veh1Pos = [_groundPos, 20, 150, 3, 0, 0, 0, []] call QS_fnc_findSafePos;     
    _vehicle1 = createVehicle [_veh1, _veh1Pos, [], 0, "CAN_COLLIDE"];
    _vehicle1 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    _vehs = _vehs + [_vehicle1];
    createVehicleCrew _vehicle1;
    (crew _vehicle1) joinSilent _veh1Group;
    _veh1Group setBehaviour "COMBAT";
    _veh1Group setCombatMode "RED";
    _veh1Group setVariable ["zbe_cacheDisabled", true];
    [(units _veh1Group)] call QS_fnc_setSkill4;
    _veh1Group deleteGroupWhenEmpty true;
    _groups = _groups + [_veh1Group];
    [_veh1Group, _basePos, 200] call BIS_fnc_taskPatrol;
};
if (_score > 29) then {
	_veh2Group = createGroup east;
    _veh2Pos = [_groundPos, 20, 200, 3, 0, 0, 0, []] call QS_fnc_findSafePos;     
    _vehicle2 = createVehicle [_veh2, _veh2Pos, [], 0, "CAN_COLLIDE"];
    _vehicle2 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    _vehs = _vehs + [_vehicle2];
    createVehicleCrew _vehicle2;
    (crew _vehicle2) joinSilent _veh2Group;
    _veh2Group setBehaviour "COMBAT";
    _veh2Group setCombatMode "RED";
    _veh2Group setVariable ["zbe_cacheDisabled", true];
    [(units _veh2Group)] call QS_fnc_setSkill4;
    _veh2Group deleteGroupWhenEmpty true;
    _groups = _groups + [_veh2Group];
    [_veh2Group, _basePos, 300] call BIS_fnc_taskPatrol;
};
sleep 1800;
{
    _veh = _x;
    if (side _veh == east || {alive _x} count crew _veh == 0) then {
        deleteVehicle _veh;
    };
} forEach _vehs;
{
    _gr = _x;
    {
        deleteVehicle _x;
    } forEach (units _gr);
    deleteGroup _gr;        
} forEach _groups;
