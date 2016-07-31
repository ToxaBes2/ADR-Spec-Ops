//Allow player to respawn with his loadout? If true unit will respawn with all ammo from initial save! Set to false to disable this and rely on other scripts!
vas_onRespawn = false;
//Preload Weapon Config?
vas_preload = true;
//If limiting weapons its probably best to set this to true so people aren't loading custom loadouts with restricted gear.
vas_disableLoadSave = false;
//Amount of save/load slots
vas_customslots = 29; //9 is actually 10 slots, starts from 0 to whatever you set, so always remember when setting a number to minus by 1, i.e 12 will be 11.
//Disable 'VAS hasn't finished loading' Check !!! ONLY RECOMMENDED FOR THOSE THAT USE ACRE AND OTHER LARGE ADDONS !!!
vas_disableSafetyCheck = false;
/*
	NOTES ON EDITING!
	YOU MUST PUT VALID CLASS NAMES IN THE VARIABLES IN AN ARRAY FORMAT, NOT DOING SO WILL RESULT IN BREAKING THE SYSTEM!
	PLACE THE CLASS NAMES OF GUNS/ITEMS/MAGAZINES/BACKPACKS/GOGGLES IN THE CORRECT ARRAYS! TO DISABLE A SELECTION I.E
	GOGGLES vas_goggles = [""]; AND THAT WILL DISABLE THE ITEM SELECTION FOR WHATEVER VARIABLE YOU ARE WANTING TO DISABLE!

														EXAMPLE
	vas_weapons = ["srifle_EBR_ARCO_point_grip_F","arifle_Khaybar_Holo_mzls_F","arifle_TRG21_GL_F","Binocular"];
	vas_magazines = ["30Rnd_65x39_case_mag","20Rnd_762x45_Mag","30Rnd_65x39_caseless_green"];
	vas_items = ["ItemMap","ItemGPS","NVGoggles"];
	vas_backpacks = ["B_Bergen_sgg_Exp","B_AssaultPack_rgr_Medic"];
	vas_goggles = [""];

												Example for side specific (TvT)
	switch(playerSide) do
	{
		//Blufor
		case west:
		{
			vas_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
		//Opfor
		case west:
		{
			vas_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
	};
*/

