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

[] spawn {
	disableSerialization;
	waitUntil {!isNull(findDisplay 46)};
	(findDisplay 46) displayAddEventHandler ["keyDown", "_this call QS_fnc_KeyDown"];
};

// Resistance only
if (playerSide == resistance) then {	
	0 cutText["Проверка игрового времени...", "BLACK FADED"];
    0 cutFadeOut 9999999;
    waitUntil {(getPlayerUID player) != ""};
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
    [player] call QS_fnc_addPartizanItems;
    player setPos _newPlayerPos;
	_dir = player getDir partizan_ammo;
	player setDir _dir;
	["getPlayerHours",[getPlayerUID player], player] remoteExec ["sqlServerCall", 2];
    sleep 10;

	// Resistance engineers only
	if (typeOf player in ["I_G_engineer_F"]) then {
		player setUnitTrait ["UAVHacker", true];
		player setUnitTrait ["engineer", true];
	};
	if (typeOf player in ["I_G_medic_F"]) then {
	    player setUnitTrait ["Medic", true];
    };

	hqSideChat = "Разведка сообщила об увеличении активности партизан на острове.";
	publicVariable "hqSideChat";
	[west, "HQ"] sideChat hqSideChat;
} else {
	"partizan_vehicle" setMarkerAlphaLocal 0;
};

// Pilots only
if (typeOf player in ["B_Helipilot_F"]) then {
	player addBackpack "B_AssaultPack_sgg";
	player addItemToBackpack "ToolKit";

	// check hours on server for become a pilot
	0 cutText["Проверка игрового времени...", "BLACK FADED"];
    0 cutFadeOut 9999999;
    waitUntil {(getPlayerUID player) != ""};
    ["getPilotHours",[getPlayerUID player], player] remoteExec ["sqlServerCall", 2];
    sleep 10;

	// Laser targets on pilots HMDs
	player addEventHandler [ "GetInMan", {
		[_this select 0, _this select 2] spawn QS_fnc_HMDLaserTarget;
	}];

	// Disable thermal vision on targeting pods during the day
	//player addEventHandler [ "GetInMan", {
	//	[_this select 0, _this select 2] spawn QS_fnc_CheckVisionMode;
	//}];
};

// Client executions
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\vehicle\crew\crew.sqf";}; 							// vehicle HUD
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\pilotCheck.sqf";};									// pilots only
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\misc\diary.sqf";};									// diary tabs
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\icons.sqf";};										// blufor map tracker
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\3rd_view_restrictions.sqf";};                       // 3rd view restrictions
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\heliRearRamp.sqf";};                                // Block rear ramp actions for non-pilots
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\stickyC4\stickycharge.sqf";};                       // Sticky C4 logic
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\vehicle\tow\tow.sqf";};                             // TOW script
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\admin_uid.sqf";};                                   // Admin tools
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\shutDownThermal.sqf";};                             // Disable thermal mode for Viper's helmet and ENVG-II goggles
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\holsterWeapon.sqf";};                               // Weapon holster 
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
if (typeOf player in ["B_engineer_F", "I_G_engineer_F"]) then {
	_null = [] spawn {
		private ["_uav", "_uav_action_id1", "_uav_action_id2"];
		while {true} do {
			if ((typeOf cameraOn) in ["B_UAV_01_F","B_UGV_01_F","B_UGV_01_rcws_F","B_UAV_05_F","I_UAV_01_F","I_UAV_02_F","I_UAV_02_CAS_F","I_UGV_01_F","I_UGV_01_rcws_F","O_UAV_01_F","O_UAV_02_F","O_UAV_02_CAS_F","O_UGV_01_F","O_UGV_01_rcws_F","B_T_UAV_03_F","O_T_UAV_04_CAS_F","B_T_UAV_03_dynamicLoadout_F"]) then {
				_uav = cameraOn;
				1 fadeSound 0.33;
				_uav_action_id1 = _uav addAction ["<t color='#FFEB3B'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa' size='1.0'/> Вставить беруши</t>", {1 fadeSound 0.33}, "", -95, false, true, "", "soundVolume == 1"];
				_uav_action_id2 = _uav addAction ["<t color='#FFEB3B'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa' size='1.0'/> Вытащить беруши</t>", {1 fadeSound 1}, "", -95, false, true, "", "soundVolume != 1"];
                _uav_action_id3 = _uav addAction ["<t color='#FFEB3B'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\top_close_gs.paa' size='1.0'/> Уничтожить беспилотник</t>", {(_this select 0) setDamage 1}, "", -99, false];                                                
                while {cameraOn == _uav} do {
					sleep 5;
				};
				1 fadeSound 1;
				_uav removeAction _uav_action_id1;
				_uav removeAction _uav_action_id2;
                _uav removeAction _uav_action_id3;
			};
		    sleep 5;
		};
	};
};

// Add restrictions for BLUFOR players
if (playerSide == west) then {
	player addEventHandler ["InventoryClosed", {
	    [(_this select 0)] call QS_fnc_applyRestrictionsWest;
    }];
    player addEventHandler ["ContainerClosed", {
	    [(_this select 1)] call QS_fnc_applyRestrictionsWest;
    }];
    player addEventHandler ["Take", {
	    [(_this select 0)] call QS_fnc_applyRestrictionsWest;
    }];
    [missionNamespace, "arsenalClosed", {
        if (playerSide == west) then {
           [player, true] call QS_fnc_applyRestrictionsWest;
        };        
    }] call BIS_fnc_addScriptedEventHandler;
    [missionNamespace, "arsenalOpened", {
        disableSerialization;
        _display = _this select 0;
        _display displayAddEventHandler ["KeyDown", "if ((_this select 1) in [19,24,29,31,46,47]) then {true}"];
        {
            ( _display displayCtrl _x ) ctrlSetText "";
            ( _display displayCtrl _x ) ctrlRemoveAllEventHandlers "buttonclick";
        } forEach [ 44150 ];
    }] call BIS_fnc_addScriptedEventHandler;

    if (isNil "ARSENAL_ENABLED") then {
        ARSENAL_ENABLED = true;
        publicVariable "ARSENAL_ENABLED";
    };
    
    // clear items from unit on first load
    if !(ARSENAL_ENABLED) then {
        removeAllweapons player;
        removeBackpack player;
        removeVest player;
        removeHeadgear player;
        {player removeItem _x} foreach (items player);
    };
};

