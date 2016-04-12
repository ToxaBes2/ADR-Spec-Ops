/*
Author:	ToxaBes
Description: fill buildings with bots in given raduis
Format: [startPos, radius, bots, side, (bool) zeus curator (optional), (array) black list of buildings (optional), aiming accuracy 0-1 (optional)]
*/
if (!isServer) exitWith {};

// prepare params
_startPos = _this select 0;
if (count _startPos > 2) then {
    _startPos resize 2;
};
_radius = _this select 1;
_bots = _this select 2;
_side = _this select 3;
_zeusCurator = _this param [4, false];
_blackList = _this param [5, []];
_accuracy = _this param [6, -1];
if (_accuracy == -1) then {
    switch (PARAMS_AimingAccuracy) do { 
        case 0 : {  _accuracy = 0.1; }; 
        case 1 : {  _accuracy = 0.3; }; 
        case 2 : {  _accuracy = 0.5; }; 
        case 3 : {  _accuracy = 0.7; }; 
        case 4 : {  _accuracy = 1; }; 
        default {   _accuracy = 1; }; 
    };
};
_enemiesArray = [grpNull];
_units = [];
_bridges = ["Land_Bridge_HighWay_PathLod_F","Land_Bridge_Concrete_PathLod_F","Land_Bridge_Asphalt_PathLod_F","Land_Bridge_01_PathLod_F"];
_towers = ["Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V1_No1_F","Land_Cargo_Tower_V1_No2_F","Land_Cargo_Tower_V1_No3_F","Land_Cargo_Tower_V1_No4_F","Land_Cargo_Tower_V1_No5_F","Land_Cargo_Tower_V1_No6_F","Land_Cargo_Tower_V1_No7_F","Land_Cargo_Tower_V2_F","Land_Cargo_Tower_V3_F"];
switch (_side) do { 
	case WEST : {
        _units = ["B_Soldier_02_f", "B_Soldier_03_f", "B_Soldier_04_f", "B_Soldier_05_f", "B_Soldier_F", "B_Soldier_lite_F", "B_Soldier_GL_F", 
"B_soldier_AR_F", "B_Soldier_SL_F", "B_Soldier_TL_F", "B_soldier_M_F", "B_soldier_LAT_F", "B_medic_F", "B_soldier_repair_F", 
"B_soldier_exp_F", "B_Soldier_A_F", "B_soldier_AT_F", "B_soldier_AA_F", "B_engineer_F", "B_crew_F", "B_officer_F", 
"B_soldier_PG_F", "B_soldier_UAV_F", "b_soldier_unarmed_f", "B_recon_F", "B_recon_LAT_F", "B_recon_exp_F", "B_recon_medic_F", 
"B_recon_TL_F", "B_recon_M_F", "B_recon_JTAC_F", "B_spotter_F", "B_sniper_F", "b_soldier_survival_F", "B_CTRG_soldier_GL_LAT_F", 
"B_CTRG_soldier_engineer_exp_F", "B_CTRG_soldier_M_medic_F", "B_CTRG_soldier_AR_A_F", "B_soldier_AAR_F", "B_soldier_AAT_F", 
"B_soldier_AAA_F", "B_support_MG_F", "B_support_GMG_F", "B_support_Mort_F", "B_support_AMG_F", "B_support_AMort_F", 
"B_G_Soldier_F", "B_G_Soldier_lite_F", "B_G_Soldier_SL_F", "B_G_Soldier_TL_F", "B_G_Soldier_AR_F", "B_G_medic_F", "B_G_engineer_F",
"B_G_Soldier_exp_F", "B_G_Soldier_GL_F", "B_G_Soldier_M_F", "B_G_Soldier_LAT_F", "B_G_Soldier_A_F", "B_G_officer_F", 
"B_Sharpshooter_F", "B_Recon_Sharpshooter_F", "B_CTRG_Sharphooter_F", "B_HeavyGunner_F", "B_G_Sharpshooter_F"];
    }; 
	case RESISTANCE : { 
        _units = ["I_Soldier_A_F","I_soldier_AR_F","I_medic_F","I_engineer_F","I_soldier_exp_F","I_Soldier_GL_F","I_soldier_M_F","I_soldier_AA_F",
"I_soldier_AT_F","I_officer_F","I_soldier_repair_F","I_Soldier_F","I_soldier_LAT_F","I_Soldier_lite_F","I_Soldier_SL_F","I_Soldier_TL_F",
"I_soldier_AAR_F","I_soldier_AAA_F","I_soldier_AAT_F","I_G_Soldier_A_F","I_G_soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_soldier_exp_F",
"I_G_Soldier_GL_F","I_G_soldier_M_F","I_G_officer_F","I_G_Soldier_F","I_G_soldier_LAT_F","I_G_Soldier_lite_F","I_G_Soldier_SL_F","I_G_Soldier_TL_F"];
    }; 
	case EAST : {
        _units = ["O_Soldier_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_TL_F","O_soldier_M_F","O_Soldier_LAT_F","O_medic_F",
"O_soldier_repair_F","O_soldier_exp_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_soldier_PG_F","O_recon_F","O_recon_M_F",
"O_recon_LAT_F","O_recon_medic_F","O_recon_TL_F","O_Soldier_AAT_F","O_soldierU_M_F","O_SoldierU_GL_F","O_Urban_Sharpshooter_F", "O_HeavyGunner_F",
"O_Urban_HeavyGunner_F","O_support_MG_F","O_soldierU_F", "O_soldierU_AR_F", "O_soldierU_AAR_F", "O_soldierU_LAT_F", "O_soldierU_AT_F", "O_soldierU_AAT_F",
"O_soldierU_AA_F", "O_soldierU_AAA_F", "O_soldierU_TL_F", "O_SoldierU_SL_F", "O_soldierU_medic_F", "O_soldierU_repair_F", "O_soldierU_exp_F",
"O_engineer_U_F", "O_soldierU_A_F", "O_Sharpshooter_F"];
    }; 
    case CIVILIAN : {
        _units = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_euro","C_man_polo_1_F_asia",
"C_man_polo_2_F","C_man_polo_2_F_afro","C_man_polo_2_F_euro","C_man_polo_2_F_asia","C_man_polo_3_F","C_man_polo_3_F_afro","C_man_polo_3_F_euro",
"C_man_polo_3_F_asia","C_man_polo_4_F","C_man_polo_4_F_afro","C_man_polo_4_F_euro","C_man_polo_4_F_asia","C_man_polo_5_F","C_man_polo_5_F_afro",
"C_man_polo_5_F_euro","C_man_polo_5_F_asia","C_man_polo_6_F","C_man_polo_6_F_afro","C_man_polo_6_F_euro","C_man_polo_6_F_asia","C_man_p_fugitive_F",
"C_man_p_fugitive_F_afro","C_man_p_fugitive_F_euro","C_man_p_fugitive_F_asia","C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_beggar_F_euro",
"C_man_p_beggar_F_asia","C_man_w_worker_F","C_man_hunter_1_F","C_man_p_shorts_1_F","C_man_p_shorts_1_F_afro","C_man_p_shorts_1_F_euro","C_man_p_shorts_1_F_asia",
"C_man_shorts_1_F","C_man_shorts_1_F_afro","C_man_shorts_1_F_euro","C_man_shorts_1_F_asia","C_man_shorts_2_F","C_man_shorts_2_F_afro","C_man_shorts_2_F_euro",
"C_man_shorts_2_F_asia","C_man_shorts_3_F","C_man_shorts_3_F_afro","C_man_shorts_3_F_euro","C_man_shorts_3_F_asia","C_man_shorts_4_F","C_man_shorts_4_F_afro",
"C_man_shorts_4_F_euro","C_man_shorts_4_F_asia","C_Nikos","C_Nikos_aged"];
    };
};

