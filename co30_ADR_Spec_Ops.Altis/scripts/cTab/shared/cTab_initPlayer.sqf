// cTab - Commander's Tablet with FBCB2 Blue Force Tracking
// Battlefield tablet to access real time intel and blue force tracker.
// By - Riouken
// http://forums.bistudio.com/member.php?64032-Riouken
// You may re-use any of this work as long as you provide credit back to me.

// Exit if this is machine has no interface, i.e. is a headless client (HC)
if (!hasInterface) exitWith {};
if !(typeOf player in ["B_Soldier_SL_F", "B_T_Soldier_SL_F"]) exitWith {};

systemChat ('Командирский планшет: "Shift+M"');

// keys.sqf parses the userconfig
#include "..\functions\keys.sqf"
#include "..\shared\cTab_gui_macros.hpp"

//if (typeOf player in ["B_Soldier_SL_F", "B_T_Soldier_SL_F"]) then {
//    player addAction ["<t color='#D8D80E'><img image='\A3\ui_f\data\gui\cfg\CommunicationMenu\call_ca.paa' size='1.0'/> Командирский планшет</t>", "scripts\cTab\shared\openTablet.sqf", "", -99, false, true];   // Commander tools
//};

// Get a rsc layer for for our displays
cTabRscLayer = ["cTab"] call BIS_fnc_rscLayer;
cTabRscLayerMailNotification = ["cTab_mailNotification"] call BIS_fnc_rscLayer;

// Set up user markers
cTab_userMarkerTransactionId = -1;
cTab_userMarkerLists = [];
[] call cTab_fnc_getUserMarkerList;

// Set up side specific encryption keys
if (isNil "cTab_encryptionKey_west") then {
	cTab_encryptionKey_west = "b";
};
if (isNil "cTab_encryptionKey_east") then {
	cTab_encryptionKey_east = "o";
};
if (isNil "cTab_encryptionKey_guer") then {
	cTab_encryptionKey_guer = call {
		if (([west,resistance] call BIS_fnc_areFriendly) and {!([east,resistance] call BIS_fnc_areFriendly)}) exitWith {
			"b"
		};
		if (([east,resistance] call BIS_fnc_areFriendly) and {!([west,resistance] call BIS_fnc_areFriendly)}) exitWith {
			"o"
		};
		"i"
	};
};
if (isNil "cTab_encryptionKey_civ") then {
	cTab_encryptionKey_civ = "c";
};

// Set up empty lists
cTabBFTgroups = [];
cTabBFTvehicles = [];
cTabUAVlist = [];
cTabHcamlist = [];
cTabNotificationCache = [];
cTabTADownIconBaseSize = 18;
cTabMicroDAGRfontColour = [57/255, 255/255, 20/255, 1];
cTabMicroDAGRhighlightColour = [243/255, 243/255, 21/255, 1];
cTabMapScaleFactor = 5;
cTabMapScaleUAV = 0.8 / cTabMapScaleFactor;
cTabMapScaleHCam = 0.3 / cTabMapScaleFactor;

cTabDisplayPropertyGroups = [
	["cTab_Tablet_dlg","Tablet"]
];

cTabSettings = [];

[cTabSettings,"COMMON",[
	["mode","BFT"],
	["mapScaleMin",0.1],
	["mapScaleMax",2 ^ round(sqrt(2666 * cTabMapScaleFactor / 1024))]
]] call BIS_fnc_setToPairs;

[cTabSettings,"Main",[
]] call BIS_fnc_setToPairs;

[cTabSettings,"Tablet",[
	["dlgIfPosition",[]],
	["mode","DESKTOP"],
	["showIconText",true],
	["mapWorldPos",[]],
	["mapScaleDsp",2],
	["mapScaleDlg",2],
	["mapTypes",[["SAT",IDC_CTAB_SCREEN],["TOPO",IDC_CTAB_SCREEN_TOPO]]],
	["mapType","SAT"],
	["uavCam",""],
	["hCam",""],
	["mapTools",true],
	["nightMode",2],
	["brightness",0.9],
	["visualModeUAV",0],
	["visualModeHCAM",0]
]] call BIS_fnc_setToPairs;

