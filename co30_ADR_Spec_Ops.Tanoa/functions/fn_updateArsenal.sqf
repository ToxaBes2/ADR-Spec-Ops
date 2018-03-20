/*
Author: ToxaBes
Description: update arsenal whitelisted weapons for players
*/
_level = _this select 0;

_initialWList = ["hgun_Pistol_Signal_F","hgun_P07_F","hgun_Rook40_F","hgun_P07_snds_F","hgun_Pistol_01_F","hgun_Rook40_snds_F",
"hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Pistol_heavy_01_snds_F","hgun_Pistol_heavy_01_MRD_F","hgun_Pistol_heavy_02_Yorris_F",
"hgun_ACPC2_F","hgun_ACPC2_snds_F","Binocular","Rangefinder","Laserdesignator_01_khk_F","MineDetector","arifle_SDAR_F","launch_NLAW_F",
"arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_khk_F","arifle_SPAR_02_khk_F","arifle_SPAR_03_khk_F","srifle_LRR_tna_F","SMG_01_F","arifle_MX_khk_F",
"arifle_MXC_khk_F","arifle_MXM_khk_F","srifle_LRR_tna_F","arifle_MX_SW_khk_F"];

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

_smaList = ["SMA_HK416afgQCB","SMA_HK416afg","SMA_HK416vfg","SMA_HK416GL","SMA_HK416afgOD","SMA_HK416MOEOD","SMA_HK416CQBafgOD","SMA_HK416CQBMOEOD",
"SMA_HK416GLOD","SMA_HK416CQBGLOD","SMA_HK416_afg_ODPAINTED","SMA_HK416_GL_ODPAINTED","SMA_HK416_vfg_ODPAINTED","SMA_HK416CQB_vfg_ODPAINTED",
"SMA_HK416CUSTOMafg","SMA_HK416CUSTOMCQBvfg","SMA_HK416CUSTOMCQBvfgB","SMA_HK416CUSTOMCQBvfgODP","SMA_HK416CUSTOMvfg","SMA_HK416CUSTOMvfgB",
"SMA_HK416CUSTOMvfgODP","SMA_HK416CUSTOMCQBafg","SMA_HK416CUSTOMCQBafgB","SMA_HK416CUSTOMCQBafgODP","SMA_HK416CUSTOMafgB","SMA_HK416CUSTOMafgODP",
"SMA_HK416GLCQB","SMA_HK416GLCQB_B","SMA_HK416GLCQB_ODP","SMA_HK417","SMA_HK417vfg","SMA_HK417_16in","SMA_SAR21_F","SMA_SAR21MMS_F",
"SMA_SAR21_AFG_F","SMA_SAR21MMS_AFG_F","SMA_SKS_F","SMA_SKS_TAN_F","SMA_STG_E4_F","SMA_STG_E4_BLACK_F","SMA_STG_E4_OD_F","SMA_AUG_EGLM",
"SMA_AUG_A3_F","SMA_AUG_A3_MCAM_F","SMA_AUG_A3_KRYPT_F","SMA_AUG_EGLM_Olive","SMA_AUG_EGLM_tan","SMA_MK16","SMA_Mk17","SMA_Mk16_EGLM",
"SMA_Mk17_EGLM","SMA_Mk16_black","SMA_Mk16_Green","SMA_Mk16_blackQCB","SMA_Mk16_GreenQCB","SMA_Mk16QCB","SMA_Mk17_black","SMA_Mk17_Green",
"SMA_MK16_EGLM_black","SMA_MK16_EGLM_Green","SMA_MK17_EGLM_black","SMA_MK17_EGLM_Green","SMA_Mk17_16_black","SMA_Mk17_16_Green","SMA_Mk17_16",
"SMA_ACR","SMA_ACRblk","SMA_ACRGL","SMA_ACRGL_B","SMA_ACRMOE","SMA_ACRMOE_Blk","SMA_ACRREM","SMA_ACRREMblk","SMA_ACRREMGL","SMA_ACRREMGL_B",
"SMA_ACRREMCQBGL","SMA_ACRREMCQBGL_B","SMA_ACRREMMOE","SMA_ACRREMMOEblk","SMA_ACRREMMOECQB","SMA_ACRREMMOECQBblk","SMA_ACRREMAFG","SMA_ACRREMAFGblk",
"SMA_ACRREMAFGCQB","SMA_ACRREMAFGCQBblk","SMA_ACRREM_N","SMA_ACRREMblk_N","SMA_ACRREMMOE_N","SMA_ACRREMMOEblk_N","SMA_ACRREMMOECQB_N",
"SMA_ACRREMMOECQBblk_N","SMA_ACRREMAFG_N","SMA_ACRREMAFGblk_N","SMA_ACRREMAFGCQB_N","SMA_ACRREMAFGCQBblk_N","SMA_ACRREMCQBGL_B_N","SMA_ACRREMCQBGL_N",
"SMA_ACRREMGL_B_N","SMA_ACRREMGL_N","sma_minimi_mk3_762tlb","sma_minimi_mk3_762tlb_des","sma_minimi_mk3_762tlb_wdl","sma_minimi_mk3_762tsb",
"sma_minimi_mk3_762tsb_des","sma_minimi_mk3_762tsb_wdl","SMA_L85RIS","SMA_L85RISNR","SMA_L85RISafg","SMA_L85RISafgNR","SMA_Steyr_AUG_F",
"SMA_Steyr_AUG_BLACK_F","SMA_AAC_MPW_9_Black","SMA_AAC_MPW_9_Woodland","SMA_AAC_MPW_9_OD","SMA_AAC_MPW_9_Desert","SMA_AAC_MPW_9_Tan",
"SMA_AAC_MPW_12_Black","SMA_AAC_MPW_12_Woodland","SMA_AAC_MPW_12_OD","SMA_AAC_MPW_12_Desert","SMA_AAC_MPW_12_Tan","SMA_AAC_MPW_16_Black",
"SMA_AAC_MPW_16_Woodland","SMA_AAC_MPW_16_OD","SMA_AAC_MPW_16_Desert","SMA_AAC_MPW_16_Tan","SMA_AAC_762_sdn6","SMA_AAC_762_sdn6_w",
"SMA_AAC_762_sdn6_d","SMA_AAC_762_sdn6_T","SMA_AAC_762_sdn6_G","SMA_Tavor_F","SMA_TavorOD_F","SMA_TavorBLK_F","SMA_CTAR_F","SMA_CTAROD_F",
"SMA_CTARBLK_F","SMA_MK18afg","SMA_MK18afg_SM","SMA_MK18afgBLK","SMA_MK18afgODBLK","SMA_MK18afgBLK_SM","SMA_MK18afgODBLK_SM","SMA_MK18afgOD",
"SMA_MK18afgOD_SM","SMA_MK18afgTAN","SMA_MK18afgTAN_SM","SMA_MK18afgTANBLK","SMA_MK18afgTANBLK_SM","SMA_MK18MOE","SMA_MK18MOE_SM","SMA_MK18MOETAN",
"SMA_MK18MOETAN_SM","SMA_MK18MOEBLK","SMA_MK18MOEBLK_SM","SMA_MK18MOEODBLK","SMA_MK18MOEODBLK_SM","SMA_MK18MOEOD","SMA_MK18MOEOD_SM",
"SMA_MK18MOEBLKTAN","SMA_MK18MOEBLKTAN_SM","SMA_MK18_GL","SMA_MK18_GL_SM","SMA_MK18TANBLK_GL","SMA_MK18TANBLK_GL_SM","SMA_MK18TAN_GL",
"SMA_MK18TAN_GL_SM","SMA_MK18BLK_GL","SMA_MK18BLK_GL_SM","SMA_MK18ODBLK_GL","SMA_MK18ODBLK_GL_SM","SMA_MK18OD_GL","SMA_MK18OD_GL_SM",
"SMA_M4_GL","SMA_M4_GL_SM","SMA_M4afg","SMA_M4afg_SM","SMA_M4afg_Tan","SMA_M4afg_Tan_SM","SMA_M4afg_OD","SMA_M4afg_OD_SM","SMA_M4afg_BLK1",
"SMA_M4afg_BLK1_SM","SMA_M4MOE","SMA_M4MOE_SM","SMA_M4MOE_Tan","SMA_M4MOE_Tan_SM","SMA_M4MOE_OD","SMA_M4MOE_OD_SM","SMA_M4MOE_BLK1",
"SMA_M4MOE_BLK1_SM","SMA_M4afgSTOCK","SMA_M4CQBR","SMA_M4CQBRMOE"];

