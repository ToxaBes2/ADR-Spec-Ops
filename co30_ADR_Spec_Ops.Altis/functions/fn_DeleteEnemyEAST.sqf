/*
Author: ToxaBes
Description: delete enemies in given radius
*/
_pos = _this select 0;
_radius = _this select 1;
_unitTypes = ["O_Soldier_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_TL_F","O_soldier_M_F","O_Soldier_LAT_F",
"O_medic_F","O_soldier_repair_F","O_soldier_exp_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_soldier_PG_F","O_recon_F",
"O_recon_M_F","O_recon_LAT_F","O_recon_medic_F","O_recon_TL_F","O_Soldier_AAT_F","O_soldierU_M_F","O_SoldierU_GL_F",
"O_HeavyGunner_F","O_Urban_HeavyGunner_F","O_support_MG_F","O_soldierU_F","O_soldierU_AR_F","O_soldierU_AAR_F","O_soldierU_LAT_F", 
"O_soldierU_AT_F","O_soldierU_AAT_F","O_soldierU_AA_F","O_soldierU_AAA_F","O_soldierU_TL_F","O_SoldierU_SL_F","O_soldierU_medic_F",
"O_soldierU_repair_F","O_soldierU_exp_F","O_engineer_U_F","O_soldierU_A_F","O_Sharpshooter_F","O_Urban_Sharpshooter_F","O_sniper_F",
"O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F"];
_units = nearestObjects [_pos, _unitTypes, _radius];
{
    if !(_x isKindOf "Man") then {
	    {
	        deleteVehicle _x;
	    } forEach (crew _x);
	};
	deleteVehicle _x;
} foreach _units;