private ["_iampilot", "_btc_tk_prison"];

//=========================== PILOTS ONLY
_pilots = ["B_Helipilot_F", "O_helipilot_F"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;

if (_iampilot) then {
	//===== HELI TURRETS LOCK
	player addAction ["<t color='#FF9800'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Разрешить стрельбу</t>", QS_fnc_uh80TurretActions, [0], -95, false, false, '', '[] call QS_fnc_conditionUH80TurretActionUnlock'];
	player addAction ["<t color='#FF9800'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Запретить стрельбу</t>", QS_fnc_uh80TurretActions, [1], -95, false, false, '', '[] call QS_fnc_conditionUH80TurretActionLock'];

	//===== FIELD REPAIR
	vehicle_repaired = false;
	player addAction ["<t color='#FF9800'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_debug_ca.paa' size='1.0'/> Полевой ремонт</t>", QS_fnc_actionPilotRepair, [1], 100, false, false, '', '[] call QS_fnc_conditionPilotRepair'];
};

//====================== Clear vehicle inventory
inventory_cleared = false;
player addAction ["<t color='#2196F3'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_toolbox_modules_ca.paa' size='1.0'/> Освободить грузоотсек</t>", QS_fnc_actionClearInventory, [], -96, false, false, '', '[] call QS_fnc_conditionClearInventory'];

//====================== Magazine Repack
player addAction ["<t color='#84FFFF'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargomag_ca.paa' size='1.0'/> " + localize "STR_ADR_MagRepack" + "</t>", QS_fnc_actionMagRepack, [], -97, false, false, ''];

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

// Hide objects near heli landing
((getMarkerPos "respawn_west") nearestObject 492374) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492375) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492438) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492359) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492364) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492365) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492366) hideObject true;