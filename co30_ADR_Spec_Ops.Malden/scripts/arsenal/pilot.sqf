/*
Author: ToxaBes
Description: fill arsenal for pilot class
*/
_myBox = _this select 0;

_weaponsList = ["hgun_Pistol_Signal_F","hgun_P07_F","hgun_Pistol_01_F","hgun_Rook40_F","hgun_P07_snds_F","hgun_Rook40_snds_F","hgun_Pistol_heavy_01_F",
"hgun_Pistol_heavy_02_F","hgun_Pistol_heavy_01_snds_F","hgun_Pistol_heavy_01_MRD_F","hgun_Pistol_heavy_02_Yorris_F","hgun_ACPC2_F","hgun_ACPC2_snds_F",
"Binocular","Rangefinder"];

_bluforWList = [
    "SMG_01_F"
];

_resistanceWList = [
    "hgun_PDW2000_F","hgun_PDW2000_snds_F","hgun_PDW2000_Holo_F","hgun_PDW2000_Holo_snds_F"
];

_opforWList = [
    "SMG_02_F"
];

_indWList = [
    "SMG_05_F"
];

// Arsenal #1
if (BLUFOR_BASE_SCORE > 1) then {        
    _weaponsList = _weaponsList + _bluforWList;
};

// Arsenal #2
if (BLUFOR_BASE_SCORE > 10) then {        
    _weaponsList = _weaponsList + _resistanceWList;
};

// Arsenal #3
if (BLUFOR_BASE_SCORE > 19) then {        
    _weaponsList = _weaponsList + _opforWList;
};

// Arsenal #4
if (BLUFOR_BASE_SCORE > 28) then {        
    _weaponsList = _weaponsList + _indWList;
};


[_myBox, _weaponsList, false, false] call BIS_fnc_addVirtualWeaponCargo;

//--- Рюкзаки
[_myBox, [
"B_Parachute",
"B_AssaultPack_rgr",
"B_AssaultPack_cbr",
"B_AssaultPack_sgg",
"B_AssaultPack_khk",
"B_AssaultPack_blk",
"B_AssaultPack_mcamo",
"B_AssaultPackG",
"B_AssaultPack"
], false, false] call BIS_fnc_addVirtualBackpackCargo;

[_myBox, [
"U_B_HeliPilotCoveralls",
"U_B_PilotCoveralls",

//--- Пояса,жилеты
"V_TacVest_khk",
"V_TacVest_brn",
"V_TacVest_oli",
"V_TacVest_blk",
"V_TacVestCamo_khk",

//--- Шлемы
"H_PilotHelmetFighter_B",
"H_PilotHelmetHeli_B",
"H_CrewHelmetHeli_B",

//--- Глушаки
"muzzle_snds_H",
"muzzle_snds_L",
"muzzle_snds_M",
"muzzle_snds_B",
"muzzle_snds_H_MG",
"muzzle_snds_acp",

//--- Оптика
"optic_Arco",
"optic_Hamr",
"optic_Aco",
"optic_ACO_grn",
"optic_Aco_smg",
"optic_ACO_grn_smg",
"optic_Holosight",
"optic_Holosight_smg",
"optic_Yorris",
"optic_MRD",
"optic_Arco_blk_F",
"optic_ERCO_snd_F",
"optic_ERCO_blk_F",
"optic_Holosight_blk_F",
"optic_Holosight_smg_blk_F",

//--- Дополнения
"acc_flashlight",
"acc_pointer_IR",
"acc_flashlight_pistol",

//--- Вещи
"ItemMap",
"ItemRadio",
"ItemGPS",
"ItemCompass",
"ItemWatch",
"G_Spectacles",
"NVGoggles",
"NVGoggles_INDEP",
"NVGoggles_OPFOR",
"FirstAidKit",
"ToolKit",
//Tanoa
"NVGogglesB_blk_F",
"NVGogglesB_grn_F",
"NVGogglesB_gry_F"
], false, false] call BIS_fnc_addVirtualItemCargo;

//--- Патроны
[_myBox, [
// Магазины
"16Rnd_9x21_Mag",
"30Rnd_9x21_Mag",

// Гранаты
"B_IR_Grenade",
"HandGrenade",
"MiniGrenade",
// Дымы
"SmokeShell",
"SmokeShellBlue",
"SmokeShellGreen",
"SmokeShellOrange",
"SmokeShellPurple",
"SmokeShellRed",
"SmokeShellYellow",
// Химсвет
"Chemlight_blue",
"Chemlight_green",
"Chemlight_red",
"Chemlight_yellow",

// Патроны Apex
"11Rnd_45ACP_Mag",
"16Rnd_9x21_green_Mag",
"16Rnd_9x21_red_Mag",
"16Rnd_9x21_yellow_Mag",
"30Rnd_45ACP_Mag_SMG_01",
"30Rnd_45ACP_Mag_SMG_01_Tracer_Green",
"30Rnd_45ACP_Mag_SMG_01_Tracer_Red",
"30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
"30Rnd_9x21_Mag_SMG_02",
"30Rnd_9x21_Mag_SMG_02_Tracer_Green",
"30Rnd_9x21_Mag_SMG_02_Tracer_Red",
"30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",
"30Rnd_9x21_Red_Mag",
"30Rnd_9x21_Yellow_Mag",
"6Rnd_45ACP_Cylinder",
"6Rnd_GreenSignal_F",
"6Rnd_RedSignal_F",
"9Rnd_45ACP_Mag"
], false, false] call BIS_fnc_addVirtualMagazineCargo;


// SMA Weapons
if (isClass(configfile >> "CfgPatches" >> "SMA_Weapons") && BLUFOR_BASE_SCORE > 1) then {       
    [_myBox,[
        // optics
        "SMA_MICRO_T2",
        "SMA_MICRO_T2_LM",
        "SMA_eotech",
        "SMA_eotech_T",
        "SMA_eotech_G",        
        "SMA_AIMPOINT",
        "SMA_AIMPOINT_GLARE",
        "SMA_BARSKA",
        "SMA_CMORE",
        "SMA_CMOREGRN"
    ], false, false] call BIS_fnc_addVirtualItemCargo;
};
