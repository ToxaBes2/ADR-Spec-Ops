/*
Author: Quiksilver
Last modified: 23/10/2014 ArmA 1.32 by Quiksilver
Description:

	Restricts certain weapon systems to different roles
_________________________________________________*/

private ["_uavOperator", "_uavRestricted", "_missileSoldiers", "_missileSpecialised", "_missileSmallSoldiers", "_missileSmallSpecialised", "_snipers", "_sniperSpecialised", "_backpackRestricted", "_autoRiflemen", "_autoSpecialised", "_marksman", "_marksmanGun", "_pilot", "_pilotWeapons", "_grenadier", "_grenadierWeapons", "_commanders", "_commanderItems", "_ThermalOpt", "_marksmanOpticsGrp", "_marksmanOpticsItems", "_basePos", "_szmkr", "_EHFIRED", "_firstRun", "_insideSafezone", "_outsideSafezone", "_optics", "_items", "_assignedItems"];

#define AT_MSG "Только ракетчики ПТ могут использовать это оружие."
#define AT_SMALL_MSG "Только ракетчики ПТ и командиры отделений могут использовать это оружие."
#define SNIPER_MSG "Только снайперы могут использовать это оружие."
#define AUTOTUR_MSG "Данное вооружение запрещено."
#define UAV_MSG "Только инженеры могут использовать терминал управления."
#define MG_MSG "Только пулеметчики могут использовать пулеметы."
#define MRK_MSG "Только пехотные снайперы могут использовать это оружие."
#define PILOT_MSG "Пилоты могут использовать только пистолеты и пистолеты-пулемёты."
#define GRENADIER_MSG "Использовать подствольные гранатометы могут только командиры отделений, медики и инженеры."
#define COMMANDER_MSG "Использовать бинокли с лазерным целеуказателем могут только командиры отделений."
#define MARKSMANOPT_MSG "Использовать оптические прицелы LRPS, SOS, AMS, KAHLIA могут только снайперы и пехотные снайперы."
#define GHILLIIE_MSG "Использовать гилли и маскхалаты могут только снайперы и пехотные снайперы."

//===== UAV TERMINAL
_uavOperator = ["B_engineer_F", "B_T_Engineer_F","I_G_engineer_F","I_C_Soldier_Para_8_F"];
_uavRestricted = ["B_UavTerminal","O_UavTerminal","I_UavTerminal"];

//===== AT / MISSILE LAUNCHERS
_missileSoldiers = ["B_soldier_AT_F","B_T_Soldier_AT_F","I_G_Soldier_AR_F","I_C_Soldier_Para_4_F"];
_missileSpecialised = ["launch_B_Titan_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_short_F","launch_O_Titan_short_F","launch_I_Titan_short_F","launch_B_Titan_tna_F","launch_B_Titan_short_tna_F","launch_O_Titan_ghex_F","launch_O_Titan_short_ghex_F"];

//===== SMALL MISSILE LAUNCHERS
_missileSmallSoldiers = ["B_soldier_AT_F","B_T_Soldier_AT_F","B_Soldier_SL_F","B_T_Soldier_SL_F","I_G_Soldier_AR_F","I_G_engineer_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_8_F"];
_missileSmallSpecialised = ["launch_RPG32_F","launch_NLAW_F","launch_RPG32_ghex_F","launch_RPG7_F"];

//===== SNIPER RIFLES
_snipers = ["B_sniper_F","B_T_Sniper_F","I_G_engineer_F","I_C_Soldier_Para_8_F"];
_sniperSpecialised = ["srifle_GM6_camo_F","srifle_GM6_camo_SOS_F","srifle_GM6_camo_LRPS_F","srifle_LRR_camo_F","srifle_LRR_camo_SOS_F","srifle_LRR_camo_LRPS_F","srifle_GM6_F","srifle_GM6_SOS_F","srifle_GM6_LRPS_F","srifle_LRR_F","srifle_LRR_SOS_F","srifle_LRR_LRPS_F","srifle_LRR_tna_F","srifle_LRR_tna_LRPS_F","srifle_GM6_ghex_F","srifle_GM6_ghex_LRPS_F"];