// find positions
_goodPos = [];
_houseList = _startPos nearObjects ["House", _radius];
{
    if (_x in _blackList || typeOf _x in _bridges) then {

    } else {
        _c = 0;
        while { format ["%1", _x buildingPos _c] != "[0,0,0]" } do { 
            _buildingPos = _x buildingPos _c;
            _nearMan = nearestObject [_buildingPos, "Man"];
            _skip = false;
            if (_nearMan != objNull) then {
                if (_nearMan distance2D _buildingPos < 2) then {
                    _skip = true;
                };
            };
            _nearTerminal = nearestObject [_buildingPos, "Land_DataTerminal_01_F"];
            if (!_skip && _nearTerminal != objNull) then {
                if (_nearTerminal distance2D _buildingPos < 2) then {
                    _skip = true;
                };
            };
            if !(_skip) then {
                _goodPos set [(count _goodPos), [_x, _x buildingPos _c]];
            };                            
            _c = _c + 1;
        };
    };
} forEach _houseList;
_goodPos = _goodPos call QS_fnc_TBshuffle;
if ((count _goodPos) < _bots) then {
    _bots = count _goodPos;
} else {
    _goodPos resize _bots;
};
_goodPos sort true;

// fill it with units
_unitsInGroup = 0;
_grp = createGroup _side;
for "_i" from 1 to _bots do {
    _point = (_goodPos select (_i - 1));
    _house = _point select 0;
    _pos = _point select 1;
    _dir = getDir _house;    
    _samplePosASL = ATLtoASL[_pos select 0, _pos select 1, (_pos select 2) + 1.5];
    _windowsCnt = 0;
    _windowsDir = [];
    _wallsDir = [];
    for "_d" from _dir to (_dir + 270) step 90 do {
        _dst = 5;
        _counterPosASL =  [(_samplePosASL select 0) + sin _d * _dst, (_samplePosASL select 1) + cos _d * _dst,_samplePosASL select 2];
        _counterPosHASL = [_counterPosASL select 0, _counterPosASL select 1, (_counterPosASL select 2) + 20];        
        _window = true;
        _liw = lineIntersectsWith [_counterPosHASL, _counterPosASL];
        if (count _liw > 0 && {(_liw select 0) isKindOf "House"}) then {
            _window = false;
        };        
        if(_window) then {
            _liw = lineIntersectsWith [_samplePosASL, _counterPosASL];
            if (count _liw > 0 && {(_liw select 0) isKindOf "House"}) then {
                _window = false;
            };
        };
        _watchDir = ([_samplePosASL,_counterPosASL] call BIS_fnc_dirTo);
        if (_window) then {
           _windowsCnt = _windowsCnt + 1;
           _windowsDir = _windowsDir + [_watchDir];
        } else {
           _wallsDir = _wallsDir + [_watchDir];
        };
    };
    (_units call BIS_fnc_selectRandom) createUnit [_pos, _grp, "[this] call QS_fnc_moveToHC;currentGuard = this;", 0, (["CAPTAIN","MAJOR","COLONEL"] call BIS_fnc_selectRandom)];
    currentGuard allowDamage false;
    currentGuard setVariable ["BIS_enableRandomization", false];      
    if (typeOf _house in _towers) then {
        currentGuard setPosATL _pos;
    } else {
        currentGuard setPos _pos;
    };        
    doStop currentGuard;        
    currentGuard setBehaviour "SAFE";
    currentGuard allowDamage true;
    if (_windowsCnt == 0) then {

        // internal house position without windows
        _watchDir = _wallsDir call BIS_fnc_selectRandom;
        currentGuard setDir (_watchDir + 180);        
        currentGuard setUnitPos "UP";
        _null = [currentGuard, _house, 30] spawn {_this call compile preProcessFileLineNumbers "scripts\patrol.sqf"};        
    } else {
        if (_windowsCnt == 1) then {

            // window      
            currentGuard setUnitPos "UP";     
            _null = [currentGuard, _windowsDir, 0] spawn {_this call compile preProcessFileLineNumbers "scripts\watch.sqf"};      
        } else {

            // balcony
            _unitPos = ["UP","MIDDLE"] call BIS_fnc_selectRandom;
            currentGuard setUnitPos _unitPos;
            [currentGuard,(["WATCH1","WATCH2"] call BIS_fnc_selectRandom),"FULL", {lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;        
        };        
    };
    
    // 4 units + 1 teamleader in each group
    if (_unitsInGroup == 4) then {
        _grp selectLeader currentGuard;
        _unitsInGroup = 0;
        _grp setBehaviour "SAFE";
        _grp setCombatMode "RED";
        [(units _grp)] call QS_fnc_setSkill4;
        if (_accuracy > -1) then {
            {
                _x setSkill ["aimingAccuracy", _accuracy];
            } forEach (units _grp);
        };
        _enemiesArray = _enemiesArray + [_grp];
        if (_zeusCurator) then {
            {
                _x addCuratorEditableObjects [(units _grp), true];
            } forEach allCurators;
        };
        _grp = createGroup _side;
    } else {
        _unitsInGroup = _unitsInGroup + 1;
    };    
};

_enemiesArray