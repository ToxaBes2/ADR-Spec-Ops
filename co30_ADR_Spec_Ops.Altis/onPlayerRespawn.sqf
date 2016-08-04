private ["_pilots", "_btc_tk_prison", "_tk", "_rules", "_playerType", "_null"];

//=========================== PILOTS ONLY
if (typeOf player in ["B_Helipilot_F", "B_T_Helipilot_F"]) then {
	//===== HELI TURRETS LOCK
	player addAction ["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Разрешить стрельбу</t>", QS_fnc_uh80TurretActions, 0, -95, false, true, "", "[] call QS_fnc_conditionUH80TurretActionUnlock"];
	player addAction ["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Запретить стрельбу</t>", QS_fnc_uh80TurretActions, 1, -95, false, true, "", "[] call QS_fnc_conditionUH80TurretActionLock"];

	//===== FIELD REPAIR
	vehicle_repaired = false;
	player addAction ["<t color='#FFC107'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_debug_ca.paa' size='1.0'/> Полевой ремонт</t>", QS_fnc_actionPilotRepair, "", 100, false, true, "", "[] call QS_fnc_conditionPilotRepair"];

	//===== Aircraft weapon loadout selection
	//Hellcat
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> M134 Minigun 7.62 mm[5000]; DAR[24]</t>", QS_fnc_actionChangeLoadout, 0, 99, false, true, "", "(typeOf (vehicle player) == 'I_Heli_light_03_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Gatling 6.5 mm[2000]; GMG 40 mm[96]</t>", QS_fnc_actionChangeLoadout, 1, 98, false, true, "", "(typeOf (vehicle player) == 'I_Heli_light_03_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Gatling Cannon 20 mm[1000]</t>", QS_fnc_actionChangeLoadout, 2, 97, false, true, "", "(typeOf (vehicle player) == 'I_Heli_light_03_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	//Buzzard
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Zephyr[4]; ASRAAM[2]</t>", QS_fnc_actionChangeLoadout, 3, 96, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Skalpel ATGM[2]; ASRAAM[2]; GBU-12[2]</t>", QS_fnc_actionChangeLoadout, 4, 95, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; ASRAAM[2]; GBU-12[4]</t>", QS_fnc_actionChangeLoadout, 5, 94, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Skalpel ATGM[2]; GBU-12[4]</t>", QS_fnc_actionChangeLoadout, 6, 93, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Tratnyr AP[20]; ASRAAM[2]; GBU-12[2]</t>", QS_fnc_actionChangeLoadout, 7, 92, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Tratnyr HE[60]; ASRAAM[2]</t>", QS_fnc_actionChangeLoadout, 8, 91, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Skalpel ATGM[2]; Tratnyr HE[20]; ASRAAM[2]</t>", QS_fnc_actionChangeLoadout, 9, 90, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
};

//====================== Clear vehicle inventory
inventory_cleared = false;
player addAction ["<t color='#2196F3'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_toolbox_modules_ca.paa' size='1.0'/> Освободить грузоотсек</t>", QS_fnc_actionClearInventory, "", -96, false, true, "", "[] call QS_fnc_conditionClearInventory"];

//====================== Earplugs
player addAction ["<t color='#FFEB3B'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa' size='1.0'/> Вставить беруши</t>", {1 fadeSound 0.33}, "", -95, false, true, "", "(soundVolume == 1) and (vehicle player != player)"];
player addAction ["<t color='#FFEB3B'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa' size='1.0'/> Вытащить беруши</t>", {1 fadeSound 1}, "", -95, false, true, "", "(soundVolume != 1) and (vehicle player != player)"];

//====================== outlw_magRepack
player addAction ["<t color='#84FFFF'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargomag_ca.paa' size='1.0'/> Перепаковка магазинов</t>", {call outlw_MR_createDialog}, "", -97, false, true, "", "outlw_MR_canCreateDialog"];

//====================== Prison check
if (!isDedicated) then {
    _btc_tk_prison = profileNamespace getVariable ["btc_tk_prison", 0];
    if (_btc_tk_prison > 0) then {
        _tk = [] spawn BTC_Teamkill;
    };
};

//====================== Rules check
if (!isDedicated) then {
    _uid = getPlayerUID player;
    _rules = missionNamespace getVariable ["TEHGAM_RULES",[]];
    if (!(_uid in _rules)) then {
        createDialog "tehgam_rules";
    };
};

// Radio channels
_playerType = typeOf player;
switch (_playerType) do {
    case "B_Helipilot_F" : {

        // pilots have access to operative channels
        (RADIO_CHANNELS select 1) radioChannelAdd [player];
    };
    case "B_Soldier_SL_F" : {

        // commanders have access to operative and commander channels
        (RADIO_CHANNELS select 1) radioChannelAdd [player];
        (RADIO_CHANNELS select 2) radioChannelAdd [player];
    };
    default {};
};

// add all players to emergency channel
(RADIO_CHANNELS select 0) radioChannelAdd [player];

// disable channels
0 enableChannel [true, false];
1 enableChannel [true, false];
2 enableChannel [false, false];
(RADIO_CHANNELS select 0) enableChannel [true, false];

// add sticky C4 event
_null = player addEventHandler ["Fired", {
    if (_this select 4 == "DemoCharge_Remote_Ammo") then {
        [_this select 0] call C4_Attach;
    };
}];

if (typeOf player in ["I_G_Soldier_AR_F","I_G_engineer_F"]) then {
    player setUnitTrait ["Medic",true];
    "partizan_base" setMarkerAlphaLocal 1;
} else {
    "partizan_base" setMarkerAlphaLocal 0;
};

// Hide objects near heli landing
((getMarkerPos "respawn_west") nearestObject 492374) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492375) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492438) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492359) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492364) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492365) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492366) hideObject true;
((getMarkerPos "respawn_west") nearestObject 529331) hideObject true;
((getMarkerPos "respawn_west") nearestObject 493984) hideObject true;
((getMarkerPos "respawn_west") nearestObject 491093) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 491010) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 493386) allowDamage false;

