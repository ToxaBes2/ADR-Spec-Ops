/*
Author: ToxaBes
Description: apply changes to BLUFOR base depends of score
*/
_level = _this select 0;

_initialWList = ["hgun_Pistol_Signal_F","hgun_P07_F","hgun_Rook40_F","hgun_P07_snds_F","hgun_Pistol_01_F","hgun_Rook40_snds_F",
"hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Pistol_heavy_01_snds_F","hgun_Pistol_heavy_01_MRD_F","hgun_Pistol_heavy_02_Yorris_F",
"hgun_ACPC2_F","hgun_ACPC2_snds_F","Binocular","Rangefinder","Laserdesignator_01_khk_F","MineDetector","arifle_SDAR_F","launch_NLAW_F",
"arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_khk_F","arifle_SPAR_02_khk_F","arifle_SPAR_03_khk_F","srifle_LRR_tna_F"];

_allWList = ["srifle_GM6_camo_F","srifle_LRR_camo_F","hgun_Pistol_Signal_F","hgun_P07_F","hgun_Rook40_F","hgun_P07_snds_F","hgun_Rook40_snds_F",
"hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Pistol_heavy_01_snds_F","hgun_Pistol_heavy_01_MRD_F","hgun_Pistol_heavy_02_Yorris_F","SMG_01_F",
"SMG_02_F","arifle_MX_F","arifle_MXC_F","arifle_MXM_F","arifle_MXM_Black_F","arifle_MX_GL_F","arifle_MX_SW_F","arifle_MX_Black_F","arifle_MXC_Black_F",
"arifle_MX_GL_Black_F","arifle_MX_SW_Black_F","srifle_LRR_F","launch_NLAW_F","launch_B_Titan_F","launch_B_Titan_short_F","launch_RPG32_F","hgun_ACPC2_F",
"hgun_ACPC2_snds_F","hgun_PDW2000_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_Mk20_GL_plain_F",
"LMG_Mk200_F","srifle_EBR_F","srifle_GM6_F","arifle_TRG20_F","arifle_TRG21_F","arifle_TRG21_GL_F","arifle_SDAR_F","arifle_Katiba_GL_F","arifle_Katiba_F",
"arifle_Katiba_C_F","LMG_Zafir_F","srifle_DMR_01_F","Binocular","Rangefinder","Laserdesignator","MineDetector","LMG_Mk200_BI_F","srifle_DMR_02_F",
"srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F",
"srifle_DMR_03_woodland_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_06_camo_F",
"srifle_DMR_06_olive_F","MMG_01_hex_F","MMG_01_tan_F","MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F","MMG_02_black_RCO_BI_F","srifle_DMR_07_blk_F",
"srifle_DMR_07_hex_F","arifle_SPAR_03_snd_F","arifle_SPAR_03_blk_F","arifle_ARX_blk_F","arifle_ARX_hex_F","arifle_ARX_blk_F","LMG_03_F","arifle_CTARS_blk_F",
"arifle_CTARS_hex_F","arifle_SPAR_02_snd_F","arifle_SPAR_02_blk_F","launch_RPG7_F","arifle_AK12_F","arifle_AKM_F","arifle_AKS_F","arifle_CTAR_blk_F",
"arifle_CTAR_hex_F","arifle_SPAR_01_snd_F","arifle_SPAR_01_blk_F","arifle_AK12_GL_F","arifle_CTAR_GL_blk_F","arifle_CTAR_GL_hex_F","arifle_SPAR_01_GL_snd_F",
"arifle_SPAR_01_GL_blk_F","hgun_Pistol_01_F","SMG_05_F""srifle_DMR_07_ghex_F","srifle_GM6_ghex_F","srifle_LRR_tna_F","arifle_MX_SW_khk_F","launch_RPG32_ghex_F",
"launch_O_Titan_ghex_F","launch_B_Titan_tna_F","launch_O_Titan_short_ghex_F","launch_B_Titan_short_tna_F","arifle_CTAR_ghex_F","arifle_CTAR_GL_ghex_F",
"arifle_CTARS_ghex_F","arifle_MX_khk_F","arifle_MXC_khk_F","arifle_MXM_khk_F","arifle_SPAR_01_khk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_02_khk_F",
"arifle_SPAR_03_khk_F","arifle_ARX_ghex_F"];

