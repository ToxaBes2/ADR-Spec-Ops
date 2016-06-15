/*
Author: Quiksilver
Script Name: Soldier Tracker
Contact: camball@gmail.com || 
Created: 8/08/2014
Version: v1.0.1
Last modified: 13/10/2014 ArmA 1.30 by Quiksilver
DESCRIPTION:

	A CPU-friendly Player Icons script for showing players and vehicles on the map interfaces.
	Developed for my in-development co-op mission, decided to package and release it by itself.
	This version contains the basics.
	Designed for realism. No fancy frills, bright colors or gimmicky features.
	Enjoy!
	
	Note: 
	
		Common medical variables for icon color.
		Replace the relevant line in QS_fnc_iconColor (~line 37) with the correct line below:
		
			BTC Revive: 			if (format [""%1"", _u getVariable ""BTC_need_revive""] == ""1"") exitWith {_c = [1,1,1,1];_c;};
			Farooq's Revive: 		if (format [""%1"", _u getVariable ""FAR_isUnconscious""] == ""1"") exitWith {_c = [1,1,1,1];_c;};
			AIS Wounding System: 	if (_u getVariable ""unit_is_unconscious"") exitWith {_c = [1,1,1,1];_c;};
_________________________________________________________________*/

//=============================================================== FUNCTIONS

//======================== ICON COLOR

QS_fnc_iconColor = compileFinal "
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

QS_fnc_iconType = compileFinal "
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

QS_fnc_iconSize = compileFinal "
	private [""_v"",""_i""];
	_v = _this select 0;
	if (_v isKindOf ""Man"") exitWith {_i = 22;_i;};
	if (_v isKindOf ""LandVehicle"") exitWith {_i = 28;_i;};
	if (_v isKindOf ""Air"") exitWith {_i = 28;_i;};
	if (_v isKindOf ""Ship"") exitWith {_i = 26;_i;};
";

//======================== ICON TEXT

QS_fnc_iconText = compileFinal "
	private [""_n"",""_v"",""_y"",""_vt"",""_t"",""_vn""];
	_v = _this select 0;
	_vt = _v getVariable [""vt"",""""];
	if (_vt == """") then {
		_vt = getText (configFile >> ""CfgVehicles"" >> typeOf _v >> ""displayName"");
		_v setVariable [""vt"",_vt];
	};
	_vn = name (crew _v select 0);
	if (((_v distance player) < 3500) || {(serverCommandAvailable ""#kick"")}) then {
		_t = format [""%1 [%2]"",_vn,_vt];
	} else {
		_t = format [""%1"",_vn];
	};
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
			_au = [""I_UAV_01_F"",""B_UAV_01_F"",""O_UAV_01_F"",""I_UAV_02_F"",""O_UAV_02_F"",""I_UAV_02_CAS_F"",""O_UAV_02_CAS_F"",""B_UAV_02_F"",""B_UAV_02_CAS_F"",""O_UAV_01_F"",""O_UGV_01_F"",""O_UGV_01_rcws_F"",""I_UGV_01_F"",""B_UGV_01_F"",""I_UGV_01_rcws_F"",""B_UGV_01_rcws_F"",""B_GMG_01_A_F"",""B_HMG_01_A_F"",""O_GMG_01_A_F"",""O_HMG_01_A_F"",""I_GMG_01_A_F"",""I_HMG_01_A_F""];
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

QS_fnc_iconDrawMap = compileFinal "
	private [""_v"",""_iconType"",""_color"",""_pos"",""_iconSize"",""_dir"",""_text"",""_shadow"",""_textSize"",""_textFont"",""_textOffset"",""_units""];
	_shadow = 1;
	_textSize = 0.05;
	_textFont = 'puristaMedium';
	_textOffset = 'right';
	{
		_v = vehicle _x;
		if ((side _v == playerSide) || {(captive _x)}) then {
			_iconType = [_v] call QS_fnc_iconType;
			_color = [_x] call QS_fnc_iconColor;	
			_pos = getPosASL _v;		
			_iconSize = [_v] call QS_fnc_iconSize;	
			_dir = getDir _v;		
			_text = [_v] call QS_fnc_iconText;
					
			if (_x == crew _v select 0 || {_x in allUnitsUav}) then {	
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
				]
			};
		};
	} count (playableUnits + switchableUnits + allUnitsUav);	
";

//======================== DRAW GPS

QS_fnc_iconDrawGPS = compileFinal "
	private [""_v"",""_iconType"",""_color"",""_pos"",""_iconSize"",""_dir"",""_text"",""_shadow"",""_textSize"",""_textFont"",""_textOffset""];	
	_text = """";
	_shadow = 1;
	_textSize = 0.05;
	_textFont = 'puristaMedium';
	_textOffset = 'right';
	{
		_v = vehicle _x;
		if ((side _v == playerSide) || {(captive _x)}) then {
			if ((_x distance player) < 300) then {
				_iconType = [_v] call QS_fnc_iconType;
				_color = [_x] call QS_fnc_iconColor;	
				_pos = getPosASL _v;		
				_iconSize = [_v] call QS_fnc_iconSize;	
				_dir = getDir _x;		
					
				if (_x == crew _v select 0 || {_x in allUnitsUav}) then {	
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
					]
				};
			};
		};
	} count (playableUnits + switchableUnits + allUnitsUav);	
";

//=============================================================== INITIALIZATION

[] spawn {
	sleep 0.1;
	
	//===== INIT MAP
	
	waitUntil {sleep 0.1; !(isNull (findDisplay 12))};
	clientEhDrawMap = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",QS_fnc_iconDrawMap];
	
	//===== INIT GPS (waits for GPS to open)
	
	disableSerialization;
	_gps = controlNull;
	while {isNull _gps} do {
		{
			if !(isNil {_x displayctrl 101}) then {
				_gps = _x displayctrl 101
			};
		} count (uiNamespace getVariable "IGUI_Displays");
		sleep 1;
	};
	clientEhDrawGps = _gps ctrlAddEventHandler ["Draw",QS_fnc_iconDrawGPS];
	
	//===== INIT RESPAWN MENU MAP - UNSUPPORTED v1.0.0
	//===== INIT ZEUS MAP - UNSUPPORTED v1.0.0
	//===== INIT ARTILLERY COMPUTER - UNSUPPORTED v1.0.0
	//===== INIT UAV TERMINAL MAP - UNSUPPORTED v1.0.0
};