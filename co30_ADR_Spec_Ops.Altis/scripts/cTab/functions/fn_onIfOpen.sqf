/*
	Name: cTab_fnc_onIfOpen
	
	Author(s):
		Gundy
	
	Description:
		Handles dialog / display setup, called by "onLoad" event
	
	Parameters:
		0: Display
	
	Returns:
		BOOLEAN - TRUE
	
	Example:
		// open TAD display as main interface type
		[_dispaly] call cTab_fnc_onIfOpen;
*/
#include "..\shared\cTab_gui_macros.hpp"
private [];

uiNamespace setVariable [cTabIfOpen select 1,_this select 0];

_displayName = cTabIfOpen select 1;
_display = uiNamespace getVariable _displayName;
_errorCtrl = _display displayCtrl IDC_ERROR_CONTROLGROUP;
_errorCtrl ctrlShow false;

[] call cTab_fnc_updateInterface;

cTabIfOpenStart = false;

true