_bluforWList = ["SMG_01_F","SMG_05_F","hgun_PDW2000_F""arifle_MXM_Black_F","arifle_MX_Black_F","arifle_MXC_Black_F","arifle_MX_GL_Black_F",
"arifle_MX_SW_Black_F","srifle_LRR_F","launch_B_Titan_short_tna_F","launch_B_Titan_tna_F","srifle_EBR_F","srifle_DMR_02_F","srifle_DMR_02_camo_F",
"srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F",
"MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F","MMG_02_black_RCO_BI_F","arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_blk_F","arifle_SPAR_02_blk_F",
"arifle_SPAR_03_blk_F","arifle_SPAR_03_blk_F","arifle_MXC_khk_F","arifle_MXM_khk_F","arifle_MX_GL_khk_F","arifle_MX_SW_khk_F","arifle_MX_khk_F"];

_resistanceWList = ["LMG_Mk200_BI_F","LMG_Mk200_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F",
"arifle_Mk20_GL_plain_F","arifle_TRG20_F","arifle_TRG21_F","arifle_TRG21_GL_F","srifle_DMR_06_olive_F","srifle_DMR_06_camo_F"];

_opforWList = ["srifle_GM6_F","arifle_Katiba_GL_F","arifle_Katiba_F","arifle_Katiba_C_F","LMG_Zafir_F","srifle_DMR_01_F","srifle_DMR_04_F",
"srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_tan_f","MMG_01_tan_F","srifle_DMR_07_blk_F","arifle_ARX_blk_F","arifle_ARX_blk_F",
"arifle_CTARS_blk_F","arifle_CTAR_blk_F","arifle_CTAR_GL_blk_F""launch_RPG32_ghex_F"];

_indWList = ["LMG_03_F","launch_RPG7_F","arifle_AK12_F","arifle_AKM_F","arifle_AKS_F","arifle_AK12_GL_F"];