// Add actions specific to resistance players
if (side player == resistance) then {
	// Take uniform from CSAT dead bodies
    player addAction ["<t color='#F44336'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\uniform_ca.paa' size='1.0'/> Одеть форму противника</t>","scripts\misc\getEnemyUniform.sqf",[],6,true,true,"",'((vehicle player) == player && cursorObject isKindOf "O_Soldier_base_F" && !alive cursorObject && !((uniform cursorObject) == "") && (player distance cursorObject) < 2 && animationState player != "ainvpknlmstpsnonwrfldnon_medic0s")'];

	// Open unconscious players inventory
    player addAction ["<t color='#FFC107'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\uniform_ca.paa' size='1.0'/> Обыскать</t>",{player action ["Gear", cursorTarget]},[],7,true,true,"",'((vehicle player) == player && (cursorObject getVariable "BTC_need_revive") == 1 && (player distance cursorObject) < 2 && animationState player != "ainvpknlmstpsnonwrfldnon_medic0s")'];
};

// Deal with static map markers
if (playerSide == west) then {
    "partizan_base" setMarkerAlphaLocal 0;
    "Helipad" setMarkerAlphaLocal 1;
    "Arsenal" setMarkerAlphaLocal 1;
    "Laptops" setMarkerAlphaLocal 1;
    "Vehicle_depot_1" setMarkerAlphaLocal 1;
    "Armor" setMarkerAlphaLocal 1;
    "UAVspawn" setMarkerAlphaLocal 1;
    "Arsenal_1" setMarkerAlphaLocal 1;
    "Helo_spawn" setMarkerAlphaLocal 1;
    "Side" setMarkerAlphaLocal 1;
    "m_mod" setMarkerAlphaLocal 1;
    "Repair_1" setMarkerAlphaLocal 1;
    "changeLoadout" setMarkerAlphaLocal 1;
    "Repair_2" setMarkerAlphaLocal 1;
    "Repair_2_1" setMarkerAlphaLocal 1;
    "B2" setMarkerAlphaLocal 1;
    "B2_1" setMarkerAlphaLocal 1;
    "med" setMarkerAlphaLocal 1;
    "vehService" setMarkerAlphaLocal 1;
} else {
    "partizan_base" setMarkerAlphaLocal 1;
    "Helipad" setMarkerAlphaLocal 0;
    "Arsenal" setMarkerAlphaLocal 0;
    "Laptops" setMarkerAlphaLocal 0;
    "Vehicle_depot_1" setMarkerAlphaLocal 0;
    "Armor" setMarkerAlphaLocal 0;
    "UAVspawn" setMarkerAlphaLocal 0;
    "Arsenal_1" setMarkerAlphaLocal 0;
    "Helo_spawn" setMarkerAlphaLocal 0;
    "Side" setMarkerAlphaLocal 0;
    "m_mod" setMarkerAlphaLocal 0;
    "Repair_1" setMarkerAlphaLocal 0;
    "changeLoadout" setMarkerAlphaLocal 0;
    "Repair_2" setMarkerAlphaLocal 0;
    "Repair_2_1" setMarkerAlphaLocal 0;
    "B2" setMarkerAlphaLocal 0;
    "B2_1" setMarkerAlphaLocal 0;
    "med" setMarkerAlphaLocal 0;
    "vehService" setMarkerAlphaLocal 0;
};

// Remove color corrections effects
// In case they were not removed correctly during respawn
if (!isNil {BTC_blur}) then {ppEffectDestroy BTC_blur;};
if (!isNil {BTC_cc}) then {ppEffectDestroy BTC_cc;};
if (!isNil {BTC_grain}) then {ppEffectDestroy BTC_grain;};

// Remove earplugs on respawn
1 fadeSound 1;

// Don't show submenu actions on partizan arsenal box
adr_partizan_submenu = false;
