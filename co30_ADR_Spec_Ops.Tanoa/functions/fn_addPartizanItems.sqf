/*
Author: ToxaBes
Description: add partizan items on init load
*/
_player = _this select 0;
_uniform = ["U_BG_Guerilla1_1","U_BG_Guerilla2_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_Guerilla3_2","U_BG_Guerilla6_1",
"U_BG_Guerrilla_6_1","U_BG_leader","U_IG_Guerrilla_6_1","U_IG_leader","U_I_G_resistanceLeader_F","U_OG_Guerilla1_1","U_OG_Guerilla2_1",
"U_OG_Guerilla2_2","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_Guerrilla_6_1","U_OG_leader"];
_backpacks = ["B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_khk","B_AssaultPack_rgr","B_AssaultPack_sgg"];
_vests = ["V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_Rangemaster_belt"];
_headgear = ["H_Bandanna_camo","H_Bandanna_cbr","H_Bandanna_gry","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_mcamo","H_Bandanna_sgg",
"H_Bandanna_surfer","H_Beret_02","H_Beret_Colonel","H_Beret_blk","H_Beret_blk_POLICE","H_Beret_brn_SF","H_Beret_grn","H_Beret_grn_SF",
"H_Beret_red","H_Cap_blk","H_Cap_blk_CMMG","H_Cap_blk_ION","H_Cap_blu","H_Cap_grn","H_Cap_grn_BI","H_Cap_headphones","H_Cap_khaki_specops_UK",
"H_Cap_oli","H_Cap_oli_hs","H_Cap_red","H_Cap_tan","H_Cap_tan_specops_US","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan",
"H_MilCap_blue","H_MilCap_gry","H_MilCap_mcamo","H_MilCap_rucamo","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_khk","H_Shemag_olive",
"H_Shemag_olive_hs","H_Shemag_tan","H_StrawHat","H_StrawHat_dark","H_StrawHat_dark","H_TurbanO_blk","H_Watchcap_blk","H_Watchcap_camo",
"H_Watchcap_khk","H_Watchcap_sgg"];
_googles = ["G_Aviator","G_Balaclava_blk","G_Balaclava_lowprofile","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk",
"G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan","G_Lowprofile","G_Shades_Black",
"G_Shades_Blue","G_Shades_Green","G_Shades_Red","G_Spectacles","G_Spectacles_Tinted","G_Sport_Blackred","G_Sport_Blackyellow",
"G_Sport_Checkered","G_Sport_Greenblack","G_Sport_Red","G_Squares","G_Squares_Tinted","G_balaclava_combat"];
//_weapons = ["arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_TRG20_F","arifle_TRG21_F"];

_weapons = [
    ["hgun_ACPC2_F", ["9Rnd_45ACP_Mag"]],
    ["hgun_ACPC2_snds_F", ["9Rnd_45ACP_Mag"]],
    ["gun_P07_F", ["16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_yellow_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag"], "muzzle_snds_L"],
    ["hgun_P07_snds_F", [ "16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_yellow_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag"]],
    ["hgun_Pistol_heavy_01_F", ["11Rnd_45ACP_Mag"], "optic_MRD"],
    ["hgun_Pistol_heavy_01_snds_F", ["11Rnd_45ACP_Mag"], "optic_MRD"],
    ["hgun_Pistol_heavy_01_MRD_F", ["11Rnd_45ACP_Mag"], "muzzle_snds_acp"],
    ["hgun_Pistol_heavy_02_F", ["6Rnd_45ACP_Cylinder"]],
    ["hgun_Pistol_heavy_02_Yorris_F", ["6Rnd_45ACP_Cylinder"]],
    ["hgun_Rook40_F", ["16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_yellow_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag"]],
    ["hgun_Rook40_snds_F", ["16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_yellow_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag"]],
    ["hgun_PDW2000_F", ["30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag","16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_yellow_Mag"], "muzzle_snds_L"],
    ["hgun_PDW2000_snds_F", ["30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag","16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_yellow_Mag"], "optic_Holosight_smg"],
    ["hgun_PDW2000_Holo_F", ["30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag","16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_yellow_Mag"], "muzzle_snds_L"],
    ["hgun_PDW2000_Holo_snds_F", ["30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag","16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_yellow_Mag"]],
    ["SMG_01_F", ["30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01_tracer_green","30Rnd_45ACP_Mag_SMG_01_Tracer_Red","30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow"], "muzzle_snds_acp"],
    ["SMG_01_Holo_F", ["30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01_tracer_green","30Rnd_45ACP_Mag_SMG_01_Tracer_Red","30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow"], "muzzle_snds_acp"],
    ["SMG_01_Holo_pointer_snds_F", ["30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01_tracer_green","30Rnd_45ACP_Mag_SMG_01_Tracer_Red","30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow"]],
    ["SMG_01_ACO_F", ["30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01_tracer_green","30Rnd_45ACP_Mag_SMG_01_Tracer_Red","30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow"], "muzzle_snds_acp"],
    ["SMG_02_F", ["30Rnd_9x21_Mag_SMG_02","30Rnd_9x21_Mag_SMG_02_Tracer_Red","30Rnd_9x21_Mag_SMG_02_Tracer_Yellow","30Rnd_9x21_Mag_SMG_02_Tracer_Green","30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag"], "optic_ACO_grn_smg"],
    ["SMG_02_ACO_F", ["30Rnd_9x21_Mag_SMG_02","30Rnd_9x21_Mag_SMG_02_Tracer_Red","30Rnd_9x21_Mag_SMG_02_Tracer_Yellow","30Rnd_9x21_Mag_SMG_02_Tracer_Green","30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag"], "muzzle_snds_L"],
    ["SMG_02_ARCO_pointg_F", ["30Rnd_9x21_Mag_SMG_02","30Rnd_9x21_Mag_SMG_02_Tracer_Red","30Rnd_9x21_Mag_SMG_02_Tracer_Yellow","30Rnd_9x21_Mag_SMG_02_Tracer_Green","30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag"], "muzzle_snds_L"]
];

