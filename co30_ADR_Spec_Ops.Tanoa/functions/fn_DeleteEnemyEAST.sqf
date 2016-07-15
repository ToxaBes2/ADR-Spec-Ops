/*
Author: ToxaBes
Description: delete enemies in given radius
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
_pos = _this select 0;
_radius = _this select 1;
_unitTypes = ["O_Soldier_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_TL_F","O_soldier_M_F","O_Soldier_LAT_F",
"O_medic_F","O_soldier_repair_F","O_soldier_exp_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_soldier_PG_F","O_recon_F",
"O_recon_M_F","O_recon_LAT_F","O_recon_medic_F","O_recon_TL_F","O_Soldier_AAT_F","O_soldierU_M_F","O_SoldierU_GL_F",
"O_HeavyGunner_F","O_Urban_HeavyGunner_F","O_support_MG_F","O_soldierU_F","O_soldierU_AR_F","O_soldierU_AAR_F","O_soldierU_LAT_F",
"O_soldierU_AT_F","O_soldierU_AAT_F","O_soldierU_AA_F","O_soldierU_AAA_F","O_soldierU_TL_F","O_SoldierU_SL_F","O_soldierU_medic_F",
"O_soldierU_repair_F","O_soldierU_exp_F","O_engineer_U_F","O_soldierU_A_F","O_Sharpshooter_F","O_Urban_Sharpshooter_F","O_sniper_F",
"O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F",
"I_Soldier_A_F","I_soldier_AR_F","I_medic_F","I_engineer_F","I_soldier_exp_F","I_Soldier_GL_F","I_soldier_M_F","I_soldier_AA_F",
"I_soldier_AT_F","I_officer_F","I_soldier_repair_F","I_Soldier_F","I_soldier_LAT_F","I_Soldier_lite_F","I_Soldier_SL_F","I_Soldier_TL_F",
"I_soldier_AAR_F","I_soldier_AAA_F","I_soldier_AAT_F","I_G_Soldier_A_F","I_G_soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_soldier_exp_F",
"I_G_Soldier_GL_F","I_G_soldier_M_F","I_G_officer_F","I_G_Soldier_F","I_G_soldier_LAT_F","I_G_Soldier_lite_F","I_G_Soldier_SL_F","I_G_Soldier_TL_F",
"O_T_APC_Tracked_02_AA_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_Crew_F","O_T_Diver_Exp_F","O_T_Diver_F",
"O_T_Diver_TL_F","O_T_Engineer_F","O_T_Helicrew_F","O_T_Helipilot_F","O_T_LSV_02_armed_F","O_T_LSV_02_unarmed_F","O_T_MBT_02_arty_ghex_F",
"O_T_MBT_02_cannon_ghex_F","O_T_MRAP_02_ghex_F","O_T_MRAP_02_gmg_ghex_F","O_T_MRAP_02_hmg_ghex_F","O_T_Medic_F","O_T_Officer_F","O_T_Pilot_F",
"O_T_Recon_Exp_F","O_T_Recon_F","O_T_Recon_JTAC_F","O_T_Recon_LAT_F","O_T_Recon_M_F","O_T_Recon_Medic_F","O_T_Recon_TL_F","O_T_Sniper_F",
"O_T_Soldier_AAA_F","O_T_Soldier_AAR_F","O_T_Soldier_AAT_F","O_T_Soldier_AA_F","O_T_Soldier_AR_F","O_T_Soldier_AT_F","O_T_Soldier_A_F",
"O_T_Soldier_Exp_F","O_T_Soldier_F","O_T_Soldier_GL_F","O_T_Soldier_LAT_F","O_T_Soldier_M_F","O_T_Soldier_PG_F","O_T_Soldier_Repair_F",
"O_T_Soldier_SL_F","O_T_Soldier_TL_F","O_T_Soldier_UAV_F","O_T_Spotter_F","O_T_Support_AMG_F","O_T_Support_AMort_F","O_T_Support_GMG_F",
"O_T_Support_MG_F","O_T_Support_Mort_F","O_T_ghillie_tna_F","O_V_Soldier_Exp_ghex_F","O_V_Soldier_JTAC_ghex_F","O_V_Soldier_LAT_ghex_F",
"O_V_Soldier_M_ghex_F","O_V_Soldier_Medic_ghex_F","O_V_Soldier_TL_ghex_F","O_V_Soldier_ghex_F","O_V_Soldier_Exp_hex_F","O_V_Soldier_JTAC_hex_F",
"O_V_Soldier_M_hex_F","O_V_Soldier_hex_F","O_V_Soldier_Medic_hex_F","O_V_Soldier_LAT_hex_F","O_V_Soldier_TL_hex_F"];
_units = nearestObjects [_pos, _unitTypes, _radius];
{
	_isReward = _x getVariable ["IS_REWARD", false];
	if (side _x == ENEMY_SIDE && !_isReward) then {
        if !(_x isKindOf "Man") then {
	        {
	            deleteVehicle _x;
	        } forEach (crew _x);
	    };
	    deleteVehicle _x;
    };
} foreach _units;
_units = _pos nearObjects ["Man", _radius];
{
	_isReward = _x getVariable ["IS_REWARD", false];
	if (side _x == ENEMY_SIDE && !_isReward) then {
        deleteVehicle _x;
	};
} foreach _units;
