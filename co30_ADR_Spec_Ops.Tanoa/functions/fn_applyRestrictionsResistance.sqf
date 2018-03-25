/*
Author:	Quicksilver (changed by ToxaBes)
Description: check for restriction weapons and gear after load from aresenal or take from container
*/
_player = _this select 0;
_remove = _this param [1, false];

#define AT_MSG "Только ракетчики ПТ могут использовать это оружие"
#define SNIPER_MSG "Только снайперы могут использовать это оружие"
#define AUTOTUR_MSG "Данное вооружение запрещено"
#define UAV_MSG "Только инженеры могут использовать терминал управления"
#define MG_MSG "Только пулеметчики могут использовать пулеметы"
#define MRK_MSG "Только снайперы могут использовать это оружие"
#define MARKSMANOPT_MSG "Использовать оптические прицелы LRPS, SOS, AMS, KAHLIA могут только снайперы и пехотные снайперы"
#define GHILLIIE_MSG "Использовать гилли и маскхалаты могут только снайперы и пехотные снайперы"
#define ITEM_MSG "Предметы противника запрещены"
#define MINEDETECOR_MSG "Только инженеры могут использовать детектор мин"

// UAV TERMINAL
_uavOperator = ["I_C_Soldier_Para_8_F"];

// AT / MISSILE LAUNCHERS
_missileSoldiers = ["I_C_Soldier_Para_5_F"];
_missileSpecialised = ["launch_B_Titan_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_short_F","launch_O_Titan_short_F","launch_I_Titan_short_F","launch_B_Titan_tna_F","launch_B_Titan_short_tna_F","launch_O_Titan_ghex_F","launch_O_Titan_short_ghex_F"];

// SNIPER RIFLES
_snipers = ["I_C_Soldier_Para_8_F"];
_sniperSpecialised = ["srifle_GM6_camo_F","srifle_GM6_camo_SOS_F","srifle_GM6_camo_LRPS_F","srifle_LRR_camo_F","srifle_LRR_camo_SOS_F","srifle_LRR_camo_LRPS_F","srifle_GM6_F","srifle_GM6_SOS_F","srifle_GM6_LRPS_F","srifle_LRR_F","srifle_LRR_SOS_F","srifle_LRR_LRPS_F","srifle_LRR_tna_F","srifle_LRR_tna_LRPS_F","srifle_GM6_ghex_F","srifle_GM6_ghex_LRPS_F",
"SMA_HK417","SMA_HK417vfg","SMA_HK417_16in","SMA_Mk17_16_black","SMA_Mk17_16_Green","SMA_Mk17_16"];

// LMG
_autoRiflemen = ["I_C_Soldier_Para_3_F"];
_autoSpecialised = ["LMG_Mk200_LP_BI_F","LMG_Mk200_BI_F","MMG_01_hex_F","MMG_01_tan_F","MMG_01_hex_ARCO_LP_F","MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F","MMG_02_sand_RCO_LP_F","MMG_02_black_RCO_BI_F","LMG_Mk200_F","LMG_Mk200_MRCO_F","LMG_Mk200_pointer_F","LMG_Zafir_F","LMG_Zafir_pointer_F","LMG_Zafir_ARCO_F","arifle_MX_SW_F","arifle_MX_SW_Black_F","arifle_MX_SW_khk_F","arifle_CTARS_blk_F","arifle_CTARS_ghex_F","arifle_CTARS_hex_F","arifle_CTARS_blk_Pointer_F","LMG_03_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","arifle_SPAR_02_blk_Pointer_F","arifle_MX_SW_khk_F","arifle_MX_SW_khk_Pointer_F",
"sma_minimi_mk3_762tlb","sma_minimi_mk3_762tlb_des","sma_minimi_mk3_762tlb_wdl","sma_minimi_mk3_762tsb","sma_minimi_mk3_762tsb_des","sma_minimi_mk3_762tsb_wdl"];

