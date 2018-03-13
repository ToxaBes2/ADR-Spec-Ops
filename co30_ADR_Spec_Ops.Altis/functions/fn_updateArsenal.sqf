/*
Author: ToxaBes
Description: update arsenal whitelisted weapons for players
*/
_level = _this select 0;

_initialWList = ["hgun_Pistol_Signal_F","hgun_P07_F","hgun_Pistol_01_F","hgun_Rook40_F","hgun_P07_snds_F","hgun_Rook40_snds_F","hgun_Pistol_heavy_01_F",
"hgun_Pistol_heavy_02_F","hgun_Pistol_heavy_01_snds_F","hgun_Pistol_heavy_01_MRD_F","hgun_Pistol_heavy_02_Yorris_F","hgun_ACPC2_F","hgun_ACPC2_snds_F",
"Binocular","Rangefinder","Laserdesignator","MineDetector","arifle_SDAR_F","launch_NLAW_F","arifle_MX_F","arifle_MXC_F","arifle_MXM_F","arifle_MX_GL_F",
"arifle_MX_SW_F","srifle_LRR_camo_F","SMG_01_F","arifle_MX_F","arifle_MX_SW_F","arifle_MXM_F","srifle_LRR_camo_F","arifle_MXC_F"];

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

_bluforWList = ["hgun_PDW2000_F","SMG_01_F","SMG_05_F","arifle_MXM_Black_F","arifle_MX_Black_F","arifle_MXC_Black_F","arifle_MX_GL_Black_F",
    "arifle_MX_SW_Black_F","srifle_LRR_F","launch_B_Titan_F","launch_B_Titan_short_F","srifle_EBR_F","srifle_DMR_02_F","srifle_DMR_02_camo_F",
    "srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F",
    "MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F","MMG_02_black_RCO_BI_F","arifle_SPAR_03_snd_F","arifle_SPAR_03_blk_F","arifle_SPAR_02_snd_F",
    "arifle_SPAR_02_blk_F","arifle_SPAR_01_snd_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_GL_snd_F","arifle_SPAR_01_GL_blk_F","SMG_01_F","arifle_MX_F",
    "arifle_MX_SW_F","arifle_MXM_F","srifle_LRR_camo_F","arifle_MXC_F"];

_resistanceWList = ["LMG_Mk200_BI_F","LMG_Mk200_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F",
"arifle_Mk20_GL_plain_F","arifle_TRG20_F","arifle_TRG21_F","arifle_TRG21_GL_F","srifle_DMR_06_olive_F","srifle_DMR_06_camo_F"];

_opforWList = ["srifle_GM6_F","arifle_Katiba_GL_F","arifle_Katiba_F","arifle_Katiba_C_F","LMG_Zafir_F","srifle_DMR_01_F","srifle_DMR_04_F",
"srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_tan_f","MMG_01_tan_F","srifle_DMR_07_blk_F","arifle_ARX_blk_F","arifle_ARX_blk_F",
"arifle_CTARS_blk_F","arifle_CTAR_blk_F","arifle_CTAR_GL_blk_F","launch_RPG32_F"];

_indWList = ["LMG_03_F","launch_RPG7_F","arifle_AK12_F","arifle_AKM_F","arifle_AKS_F","arifle_AK12_GL_F"];

[ammo1, _allWList, true, false] call BIS_fnc_removeVirtualWeaponCargo;
[base_arsenal_infantry, _allWList, true, false] call BIS_fnc_removeVirtualWeaponCargo;

// Arsenal #1
if (_level > 1) then {        
    _initialWList = _initialWList + _bluforWList;
};

// Arsenal #2
if (_level > 10) then {        
    _initialWList = _initialWList + _resistanceWList;
};

// Arsenal #3
if (_level > 19) then {        
    _initialWList = _initialWList + _opforWList;
};

// Arsenal #4
if (_level > 28) then {        
    _initialWList = _initialWList + _indWList;
};

[ammo1, _initialWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
[base_arsenal_infantry, _initialWList, true, false] call BIS_fnc_addVirtualWeaponCargo;