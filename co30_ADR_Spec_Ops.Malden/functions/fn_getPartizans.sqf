/*
Author: ToxaBes
Description: recruit resistance bots into group
*/
_player = _this select 0;
_timeout = 2400; // 40 mins
_units = [];
if (isNil "PARTIZAN_RECRUIT") then {
    PARTIZAN_RECRUIT = time - 1; publicVariable "PARTIZAN_RECRUIT";
};
_diff = PARTIZAN_RECRUIT - time;
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
if (PARTIZAN_BASE_SCORE > 8) then {
	if (worldName == "Tanoa") then {
        _units = ["I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_8_F"];
    }else {
    	_units = ["I_G_Soldier_F","I_G_medic_F","I_G_Soldier_AR_F","I_G_engineer_F"];
    };
};

// Bots 2
if (PARTIZAN_BASE_SCORE > 17) then {
    if (worldName == "Tanoa") then {
        _units = ["I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_4_F"];
    }else {
    	_units = ["I_G_Sharpshooter_F","I_G_Soldier_LAT_F","I_G_Soldier_GL_F","I_G_Soldier_AR_F"];
    };
};

// Bots 3
if (PARTIZAN_BASE_SCORE > 26) then {
    _units = ["I_Soldier_AT_F","I_Soldier_AA_F","I_Soldier_AR_F","I_Sniper_F"];
};

// Bots 4
if (PARTIZAN_BASE_SCORE > 35) then {
    if (worldName == "Tanoa") then {
        _units = ["O_V_Soldier_JTAC_ghex_F","O_V_Soldier_M_ghex_F","O_V_Soldier_Exp_ghex_F","O_V_Soldier_LAT_ghex_F","O_V_Soldier_Medic_ghex_F"];
    }else {
        _units = ["O_V_Soldier_JTAC_hex_F","O_V_Soldier_M_hex_F","O_V_Soldier_Exp_hex_F","O_V_Soldier_LAT_hex_F","O_V_Soldier_Medic_hex_F"];
    };
};

if (count _units == 0) exitWith {
    ["<t color='#F44336' size = '.48'>Рекрутинг бойцов невозможен на данном уровне развития базы!</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

_pos = getPos _player;
_grp = createGroup resistance;
{
   _x createUnit [_pos, _grp, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];   
} forEach _units;
_grp deleteGroupWhenEmpty true;
[(units _grp)] call QS_fnc_setSkill3;
(units _grp) joinSilent (group _player);
(group _player) selectLeader _player;

PARTIZAN_RECRUIT = time + _timeout; publicVariable "PARTIZAN_RECRUIT";