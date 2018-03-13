/*
Author: ToxaBes
Description: add partizan patrol
*/
_center = _this select 0;
_blufor_base = getMarkerPos "respawn_west";
if (_center distance2D _blufor_base < 500) exitWith {
    ["<t color='#F44336' size = '.48'>Слишком близко к базе регулярной армии!</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
["<t color='#7FDA0B' size = '.48'>Вызов патруля...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;

_patrolGroup = createGroup resistance;
_spawnPos = [_center, 500, 600, 1, 0, 10, 0, []] call QS_fnc_findSafePos;
"I_Soldier_AA_F" createUnit [_spawnPos, _patrolGroup, "unit1 = this;"];
removeAllWeapons unit1;
removeAllItems unit1;
removeAllAssignedItems unit1;
removeUniform unit1;
removeVest unit1;
removeBackpack unit1;
removeHeadgear unit1;
removeGoggles unit1;
unit1 forceAddUniform "U_BG_Guerilla2_2";
unit1 addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {unit1 addItemToUniform "30Rnd_556x45_Stanag";};
unit1 addVest "V_PlateCarrierIA2_dgtl";
for "_i" from 1 to 2 do {unit1 addItemToVest "30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {unit1 addItemToVest "9Rnd_45ACP_Mag";};
unit1 addItemToVest "SmokeShell";
unit1 addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {unit1 addItemToVest "Chemlight_green";};
unit1 addBackpack "I_Fieldpack_oli_AA";
for "_i" from 1 to 2 do {unit1 addItemToBackpack "Titan_AA";};
unit1 addHeadgear "H_Shemag_olive";
unit1 addWeapon "arifle_Mk20C_F";
unit1 addPrimaryWeaponItem "acc_pointer_IR";
unit1 addPrimaryWeaponItem "optic_ACO_grn";
unit1 addWeapon "launch_I_Titan_F";
unit1 addSecondaryWeaponItem "acc_pointer_IR";
unit1 addWeapon "hgun_ACPC2_F";
unit1 linkItem "ItemMap";
unit1 linkItem "ItemCompass";
unit1 linkItem "ItemWatch";
unit1 linkItem "ItemRadio";
unit1 linkItem "NVGoggles_INDEP";

"I_Soldier_AA_F" createUnit [_spawnPos, _patrolGroup, "unit2 = this;"];
removeAllWeapons unit2;
removeAllItems unit2;
removeAllAssignedItems unit2;
removeUniform unit2;
removeVest unit2;
removeBackpack unit2;
removeHeadgear unit2;
removeGoggles unit2;
unit2 forceAddUniform "U_BG_Guerilla2_3";
unit2 addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {unit2 addItemToUniform "30Rnd_556x45_Stanag";};
unit2 addVest "V_PlateCarrierIA2_dgtl";
for "_i" from 1 to 2 do {unit2 addItemToVest "30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {unit2 addItemToVest "9Rnd_45ACP_Mag";};
unit2 addItemToVest "SmokeShell";
unit2 addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {unit2 addItemToVest "Chemlight_green";};
unit2 addBackpack "I_Fieldpack_oli_AA";
for "_i" from 1 to 2 do {unit2 addItemToBackpack "Titan_AA";};
unit2 addHeadgear "H_Cap_blk_Raven";
unit2 addGoggles "G_Lowprofile";
unit2 addWeapon "arifle_Mk20C_F";
unit2 addPrimaryWeaponItem "acc_pointer_IR";
unit2 addPrimaryWeaponItem "optic_ACO_grn";
unit2 addWeapon "launch_I_Titan_F";
unit2 addSecondaryWeaponItem "acc_pointer_IR";
unit2 addWeapon "hgun_ACPC2_F";
unit2 linkItem "ItemMap";
unit2 linkItem "ItemCompass";
unit2 linkItem "ItemWatch";
unit2 linkItem "ItemRadio";
unit2 linkItem "NVGoggles_INDEP";

"I_Soldier_AT_F" createUnit [_spawnPos, _patrolGroup, "unit3 = this;"];
removeAllWeapons unit3;
removeAllItems unit3;
removeAllAssignedItems unit3;
removeUniform unit3;
removeVest unit3;
removeBackpack unit3;
removeHeadgear unit3;
removeGoggles unit3;
unit3 forceAddUniform "U_BG_leader";
unit3 addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {unit3 addItemToUniform "30Rnd_556x45_Stanag";};
unit3 addVest "V_PlateCarrierIA2_dgtl";
for "_i" from 1 to 2 do {unit3 addItemToVest "30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {unit3 addItemToVest "9Rnd_45ACP_Mag";};
unit3 addItemToVest "SmokeShell";
unit3 addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {unit3 addItemToVest "Chemlight_green";};
unit3 addBackpack "I_Fieldpack_oli_AT";
for "_i" from 1 to 2 do {unit3 addItemToBackpack "Titan_AT";};
unit3 addHeadgear "H_Cap_oli_hs";
unit3 addWeapon "arifle_Mk20C_F";
unit3 addPrimaryWeaponItem "acc_pointer_IR";
unit3 addPrimaryWeaponItem "optic_ACO_grn";
unit3 addWeapon "launch_I_Titan_short_F";
unit3 addSecondaryWeaponItem "acc_pointer_IR";
unit3 addWeapon "hgun_ACPC2_F";
unit3 linkItem "ItemMap";
unit3 linkItem "ItemCompass";
unit3 linkItem "ItemWatch";
unit3 linkItem "ItemRadio";
unit3 linkItem "NVGoggles_INDEP";

"I_Soldier_AT_F" createUnit [_spawnPos, _patrolGroup, "unit4 = this;"];
removeAllWeapons unit4;
removeAllItems unit4;
removeAllAssignedItems unit4;
removeUniform unit4;
removeVest unit4;
removeBackpack unit4;
removeHeadgear unit4;
removeGoggles unit4;
unit4 forceAddUniform "U_BG_Guerrilla_6_1";
unit4 addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {unit4 addItemToUniform "30Rnd_556x45_Stanag";};
unit4 addVest "V_PlateCarrierIA2_dgtl";
for "_i" from 1 to 2 do {unit4 addItemToVest "30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {unit4 addItemToVest "9Rnd_45ACP_Mag";};
unit4 addItemToVest "SmokeShell";
unit4 addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {unit4 addItemToVest "Chemlight_green";};
unit4 addBackpack "I_Fieldpack_oli_AT";
for "_i" from 1 to 2 do {unit4 addItemToBackpack "Titan_AT";};
unit4 addHeadgear "H_Booniehat_dgtl";
unit4 addWeapon "arifle_Mk20C_F";
unit4 addPrimaryWeaponItem "acc_pointer_IR";
unit4 addPrimaryWeaponItem "optic_ACO_grn";
unit4 addWeapon "launch_I_Titan_short_F";
unit4 addSecondaryWeaponItem "acc_pointer_IR";
unit4 addWeapon "hgun_ACPC2_F";
unit4 linkItem "ItemMap";
unit4 linkItem "ItemCompass";
unit4 linkItem "ItemWatch";
unit4 linkItem "ItemRadio";
unit4 linkItem "NVGoggles_INDEP";

_nearestTargets = nearestObjects [_center, ["Man","LandVehicle"], 200];
{
    _patrolGroup reveal [_x, 4];
} forEach _nearestTargets;

[_patrolGroup, _center] call BIS_fnc_taskAttack;
_patrolGroup setBehaviour "COMBAT";
_patrolGroup setCombatMode "RED";
[(units _patrolGroup)] call QS_fnc_setSkill4;
[_patrolGroup, true] call QS_fnc_moveToHC;

[_patrolGroup] spawn {
	_patrolGroup = _this select 0;
	sleep 1800; // 30 mins
	{
         deleteVehicle _x;
    } forEach units _patrolGroup;
    deleteGroup _patrolGroup;
};