// check for Apex DLC to allow dlc weapons
if (395180 in (getDLCs 1)) then {
    //_weapons = ["arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_TRG20_F","arifle_TRG21_F","arifle_AKS_F"];
    _weapons append [["hgun_Pistol_01_F", ["10Rnd_9x21_Mag"]],["SMG_05_F", ["30Rnd_9x21_Mag_SMG_02","30Rnd_9x21_Mag_SMG_02_Tracer_Red","30Rnd_9x21_Mag_SMG_02_Tracer_Yellow","30Rnd_9x21_Mag_SMG_02_Tracer_Green"], "muzzle_snds_L"]];
};

_player forceAddUniform (selectRandom _uniform);
_player addVest (selectRandom _vests);
_player addGoggles (selectRandom _googles);
_player addBackpack (selectRandom _backpacks);
_player addHeadgear (selectRandom _headgear);
_player addWeapon "Binocular";
_player addItem "ItemMap";
_player assignItem "ItemMap";
_player addItem "ItemRadio";
_player assignItem "ItemRadio";
_player addItem "ItemCompass";
_player assignItem "ItemCompass";
_player addItem "ItemWatch";
_player assignItem "ItemWatch";
_player addItem "FirstAidKit";
_player addItem "FirstAidKit";
_player addItem "FirstAidKit";
_player addItem "FirstAidKit";
if (_player getUnitTrait "medic" || typeOf _player in ["I_C_Soldier_Para_3_F", "I_C_Soldier_Para_7_F"]) then {
    _player addItem "Medikit";
};
if (_player getUnitTrait "engineer" || typeOf _player in ["I_C_Soldier_Para_3_F", "I_C_Soldier_Para_8_F"]) then {
    _player removeItem "ItemGPS";
    _player addItem "I_UavTerminal";
    _player assignItem "I_UavTerminal";
} else {
	  _player addItem "ItemGPS";
	  _player assignItem "ItemGPS";
};
_weaponData = selectRandom _weapons;
_selectedWeapon = _weaponData select 0;
_selectedMagazines = _weaponData select 1;
_selectedAttachment = false;
if (count _weaponData == 3) then {
    if (random 10 > 6) then {
        selectedAttachment = _weaponData select 2;
    };
};
for "_i" from 0 to 5 do {
    _player addMagazines [(selectRandom _selectedMagazines), 1];
};
//_selectedWeapon = selectRandom _weapons;
//if (_selectedWeapon == "arifle_AKS_F") then {
//   _player addMagazines ["30Rnd_545x39_Mag_F", 2];
//   _player addMagazines ["30Rnd_545x39_Mag_Green_F", 2];
//   _player addMagazines ["30Rnd_545x39_Mag_Tracer_F", 2];
//   _player addMagazines ["30Rnd_545x39_Mag_Tracer_Green_F", 2];
//} else {
//    _player addPrimaryWeaponItem "acc_flashlight";
//    _player addMagazines ["30Rnd_556x45_Stanag", 2];
//    _player addMagazines ["30Rnd_556x45_Stanag_Tracer_Red", 2];
//    _player addMagazines ["30Rnd_556x45_Stanag_Tracer_Green", 2];
//    _player addMagazines ["30Rnd_556x45_Stanag_Tracer_Yellow", 2];
//};
_player addWeapon _selectedWeapon;

// add needed things in partizan ammo
//partizan_ammo addItemCargoGlobal ["U_I_Wetsuit", 1];
//partizan_ammo addItemCargoGlobal ["V_RebreatherIA", 1];
//partizan_ammo addItemCargoGlobal ["G_Diving", 1];
//partizan_ammo addWeaponCargoGlobal ["arifle_SDAR_F", 1];
//partizan_ammo addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 7];
//partizan_ammo addItemCargoGlobal ["FirstAidKit", 5];
true