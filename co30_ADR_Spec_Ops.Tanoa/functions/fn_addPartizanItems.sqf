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
_weapons = ["arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_TRG20_F","arifle_TRG21_F","arifle_AKS_F"];

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
if (_player getUnitTrait "medic") then {
    _player addItem "Medikit";
};
if (_player getUnitTrait "engineer") then {
    _player addItem "ToolKit";
    _player addItem "I_UavTerminal";
    _player assignItem "I_UavTerminal";
} else {
	_player addItem "ItemGPS";
	_player assignItem "ItemGPS";
};
_selectedWeapon = selectRandom _weapons;
if (_selectedWeapon == "arifle_AKS_F") then {
   _player addMagazines ["30Rnd_545x39_Mag_F", 2];
   _player addMagazines ["30Rnd_545x39_Mag_Green_F", 2];
   _player addMagazines ["30Rnd_545x39_Mag_Tracer_F", 2];
   _player addMagazines ["30Rnd_545x39_Mag_Tracer_Green_F", 2];
} else {
    _player addPrimaryWeaponItem "acc_flashlight";
    _player addMagazines ["30Rnd_556x45_Stanag", 2];
    _player addMagazines ["30Rnd_556x45_Stanag_Tracer_Red", 2];
    _player addMagazines ["30Rnd_556x45_Stanag_Tracer_Green", 2];
    _player addMagazines ["30Rnd_556x45_Stanag_Tracer_Yellow", 2];
};
_player addWeapon _selectedWeapon;

// add needed things in partizan ammo
partizan_ammo addItemCargoGlobal ["U_I_Wetsuit", 1];
partizan_ammo addItemCargoGlobal ["V_RebreatherIA", 1];
partizan_ammo addItemCargoGlobal ["G_Diving", 1];
partizan_ammo addItemCargoGlobal ["U_I_Wetsuit", 1];
partizan_ammo addWeaponCargoGlobal ["arifle_SDAR_F", 1];
partizan_ammo addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 7];
partizan_ammo addItemCargoGlobal ["FirstAidKit", 5];
true