// MARKSMAN
_marksman = ["I_C_Soldier_Para_8_F"];
_marksmanGun = ["srifle_DMR_01_DMS_BI_F","srifle_DMR_01_DMS_snds_BI_F","srifle_EBR_MRCO_LP_BI_F","arifle_MXM_DMS_LP_BI_snds_F","arifle_MXM_Hamr_LP_BI_F","srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_02_ACO_F","srifle_DMR_02_MRCO_F","srifle_DMR_02_SOS_F","srifle_DMR_02_DMS_F","srifle_DMR_02_sniper_AMS_LP_S_F","srifle_DMR_02_camo_AMS_LP_F","srifle_DMR_02_ARCO_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F","srifle_DMR_03_spotter_F","srifle_DMR_03_ACO_F","srifle_DMR_03_MRCO_F","srifle_DMR_03_SOS_F","srifle_DMR_03_DMS_F","srifle_DMR_03_tan_AMS_LP_F","srifle_DMR_03_DMS_snds_F","srifle_DMR_03_ARCO_F","srifle_DMR_03_AMS_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_04_ACO_F","srifle_DMR_04_MRCO_F","srifle_DMR_04_SOS_F","srifle_DMR_04_DMS_F","srifle_DMR_04_ARCO_F","srifle_DMR_04_NS_LP_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_05_ACO_F","srifle_DMR_05_MRCO_F","srifle_DMR_05_SOS_F","srifle_DMR_05_DMS_F","srifle_DMR_05_KHS_LP_F","srifle_DMR_05_DMS_snds_F","srifle_DMR_05_ARCO_F","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_DMR_06_camo_khs_F","srifle_DMR_01_F","srifle_DMR_01_ACO_F","srifle_DMR_01_MRCO_F","srifle_DMR_01_SOS_F","srifle_DMR_01_DMS_F","srifle_DMR_01_DMS_snds_F","srifle_DMR_01_ARCO_F","srifle_EBR_F","srifle_EBR_ACO_F","srifle_EBR_MRCO_pointer_F","srifle_EBR_ARCO_pointer_F","srifle_EBR_SOS_F","srifle_EBR_ARCO_pointer_snds_F","srifle_EBR_DMS_F","srifle_EBR_Hamr_pointer_F","srifle_EBR_DMS_pointer_snds_F","arifle_MXM_F","arifle_MXM_Hamr_pointer_F","arifle_MXM_SOS_pointer_F","arifle_MXM_RCO_pointer_snds_F","arifle_MXM_DMS_F","arifle_MXM_Black_F","srifle_DMR_07_blk_F","srifle_DMR_07_hex_F","srifle_DMR_07_ghex_F","srifle_DMR_07_blk_DMS_F","srifle_DMR_07_blk_DMS_Snds_F","arifle_MXM_khk_F","arifle_SPAR_03_blk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","arifle_SPAR_03_blk_MOS_Pointer_Bipod_F","arifle_MXM_khk_F","arifle_MXM_khk_MOS_Pointer_Bipod_F","arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F","arifle_ARX_ghex_ACO_Pointer_Snds_F","arifle_ARX_ghex_ARCO_Pointer_Snds_F","arifle_ARX_ghex_DMS_Pointer_Snds_Bipod_F","arifle_ARX_hex_ACO_Pointer_Snds_F","arifle_ARX_hex_ARCO_Pointer_Snds_F","arifle_ARX_hex_DMS_Pointer_Snds_Bipod_F",
"SMA_HK417","SMA_HK417vfg","SMA_HK417_16in","SMA_Mk17_16_black","SMA_Mk17_16_Green","SMA_Mk17_16"];

// THERMAL
_ThermalOpt = ["optic_Nightstalker","optic_tws","optic_tws_mg"];
_ThermalTeam = [];

// MARKSMAN OPTICS
_marksmanOpticsGrp = ["I_C_Soldier_Para_8_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_3_F"];
_marksmanOpticsItems = ["optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_SOS","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_SOS_khk_F"];

_ghillieGroups = ["I_C_Soldier_Para_8_F"];
_ghillieItems = ["U_B_GhillieSuit","U_O_GhillieSuit","U_I_GhillieSuit","U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard","U_B_T_FullGhillie_tna_F","U_B_T_Sniper_F","U_O_T_FullGhillie_tna_F","U_O_T_Sniper_F"];

// ITEMS
//_disabledItems = ["NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F"];

// Weapons check
_box = createVehicle ["groundWeaponHolder", _player modelToWorld [0,0.6,0], [], 0.5, "CAN_COLLIDE"];
_box setDir floor (random 360);
// Sniper Rifles
if (({_player hasWeapon _x} count _sniperSpecialised) > 0) then {
	if (({_player isKindOf _x} count _snipers) < 1) then {
		if (!_remove) then {
		    _box addWeaponCargoGlobal [primaryWeapon _player, 1];
	    };
		_player removeWeapon (primaryWeapon _player);
		[format ["<t color='#F44336' size = '.55'>%1</t>", SNIPER_MSG], 0, 1, 5, 0, 0] spawn BIS_fnc_dynamicText;
	};
};

