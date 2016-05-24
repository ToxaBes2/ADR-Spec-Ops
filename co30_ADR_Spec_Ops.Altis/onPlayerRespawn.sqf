private ["_pilots", "_iampilot", "_btc_tk_prison"];

//=========================== PILOTS ONLY
_pilots = ["B_Helipilot_F", "O_helipilot_F"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;

if (_iampilot) then {
	//===== HELI TURRETS LOCK
	player addAction ["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Разрешить стрельбу</t>", QS_fnc_uh80TurretActions, 0, -95, false, false, '', '[] call QS_fnc_conditionUH80TurretActionUnlock'];
	player addAction ["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Запретить стрельбу</t>", QS_fnc_uh80TurretActions, 1, -95, false, false, '', '[] call QS_fnc_conditionUH80TurretActionLock'];

	//===== FIELD REPAIR
	vehicle_repaired = false;
	player addAction ["<t color='#FFC107'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_debug_ca.paa' size='1.0'/> Полевой ремонт</t>", QS_fnc_actionPilotRepair, '', 100, false, false, '', '[] call QS_fnc_conditionPilotRepair'];

	//===== Aircraft weapon loadout selection
	//Hellcat
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> M134 Minigun 7.62 mm[5000]; DAR[24]</t>", QS_fnc_actionChangeLoadout, 0, 99, false, false, "", "(typeOf (vehicle player) == 'I_Heli_light_03_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Gatling 6.5 mm[2000]; GMG 40 mm[96]</t>", QS_fnc_actionChangeLoadout, 1, 98, false, false, "", "(typeOf (vehicle player) == 'I_Heli_light_03_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Gatling Cannon 20 mm[1000]</t>", QS_fnc_actionChangeLoadout, 2, 97, false, false, "", "(typeOf (vehicle player) == 'I_Heli_light_03_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	//Buzzard
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Zephyr[4]; ASRAAM[2]</t>", QS_fnc_actionChangeLoadout, 3, 96, false, false, "", "(typeOf (vehicle player) == 'I_Plane_Fighter_03_AA_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Skalpel ATGM[2]; ASRAAM[2]; GBU-12[2]</t>", QS_fnc_actionChangeLoadout, 4, 95, false, false, "", "(typeOf (vehicle player) == 'I_Plane_Fighter_03_AA_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; ASRAAM[2]; GBU-12[4]</t>", QS_fnc_actionChangeLoadout, 5, 94, false, false, "", "(typeOf (vehicle player) == 'I_Plane_Fighter_03_AA_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Skalpel ATGM[2]; GBU-12[4]</t>", QS_fnc_actionChangeLoadout, 6, 93, false, false, "", "(typeOf (vehicle player) == 'I_Plane_Fighter_03_AA_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Tratnyr AP[20]; ASRAAM[2]; GBU-12[2]</t>", QS_fnc_actionChangeLoadout, 7, 92, false, false, "", "(typeOf (vehicle player) == 'I_Plane_Fighter_03_AA_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Tratnyr HE[60]; ASRAAM[2]</t>", QS_fnc_actionChangeLoadout, 8, 91, false, false, "", "(typeOf (vehicle player) == 'I_Plane_Fighter_03_AA_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
	player addAction["<t color='#FFC107'><img image='\a3\ui_f\data\map\VehicleIcons\iconplane_ca.paa' size='1.0'/> Twin Cannon 20mm[300]; Skalpel ATGM[2]; Tratnyr HE[20]; ASRAAM[2]</t>", QS_fnc_actionChangeLoadout, 9, 90, false, false, "", "(typeOf (vehicle player) == 'I_Plane_Fighter_03_AA_F') && (((vehicle player) distance2D (getMarkerPos 'changeLoadout')) < 7) && ((getPos (vehicle player) select 2) < 1) && (driver (vehicle player) == player) && (isNil 'ADR_aircraftChangeLoadout')"];
};

//====================== Clear vehicle inventory
inventory_cleared = false;
player addAction ["<t color='#2196F3'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_toolbox_modules_ca.paa' size='1.0'/> Освободить грузоотсек</t>", QS_fnc_actionClearInventory, '', -96, false, false, '', '[] call QS_fnc_conditionClearInventory'];

//====================== Magazine Repack
player addAction ["<t color='#84FFFF'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargomag_ca.paa' size='1.0'/> " + localize "STR_ADR_MagRepack" + "</t>", QS_fnc_actionMagRepack, '', -97, false, false, ''];

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

// add sticky C4 event
_null = player addEventHandler ["Fired", {
    if (_this select 4 == "DemoCharge_Remote_Ammo") then {
        [_this select 0] call C4_Attach;
    };
}];

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
