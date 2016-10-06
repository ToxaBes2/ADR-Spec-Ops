/*
@filename: initPlayerLocal.sqf
Author:	Quiksilver
Description: Client scripts and event handlers.
*/

if (!hasInterface) exitWith {};

private ["_partizanPos", "_dist", "_accepted", "_newPlayerPos", "_dir", "_null", "_player", "_vehicle", "_helmet", "_csatHelmets", "_array", "_type", "_message", "_GHint", "_profileName"];

enableSentences false;
enableEngineArtillery false;

waitUntil {!isNull player};

// Resistance only
if (playerSide == resistance) then {
	player setUnitTrait ["Medic", true];
	0 cutText["Проверка игрового времени...", "BLACK FADED"];
    0 cutFadeOut 9999999;
    waitUntil {(getPlayerUID player) != ""};
    removeAllweapons player;
	removevest player;
	removeBackpack player;
	removeheadgear player;
	removegoggles player;
	removeBackPack player;
	{player removeItem _x} foreach (items player);
	{player unassignItem _x; player removeItem _x} foreach (assignedItems player);
	sleep 1;
    _partizanPos = getMarkerPos "partizan_base";
	_dist = 6;
    _accepted = false;
	_newPlayerPos = _partizanPos findEmptyPosition [1, _dist, "I_G_engineer_F"];
	if (count _newPlayerPos > 0) then {
        _accepted = true;
    };
	while {!_accepted} do {
		_dist = _dist + 2;
        _newPlayerPos = _partizanPos findEmptyPosition [1, _dist, "I_G_engineer_F"];
        if (count _newPlayerPos > 0) then {
            _accepted = true;
        };
    };
    player setPos _newPlayerPos;
	_dir = player getDir partizan_ammo;
	player setDir _dir;
	["getPlayerHours",[getPlayerUID player], player] remoteExec ["sqlServerCall", 2];
    sleep 10;

	// Resistance engineers only
	if (typeOf player in ["I_G_engineer_F","I_C_Soldier_Para_8_F"]) then {
		player setUnitTrait ["UAVHacker", true];
		player setUnitTrait ["engineer", true];
	};

	hqSideChat = "Разведка сообщила об увеличении активности партизан на острове.";
	publicVariable "hqSideChat";
	[west, "HQ"] sideChat hqSideChat;
} else {
	"partizan_vehicle" setMarkerAlphaLocal 0;
};

// Pilots only
if (typeOf player in ["B_Helipilot_F", "B_T_Helipilot_F"]) then {
	player addBackpack "B_AssaultPack_sgg";
	player addItemToBackpack "ToolKit";

	// check hours on server for become a pilot
    ["getPilotHours",[getPlayerUID player], player] remoteExec ["sqlServerCall", 2];
    sleep 10;

	// Laser targets on pilots HMDs
	player addEventHandler [ "GetInMan", {
		[_this select 0, _this select 2] spawn QS_fnc_HMDLaserTarget;
	}];
};

// Client executions
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\vehicle\crew\crew.sqf";}; 							// vehicle HUD
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\restrictions.sqf";}; 								// gear restrictions
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\pilotCheck.sqf";};									// pilots only
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\jump.sqf";};										// jump action
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\misc\diary.sqf";};									// diary tabs
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\icons.sqf";};										// blufor map tracker
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\admin_uid.sqf";};                                   // Admin tools
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\3rd_view_restrictions.sqf";};                       // 3rd view restrictions
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\heliRearRamp.sqf";};                                // Block rear ramp actions for non-pilots
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\stickyC4\stickycharge.sqf";};                       // Sticky C4 logic
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\vehicle\tow\tow.sqf";};                             // TOW script

if (typeOf player in ["B_Soldier_SL_F", "B_T_Soldier_SL_F"]) then {
    _null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\menu.sqf";};                          // Commander tools
};

// UAV operator tools
if (typeOf player in ["B_engineer_F", "B_T_Engineer_F"]) then {
    player addAction ["<t color='#D8D80E'><img image='\A3\Drones_F\Air_F_Gamma\UAV_01\Data\UI\icon_B_C_UAV_rgr_ca.paa' size='1.0'/> Вызвать AR-2 дартер</t>", "scripts\darter.sqf", "", -99, false, true, "", ""];	
};

if !(isNil "EW_ATTACK") then {
    if (EW_ATTACK) then {
        _null = [] spawn {_this call QS_fnc_EWattack;};                                                                      // priority EW
    };
};

// Color correction (disabled because ugly after v1.6)
//["EastWind", 0, false] call BIS_fnc_setPPeffectTemplate;