//If the arrays below are empty (as they are now) all weapons, magazines, items, backpacks and goggles will be available
//Want to limit VAS to specific weapons? Place the classnames in the array!
vas_weapons = ["srifle_GM6_camo_F", "srifle_LRR_camo_F", "hgun_Pistol_Signal_F", "hgun_P07_F", "hgun_Rook40_F", "hgun_Pistol_heavy_01_MRD_F","hgun_P07_snds_F", "hgun_Pistol_heavy_01_snds_F", "hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_02_F", "SMG_01_F", "SMG_02_F", "arifle_MX_F", "arifle_MXC_F", "arifle_MXM_F","arifle_MXM_Black_F", "arifle_MX_GL_F", "arifle_MX_SW_F", "arifle_MX_Black_F", "arifle_MXC_Black_F", "arifle_MX_GL_Black_F", "hgun_Pistol_heavy_02_Yorris_F", "arifle_MX_SW_Black_F", "srifle_LRR_F", "launch_NLAW_F", "launch_B_Titan_F", "launch_B_Titan_short_F", "launch_RPG32_F", "hgun_ACPC2_F","hgun_ACPC2_snds_F", "hgun_PDW2000_F","hgun_Rook40_snds_F", "arifle_Mk20_F", "arifle_Mk20C_F", "arifle_Mk20_GL_F", "arifle_Mk20_plain_F", "arifle_Mk20C_plain_F", "arifle_Mk20_GL_plain_F", "LMG_Mk200_F", "srifle_EBR_F", "srifle_GM6_F", "arifle_TRG20_F", "arifle_TRG21_F", "arifle_TRG21_GL_F", "arifle_SDAR_F", "arifle_Katiba_GL_F", "arifle_Katiba_F", "arifle_Katiba_C_F", "LMG_Zafir_F", "srifle_DMR_01_F", "Binocular", "Rangefinder", "Laserdesignator", "MineDetector", "LMG_Mk200_BI_F", "srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F", "srifle_DMR_03_F", "srifle_DMR_03_khaki_F", "srifle_DMR_03_tan_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_woodland_F", "srifle_DMR_04_F", "srifle_DMR_04_Tan_F", "srifle_DMR_05_blk_F", "srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "MMG_01_hex_F", "MMG_01_tan_F", "MMG_02_camo_F", "MMG_02_black_F", "MMG_02_sand_F", "MMG_02_black_RCO_BI_F", "LMG_03_F", "Laserdesignator_01_khk_F", "SMG_05_F", "arifle_AK12_F", "arifle_AK12_GL_F", "arifle_AKM_F", "arifle_AKS_F", "arifle_ARX_blk_F", "arifle_ARX_ghex_F", "arifle_ARX_hex_F", "arifle_CTARS_blk_F", "arifle_CTARS_ghex_F", "arifle_CTARS_hex_F", "arifle_CTAR_GL_blk_F", "arifle_CTAR_GL_ghex_F", "arifle_CTAR_GL_hex_F", "arifle_CTAR_blk_F", "arifle_CTAR_ghex_F", "arifle_CTAR_hex_F", "arifle_MXC_khk_F", "arifle_MXM_khk_F", "arifle_MX_GL_khk_F", "arifle_MX_SW_khk_F", "arifle_MX_khk_F", "arifle_SPAR_01_GL_blk_F", "arifle_SPAR_01_GL_khk_F", "arifle_SPAR_01_GL_snd_F", "arifle_SPAR_01_blk_F", "arifle_SPAR_01_khk_F", "arifle_SPAR_01_snd_F", "arifle_SPAR_02_blk_F", "arifle_SPAR_02_khk_F", "arifle_SPAR_02_snd_F", "arifle_SPAR_03_blk_F", "arifle_SPAR_03_khk_F", "arifle_SPAR_03_snd_F", "hgun_P07_khk_F", "hgun_Pistol_01_F", "launch_B_Titan_short_tna_F", "launch_B_Titan_tna_F", "launch_RPG32_ghex_F", "launch_RPG7_F", "launch_Titan_F", "launch_Titan_short_F", "srifle_DMR_07_blk_F", "srifle_DMR_07_ghex_F", "srifle_DMR_07_hex_F", "srifle_GM6_ghex_F", "srifle_LRR_tna_F"];
//Want to limit VAS to specific magazines? Place the classnames in the array!
vas_magazines = [];
//Want to limit VAS to specific items? Place the classnames in the array!
vas_items = ["B_UavTerminal","FirstAidKit","G_Spectacles","H_BandMask_demon","H_BandMask_khk","H_BandMask_reaper","H_Bandanna_camo","H_Bandanna_cbr","H_Bandanna_gry","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_mcamo","H_Bandanna_sgg","H_Bandanna_surfer","H_Beret_02","H_Beret_Colonel","H_Beret_blk","H_Beret_blk_POLICE","H_Beret_brn_SF","H_Beret_gen_F","H_Beret_grn","H_Beret_grn_SF","H_Beret_red","H_Booniehat_dirty","H_Booniehat_grn","H_Booniehat_khk_hs","H_Booniehat_mcamo","H_Booniehat_tan","H_Booniehat_tna_F","H_Cap_blk","H_Cap_blk_CMMG","H_Cap_blk_ION","H_Cap_blu","H_Cap_grn","H_Cap_grn_BI","H_Cap_headphones","H_Cap_khaki_specops_UK","H_Cap_marshal","H_Cap_oli","H_Cap_oli_hs","H_Cap_press","H_Cap_red","H_Cap_tan","H_Cap_tan_specops_US","H_CrewHelmetHeli_B","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_HelmetB","H_HelmetB_Enh_tna_F","H_HelmetB_Light_tna_F","H_HelmetB_TI_tna_F","H_HelmetB_black","H_HelmetB_camo","H_HelmetB_desert","H_HelmetB_grass","H_HelmetB_light","H_HelmetB_light","H_HelmetB_light_black","H_HelmetB_light_desert","H_HelmetB_light_grass","H_HelmetB_light_sand","H_HelmetB_light_snakeskin","H_HelmetB_paint","H_HelmetB_plain_blk","H_HelmetB_plain_mcamo","H_HelmetB_sand","H_HelmetB_snakeskin","H_HelmetB_tna_F","H_HelmetCrew_B","H_HelmetSpecB","H_HelmetSpecB_blk","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_Helmet_Kerry","H_Helmet_Skate","H_MilCap_blue","H_MilCap_gen_F","H_MilCap_gry","H_MilCap_mcamo","H_MilCap_rucamo","H_MilCap_tna_F","H_PilotHelmetFighter_B","H_PilotHelmetHeli_B","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_khk","H_Shemag_olive","H_Shemag_olive_hs","H_Shemag_tan","H_StrawHat","H_StrawHat_dark","H_StrawHat_dark","H_TurbanO_blk","H_Watchcap_blk","H_Watchcap_camo","H_Watchcap_khk","H_Watchcap_sgg","ItemCompass","ItemGPS","ItemMap","ItemRadio","ItemWatch","Medikit","NVGoggles","NVGoggles_INDEP","NVGoggles_OPFOR","NVGoggles_tna_F","ToolKit","U_B_CTRG_Soldier_2_F","U_B_CTRG_Soldier_3_F","U_B_CTRG_Soldier_F","U_B_HeliPilotCoveralls","U_B_PilotCoveralls","U_B_T_FullGhillie_tna_F","U_B_T_Sniper_F","U_B_T_Soldier_AR_F","U_B_T_Soldier_F","U_B_T_Soldier_SL_F","U_B_Wetsuit","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_Chestrig_blk","V_Chestrig_khk","V_Chestrig_oli","V_Chestrig_rgr","V_I_G_resistanceLeader_F","V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier1_rgr_noflag_F","V_PlateCarrier1_tna_F","V_PlateCarrier2_rgr","V_PlateCarrier2_rgr_noflag_F","V_PlateCarrier3_rgr","V_PlateCarrierGL_blk","V_PlateCarrierGL_rgr","V_PlateCarrierGL_tna_F","V_PlateCarrierH_CTRG","V_PlateCarrierL_CTRG","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_rgr","V_PlateCarrierSpec_tna_F","V_PlateCarrier_Kerry","V_Press_F","V_Rangemaster_belt","V_RebreatherB","V_TacChestrig_cbr_F","V_TacChestrig_oli_F","V_TacVestCamo_khk","V_TacVestIR_blk","V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_gen_F","V_TacVest_khk","V_TacVest_oli","acc_flashlight","acc_pointer_IR","bipod_01_F_blk","bipod_01_F_mtp","bipod_01_F_snd","bipod_02_F_blk","bipod_02_F_hex","bipod_02_F_tan","bipod_03_F_blk","bipod_03_F_oli","muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand","muzzle_snds_93mmg","muzzle_snds_93mmg_tan","muzzle_snds_B","muzzle_snds_H","muzzle_snds_H_MG","muzzle_snds_L","muzzle_snds_M","muzzle_snds_acp","optic_ACO_grn","optic_ACO_grn_smg","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_Aco","optic_Aco_smg","optic_Arco","optic_DMS","optic_Hamr","optic_Holosight","optic_Holosight_smg","optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_LRPS","optic_MRCO","optic_MRD","optic_NVS","optic_SOS","optic_Yorris"];
//Want to limit backpacks? Place the classnames in the array!
vas_backpacks = ["B_AA_01_weapon_F","B_AT_01_weapon_F","B_AssaultPack","B_AssaultPackG","B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_khk","B_AssaultPack_rgr","B_AssaultPack_sgg","B_Bergen_blk","B_Bergen_rgr","B_Bergen_sgg","B_Carryall_cbr","B_Carryall_khk","B_Carryall_oli","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_cbr","B_FieldPack_khk","B_FieldPack_oli","B_GMG_01_high_weapon_F","B_GMG_01_weapon_F","B_HMG_01_high_weapon_F","B_HMG_01_support_F","B_HMG_01_support_high_F","B_HMG_01_weapon_F","B_Kitbag_cbr","B_Kitbag_rgr","B_Kitbag_sgg","B_Mortar_01_support_F","B_Mortar_01_weapon_F","B_Parachute","B_TacticalPack_blk","B_TacticalPack_oli","B_TacticalPack_rgr","B_UAV_01_backpack_F"];
//Want to limit goggles? Place the classnames in the array!
vas_glasses = ["G_Aviator", "G_Balaclava_blk", "G_balaclava_combat", "G_Balaclava_lowprofile", "G_Balaclava_oli", "G_Bandanna_aviator", "G_Bandanna_beast", "G_Bandanna_blk", "G_Bandanna_khk", "G_Bandanna_oli", "G_Bandanna_shades", "G_Bandanna_sport", "G_Bandanna_tan", "G_Combat", "G_Diving", "G_Lowprofile", "G_Shades_Black", "G_Shades_Blue", "G_Shades_Green", "G_Shades_Red", "G_Spectacles", "G_Spectacles_Tinted", "G_Sport_Blackred", "G_Sport_Blackyellow", "G_Sport_Checkered", "G_Sport_Greenblack", "G_Sport_Red", "G_Squares", "G_Squares_Tinted", "G_Tactical_Black", "G_Tactical_Clear", "G_Balaclava_TI_G_blk_F", "G_Balaclava_TI_G_tna_F", "G_Balaclava_TI_blk_F", "G_Balaclava_TI_tna_F", "G_Combat_Goggles_tna_F", "B_AssaultPack_tna_F", "B_Bergen_mcamo_F", "B_Bergen_tna_F", "B_ViperHarness_blk_F", "B_ViperHarness_khk_F", "B_ViperHarness_oli_F", "B_ViperLightHarness_blk_F", "B_ViperLightHarness_khk_F", "B_ViperLightHarness_oli_F"];


/*
	NOTES ON EDITING:
	THIS IS THE SAME AS THE ABOVE VARIABLES, YOU NEED TO KNOW THE CLASS NAME OF THE ITEM YOU ARE RESTRICTING. THIS DOES NOT WORK IN
	CONJUNCTION WITH THE ABOVE METHOD, THIs IS ONLY FOR RESTRICTING / LIMITING ITEMS FROM VAS AND NOTHING MORE

														EXAMPLE
	vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
	vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
	vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS

												Example for side specific (TvT)
	switch(playerSide) do
	{
		//Blufor
		case west:
		{
			vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
		//Opfor
		case west:
		{
			vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
	};
*/

//Below are variables you can use to restrict certain items from being used.
//Weapons to remove from VAS
vas_r_weapons = [
	"Laserdesignator_03",
	"Laserdesignator_02",
	"Laserdesignator_02_ghex_F"
];
//Backpacks to remove from VAS
vas_r_backpacks = [
	"B_AssaultPack_dgtl",
	"B_AssaultPack_mcamo",
	"B_AssaultPack_ocamo",
	"B_Bergen_dgtl_F",
	"B_Bergen_hex_F",
	"B_Bergen_mcamo",
	"B_Carryall_ghex_F",
	"B_Carryall_mcamo",
	"B_Carryall_ocamo",
	"B_FieldPack_ghex_F",
	"B_FieldPack_ocamo",
	"B_FieldPack_oucamo",
	"B_GMG_01_A_high_weapon_F",
	"B_GMG_01_A_weapon_F",
	"B_HMG_01_A_high_weapon_F",
	"B_HMG_01_A_weapon_F",
	"B_Kitbgg_mcamo",
	"B_TacticalPack_mcamo",
	"B_TacticalPack_ocamo",
	"B_ViperHarness_ghex_F",
	"B_ViperHarness_hex_F",
	"B_ViperLightHarness_ghex_F",
	"B_ViperLightHarness_hex_F",
	"I_AA_01_weapon_F",
	"I_AT_01_weapon_F",
	"I_GMG_01_A_high_weapon_F",
	"I_GMG_01_A_weapon_F",
	"I_GMG_01_high_weapon_F",
	"I_GMG_01_weapon_F",
	"I_HMG_01_A_high_weapon_F",
	"I_HMG_01_A_weapon_F",
	"I_HMG_01_high_weapon_F",
	"I_HMG_01_support_F",
	"I_HMG_01_support_high_F",
	"I_HMG_01_weapon_F",
	"I_Mortar_01_support_F",
	"I_Mortar_01_weapon_F",
	"I_UAV_01_backpack_F",
	"O_AA_01_weapon_F",
	"O_AT_01_weapon_F",
	"O_GMG_01_A_high_weapon_F",
	"O_GMG_01_A_weapon_F",
	"O_GMG_01_high_weapon_F",
	"O_GMG_01_weapon_F",
	"O_HMG_01_A_high_weapon_F",
	"O_HMG_01_A_weapon_F",
	"O_HMG_01_high_weapon_F",
	"O_HMG_01_support_F",
	"O_HMG_01_support_high_F",
	"O_HMG_01_weapon_F",
	"O_Mortar_01_support_F",
	"O_Mortar_01_weapon_F",
	"O_UAV_01_backpack_F"
];

//Magazines to remove from VAS
vas_r_magazines = [];

//Items to remove from VAS
vas_r_items = [
	//---- ОДЕЖДА
	"U_AntigonaBody",
	"U_AttisBody",
	"U_BG_Guerilla1_1",
	"U_BG_Guerilla2_1",
	"U_BG_Guerilla2_2",
	"U_BG_Guerilla2_3",
	"U_BG_Guerilla3_1",
	"U_BG_Guerilla3_2",
	"U_BG_Guerilla6_1",
	"U_BG_Guerrilla_6_1",
	"U_BG_leader",
	"U_B_CTRG_1",
	"U_B_CTRG_2",
	"U_B_CTRG_3",
	"U_B_CTRG_Soldier_urb_1_F",
	"U_B_CTRG_Soldier_urb_2_F",
	"U_B_CTRG_Soldier_urb_3_F",
	"U_B_CombatUniform_mcam",
	"U_B_CombatUniform_mcam_tshirt",
	"U_B_CombatUniform_mcam_vest",
	"U_B_CombatUniform_mcam_worn",
	"U_B_CombatUniform_sgg",
	"U_B_CombatUniform_sgg_tshirt",
	"U_B_CombatUniform_sgg_vest",
	"U_B_CombatUniform_wdl",
	"U_B_CombatUniform_wdl_tshirt",
	"U_B_CombatUniform_wdl_vest",
	"U_B_FullGhillie_ard",
	"U_B_FullGhillie_lsh",
	"U_B_FullGhillie_sard",
	"U_B_GEN_Commander_F",
	"U_B_GEN_Soldier_F",
	"U_B_GhillieSuit",
	"U_B_SpecopsUniform_sgg",
	"U_B_survival_uniform",
	"U_BasicBody",
	"U_C_Commoner1_1",
	"U_C_Commoner1_2",
	"U_C_Commoner1_3",
	"U_C_Commoner1_4",
	"U_C_Commoner1_5",
	"U_C_Commoner1_6",
	"U_C_Commoner2_1",
	"U_C_Commoner2_2",
	"U_C_Commoner2_3",
	"U_C_Commoner2_4",
	"U_C_Commoner2_5",
	"U_C_Commoner2_6",
	"U_C_Commoner_shorts",
	"U_C_Farmer",
	"U_C_Fisherman",
	"U_C_FishermanOveralls",
	"U_C_HunterBody_brn",
	"U_C_HunterBody_grn",
	"U_C_Journalist",
	"U_C_Journalist",
	"U_C_Man_casual_1_F",
	"U_C_Man_casual_2_F",
	"U_C_Man_casual_3_F",
	"U_C_Man_casual_4_F",
	"U_C_Man_casual_5_F",
	"U_C_Man_casual_6_F",
	"U_C_Novak",
	"U_C_Poor_1",
	"U_C_Poor_1",
	"U_C_Poor_2",
	"U_C_Poor_shorts_1",
	"U_C_Poor_shorts_2",
	"U_C_PriestBody",
	"U_C_Scavenger_1",
	"U_C_Scavenger_2",
	"U_C_Scientist",
	"U_C_TeeSurfer_shorts_1",
	"U_C_TeeSurfer_shorts_2",
	"U_C_WorkerCoveralls",
	"U_C_WorkerOveralls",
	"U_C_man_sport_1_F",
	"U_C_man_sport_2_F",
	"U_C_man_sport_3_F",
	"U_IG_Guerrilla_6_1",
	"U_IG_Menelaos",
	"U_I_C_Soldier_Bandit_1_F",
	"U_I_C_Soldier_Bandit_2_F",
	"U_I_C_Soldier_Bandit_3_F",
	"U_I_C_Soldier_Bandit_4_F",
	"U_I_C_Soldier_Bandit_5_F",
	"U_I_C_Soldier_Camo_F",
	"U_I_C_Soldier_Para_1_F",
	"U_I_C_Soldier_Para_2_F",
	"U_I_C_Soldier_Para_3_F",
	"U_I_C_Soldier_Para_4_F",
	"U_I_C_Soldier_Para_5_F",
	"U_I_CombatUniform",
	"U_I_CombatUniform_shortsleeve",
	"U_I_CombatUniform_tshirt",
	"U_I_G_Story_Protagonist_F",
	"U_I_G_resistanceLeader_F",
	"U_I_GhillieSuit",
	"U_I_HeliPilotCoveralls",
	"U_I_OfficerUniform",
	"U_I_Wetsuit",
	"U_I_pilotCoveralls",
	"U_Marshal",
	"U_NikosAgedBody",
	"U_NikosBody",
	"U_OG_Guerilla1_1",
	"U_OG_Guerilla2_1",
	"U_OG_Guerilla2_2",
	"U_OG_Guerilla2_3",
	"U_OG_Guerilla3_1",
	"U_OG_Guerilla3_2",
	"U_OG_Guerrilla_6_1",
	"U_OG_leader",
	"U_OI_Scientist",
	"U_O_CombatUniform_ocamo",
	"U_O_CombatUniform_oucamo",
	"U_O_GhillieSuit",
	"U_O_OfficerUniform_ocamo",
	"U_O_PilotCoveralls",
	"U_O_SpecopsUniform_blk",
	"U_O_SpecopsUniform_ocamo",
	"U_O_Wetsuit",
	"U_OrestesBody",

	//---- РАЗГРУЗКА
	"V_PlateCarrierGL_mtp",
	"V_PlateCarrierSpec_mtp",
	"V_TacVest_blk_POLICE",

	//---- ГОЛОВНЫЕ УБОРЫ
	"H_Cap_brn_SPECOPS",
	"H_RacingHelmet_1_F",				//Racing Helmet (Fuel)
	"H_RacingHelmet_1_black_F",			//Racing Helmet (Black)
	"H_RacingHelmet_1_blue_F",			//Racing Helmet (Blue)
	"H_RacingHelmet_1_green_F",			//Racing Helmet (Green)
	"H_RacingHelmet_1_orange_F",		//Racing Helmet (Orange)
	"H_RacingHelmet_1_red_F",			//Racing Helmet (Red)
	"H_RacingHelmet_1_white_F",			//Racing Helmet (White)
	"H_RacingHelmet_1_yellow_F",		//Racing Helmet (Yellow)
	"H_RacingHelmet_2_F",				//Racing Helmet (Bluking)
	"H_RacingHelmet_3_F",				//Racing Helmet (Redstone)
	"H_RacingHelmet_4_F",				//Racing Helmet (Vrana)
	"H_Booniehat_indp",

	//---- ПРЕДМЕТЫ
	"O_UavTerminal",					//UAV Terminal
	"I_UavTerminal",					//UAV Terminal
	"NVGogglesB_blk_F",
	"NVGogglesB_grn_F",
	"NVGogglesB_gry_F",

	//---- ОПТИКА
	"optic_Nightstalker",				//Nightstalker
	"optic_tws",						//TWS
	"optic_tws_mg",						//TWS MG

	// Apex
	"H_HelmetCrew_O_ghex_F",
	"H_HelmetLeaderO_ghex_F",
	"H_HelmetO_ViperSP_ghex_F",
	"H_HelmetO_ViperSP_hex_F",
	"H_HelmetO_ghex_F",
	"H_HelmetSpecO_ghex_F",
	"H_MilCap_ghex_F",
	"O_NVGoggles_ghex_F",
	"O_NVGoggles_hex_F",
	"O_NVGoggles_urb_F",
	"U_B_T_FullGhillie_tna_F",
	"U_O_T_FullGhillie_tna_F",
	"U_O_T_Officer_F",
	"U_O_T_Sniper_F",
	"U_O_T_Soldier_F",
	"U_O_V_Soldier_Viper_F",
	"U_O_V_Soldier_Viper_hex_F",
	"V_BandollierB_ghex_F",
	"V_HarnessOGL_ghex_F",
	"V_HarnessO_ghex_F",

	// Extra enemy gear
	"H_Booniehat_dgtl",
	"H_Cap_blk_Raven",
	"H_Cap_brn_SPECOPS",
	"H_CrewHelmetHeli_I",
	"H_CrewHelmetHeli_O",
	"H_HelmetCrew_I",
	"H_HelmetCrew_O",
	"H_HelmetLeaderO_ocamo",
	"H_HelmetO_ocamo",
	"H_HelmetSpecO_blk",
	"H_HelmetSpecO_ocamo",
	"H_MilCap_dgtl",
	"H_MilCap_ocamo",
	"H_PilotHelmetFighter_I",
	"H_PilotHelmetFighter_O",
	"H_PilotHelmetHeli_I",
	"H_PilotHelmetHeli_O",
	"U_B_Protagonist_VR",
	"U_I_FullGhillie_ard",
	"U_I_FullGhillie_lsh",
	"U_I_FullGhillie_sard",
	"U_I_Protagonist_VR",
	"U_O_FullGhillie_ard",
	"U_O_FullGhillie_lsh",
	"U_O_FullGhillie_sard",
	"U_O_Protagonist_VR",
	"V_HarnessO_ghex_F",
	"V_PlateCarrierIA1_dgtl",
	"V_PlateCarrierIA2_dgtl",
	"V_PlateCarrierIAGL_dgtl",
	"V_RebreatherIA",
	"V_RebreatherIR"
];

//Goggles to remove from VAS
vas_r_glasses = [];

VAS_pre_items_uniforms = [];
VAS_pre_items_vests = [];
VAS_pre_items_headgear = [];
VAS_pre_items_attachments = [];
VAS_pre_items_misc = [];
VAS_pre_weapons_rifles = [];
VAS_pre_weapons_heavy = [];
VAS_pre_weapons_launchers = [];
VAS_pre_weapons_pistols = [];