//===== BACKPACKS
_backpackRestricted = ["O_Mortar_01_support_F","I_Mortar_01_support_F","O_Mortar_01_weapon_F","I_Mortar_01_weapon_F","O_UAV_01_backpack_F","I_UAV_01_backpack_F","O_HMG_01_support_F","I_HMG_01_support_F","O_HMG_01_support_high_F","I_HMG_01_support_high_F","O_HMG_01_weapon_F","I_HMG_01_weapon_F","O_HMG_01_A_weapon_F","I_HMG_01_A_weapon_F","O_GMG_01_weapon_F","I_GMG_01_weapon_F","O_GMG_01_A_weapon_F","I_GMG_01_A_weapon_F","O_HMG_01_high_weapon_F","I_HMG_01_high_weapon_F","O_HMG_01_A_high_weapon_F","I_HMG_01_A_high_weapon_F","O_GMG_01_high_weapon_F","I_GMG_01_high_weapon_F","O_GMG_01_A_high_weapon_F","I_GMG_01_A_high_weapon_F","I_AT_01_weapon_F","O_AT_01_weapon_F","I_AA_01_weapon_F","O_AA_01_weapon_F","B_Respawn_TentDome_F","B_Respawn_TentA_F","B_Respawn_Sleeping_bag_F","B_Respawn_Sleeping_bag_blue_F","B_Respawn_Sleeping_bag_brown_F"];

//===== LMG
_autoRiflemen = ["B_Soldier_AR_F","B_T_Soldier_AR_F","I_G_Soldier_AR_F","I_C_Soldier_Para_4_F"];
_autoSpecialised = ["LMG_Mk200_LP_BI_F","LMG_Mk200_BI_F","MMG_01_hex_F","MMG_01_tan_F","MMG_01_hex_ARCO_LP_F","MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F","MMG_02_sand_RCO_LP_F","MMG_02_black_RCO_BI_F","LMG_Mk200_F","LMG_Mk200_MRCO_F","LMG_Mk200_pointer_F","LMG_Zafir_F","LMG_Zafir_pointer_F","LMG_Zafir_ARCO_F","arifle_MX_SW_F","arifle_MX_SW_Black_F","arifle_MX_SW_khk_F","arifle_CTARS_blk_F","arifle_CTARS_ghex_F","arifle_CTARS_hex_F","arifle_CTARS_blk_Pointer_F","LMG_03_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","arifle_SPAR_02_blk_Pointer_F","arifle_MX_SW_khk_F","arifle_MX_SW_khk_Pointer_F"];

