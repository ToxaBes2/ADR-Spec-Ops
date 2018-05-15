/*
	Name: cTab_fnc_userMenuSelect
	
	Author(s):
		Gundy, Riouken
	
	Description:
		Process user menu select events, initiated by "\cTab\shared\cTab_markerMenu_controls.hpp"
		
	
	Parameters:
		0: INTEGER - Type of user menu select event - if this doesn't match a valid type it will be considered to be an IDC
	
	Returns:
		BOOLEAN - TRUE
	
	Example:
		[1] call cTab_fnc_userMenuSelect;
*/

#include "..\shared\cTab_gui_macros.hpp"

private ["_type","_displayName","_display","_idcToShow","_control","_controlPos","_screenPos","_screenEdgeX","_screenEdgeY","_controlEdgeX","_controlEdgeY"];

disableSerialization;

_type = _this select 0;
_displayName = cTabIfOpen select 1;
_display = (uiNamespace getVariable _displayName);

_idcToShow = 0;

call {
	// send cTabUserSelIcon to server
	if (_type < 100) exitWith {
		//cTabUserSelIcon pushBack player;
		//[call cTab_fnc_getPlayerEncryptionKey,cTabUserSelIcon] call cTab_fnc_addUserMarker;
        _insertCtrl = _display displayCtrl IDC_CTAB_GROUP_SUPPORT;
        _ctrlPos = ctrlPosition _insertCtrl;
        _mapCtrl = _display displayCtrl IDC_CTAB_SUPPORT;
        _markerPos = _mapCtrl ctrlMapScreenToWorld [_ctrlPos select 0, _ctrlPos select 1];
        [_type, _markerPos] call cTab_fnc_callSupport;        
	};
		
	_idcToShow = call {
		if (_type == 100) exitWith {4657};
		if (_type == 200) exitWith {4658};		
		_type;
	};
};

// Hide all menu controls
{ctrlShow [_x,false];} count [4656,4657,4658];

// Bring the menu control we want to show into position and show it
if (_idcToShow != 0) then {
	_control = _display displayCtrl _idcToShow;
	if !(isNull _control) then {
		_controlPos = ctrlPosition _control;
		
		// figure out screen edge positions and where the edges of the control would be if we were just to move it blindly to cTabUserPos
		_screenPos = ctrlPosition (_display displayCtrl IDC_CTAB_LOADINGTXT);
		_screenEdgeX = (_screenPos select 0) + (_screenPos select 2);
		_screenEdgeY = (_screenPos select 1) + (_screenPos select 3);
		_controlEdgeX = (cTabUserPos select 0) + (_controlPos select 2);
		_controlEdgeY = (cTabUserPos select 1) + (_controlPos select 3);
		
		// if control would be clipping the right edge, correct control position
		if (_controlEdgeX > _screenEdgeX) then {
			_controlPos set [0,_screenEdgeX - (_controlPos select 2)];
		} else {
			_controlPos set [0,cTabUserPos select 0];
		};
		// if control would be clipping the bottom edge, correct control position
		if (_controlEdgeY > _screenEdgeY) then {
			_controlPos set [1,_screenEdgeY - (_controlPos select 3)];
		} else {
			_controlPos set [1,cTabUserPos select 1];
		};
		
		// move to position and show
		_control ctrlSetPosition _controlPos;
		_control ctrlCommit 0;
		_control ctrlShow true;
		ctrlSetFocus _control;
	};
};

true