// set base colors from BI -- Helps keep colors matching if user changes colors in options.
_r = profilenamespace getvariable ['Map_BLUFOR_R',0];
_g = profilenamespace getvariable ['Map_BLUFOR_G',0.8];
_b = profilenamespace getvariable ['Map_BLUFOR_B',1];
_a = profilenamespace getvariable ['Map_BLUFOR_A',0.8];
cTabColorBlue = [_r,_g,_b,_a];

_r = profilenamespace getvariable ['Map_OPFOR_R',0];
_g = profilenamespace getvariable ['Map_OPFOR_G',1];
_b = profilenamespace getvariable ['Map_OPFOR_B',1];
_a = profilenamespace getvariable ['Map_OPFOR_A',0.8];
cTabColorRed = [_r,_g,_b,_a];

_r = profilenamespace getvariable ['Map_Independent_R',0];
_g = profilenamespace getvariable ['Map_Independent_G',1];
_b = profilenamespace getvariable ['Map_Independent_B',1];
_a = profilenamespace getvariable ['Map_OPFOR_A',0.8];
cTabColorGreen = [_r,_g,_b,_a];

// Define Fire-Team colors
// MAIN,RED,GREEN,BLUE,YELLOW
cTabColorTeam = [cTabColorBlue,[200/255,0,0,0.8],[0,199/255,0,0.8],[0,0,200/255,0.8],[225/255,225/255,0,0.8]];

// define items that enable head cam
if (isNil "cTab_helmetClass_has_HCam") then {
	if (!isNil "cTab_helmetClass_has_HCam_server") then {
		cTab_helmetClass_has_HCam = cTab_helmetClass_has_HCam_server;
	} else {
		cTab_helmetClass_has_HCam = ["H_HelmetB_light","H_Helmet_Kerry","H_HelmetSpecB","H_HelmetO_ocamo"];
	};
};
// strip list of invalid config names and duplicates to save time checking through them later
_classNames = [];
{
	if (isClass (configfile >> "CfgWeapons" >> _x) && _classNames find _x == -1) then {
		0 = _classNames pushBack _x;
	};
} count cTab_helmetClass_has_HCam;
// iterate through all class names and add child classes, so we end up with a list of helmet classes that have the defined helmet classes as parents
{
	_childClasses = "inheritsFrom _x == (configfile >> 'CfgWeapons' >> '" + _x + "')" configClasses (configfile >> "CfgWeapons");
	{
		_childClassName = configName _x;
		if (_classNames find _childClassName == -1) then {
			0 = _classNames pushBack configName _x;
		};
	} count _childClasses;
} forEach _classNames;
cTab_helmetClass_has_HCam = [] + _classNames;

// fnc to set various text and icon sizes
cTab_fnc_update_txt_size = {
	cTabIconSize = cTabTxtFctr * 2;
	cTabIconManSize = cTabIconSize * 0.75;
	cTabGroupOverlayIconSize = cTabIconSize * 1.625;
	cTabUserMarkerArrowSize = cTabTxtFctr * 8 * cTabMapScaleFactor;
	cTabTxtSize = cTabTxtFctr / 12 * 0.035;
	cTabAirContactGroupTxtSize = cTabTxtFctr / 12 * 0.060;
	cTabAirContactSize = cTabTxtFctr / 12 * 32;
	cTabAirContactDummySize = cTabTxtFctr / 12 * 20;
};
// Beginning text and icon size
cTabTxtFctr = 12;
call cTab_fnc_update_txt_size;
cTabBFTtxt = true;

// Draw Map Tolls (Hook)
cTabDrawMapTools = false;

// Base defines.
cTabUavViewActive = false;
cTabUAVcams = [];
cTabCursorOnMap = false;
cTabMapCursorPos = [0,0];
cTabMapWorldPos = [];
cTabMapScale = 0.5;

// Initialize all uiNamespace variables
uiNamespace setVariable ["cTab_Tablet_dlg", displayNull];

// cTabIfOpenStart will be set to true while interface is starting and prevent further open attempts
cTabIfOpenStart = false;