// Put earplugs on when entering a helicopter or VTOL
player addEventHandler [ "GetInMan", {
    [_this select 0, _this select 2] spawn {
        private ["_player", "_vehicle"];
        _player  = _this select 0;
        _vehicle = _this select 1;
        if ((_vehicle isKindOf "Air")) then {
            1 fadeSound 0.33;
            waitUntil {
                sleep 5;
                vehicle _player != _vehicle;
            };
			if (soundVolume != 1) then {
			    1 fadeSound 1;
			};
        };
    };
}];

// Put earplugs out after leaving any vehicle
player addEventHandler [ "GetOutMan", {
	if (soundVolume != 1) then {
		1 fadeSound 1;
	};
}];

// Put earplugs in automaticly when controling UAV (Engineers only)
if (typeOf player in ["B_engineer_F", "B_T_Engineer_F", "I_G_engineer_F", "I_C_Soldier_Para_8_F"]) then {
	_null = [] spawn {
		private ["_uav", "_uav_action_id1", "_uav_action_id2"];
		while {true} do {
			if ((typeOf cameraOn) in ["B_UAV_01_F","B_UAV_02_F","B_UAV_02_CAS_F","B_UGV_01_F","B_UGV_01_rcws_F","I_UAV_01_F","I_UAV_02_F","I_UAV_02_CAS_F","I_UGV_01_F","I_UGV_01_rcws_F","O_UAV_01_F","O_UAV_02_F","O_UAV_02_CAS_F","O_UGV_01_F","O_UGV_01_rcws_F","B_T_UAV_03_F","O_T_UAV_04_CAS_F"]) then {
				_uav = cameraOn;
				1 fadeSound 0.33;
				_uav_action_id1 = _uav addAction ["<t color='#FFEB3B'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa' size='1.0'/> Вставить беруши</t>", {1 fadeSound 0.33}, "", -95, false, true, "", "soundVolume == 1"];
				_uav_action_id2 = _uav addAction ["<t color='#FFEB3B'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa' size='1.0'/> Вытащить беруши</t>", {1 fadeSound 1}, "", -95, false, true, "", "soundVolume != 1"];
				while {cameraOn == _uav} do {
					sleep 5;
				};
				1 fadeSound 1;
				_uav removeAction _uav_action_id1;
				_uav removeAction _uav_action_id2;
			};
		    sleep 5;
		};
	};
};

// Remove CSAT helmets from BLUFOR players iventory
if (playerSide == west) then {
	player addEventHandler [ "Take", {
		_player = _this select 0;
		_item = _this select 2;
		_catched = false;
		_csatHelmets = ["H_Cap_brn_SPECOPS", "H_CrewHelmetHeli_O", "H_HelmetCrew_O", "H_HelmetCrew_O_ghex_F", "H_HelmetLeaderO_ghex_F", "H_HelmetLeaderO_ocamo", "H_HelmetLeaderO_oucamo", "H_HelmetO_ViperSP_ghex_F", "H_HelmetO_ViperSP_hex_F", "H_HelmetO_ghex_F", "H_HelmetO_ocamo", "H_HelmetO_oucamo", "H_HelmetSpecO_blk", "H_HelmetSpecO_ghex_F", "H_HelmetSpecO_ocamo", "H_MilCap_ghex_F", "H_MilCap_ocamo", "H_PilotHelmetFighter_O", "H_PilotHelmetHeli_O"];
		if(_item in _csatHelmets) then {
			_player unassignItem _item;
			_player removeItem _item;
			systemChat "Головные уборы противника запрещены";
			_catched = true;
		};
        if (!_catched) then {
		    _backpacks = ["B_UAV_01_backpack_F", "O_UAV_01_backpack_F", "I_UAV_01_backpack_F"];
            if(_item in _backpacks) then {
		    	removeBackpack _player;
		    	systemChat "Рюкзаки с беспилотниками запрещены";
		    	_catched = true;
		    };	
		};
		if (!_catched) then {
		    _backpacks = ["B_ViperLightHarness_ghex_F","B_ViperLightHarness_khk_F","B_ViperHarness_ghex_F","B_Bergen_tna_F","B_Carryall_ghex_F","B_AssaultPack_tna_F","B_FieldPack_ghex_F"];
            if(_item in _backpacks) then {
		    	removeBackpack _player;
		    	systemChat "Рюкзаки противника запрещены";
		    	_catched = true;
		    };	
		};
		if (!_catched) then {
		    _vests = ["V_PlateCarrierIAGL_oli","V_PlateCarrierIAGL_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIA1_dgtl","V_HarnessOSpec_gry","V_HarnessOSpec_brn","V_HarnessOGL_gry","V_HarnessO_gry","V_HarnessOGL_brn","V_HarnessO_brn","V_Chestrig_khk","V_Rangemaster_belt","V_BandollierB_khk","V_BandollierB_cbr","V_BandollierB_rgr","V_BandollierB_blk","V_BandollierB_oli","V_PlateCarrierIAGL_oli","V_I_G_resistanceLeader_F","V_RebreatherIA","V_TacChestrig_cbr_F","V_HarnessOGL_ghex_F","V_BandollierB_ghex_F"];
            if(_item in _vests) then {
		    	removeVest _player;
		    	systemChat "Жилеты противника запрещены";
		    	_catched = true;
		    };	
		};
	}];
};