// LMG
if (({_player hasWeapon _x} count _autoSpecialised) > 0) then {
	if (({_player isKindOf _x} count _autoRiflemen) < 1) then {
		if (!_remove) then {
		    _box addWeaponCargoGlobal [primaryWeapon _player, 1];
	    };
		_player removeWeapon (primaryWeapon _player);
		[format ["<t color='#F44336' size = '.55'>%1</t>", MG_MSG], 0, 1, 5, 0, 0] spawn BIS_fnc_dynamicText;
	};
};

// Marksman
if (({_player hasWeapon _x} count _marksmanGun) > 0) then {
	if (({_player isKindOf _x} count _marksman) < 1) then {
		if (!_remove) then {
		    _box addWeaponCargoGlobal [primaryWeapon _player, 1];
	    };
		_player removeWeapon (primaryWeapon _player);
		[format ["<t color='#F44336' size = '.55'>%1</t>", MRK_MSG], 0, 1, 5, 0, 0] spawn BIS_fnc_dynamicText;
	};
};

// Launchers
if (({_player hasWeapon _x} count _missileSpecialised) > 0) then {
	if (({_player isKindOf _x} count _missileSoldiers) < 1) then {
		if (!_remove) then {
		    _box addWeaponCargoGlobal [secondaryWeapon _player, 1];
	    };
		_player removeWeapon (secondaryWeapon _player);
		[format ["<t color='#F44336' size = '.55'>%1</t>", AT_MSG], 0, 1, 5, 0, 0] spawn BIS_fnc_dynamicText;
	};
};

// Thermal optics
_optics = primaryWeaponItems _player;
if (({_x in _optics} count _ThermalOpt) > 0) then {
	{_player removePrimaryWeaponItem  _x;} count _ThermalOpt;
	[format ["<t color='#F44336' size = '.55'>%1</t>", AUTOTUR_MSG], 0, 1, 5, 0, 0] spawn BIS_fnc_dynamicText;
};

// Marksman optics
_optics = primaryWeaponItems _player;
if (({_x in _optics} count _marksmanOpticsItems) > 0) then {
	if (({_player isKindOf _x} count _marksmanOpticsGrp) < 1) then {
		{_player removePrimaryWeaponItem  _x;} count _marksmanOpticsItems;
		[format ["<t color='#F44336' size = '.55'>%1</t>", MARKSMANOPT_MSG], 0, 1, 5, 0, 0] spawn BIS_fnc_dynamicText;
	};
};

// Ghillie
if (PARTIZAN_BASE_SCORE < 29) then {
    _uniform = format ["%1", uniform _player];
    if (_uniform != "") then {
        if (_uniform in _ghillieItems) then {
        	if (({_player isKindOf _x} count _ghillieGroups) < 1) then {
        		removeUniform _player;
        		[format ["<t color='#F44336' size = '.55'>%1</t>", GHILLIIE_MSG], 0, 1, 5, 0, 0] spawn BIS_fnc_dynamicText;
        	};
        };
    };
};

// UAV
_assignedItems = assignedItems _player;
if (({"I_UavTerminal" == _x} count _assignedItems) > 0) then {
	if (({_player isKindOf _x} count _uavOperator) < 1) then {
		_player unassignItem "I_UavTerminal";
		_player removeItem "I_UavTerminal";
		_box addItemCargoGlobal ["I_UavTerminal", 1];
		[format ["<t color='#F44336' size = '.55'>%1</t>", UAV_MSG], 0, 1, 5, 0, 0] spawn BIS_fnc_dynamicText;
	};
};

// UAV
_assignedItems = assignedItems _player;
if (({"I_UavTerminal" == _x} count _assignedItems) > 0) then {
	if (({_player isKindOf _x} count _uavOperator) < 1) then {
		_player unassignItem "I_UavTerminal";
		_player removeItem "I_UavTerminal";
		_box addItemCargoGlobal ["I_UavTerminal", 1];
		[format ["<t color='#F44336' size = '.55'>%1</t>", UAV_MSG], 0, 1, 5, 0, 0] spawn BIS_fnc_dynamicText;
	};
};

// Other items
//_assignedItems = assignedItems _player;
//{
//	_currentItem = _x;
//    if (_currentItem in _disabledItems) then {
//        _player unassignItem _currentItem;
//		_player removeItem _currentItem;
//		[format ["<t color='#F44336' size = '.55'>%1</t>", ITEM_MSG], 0, 1, 5, 0, 0] spawn BIS_fnc_dynamicText;
//    };
//} forEach _assignedItems;//