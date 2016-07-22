/*
@filename: initPlayerLocal.sqf
Author:	Quiksilver
Description: Client scripts and event handlers.
*/
if (!hasInterface) exitWith {};
enableSentences false;
enableEngineArtillery false;

// check for guerrila slots
waitUntil {!isNull player};
_guers = ["I_G_Soldier_LAT_F","I_G_Soldier_AR_F","I_G_Soldier_M_F","I_G_medic_F"];
_iamguer = ({typeOf player == _x} count _guers) > 0;
if (_iamguer) then {
	0 cutText["Проверка игрового времени...", "BLACK FADED"];
    0 cutFadeOut 9999999;
    waitUntil {(getPlayerUID player) != ""};
    _uid = getPlayerUID player;                
    _clientId = owner player;      
    removeAllweapons player;
	//removeuniform player;
	removevest player;
	removeheadgear player;
	removegoggles player;
	removeBackPack player;
	{player removeItem _x} foreach (items player);
	{player unassignItem _x;player removeItem _x} foreach (assignedItems player);
	["getPlayerHours",[_uid], _clientId] remoteExec ["sqlServerCall", 2]; 
    sleep 10;    
};	

// Pilots only
_pilots = ["B_Helipilot_F", "O_helipilot_F"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;
if (_iampilot) then {
	player addBackpack "B_AssaultPack_sgg";
	player addItemToBackpack "ToolKit";

	//==== LASER TARGETS ON PILOTS HELMETS
	player addEventHandler [ "GetInMan", {
		[_this select 0, _this select 2] spawn QS_fnc_HMDLaserTarget;
	}];
};

// Client executions
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\vehicle\crew\crew.sqf";}; 							// vehicle HUD
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\restrictions.sqf";}; 								// gear restrictions
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\VAS\config.sqf";}; 									// VAS
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\pilotCheck.sqf";};									// pilots only
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\jump.sqf";};										// jump action
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\misc\diary.sqf";};									// diary tabs
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\icons.sqf";};										// blufor map tracker
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\VAclient.sqf";};									// Virtual Arsenal
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\admin_uid.sqf";};                                   // Admin tools
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\3rd_view_restrictions.sqf";};                       // 3rd view restrictions
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\heliRearRamp.sqf";};                                // Block rear ramp actions for non-pilots
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\stickyC4\stickycharge.sqf";};                       // Sticky C4 logic
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\vehicle\tow\tow.sqf";};                             // TOW script

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
        if ((_vehicle isKindOf "Helicopter") or (_vehicle isKindOf "VTOL_Base_F")) then {
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

// Remove CSAT helmets from iventory
player addEventHandler [ "Take", {
	_player = _this select 0;
	_helmet = _this select 2;
	_csatHelmets = ["H_HelmetO_ocamo", "H_Beret_ocamo", "H_MilCap_ocamo", "H_HelmetLeaderO_ocamo", "H_PilotHelmetHeli_O", "H_HelmetCrew_O", "H_PilotHelmetFighter_O", "H_CrewHelmetHeli_O", "H_HelmetSpecO_ocamo", "H_HelmetSpecO_blk", "H_HelmetO_oucamo", "H_HelmetLeaderO_oucamo"];
	if(_helmet in _csatHelmets && side _player == west) then {
		_player unassignItem _helmet;
		_player removeItem _helmet;
		systemChat "Головные уборы противника запрещены";
	};
}];

// PVEHs
"showNotification" addPublicVariableEventHandler
{
	private ["_array", "_type", "_message"];
	_array = _this select 1;
	_type = _array select 0;
	_message = "";
	if (count _array > 1) then { _message = _array select 1;};
	if ((typeName _message) != "ARRAY") then {_message = [_message];};
	[_type, _message] call BIS_fnc_showNotification;
};

"GlobalHint" addPublicVariableEventHandler
{
	private ["_GHint"];
	_GHint = _this select 1;
	hint parseText format["%1", _GHint];
};

"hqSideChat" addPublicVariableEventHandler
{
	_message = _this select 1;
	[WEST, "HQ"] sideChat _message;
	[resistance, "HQ"] sideChat _message;
};

"addToScore" addPublicVariableEventHandler
{
	((_this select 1) select 0) addScore ((_this select 1) select 1);
};

"sideMarker" addPublicVariableEventHandler
{
	"sideMarker" setMarkerPosLocal (markerPos "sideMarker");
	"sideCircle" setMarkerPosLocal (markerPos "sideCircle");
	if (count sideMarkerText == 2) then {
        "sideMarker" setMarkerTextLocal format["%1", sideMarkerText select 0];
	} else {
        "sideMarker" setMarkerTextLocal format["Допзадание: %1", sideMarkerText];
    };
};

"priorityMarker" addPublicVariableEventHandler
{
	"priorityMarker" setMarkerPosLocal (markerPos "priorityMarker");
	"priorityCircle" setMarkerPosLocal (markerPos "priorityCircle");
	"priorityMarker" setMarkerTextLocal format["Вторичная цель: %1",priorityTargetText];
};

// disable arsenal load/save/random features for all
[missionNamespace, "arsenalOpened", {
    disableSerialization;
    _display = _this select 0;
    {
        ( _display displayCtrl _x ) ctrlSetText "Disabled";
        ( _display displayCtrl _x ) ctrlSetTextColor [ 1, 0, 0, 0.5 ];
        ( _display displayCtrl _x ) ctrlRemoveAllEventHandlers "buttonclick";
    } forEach [ 44146, 44147, 44150 ];
} ] call BIS_fnc_addScriptedEventHandler;

// disable channels
0 enableChannel [true, false];
1 enableChannel [true, false];
2 enableChannel [false, false];

// log playable hours
_uid = getPlayerUID player;
_clientId = owner player;
_profileName = profileName;
_null = [_uid, _clientId, _profileName] spawn {	
	_uid = _this select 0;	
	_clientId = _this select 1; 
	_profileName = _this select 2;
	sleep 300;
	while {true} do {	    
        ["insertPlayer",[_uid, _profileName], _clientId] remoteExec ["sqlServerCall", 2];
        sleep 5;
        ["logTime",[_uid], _clientId] remoteExec ["sqlServerCall", 2];
        sleep 295;
    };
};