// hide arsenal load buttons for partizans
if (playerSide == resistance) then {
    [missionNamespace, "arsenalOpened", {
        disableSerialization;
        _display = _this select 0;
        _display displayAddEventHandler ["KeyDown", "if ((_this select 1) in [19,29]) then {true}"];
        {
            ( _display displayCtrl _x ) ctrlSetText "Disabled";
            ( _display displayCtrl _x ) ctrlSetTextColor [ 1, 0, 0, 0.5 ];
            ( _display displayCtrl _x ) ctrlRemoveAllEventHandlers "buttonclick";
        }forEach [ 44146, 44147, 44150 ];
    }] call BIS_fnc_addScriptedEventHandler;
};

// Add all players to Zeus curators as editable objects
{
	_x addCuratorEditableObjects [[player], false];
} count allCurators;

// PVEHs
"showNotification" addPublicVariableEventHandler {
	private ["_array", "_type", "_message", "_side"];
	_array = _this select 1;
	_type = _array select 0;
	_message = "";
	if (count _array > 1) then {_message = _array select 1;};
	if ((typeName _message) != "ARRAY") then {_message = [_message];};
	if (count _array > 2) then {
		_side = _array select 2;
		if (playerSide == _side) then {
			[_type, _message] call BIS_fnc_showNotification;
		};
	} else {
		[_type, _message] call BIS_fnc_showNotification;
	};
};

"GlobalHint" addPublicVariableEventHandler {
	private ["_GHint"];
	_GHint = _this select 1;
	hint parseText format["%1", _GHint];
};

"GlobalSideHint" addPublicVariableEventHandler {
	private ["_data", "_side", "_GHint"];
	_data = _this select 1;
	_side = _data select 0;
	_GHint = parseText format["%1", (_data select 1)];
	_GHint remoteExec ["hint", _side];
};

"hqSideChat" addPublicVariableEventHandler {
	private ["_message", "_array", "_side"];
	if (typeName (_this select 1) == "STRING") then {
		_message = _this select 1;
		[playerSide, "HQ"] sideChat _message;
	};
	if (typeName (_this select 1) == "ARRAY") then {
		_array = _this select 1;
		_message = _array select 0;
		_side = _array select 1;
		if (playerSide == _side) then {
			[_side, "HQ"] sideChat _message;
		};
	};
};

"addToScore" addPublicVariableEventHandler {
	((_this select 1) select 0) addScore ((_this select 1) select 1);
};

"sideMarker" addPublicVariableEventHandler {
	"sideMarker" setMarkerPosLocal (markerPos "sideMarker");
	"sideCircle" setMarkerPosLocal (markerPos "sideCircle");
	if (count sideMarkerText == 2) then {
        "sideMarker" setMarkerTextLocal format["%1", sideMarkerText select 0];
	} else {
        "sideMarker" setMarkerTextLocal format["Допзадание: %1", sideMarkerText];
    };
};

"priorityMarker" addPublicVariableEventHandler {
	"priorityMarker" setMarkerPosLocal (markerPos "priorityMarker");
	"priorityCircle" setMarkerPosLocal (markerPos "priorityCircle");
	"priorityMarker" setMarkerTextLocal format["Вторичная цель: %1", priorityTargetText];
};

// disable channels
0 enableChannel [false, false];
1 enableChannel [true, false];
2 enableChannel [false, false];

// log playable hours
_uid = getPlayerUID player;
_profileName = profileName;
_null = [_uid, _profileName] spawn {
	_uid = _this select 0;
	_profileName = _this select 1;
	sleep 300;
	while {true} do {
        ["insertPlayer",[_uid, _profileName], player] remoteExec ["sqlServerCall", 2];
        sleep 5;
        ["logTime",[_uid], player] remoteExec ["sqlServerCall", 2];
        sleep 295;
    };
};