// This is drawn every frame on the tablet. fnc
cTabOnDrawbft = {
	_cntrlScreen = _this select 0;
	_display = ctrlParent _cntrlScreen;
	
	cTabMapWorldPos = [_cntrlScreen] call cTab_fnc_ctrlMapCenter;
	cTabMapScale = ctrlMapScale _cntrlScreen;

	[_cntrlScreen,true] call cTab_fnc_drawUserMarkers;
    [_cntrlScreen] call cTab_fnc_iconDrawMap;

	// draw directional arrow at own location
	_veh = vehicle player;
	_playerPos = getPosASL _veh;
	_heading = direction _veh;
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];
	
	// update hook information
	if (cTabDrawMapTools) then {
		[_display,_cntrlScreen,_playerPos,cTabMapCursorPos,0,false] call cTab_fnc_drawHook;
	};
	
	true
};

// This is drawn every frame on the tablet. fnc
cTabOnDrawSupport = {
	_cntrlScreen = _this select 0;
	_display = ctrlParent _cntrlScreen;
	
	cTabMapWorldPos = [_cntrlScreen] call cTab_fnc_ctrlMapCenter;
	cTabMapScale = ctrlMapScale _cntrlScreen;

	[_cntrlScreen,true] call cTab_fnc_drawUserMarkers;
    [_cntrlScreen] call cTab_fnc_iconDrawMap;

	// draw directional arrow at own location
	_veh = vehicle player;
	_playerPos = getPosASL _veh;
	_heading = direction _veh;
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

	true
};

// This is drawn every frame on the tablet. fnc
cTabOnDrawGroup = {
	_cntrlScreen = _this select 0;
	_display = ctrlParent _cntrlScreen;
	
	cTabMapWorldPos = [_cntrlScreen] call cTab_fnc_ctrlMapCenter;
	cTabMapScale = ctrlMapScale _cntrlScreen;

	[_cntrlScreen,true] call cTab_fnc_drawUserMarkers;
    [_cntrlScreen] call cTab_fnc_iconDrawMap;

	// draw directional arrow at own location
	_veh = vehicle player;
	_playerPos = getPos player;
	_heading = direction _veh;
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];    
    if !(isNil "cTabWaypointIcons") then {
    	_previousPos = _playerPos;
    	_n = 1;
        {
            _icon = _x select 2;
            _pos = _x select 0;
            _text = format ["%1", _n];
            _cntrlScreen drawIcon [_icon,cTabMicroDAGRfontColour,_pos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,0,_text,0,cTabTxtSize,"TahomaB","right"];
            if (_n > 1) then {
                _cntrlScreen drawLine [_previousPos, _pos, cTabMicroDAGRfontColour];
            };
            _previousPos = _pos;
            _n = _n + 1;
        } forEach cTabWaypointIcons;
    };

	true
};

// This is drawn every frame on the tablet. fnc
cTabOnDrawBallistic = {
	_cntrlScreen = _this select 0;
	_display = ctrlParent _cntrlScreen;
	
	cTabMapWorldPos = [_cntrlScreen] call cTab_fnc_ctrlMapCenter;
	cTabMapScale = ctrlMapScale _cntrlScreen;

	[_cntrlScreen,true] call cTab_fnc_drawUserMarkers;
    [_cntrlScreen] call cTab_fnc_iconDrawMap;

	// draw directional arrow at own location
	_veh = vehicle player;
	_playerPos = getPosASL _veh;
	_heading = direction _veh;
	_cntrlScreen drawIcon ["\A3\ui_f\data\map\VehicleIcons\iconmanvirtual_ca.paa",cTabMicroDAGRfontColour,_playerPos,cTabTADownIconBaseSize,cTabTADownIconBaseSize,_heading,"", 1,cTabTxtSize,"TahomaB","right"];

	true
};