// hide arsenal load buttons for partizans and add restrictions
if (playerSide == resistance) then {
	player addEventHandler ["InventoryClosed", {
	    [(_this select 0)] call QS_fnc_applyRestrictionsResistance;
    }];
    player addEventHandler ["ContainerClosed", {
	    [(_this select 1)] call QS_fnc_applyRestrictionsResistance;
    }];
    player addEventHandler ["Take", {
	    [(_this select 0)] call QS_fnc_applyRestrictionsResistance;
    }];
    [missionNamespace, "arsenalClosed", {
        if (playerSide == resistance) then {
           [player, true] call QS_fnc_applyRestrictionsResistance;
        };        
    }] call BIS_fnc_addScriptedEventHandler;
    [missionNamespace, "arsenalOpened", {
        disableSerialization;
        _display = _this select 0;
        _display displayAddEventHandler ["KeyDown", "if ((_this select 1) in [19,24,29,31,46,47]) then {true}"];
        {
            ( _display displayCtrl _x ) ctrlSetText "";
            ( _display displayCtrl _x ) ctrlRemoveAllEventHandlers "buttonclick";
        } forEach [ 44146, 44147, 44150 ];
    }] call BIS_fnc_addScriptedEventHandler;
};

// Add player to Zeus curators as editable objects
[player] remoteExec ["QS_fnc_addCurators", 2];

// Add custom name tags
TAGS = addMissionEventHandler ["Draw3D", {
    _target = cursorTarget;
    if (alive _target) then {    	
        if (_target isKindOf "MAN") then { 
            _show = false;
            if (side _target == playerSide) then {
                _show = true;
            } else {
                _diplomacyPartizan = partizan_ammo getVariable ["DIPLOMACY", 0];
                _diplomacyBlufor = base_arsenal_infantry getVariable ["DIPLOMACY", 0];
                if (_diplomacyPartizan == 1 && _diplomacyBlufor == 1 && (side _target == west || side _target == resistance)) then {
                    _show = true;
                };
            };
            if (_show) then {
                _nametagPos = visiblePosition _target;
    	        _dist = (player distance _target) / 30;
                _color = [0.24,0.91,0.22,1];
                if (side _target == WEST) then {
                    _color = [0,0.5,1,1];
                };           
                _color set [3, 1 - _dist]; 
                _size = 0.035 - (_dist/3000);
                _text = "";          
                _nametagPos set [2, 
                    (_nametagPos select 2) + ((_target modelToWorld (_target selectionPosition 'body')) select 2) - 0.1
                ];
                _role = roleDescription _target;            
                if (_role == "") then {
                    _text = format ["%1", name _target];
                } else {
                    _text = format ["%1 (%2)", name _target, _role];
                };               
                drawIcon3D ["", _color, _nametagPos, 0, 0, 0, _text, 2, _size, "PuristaSemiBold"];
            };
        } else {
            if ({_target isKindOf _x;} count ["AIR","CAR","SHIP","TANK"] > 0) then {
            	_unitsCount = count (crew _target);
            	if (_unitsCount > 0) then {
            		_show = false;
                    if (side _target == playerSide) then {
                        _show = true;
                    } else {
                        _diplomacyPartizan = partizan_ammo getVariable ['DIPLOMACY', 0];
                        _diplomacyBlufor = base_arsenal_infantry getVariable ["DIPLOMACY", 0];
                        if (_diplomacyPartizan == 1 && _diplomacyBlufor  == 1 && (side _target == west || side _target == resistance)) then {
                            _show = true;
                        };
                    };
                    if (_show) then {
            		    _nametagPos = visiblePosition _target;
    	                _dist = (player distance _target) / 30;
                        _color = [0.24,0.91,0.22,1];
                        if (side _target == WEST) then {
                            _color = [0,0.5,1,1];
                        };           
                        _color set [3, 1 - _dist]; 
                        _size = 0.035 - (_dist/3000);
                        _text = "";
            		    _nametagPos set [2, 
                           (_nametagPos select 2) + ((_target modelToWorld (_target selectionPosition 'body')) select 2) - 0.2
                        ];
            	        _name = "";            	    
            	        if (alive (driver _target)) then {	
				            _name = name (driver _target);
                        } else {
                            if (alive (commander _target)) then {	
			                   _name = name (commander _target);
			                } else {
                                if (alive (gunner _target)) then {
                                   _name = name (gunner _target);
			                    } else {
                                    _name = name ((crew _target) select 0);
			                    };
			                };
                        };          	    
			            if (_unitsCount > 1) then {
			                _name = format ["%1 (+%2)", _name, (_unitsCount - 1)];
			            };
                        _text = format ["%1: %2", getText(configFile >> "CfgVehicles" >> (typeOf _target) >> "DisplayName"), _name];             
                        drawIcon3D ["", _color, _nametagPos, 0, 0, 0, _text, 2, _size, "PuristaSemiBold"];
                    };
                };
            };
        };       
    };
}];

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

// Set initial view distance to 1 km
setViewDistance 1000;
setObjectViewDistance [1000,50];