//===== MARKSMAN
_marksman = ["B_soldier_M_F","B_T_soldier_M_F","I_G_engineer_F","I_C_Soldier_Para_8_F"];
_marksmanGun = ["srifle_DMR_01_DMS_BI_F","srifle_DMR_01_DMS_snds_BI_F","srifle_EBR_MRCO_LP_BI_F","arifle_MXM_DMS_LP_BI_snds_F","arifle_MXM_Hamr_LP_BI_F","srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_02_ACO_F","srifle_DMR_02_MRCO_F","srifle_DMR_02_SOS_F","srifle_DMR_02_DMS_F","srifle_DMR_02_sniper_AMS_LP_S_F","srifle_DMR_02_camo_AMS_LP_F","srifle_DMR_02_ARCO_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F","srifle_DMR_03_spotter_F","srifle_DMR_03_ACO_F","srifle_DMR_03_MRCO_F","srifle_DMR_03_SOS_F","srifle_DMR_03_DMS_F","srifle_DMR_03_tan_AMS_LP_F","srifle_DMR_03_DMS_snds_F","srifle_DMR_03_ARCO_F","srifle_DMR_03_AMS_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_04_ACO_F","srifle_DMR_04_MRCO_F","srifle_DMR_04_SOS_F","srifle_DMR_04_DMS_F","srifle_DMR_04_ARCO_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_05_ACO_F","srifle_DMR_05_MRCO_F","srifle_DMR_05_SOS_F","srifle_DMR_05_DMS_F","srifle_DMR_05_KHS_LP_F","srifle_DMR_05_DMS_snds_F","srifle_DMR_05_ARCO_F","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_DMR_06_camo_khs_F","srifle_DMR_01_F","srifle_DMR_01_ACO_F","srifle_DMR_01_MRCO_F","srifle_DMR_01_SOS_F","srifle_DMR_01_DMS_F","srifle_DMR_01_DMS_snds_F","srifle_DMR_01_ARCO_F","srifle_EBR_F","srifle_EBR_ACO_F","srifle_EBR_MRCO_pointer_F","srifle_EBR_ARCO_pointer_F","srifle_EBR_SOS_F","srifle_EBR_ARCO_pointer_snds_F","srifle_EBR_DMS_F","srifle_EBR_Hamr_pointer_F","srifle_EBR_DMS_pointer_snds_F","arifle_MXM_F","arifle_MXM_Hamr_pointer_F","arifle_MXM_SOS_pointer_F","arifle_MXM_RCO_pointer_snds_F","arifle_MXM_DMS_F","arifle_MXM_Black_F","srifle_DMR_07_blk_F","srifle_DMR_07_hex_F","srifle_DMR_07_ghex_F","srifle_DMR_07_blk_DMS_F","srifle_DMR_07_blk_DMS_Snds_F","arifle_MXM_khk_F","arifle_SPAR_03_blk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","arifle_SPAR_03_blk_MOS_Pointer_Bipod_F","arifle_MXM_khk_F","arifle_MXM_khk_MOS_Pointer_Bipod_F","arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F","arifle_ARX_ghex_ACO_Pointer_Snds_F","arifle_ARX_ghex_ARCO_Pointer_Snds_F","arifle_ARX_ghex_DMS_Pointer_Snds_Bipod_F","arifle_ARX_hex_ACO_Pointer_Snds_F","arifle_ARX_hex_ARCO_Pointer_Snds_F","arifle_ARX_hex_DMS_Pointer_Snds_Bipod_F"];

//==== PILOTS
_pilot = ["B_Helipilot_F","B_T_Helipilot_F"];
_pilotWeapons = ["hgun_PDW2000_F","hgun_PDW2000_snds_F","hgun_PDW2000_Holo_F","hgun_PDW2000_Holo_snds_F","SMG_01_F","SMG_01_Holo_F","SMG_01_Holo_pointer_snds_F","SMG_01_ACO_F","SMG_02_F","SMG_02_ACO_F","SMG_02_ARCO_pointg_F","SMG_05_F"];

//=== GRENADIERS
_grenadier = ["B_Soldier_SL_F","B_T_Soldier_SL_F","B_medic_F","B_T_Medic_F","B_engineer_F","B_T_Engineer_F","I_G_Soldier_AR_F","I_G_engineer_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_8_F"];
_grenadierWeapons = ["arifle_Katiba_GL_F","arifle_TRG21_GL_F","arifle_TRG21_GL_MRCO_F","arifle_TRG21_GL_ACO_pointer_F","arifle_Katiba_GL_ACO_F","arifle_Katiba_GL_ARCO_pointer_F	","arifle_Katiba_GL_ACO_pointer_F","arifle_Katiba_GL_ACO_pointer_snds_F","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_Mk20_GL_MRCO_pointer_F","arifle_Mk20_GL_ACO_F","arifle_MX_GL_F","arifle_MX_GL_ACO_F","arifle_MX_GL_ACO_pointer_F","arifle_MX_GL_Hamr_pointer_F","arifle_MX_GL_Holo_pointer_snds_F","arifle_MX_GL_Black_F","arifle_MX_GL_Black_Hamr_pointer_F","arifle_AK12_GL_F","arifle_CTAR_GL_blk_F","arifle_CTAR_GL_ghex_F","arifle_CTAR_GL_hex_F","arifle_CTAR_GL_blk_ACO_F","arifle_CTAR_GL_blk_ACO_Pointer_Snds_F","arifle_MX_GL_khk_F","arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_GL_snd_F","arifle_SPAR_01_GL_blk_ACO_Pointer_F","arifle_MX_GL_khk_F","arifle_MX_GL_khk_ACO_F","arifle_MX_GL_khk_Hamr_Pointer_F","arifle_MX_GL_khk_Holo_Pointer_Snds_F"];