if (isClass(configfile >> "CfgPatches" >> "SMA_Weapons")) then {   
    _initialWList = _initialWList + _smaList;
    _allWList = _allWList + _smaList;
};

_bluforWList = ["SMG_01_F","SMG_05_F","hgun_PDW2000_F""arifle_MXM_Black_F","arifle_MX_Black_F","arifle_MXC_Black_F","arifle_MX_GL_Black_F",
"arifle_MX_SW_Black_F","srifle_LRR_F","launch_B_Titan_short_tna_F","launch_B_Titan_tna_F","srifle_EBR_F","srifle_DMR_02_F","srifle_DMR_02_camo_F",
"srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F",
"MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F","MMG_02_black_RCO_BI_F","arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_blk_F","arifle_SPAR_02_blk_F",
"arifle_SPAR_03_blk_F","arifle_SPAR_03_blk_F","arifle_MXC_khk_F","arifle_MXM_khk_F","arifle_MX_GL_khk_F","arifle_MX_SW_khk_F","arifle_MX_khk_F","SMG_01_F",
"arifle_MX_khk_F","arifle_MXC_khk_F","arifle_MXM_khk_F","srifle_LRR_tna_F","arifle_MX_SW_khk_F"];

_resistanceWList = ["LMG_Mk200_BI_F","LMG_Mk200_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F",
"arifle_Mk20_GL_plain_F","arifle_TRG20_F","arifle_TRG21_F","arifle_TRG21_GL_F","srifle_DMR_06_olive_F","srifle_DMR_06_camo_F"];

_opforWList = ["srifle_GM6_F","arifle_Katiba_GL_F","arifle_Katiba_F","arifle_Katiba_C_F","LMG_Zafir_F","srifle_DMR_01_F","srifle_DMR_04_F",
"srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_tan_f","MMG_01_tan_F","srifle_DMR_07_blk_F","arifle_ARX_blk_F","arifle_ARX_blk_F",
"arifle_CTARS_blk_F","arifle_CTAR_blk_F","arifle_CTAR_GL_blk_F""launch_RPG32_ghex_F"];

_indWList = ["LMG_03_F","launch_RPG7_F","arifle_AK12_F","arifle_AKM_F","arifle_AKS_F","arifle_AK12_GL_F"];

[base_arsenal_infantry, _allWList, true, false] call BIS_fnc_removeVirtualWeaponCargo;
[base_arsenal_pilots, _allWList, true, false] call BIS_fnc_removeVirtualWeaponCargo;

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

[base_arsenal_pilots, _initialWList, true, false] call BIS_fnc_addVirtualWeaponCargo;
[base_arsenal_infantry, _initialWList, true, false] call BIS_fnc_addVirtualWeaponCargo;