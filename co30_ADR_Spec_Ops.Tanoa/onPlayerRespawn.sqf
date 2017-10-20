private ["_pilots", "_btc_tk_prison", "_tk", "_rules", "_playerType", "_null"];

if (typeOf player in ["B_Soldier_SL_F", "B_T_Soldier_SL_F"]) then {
    player addAction ["<t color='#D8D80E'><img image='\A3\ui_f\data\gui\cfg\CommunicationMenu\call_ca.paa' size='1.0'/> Поддержка</t>", "scripts\commander\tools.sqf", "", -99, false, true];	// Commander tools
};
if (typeOf player in ["B_engineer_F", "B_T_Engineer_F"]) then {
    player addAction ["<t color='#D8D80E'>Вызвать AR-2 дартер</t>", QS_fnc_darter, "", -99, false, true];
    player addAction ["<t color='#D8D80E'>Вызвать AL-6 дартер</t>", QS_fnc_darterPelican, 0, -99, false, true];  
};
if (typeOf player in ["I_G_engineer_F"]) then {
    player addAction ["<t color='#D8D80E'>Вызвать AL-6 дартер</t>", QS_fnc_darterPelican, 1, -99, false, true];
};

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
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> M134 Minigun 7.62 mm[5000]; DAR[24]</t>", QS_fnc_actionChangeLoadout, 0, 99, false, true, "", "(typeOf (vehicle player) == 'I_Heli_light_03_F') && (((vehicle player) distance2D (getMarkerPos 'base_change_loadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Gatling 6.5 mm[2000]; GMG 40 mm[96]</t>", QS_fnc_actionChangeLoadout, 1, 98, false, true, "", "(typeOf (vehicle player) == 'I_Heli_light_03_F') && (((vehicle player) distance2D (getMarkerPos 'base_change_loadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Gatling Cannon 20 mm[1000]</t>", QS_fnc_actionChangeLoadout, 2, 97, false, true, "", "(typeOf (vehicle player) == 'I_Heli_light_03_F') && (((vehicle player) distance2D (getMarkerPos 'base_change_loadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	//Buzzard
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Zephyr[4]; ASRAAM[2]</t>", QS_fnc_actionChangeLoadout, 3, 96, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'base_change_loadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Skalpel ATGM[2]; ASRAAM[2]; GBU-12[2]</t>", QS_fnc_actionChangeLoadout, 4, 95, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'base_change_loadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; ASRAAM[2]; GBU-12[4]</t>", QS_fnc_actionChangeLoadout, 5, 94, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'base_change_loadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Skalpel ATGM[2]; GBU-12[4]</t>", QS_fnc_actionChangeLoadout, 6, 93, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'base_change_loadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Tratnyr AP[20]; ASRAAM[2]; GBU-12[2]</t>", QS_fnc_actionChangeLoadout, 7, 92, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'base_change_loadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Tratnyr HE[60]; ASRAAM[2]</t>", QS_fnc_actionChangeLoadout, 8, 91, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'base_change_loadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Skalpel ATGM[2]; Tratnyr HE[20]; ASRAAM[2]</t>", QS_fnc_actionChangeLoadout, 9, 90, false, true, "", "(typeOf (vehicle player) in ['I_Plane_Fighter_03_AA_F', 'I_Plane_Fighter_03_CAS_F']) && (((vehicle player) distance2D (getMarkerPos 'base_change_loadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
};

//====================== Clear vehicle inventory
inventory_cleared = false;
player addAction ["<t color='#2196F3'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_toolbox_modules_ca.paa' size='1.0'/> Освободить грузоотсек</t>", QS_fnc_actionClearInventory, "", -96, false, true, "", "[] call QS_fnc_conditionClearInventory"];

//====================== Earplugs
player addAction ["<t color='#FFEB3B'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa' size='1.0'/> Вставить беруши</t>", {1 fadeSound 0.25}, "", -95, false, true, "", "soundVolume == 1"];
player addAction ["<t color='#FFEB3B'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa' size='1.0'/> Вытащить беруши</t>", {1 fadeSound 1}, "", -95, false, true, "", "soundVolume != 1"];

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
0 enableChannel [false, false];
1 enableChannel [true, false];
2 enableChannel [false, false];
(RADIO_CHANNELS select 0) enableChannel [true, false];

// add sticky C4 event
_null = player addEventHandler ["Fired", {
    if (_this select 4 == "DemoCharge_Remote_Ammo") then {
        [_this select 0] call C4_Attach;
    };
}];

if (typeOf player in ["I_C_Soldier_Para_3_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_8_F"]) then {
	if (typeOf player in ["I_C_Soldier_Para_3_F"]) then {
	    player setUnitTrait ["Medic",true];
	};    
    "partizan_base" setMarkerAlphaLocal 1;
} else {
    "partizan_base" setMarkerAlphaLocal 0;
};

// add group leader
if (typeOf player in ["B_T_Soldier_SL_F","I_C_Soldier_Para_5_F"]) then {
    [group player, player] remoteExec ["selectLeader", groupOwner group player];
};

HAND_ITEM = nil;
_detachItems = ["B_IRStrobe","B_IR_Grenade","I_IRStrobe","I_IR_Grenade","Chemlight_red","Chemlight_yellow","Chemlight_green","Chemlight_blue"];
{
    _type = typeOf _x;
    if (_type in _detachItems) then {
        detach _x;
    };
} forEach attachedObjects player;
player setVariable ["IN_HAND", false, true];

// Add actions specific to resistance players
if (playerSide == resistance) then {
	// Take uniform from CSAT dead bodies
    player addAction ["<t color='#F44336'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\uniform_ca.paa' size='1.0'/> Одеть форму противника</t>","scripts\misc\getEnemyUniform.sqf",[],6,true,true,"",'((vehicle player) == player && (cursorObject isKindOf "O_Soldier_base_F" || cursorObject isKindOf "I_Soldier_base_F") && !alive cursorObject && !((uniform cursorObject) == "") && (player distance cursorObject) < 2 && animationState player != "ainvpknlmstpsnonwrfldnon_medic0s")'];

	// Take CSAT or Civilian uniform from GroundWeaponHolders
	player addAction ["<t color='#E91E63'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\uniform_ca.paa' size='1.0'/> Одеть форму противника</t>",QS_fnc_actionGetCargoUniform,[],6,true,true,"",'[] call QS_fnc_conditionGetCargoUniform'];

	// Open unconscious players inventory
    player addAction ["<t color='#FFC107'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\uniform_ca.paa' size='1.0'/> Обыскать</t>",{player action ["Gear", cursorTarget]},[],7,true,true,"",'((vehicle player) == player && (cursorObject getVariable "BTC_need_revive") == 1 && (player distance cursorObject) < 2 && animationState player != "ainvpknlmstpsnonwrfldnon_medic0s")'];
 
    // add IR grenade in hand
    player addAction ["Прицепить ИК гранату на плечо", QS_fnc_strobeUse,"I_IRStrobe",-999,false,false,"",' isNil "STROBE_ITEM" && "I_IR_Grenade" in (magazines player) && vehicle player == player '];
} else {
    
    // add IR grenade in hand
    player addAction ["Прицепить ИК гранату на плечо", QS_fnc_strobeUse,"B_IRStrobe",-999,false,false,"",' isNil "STROBE_ITEM" && "B_IR_Grenade" in (magazines player) && vehicle player == player '];
};

// Drop IR grenade action
player addAction ["Выбросить ИК гранату", {if (isNil "STROBE_ITEM" || isNull STROBE_ITEM) exitWith {};detach STROBE_ITEM;deleteVehicle (nearestObject [getpos STROBE_ITEM,"nvg_targetC"]);deleteVehicle STROBE_ITEM;STROBE_ITEM = nil;},"",-1001,false,false,"",'!isNil "STROBE_ITEM" && vehicle player == player '];

// Add chemlight actions
player addAction ["Взять химсвет (красный) в руки", QS_fnc_chemlightUse,"Chemlight_red",-999,false,false,"",'isNil "HAND_ITEM" && "Chemlight_red" in (magazines player) && vehicle player == player '];
player addAction ["Взять химсвет (желтый) в руки", QS_fnc_chemlightUse,"Chemlight_yellow",-999,false,false,"",'isNil "HAND_ITEM" && "Chemlight_yellow" in (magazines player) && vehicle player == player '];
player addAction ["Взять химсвет (зеленый) в руки", QS_fnc_chemlightUse,"Chemlight_green",-999,false,false,"",'isNil "HAND_ITEM" && "Chemlight_green" in (magazines player) && vehicle player == player '];
player addAction ["Взять химсвет (синий) в руки", QS_fnc_chemlightUse,"Chemlight_blue",-999,false,false,"",'isNil "HAND_ITEM" && "Chemlight_blue" in (magazines player) && vehicle player == player '];

// Move chemlight to body
player addAction ["Прицепить химсвет на плечо", {if (isNil "HAND_ITEM" || isNull HAND_ITEM) exitWith {};detach HAND_ITEM;HAND_ITEM attachTo [player, [0,0,0], "RightShoulder"];player setVariable ["IN_HAND", false, true];},"",-1000,false,false,"",'!isNil "HAND_ITEM" && vehicle player == player && player getVariable ["IN_HAND", false]'];

// Drop chemlight action
player addAction ["Выбросить химсвет", {if (isNil "HAND_ITEM" || isNull HAND_ITEM) exitWith {};detach HAND_ITEM;HAND_ITEM = nil;player setVariable ["IN_HAND", false, true];},"",-1001,false,false,"",'!isNil "HAND_ITEM" && vehicle player == player '];

// Weapon holster
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\holsterWeapon.sqf";};

// Unlock DLC vehicles
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\dlc_unlocker.sqf";};

// Deal with static map markers
if (playerSide == west) then {
    "partizan_base" setMarkerAlphaLocal 0;
	"partizan_vehicle" setMarkerAlphaLocal 0;
	"base_drone_service" setMarkerAlphaLocal 1;
	"base_aircraft_service" setMarkerAlphaLocal 1;
	"base_reward" setMarkerAlphaLocal 1;
	"base_change_loadout" setMarkerAlphaLocal 1;
	"base_helicopter_service" setMarkerAlphaLocal 1;
	"base_aircraft" setMarkerAlphaLocal 1;
	"base_helicopters" setMarkerAlphaLocal 1;
	"base_supply_modules_spawn" setMarkerAlphaLocal 1;
	"base_vehicles" setMarkerAlphaLocal 1;
	"base_armor" setMarkerAlphaLocal 1;
	"base_vehicle_service" setMarkerAlphaLocal 1;
	"base_helipad" setMarkerAlphaLocal 1;
	"base_dock" setMarkerAlphaLocal 1;
	"arsenal1" setMarkerAlphaLocal 1;
	"laptops1" setMarkerAlphaLocal 1;
	"arsenal2" setMarkerAlphaLocal 1;
	"laptops2" setMarkerAlphaLocal 1;
	"partizan_dock1" setMarkerAlphaLocal 0;
	"partizan_dock2" setMarkerAlphaLocal 0;
	"partizan_dock3" setMarkerAlphaLocal 0;
	"partizan_dock4" setMarkerAlphaLocal 0;
	"partizan_dock5" setMarkerAlphaLocal 0;
	"partizan_dock6" setMarkerAlphaLocal 0;
	"partizan_dock7" setMarkerAlphaLocal 0;
	"partizan_dock8" setMarkerAlphaLocal 0;
	"partizan_dock9" setMarkerAlphaLocal 0;
	"partizan_dock10" setMarkerAlphaLocal 0;
	"partizan_dock11" setMarkerAlphaLocal 0;
	"partizan_dock12" setMarkerAlphaLocal 0;
	"partizan_dock13" setMarkerAlphaLocal 0;
} else {
    "partizan_base" setMarkerAlphaLocal 1;
	"partizan_vehicle" setMarkerAlphaLocal 1;
	"arsenal1" setMarkerAlphaLocal 0;
	"laptops1" setMarkerAlphaLocal 0;
	"arsenal2" setMarkerAlphaLocal 0;
	"laptops2" setMarkerAlphaLocal 0;
	"base_drone_service" setMarkerAlphaLocal 0;
	"base_aircraft_service" setMarkerAlphaLocal 0;
	"base_reward" setMarkerAlphaLocal 0;
	"base_change_loadout" setMarkerAlphaLocal 0;
	"base_helicopter_service" setMarkerAlphaLocal 0;
	"base_aircraft" setMarkerAlphaLocal 0;
	"base_helicopters" setMarkerAlphaLocal 0;
	"base_supply_modules_spawn" setMarkerAlphaLocal 0;
	"base_vehicles" setMarkerAlphaLocal 0;
	"base_armor" setMarkerAlphaLocal 0;
	"base_vehicle_service" setMarkerAlphaLocal 0;
	"base_helipad" setMarkerAlphaLocal 0;
	"base_dock" setMarkerAlphaLocal 0;
	"partizan_dock1" setMarkerAlphaLocal 1;
	"partizan_dock2" setMarkerAlphaLocal 1;
	"partizan_dock3" setMarkerAlphaLocal 1;
	"partizan_dock4" setMarkerAlphaLocal 1;
	"partizan_dock5" setMarkerAlphaLocal 1;
	"partizan_dock6" setMarkerAlphaLocal 1;
	"partizan_dock7" setMarkerAlphaLocal 1;
	"partizan_dock8" setMarkerAlphaLocal 1;
	"partizan_dock9" setMarkerAlphaLocal 1;
	"partizan_dock10" setMarkerAlphaLocal 1;
	"partizan_dock11" setMarkerAlphaLocal 1;
	"partizan_dock12" setMarkerAlphaLocal 1;
	"partizan_dock13" setMarkerAlphaLocal 1;
};

// Remove color corrections effects
// In case they were not removed correctly during respawn
if (!isNil {BTC_blur}) then {ppEffectDestroy BTC_blur;};
if (!isNil {BTC_cc}) then {ppEffectDestroy BTC_cc;};
if (!isNil {BTC_cc_vig}) then {ppEffectDestroy BTC_cc_vig;};
if (!isNil {BTC_grain}) then {ppEffectDestroy BTC_grain;};

// Remove earplugs on respawn
1 fadeSound 1;

// Don't show submenu actions on partizan arsenal box
adr_partizan_submenu = false;

// Add player to Zeus curators as editable objects
[player] remoteExec ["QS_fnc_addCurators", 2];