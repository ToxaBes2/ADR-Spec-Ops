/*
Author: ToxaBes
Description: recruit bots into group
*/
_player = _this select 0;
_timeout = 2400; // 40 mins
_units = [];
if (isNil "COMMANDER_RECRUIT") then {
    COMMANDER_RECRUIT = time - 1; publicVariable "COMMANDER_RECRUIT";
};
_diff = COMMANDER_RECRUIT - time;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Рекрутинг будет доступен через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

// remove all previous reqruits in player group
_unitsInGroup = units (group _player);
{
    if !(isPlayer _x) then {
        deleteVehicle _x;
    };
} forEach _unitsInGroup;

// Bots 1
if (BLUFOR_BASE_SCORE > 8) then {
	if (worldName == "Tanoa") then {
        _units = ["B_T_Medic_F","B_T_Soldier_AR_F","B_T_Engineer_F","B_T_Soldier_F"];
    }else {
    	_units = ["B_medic_F","B_soldier_AR_F","B_engineer_F","B_Soldier_F"];
    };
};

// Bots 2
if (BLUFOR_BASE_SCORE > 17) then {
    if (worldName == "Tanoa") then {
        _units = ["B_T_Soldier_AT_F","B_T_Soldier_GL_F","B_T_Soldier_AR_F","B_T_soldier_M_F"];
    }else {
    	_units = ["B_HeavyGunner_F","B_Soldier_GL_F","B_soldier_AT_F","B_Sharpshooter_F"];
    };
};

// Bots 3
if (BLUFOR_BASE_SCORE > 26) then {
    if (worldName == "Tanoa") then {
        _units = ["B_T_Soldier_AT_F","B_T_Soldier_AA_F","B_T_ghillie_tna_F","B_T_Soldier_AR_F"];
    }else {
    	_units = ["B_soldier_AT_F","B_soldier_AA_F","B_HeavyGunner_F","B_ghillie_sard_F"];
    };
};

// Bots 4
if (BLUFOR_BASE_SCORE > 35) then {
    _units = ["B_CTRG_Soldier_M_tna_F","B_CTRG_Soldier_Medic_tna_F","B_CTRG_Soldier_JTAC_tna_F","B_CTRG_Soldier_AR_tna_F","B_CTRG_Soldier_LAT_tna_F"];
};

if (count _units == 0) exitWith {
    ["<t color='#F44336' size = '.48'>Рекрутинг бойцов невозможен на данном уровне развития базы!</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

_pos = getPos _player;
_grp = createGroup WEST;
{
   _x createUnit [_pos, _grp, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];   
} forEach _units;
_grp deleteGroupWhenEmpty true;
[(units _grp)] call QS_fnc_setSkill3;
(units _grp) joinSilent (group _player);
(group _player) selectLeader _player;

COMMANDER_RECRUIT = time + _timeout; publicVariable "COMMANDER_RECRUIT";