// This is drawn every frame on the tablet uav screen. fnc
cTabOnDrawUAV = {
	if (isNil 'cTabActUav') exitWith {};
	if (cTabActUav == player) exitWith {};
	
	_cntrlScreen = _this select 0;
	_display = ctrlParent _cntrlScreen;
	_pos = getPosASL cTabActUav;
	
	[_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
	//[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;
	[_cntrlScreen] call cTab_fnc_iconDrawMapMini;

	_cntrlScreen ctrlMapAnimAdd [0,cTabMapScaleUAV,_pos];
	ctrlMapAnimCommit _cntrlScreen;
	true
};

// This is drawn every frame on the tablet helmet cam screen. fnc
cTabOnDrawHCam = {
	if (isNil 'cTabHcams') exitWith {};
	_camHost = cTabHcams select 2;
	
	_cntrlScreen = _this select 0;
	_display = ctrlParent _cntrlScreen;
	_pos = getPosASL _camHost;
	
	[_cntrlScreen,false] call cTab_fnc_drawUserMarkers;
	//[_cntrlScreen,0] call cTab_fnc_drawBftMarkers;
	[_cntrlScreen] call cTab_fnc_iconDrawMapMini;

	_cntrlScreen ctrlMapAnimAdd [0,cTabMapScaleHCam,_pos];
	ctrlMapAnimCommit _cntrlScreen;
	true
};

/*
Function to execute the correct action when btnACT is pressed on Tablet
No Parameters
Returns TRUE
*/
cTab_Tablet_btnACT = {
	_mode = ["cTab_Tablet_dlg","mode"] call cTab_fnc_getSettings;
	call {
		//if (_mode == "UAV") exitWith {[] call cTab_fnc_remoteControlUav;};
		if (_mode == "UAV") exitWith {["cTab_Tablet_dlg",[["mode","UAV_FULL"]]] call cTab_fnc_setSettings;};
		if (_mode == "UAV_FULL") exitWith {["cTab_Tablet_dlg",[["mode","UAV"]]] call cTab_fnc_setSettings;};
		if (_mode == "UAV_FULL2") exitWith {["cTab_Tablet_dlg",[["mode","UAV"]]] call cTab_fnc_setSettings;};
		if (_mode == "HCAM") exitWith {["cTab_Tablet_dlg",[["mode","HCAM_FULL"]]] call cTab_fnc_setSettings;};
		if (_mode == "HCAM_FULL") exitWith {["cTab_Tablet_dlg",[["mode","HCAM"]]] call cTab_fnc_setSettings;};
	};
	true
};

[] spawn {
    while {true} do {
    	sleep 5;
        [] call cTab_fnc_updateLists;
        sleep 5;
    };
};



cTab_fnc_iconColor = compileFinal "
	private [""_u"",""_c"",""_a""];
	_u = _this select 0;
	_a = 0.7;

	if ((group _u) == (group player)) then {_a = 0.9;};

	if (format [""%1"", _u getVariable ""BTC_need_revive""] == ""1"") exitWith {_c = [1,0.41,0,1];_c;};

	if (side _u == east) exitWith {_c = [0.5,0,0,_a];_c;};
	if (side _u == west) exitWith {_c = [0,0.3,0.6,_a];_c;};
	if (side _u == independent) exitWith {_c = [0,0.5,0,_a];_c;};
	if (side _u == civilian) exitWith {_c = [0.4,0,0.5,_a];_c;};
	_c = [0.7,0.6,0,_a];_c;
";

//======================== ICON TYPE

cTab_fnc_iconType = compileFinal "
	private [""_v"",""_i""];
	_v = _this select 0;
	_i = _v getVariable [""icontype"",""""];
	if (_i == """") then {
		_i = getText (configFile >> ""CfgVehicles"" >> typeOf _v >> ""icon"");
		_v setVariable [""icontype"",_i];
	};
	_i;
";

//======================== ICON SIZE

cTab_fnc_iconSize = compileFinal "
	private [""_v"",""_i""];
	_v = _this select 0;
	if (_v isKindOf ""Man"") exitWith {_i = 22;_i;};
	if (_v isKindOf ""LandVehicle"") exitWith {_i = 28;_i;};
	if (_v isKindOf ""Air"") exitWith {_i = 28;_i;};
	if (_v isKindOf ""Ship"") exitWith {_i = 26;_i;};
";

//======================== ICON TEXT

cTab_fnc_iconText = compileFinal "
	private [""_n"",""_v"",""_y"",""_vt"",""_t"",""_vn""];
	_v = _this select 0;
	_vt = _v getVariable [""vt"",""""];
	if (_vt == """") then {
		_vt = getText (configFile >> ""CfgVehicles"" >> typeOf _v >> ""displayName"");
		_v setVariable [""vt"",_vt];
	};
	_vn = name (crew _v select 0);
	_t = format [""%1"",_vn];
	if (_v isKindOf ""LandVehicle"" || _v isKindOf ""Air"" || _v isKindOf ""Ship"") then {
		_n = 0;
		_n = ((count crew _v) - 1);

		if (_n > 0) then {
			if (!isNull driver _v) then {
				_t = format [""%1 [%2] +%3"",_vn,_vt,_n];
			} else {
				_t = format [""[%1] %2 +%3"",_vt,_vn,_n];
			};
		} else {
			if (!isNull driver _v) then {
				_t = format [""%1 [%2]"",_vn,_vt];
			} else {
				_t = format [""[%1] %2"",_vt,_vn];
			};
		};
		if (!isPlayer _v) then {
			_au = [""I_UAV_01_F"",""B_UAV_01_F"",""B_UAV_05_F"",""B_UAV_02_dynamicLoadout_F"",""O_UAV_01_F"",""I_UAV_02_F"",""O_UAV_02_F"",""I_UAV_02_CAS_F"",""O_UAV_02_CAS_F"",""B_UAV_02_F"",""B_UAV_02_CAS_F"",""O_UAV_01_F"",""O_UGV_01_F"",""O_UGV_01_rcws_F"",""I_UGV_01_F"",""B_UGV_01_F"",""I_UGV_01_rcws_F"",""B_UGV_01_rcws_F"",""B_GMG_01_A_F"",""B_HMG_01_A_F"",""O_GMG_01_A_F"",""O_HMG_01_A_F"",""I_GMG_01_A_F"",""I_HMG_01_A_F""];
			_iau = ({typeOf _v == _x} count _au) > 0;
			if (_iau) exitWith {
				if (isUavConnected _v) then {
					_y = (UAVControl _v) select 0;
					_t = format [""%1 [%2]"",name _y,_vt]; _t;
				} else {
					_t = format [""[AI] [%1]"",_vt]; _t;
				};
			};
		};
	};
	_t;
";

//======================== DRAW MAP

cTab_fnc_iconDrawMap = compileFinal "
	private [""_v"",""_iconType"",""_color"",""_pos"",""_iconSize"",""_dir"",""_text"",""_shadow"",""_textSize"",""_textFont"",""_textOffset"",""_units""];
	_shadow = 1;
	_textSize = 0.04;
	_textFont = 'puristaMedium';
	_textOffset = 'right';
	_group = group player;
	{
		_v = vehicle _x;
		if (_v distance2D player < 1000) then {
			_iconType = [_v] call cTab_fnc_iconType;
			_color = [_x] call cTab_fnc_iconColor;
			_pos = getPosASL _v;
			_iconSize = [_v] call cTab_fnc_iconSize;
			_dir = getDir _v;
			_text = [_v] call cTab_fnc_iconText;    
			_this select 0 drawIcon [
				_iconType,
				_color,
				_pos,
				_iconSize,
				_iconSize,
				_dir,
				_text,
				_shadow,
				_textSize,
				_textFont,
				_textOffset
			];
		};
	} count (units _group);
";

cTab_fnc_iconDrawMapMini = compileFinal "
	private [""_v"",""_iconType"",""_color"",""_pos"",""_iconSize"",""_dir"",""_text"",""_shadow"",""_textSize"",""_textFont"",""_textOffset"",""_units""];
	_shadow = 1;
	_textSize = 0.04;
	_textFont = 'puristaMedium';
	_textOffset = 'right';
	_group = group player;
	{
		_v = vehicle _x;
		if (_v distance2D player < 1200) then {
			_iconType = [_v] call cTab_fnc_iconType;
			_color = [_x] call cTab_fnc_iconColor;
			_pos = getPosASL _v;
			_iconSize = [_v] call cTab_fnc_iconSize;
			_dir = getDir _v;
			_this select 0 drawIcon [
				_iconType,
				_color,
				_pos,
				_iconSize,
				_iconSize,
				_dir,
				"""",
				_shadow,
				_textSize,
				_textFont,
				_textOffset
			];
		};
	} count (units _group);
";