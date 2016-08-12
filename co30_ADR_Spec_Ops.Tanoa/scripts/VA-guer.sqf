private ["_myBox"];
_myBox = _this select 0;

//--- Рюкзаки
[_myBox, [
"B_AssaultPack_blk",
"B_AssaultPack_cbr",
"B_AssaultPack_khk",
"B_AssaultPack_rgr",
"B_AssaultPack_sgg",
"B_Parachute"
], true, false] call BIS_fnc_addVirtualBackpackCargo;

[_myBox, [
//--- Партизаны
"U_I_C_Soldier_Camo_F",
"U_I_C_Soldier_Para_1_F",
"U_I_C_Soldier_Para_2_F",
"U_I_C_Soldier_Para_3_F",
"U_I_C_Soldier_Para_4_F",
"U_I_C_Soldier_Para_5_F",
"U_I_Wetsuit",

//--- Пояса,жилеты
"V_BandollierB_blk",
"V_BandollierB_cbr",
"V_BandollierB_khk",
"V_BandollierB_oli",
"V_BandollierB_rgr",
"V_Rangemaster_belt",
"V_RebreatherIA",

//--- Кепки,банданы
"H_Bandanna_camo",
"H_Bandanna_cbr",
"H_Bandanna_gry",
"H_Bandanna_khk",
"H_Bandanna_khk_hs",
"H_Bandanna_mcamo",
"H_Bandanna_sgg",
"H_Bandanna_surfer",
"H_Beret_02",
"H_Beret_Colonel",
"H_Beret_blk",
"H_Beret_blk_POLICE",
"H_Beret_brn_SF",
"H_Beret_grn",
"H_Beret_grn_SF",
"H_Beret_red",
"H_Cap_blk",
"H_Cap_blk_CMMG",
"H_Cap_blk_ION",
"H_Cap_blu",
"H_Cap_grn",
"H_Cap_grn_BI",
"H_Cap_headphones",
"H_Cap_khaki_specops_UK",
"H_Cap_oli",
"H_Cap_oli_hs",
"H_Cap_red",
"H_Cap_tan",
"H_Cap_tan_specops_US",
"H_Hat_brown",
"H_Hat_camo",
"H_Hat_checker",
"H_Hat_grey",
"H_Hat_tan",
"H_MilCap_blue",
"H_MilCap_gry",
"H_MilCap_mcamo",
"H_MilCap_rucamo",
"H_ShemagOpen_khk",
"H_ShemagOpen_tan",
"H_Shemag_khk",
"H_Shemag_olive",
"H_Shemag_olive_hs",
"H_Shemag_tan",
"H_StrawHat",
"H_StrawHat_dark",
"H_StrawHat_dark",
"H_TurbanO_blk",
"H_Watchcap_blk",
"H_Watchcap_camo",
"H_Watchcap_khk",
"H_Watchcap_sgg",

//--- Очки
"G_Aviator",
"G_Balaclava_blk",
"G_Balaclava_lowprofile",
"G_Balaclava_oli",
"G_Bandanna_aviator",
"G_Bandanna_beast",
"G_Bandanna_blk",
"G_Bandanna_khk",
"G_Bandanna_oli",
"G_Bandanna_shades",
"G_Bandanna_sport",
"G_Bandanna_tan",
"G_Diving",
"G_Lowprofile",
"G_Shades_Black",
"G_Shades_Blue",
"G_Shades_Green",
"G_Shades_Red",
"G_Spectacles",
"G_Spectacles_Tinted",
"G_Sport_Blackred",
"G_Sport_Blackyellow",
"G_Sport_Checkered",
"G_Sport_Greenblack",
"G_Sport_Red",
"G_Squares",
"G_Squares_Tinted",
"G_balaclava_combat",

//--- Дополнения
"acc_flashlight",

//--- Вещи
"FirstAidKit",
"ItemCompass",
"ItemMap",
"ItemRadio",
"ItemWatch",
"I_UavTerminal",
"Medikit",
"ToolKit"
], true, false] call BIS_fnc_addVirtualItemCargo;

//--- Патроны
[_myBox, [
//--- Магазины
"30Rnd_556x45_Stanag",
"30Rnd_556x45_Stanag_Tracer_Red",
"30Rnd_556x45_Stanag_Tracer_Green",
"30Rnd_556x45_Stanag_Tracer_Yellow",
"20Rnd_556x45_UW_mag",
"30Rnd_545x39_Mag_F",
"30Rnd_545x39_Mag_Green_F",
"30Rnd_545x39_Mag_Tracer_F",
"30Rnd_545x39_Mag_Tracer_Green_F",

//--- Химсвет
"Chemlight_yellow"
], true, false] call BIS_fnc_addVirtualMagazineCargo;

//--- Оружие
[_myBox, [
"arifle_Mk20_F",
"arifle_Mk20C_F",
"arifle_Mk20_plain_F",
"arifle_Mk20C_plain_F",
"arifle_TRG20_F",
"arifle_TRG21_F",
"arifle_SDAR_F",
"arifle_AKS_F",
"Binocular"
], true, false] call BIS_fnc_addVirtualWeaponCargo;

sleep 5;

_myBox removeAction (_myBox getvariable ['bis_fnc_arsenal_action', -1]);
_myBox setvariable ['bis_fnc_arsenal_action', nil];