//=== COMMANDERS
_commanders = ["B_Soldier_SL_F","B_T_Soldier_SL_F","I_G_Soldier_AR_F","I_G_engineer_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_8_F"];
_commanderItems = ["Laserdesignator","Laserdesignator_02","Laserdesignator_03","Laserdesignator_01_khk_F","Laserdesignator_02_ghex_F"];

//===== THERMAL
_ThermalOpt = ["optic_Nightstalker","optic_tws","optic_tws_mg"];
_ThermalTeam = [];

//===== MARKSMAN OPTICS
_marksmanOpticsGrp = ["B_sniper_F","B_T_Sniper_F","B_soldier_M_F","B_T_soldier_M_F","I_G_Soldier_AR_F","I_G_engineer_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_8_F"];
_marksmanOpticsItems = ["optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_SOS","optic_LRPS"];

_ghillieGroups = ["B_soldier_M_F","B_sniper_F","I_G_Soldier_AR_F","I_G_engineer_F","B_T_soldier_M_F","B_T_Sniper_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_8_F"];
_ghillieItems = ["U_B_GhillieSuit","U_O_GhillieSuit","U_I_GhillieSuit","U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard","U_B_T_FullGhillie_tna_F","U_B_T_Sniper_F","U_O_T_FullGhillie_tna_F","U_O_T_Sniper_F"];

_basePos = getMarkerPos "respawn_west";

/*
// Restrict shooting on base territory
_szmkr = getMarkerPos "safezone_marker";
#define SZ_RADIUS 400

_EHFIRED = {
	deleteVehicle (_this select 6);
	hintC "Использование оружия на базе запрещено! В целях безопасности.";
    hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
        0 = _this spawn {
            _this select 0 displayRemoveEventHandler ["unload", hintC_EH];
            hintSilent "";
        };
    }];
};

_firstRun = TRUE;
if (_firstRun) then {
	_firstRun = FALSE;
	if ((player distance _szmkr) <= SZ_RADIUS) then {
		_insideSafezone = TRUE;
		_outsideSafezone = FALSE;
		EHFIRED = player addEventHandler ["Fired",_EHFIRED];
	} else {
		_outsideSafezone = TRUE;
		_insideSafezone = FALSE;
	};
};
*/

