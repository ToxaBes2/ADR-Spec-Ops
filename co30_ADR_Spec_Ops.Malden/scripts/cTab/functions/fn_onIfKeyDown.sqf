/*
 	Name: cTab_fnc_onIfKeyDown
 	
 	Author(s):
		Gundy, Riouken

 	Description:
		Process onKeyDown events from cTab dialogs
		
	
	Parameters:
		0: OBJECT  - Display that called the onKeyDown event
		1: INTEGER - DIK code of onKeyDown event
		2: BOOLEAN - Shift key pressed
		3: BOOLEAN - Ctrl key pressed
		4: BOOLEAN - Alt key pressed
 	
 	Returns:
		BOOLEAN - If onKeyDown event was acted upon
 	
 	Example:
		[_display,_dikCode,_shiftKey,_ctrlKey,_altKey] call cTab_fnc_onIfKeyDown;
*/

#include "\a3\editor_f\Data\Scripts\dikCodes.h"

private["_display","_dikCode","_shiftKey","_ctrlKey","_altKey","_displayName","_mapTypes","_currentMapType","_currentMapTypeIndex","_ctrlScreen","_markerIndex"];

_display = _this select 0;
_displayName = cTabIfOpen select 1;
_dikCode = _this select 1;
_shiftKey = _this select 2;
_ctrlKey = _this select 3;
_altKey = _this select 4;

if (_dikCode == DIK_F1 && {_displayName in ["cTab_Tablet_dlg"]}) exitWith {
	[_displayName,[["mode","BFT"]]] call cTab_fnc_setSettings;
	true
};
if (_dikCode == DIK_F2 && {_displayName in ["cTab_Tablet_dlg"]}) exitWith {
	[_displayName,[["mode","UAV"]]] call cTab_fnc_setSettings;
	true
};
if (_dikCode == DIK_F3 && {_displayName in ["cTab_Tablet_dlg"]}) exitWith {
	[_displayName,[["mode","HCAM"]]] call cTab_fnc_setSettings;
	true
};
if (_dikCode == DIK_F4 && {_displayName in ["cTab_Tablet_dlg"]}) exitWith {
	[_displayName,[["mode","SUPPORT"]]] call cTab_fnc_setSettings;
	true
};
if (_dikCode == DIK_F5 && {_displayName in ["cTab_Tablet_dlg"]}) exitWith {
	[_displayName,[["mode","GROUP"]]] call cTab_fnc_setSettings;
	true
};
if (_dikCode == DIK_F6 && {_displayName in ["cTab_Tablet_dlg"]}) exitWith {
	[_displayName,[["mode","BALLISTIC"]]] call cTab_fnc_setSettings;
	true
};
if (_dikCode == DIK_DELETE && {cTabCursorOnMap}) exitWith {	
	_mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
	_currentMapType = [_displayName,"mapType"] call cTab_fnc_getSettings;
	_currentMapTypeIndex = [_mapTypes,_currentMapType] call BIS_fnc_findInPairs;
	_ctrlScreen = _display displayCtrl (_mapTypes select _currentMapTypeIndex select 1);
	_marker = [_ctrlScreen,cTabMapCursorPos] call cTab_fnc_findUserMarker;
	if (_marker in AllMapMarkers) then {
		//[call cTab_fnc_getPlayerEncryptionKey,_markerIndex] call cTab_fnc_deleteUserMarker;
		deleteMarker _marker;
	};
	true
};

false