[base_arsenal_infantry, _allWList, true, false] call BIS_fnc_removeVirtualWeaponCargo;
[base_arsenal_infantry, _initialWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
[base_arsenal_pilots, _allWList, true, false] call BIS_fnc_removeVirtualWeaponCargo;
[base_arsenal_pilots, _initialWList, true, false] call BIS_fnc_addVirtualWeaponCargo;

// Base #1
if (_level > 0) then {
    {
        _x hideObjectGlobal false;
    } forEach [stop1, gate1, stop2, gate2, stop3, gate3];
    _turrets = [baseTurret1, baseTurret2, baseTurret3, baseTurret4, baseTurret5, baseTurret6, baseTurret7, baseTurret8, baseTurret9, baseTurret10, 
    baseTurret11, baseTurret12, baseTurret13, baseTurret14, baseTurret15];
    {
        if !(isPlayer (gunner _x)) then {
            deleteVehicle (gunner _x);
        }; 
    } foreach _turrets;
	_grpTurret1 = createGroup west;
    "B_T_Support_MG_F" createUnit [getposATL baseTurret1, _grpTurret1, "this moveInGunner baseTurret1"];
    "B_T_Support_MG_F" createUnit [getposATL baseTurret3, _grpTurret1, "this moveInGunner baseTurret3"];
    "B_T_Support_MG_F" createUnit [getposATL baseTurret5, _grpTurret1, "this moveInGunner baseTurret5"];
    "B_T_Support_MG_F" createUnit [getposATL baseTurret7, _grpTurret1, "this moveInGunner baseTurret7"];
    "B_T_Support_MG_F" createUnit [getposATL baseTurret9, _grpTurret1, "this moveInGunner baseTurret9"];
    "B_T_Support_MG_F" createUnit [getposATL baseTurret11, _grpTurret1, "this moveInGunner baseTurret11"];
    "B_T_Support_MG_F" createUnit [getposATL baseTurret13, _grpTurret1, "this moveInGunner baseTurret13"];
    "B_T_Support_MG_F" createUnit [getposATL baseTurret15, _grpTurret1, "this moveInGunner baseTurret15"];
    _grpTurret1 setBehaviour "COMBAT";
    _grpTurret1 setCombatMode "RED";
    [(units _grpTurret1)] call QS_fnc_setSkill4;
} else {
    {
        _x hideObjectGlobal true;
    } forEach [stop1, gate1, stop2, gate2, stop3, gate3];
    _turrets = [baseTurret1, baseTurret2, baseTurret3, baseTurret4, baseTurret5, baseTurret6, baseTurret7, baseTurret8, baseTurret9, baseTurret10, 
    baseTurret11, baseTurret12, baseTurret13, baseTurret14, baseTurret15];
    {
        if !(isPlayer (gunner _x)) then {
            deleteVehicle (gunner _x);
        };        
    } foreach _turrets;
};

// Arsenal #1
if (_level > 1) then {        
    [base_arsenal_infantry, _bluforWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
    [base_arsenal_pilots, _bluforWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
};

// Arsenal #2
if (_level > 10) then {        
    [base_arsenal_infantry, _resistanceWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
    [base_arsenal_pilots, _resistanceWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
};

// Arsenal #3
if (_level > 19) then {        
    [base_arsenal_infantry, _opforWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
    [base_arsenal_pilots, _opforWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
};

// Arsenal #4
if (_level > 28) then {        
    [base_arsenal_infantry, _indWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
    [base_arsenal_pilots, _indWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
};

// Base #4
if (_level > 27) then {
    _posSpawn = [6839, 7289, (random 15) + 15];
    _uavData = [_posSpawn, 90, "B_UAV_01_F", WEST] call BIS_fnc_spawnVehicle;
    base_darter = _uavData select 0;
    _uavGroup = _uavData select 2;
    base_darter addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    base_darter addWeapon ("LMG_Mk200_F");
    base_darter addMagazine ("200Rnd_65x39_cased_Box_Tracer");
    _uavGroup setBehaviour "SAFE";
    _uavGroup setCombatMode "RED";
    [(units _uavGroup)] call QS_fnc_setSkill3;
    [_uavGroup, _posSpawn, (40 + (random 80))] call BIS_fnc_taskPatrol;
    _uavGroup deleteGroupWhenEmpty true;
    [base_darter] spawn {
        _u = _this select 0;
        while {alive _u} do {
            _u setFuel 1;
            _u setVehicleAmmo 1;
            sleep 600;
        };        
    };
    [base_darter] spawn {
        _u = _this select 0;
        while {alive _u} do {
            waitUntil {isUAVConnected _u};
            _ctrl = UAVControl _u;
            _unit = _ctrl select 0;
            _unit connectTerminalToUAV objNull;
            "Доступ к автоматической системе охраны запрещен!" remoteExec ["hint", _unit];                 
        };
    };
} else {
    {
        deleteVehicle _x;
    } forEach (crew base_darter);
    deleteVehicle base_darter;    
};

// Engeneer 4
if (_level > 34) then {
    _ugvs = [UGV1];
    if !(isNil "UGV2") then {
        _ugvs pushBack UGV2;
    };
    {
        if (alive _x) then {
            _ugv = _x;
            _weapons = _ugv weaponsTurret [0];
            if !("missiles_titan_static" in _weapons) then {
                _magazine = selectRandom ["1Rnd_GAT_missiles", "1Rnd_GAA_missiles"];
                for "_i" from 1 to 4 do {
                    _ugv addMagazineTurret [_magazine, [0]];
                };
                _ugv addWeaponTurret ["missiles_titan_static",[0]];
            };
        };
    } forEach _ugvs;
};

// Pilot 1
if (_level > 6) then {
    base_supply_modules_spawn hideObjectGlobal false;
} else {
    base_supply_modules_spawn hideObjectGlobal true;
};