while {true} do {
	//------------------------------------- Pilots
	if (({player isKindOf _x} count _pilot) > 0) then {
		if (!(primaryWeapon player in _pilotWeapons) and (primaryWeapon player != "")) then {
			player removeWeapon (primaryWeapon player);
			titleText [PILOT_MSG,"PLAIN",2];
		};
		sleep 0.1;

	} else {

		//------------------------------------- Grenadiers
		if (({player hasWeapon _x} count _grenadierWeapons) > 0) then {
			if (({player isKindOf _x} count _grenadier) < 1) then {
				player removeWeapon (primaryWeapon player);
				titleText [GRENADIER_MSG,"PLAIN",2];
			};
		};
		sleep 0.1;

		//------------------------------------- Sniper Rifles
		if (({player hasWeapon _x} count _sniperSpecialised) > 0) then {
			if (({player isKindOf _x} count _snipers) < 1) then {
				player removeWeapon (primaryWeapon player);
				titleText [SNIPER_MSG,"PLAIN",2];
			};
		};
		sleep 0.1;

		//------------------------------------- LMG
		if (({player hasWeapon _x} count _autoSpecialised) > 0) then {
			if (({player isKindOf _x} count _autoRiflemen) < 1) then {
				player removeWeapon (primaryWeapon player);
				titleText [MG_MSG,"PLAIN",2];
			};
		};
		sleep 0.1;

		//------------------------------------- Marksman
		if (({player hasWeapon _x} count _marksmanGun) > 0) then {
			if (({player isKindOf _x} count _marksman) < 1) then {
				player removeWeapon (primaryWeapon player);
				titleText [MRK_MSG,"PLAIN",2];
			};
		};
		sleep 0.1;
	};

	//------------------------------------- Launchers
	if (({player hasWeapon _x} count _missileSpecialised) > 0) then {
		if (({player isKindOf _x} count _missileSoldiers) < 1) then {
			player removeWeapon (secondaryWeapon player);
			titleText [AT_MSG,"PLAIN",2];
		};
	};
	sleep 0.1;

	//------------------------------------- Small Launchers
	if (({player hasWeapon _x} count _missileSmallSpecialised) > 0) then {
		if (({player isKindOf _x} count _missileSmallSoldiers) < 1) then {
			player removeWeapon (secondaryWeapon player);
			titleText [AT_SMALL_MSG,"PLAIN",2];
		};
	};
	sleep 0.1;

	//------------------------------------- Thermal optics
	_optics = primaryWeaponItems player;
	if (({_x in _optics} count _ThermalOpt) > 0) then {
		{player removePrimaryWeaponItem  _x;} count _ThermalOpt;
		titleText [AUTOTUR_MSG,"PLAIN",2];
	};
	sleep 0.1;

	//------------------------------------- Laser Designators

	_items = items player + assignedItems player;
	if (({_x in _items} count _commanderItems) > 0) then {
		if (({player isKindOf _x} count _commanders) < 1) then {
			player removeItem "Laserbatteries";
			{
			    player removeWeapon _x;
		    } forEach _commanderItems;
			titleText [COMMANDER_MSG,"PLAIN",2];
		};
	};
	sleep 0.1;

	//------------------------------------- Marksman optics
	_optics = primaryWeaponItems player;
	if (({_x in _optics} count _marksmanOpticsItems) > 0) then {
		if (({player isKindOf _x} count _marksmanOpticsGrp) < 1) then {
			{player removePrimaryWeaponItem  _x;} count _marksmanOpticsItems;
			titleText [MARKSMANOPT_MSG,"PLAIN",2];
		};
	};
	sleep 0.1;

    //------------------------------------- Ghillie
	_uniform = uniform player;
	if ((uniform player) in _ghillieItems) then {
		if (({player isKindOf _x} count _ghillieGroups) < 1) then {
			removeUniform player;
			titleText [GHILLIIE_MSG,"PLAIN",2];
		};
	};
	sleep 0.1;

	//------------------------------------- Enemy turret backpacks
	if ((backpack player) in _backpackRestricted) then {
		removeBackpack player;
		titleText [AUTOTUR_MSG, "PLAIN", 2];
	};
	sleep 0.1;

	//------------------------------------- UAV
	_assignedItems = assignedItems player;
	if (({"B_UavTerminal" == _x} count _assignedItems) > 0) then {
		if (({player isKindOf _x} count _uavOperator) < 1) then {
			player unassignItem "B_UavTerminal";
			player removeItem "B_UavTerminal";
			titleText [UAV_MSG,"PLAIN",2];
		};
	};
	sleep 0.1;

	/*
	===================================== SAFE ZONE MANAGER
	_szmkr = getMarkerPos "safezone_marker";
	if (_insideSafezone) then {
		if ((player distance _szmkr) > SZ_RADIUS) then {
			_insideSafezone = FALSE;
			_outsideSafezone = TRUE;
			player removeEventHandler ["Fired",EHFIRED];
		};
	};
	sleep 1;
	if (_outsideSafezone) then {
		if ((player distance _szmkr) < SZ_RADIUS) then {
			_outsideSafezone = FALSE;
			_insideSafezone = TRUE;
			EHFIRED = player addEventHandler ["Fired",_EHFIRED];
		};
	};
	*/

	//----- Sleep
	_basePos = getMarkerPos "respawn_west";
	if ((player distance2D _basePos) <= 500) then {
		sleep 2;
	} else {
		sleep 10;
	};
};
