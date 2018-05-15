/*
Function to toggle mapType to the next one in the list of available map types
Parameter 0: String of uiNamespace variable for which to toggle to mapType for
Returns TRUE
*/
disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"
_displayName = _this select 0;
_mode = _this select 1;
if (_mode == "BFT") then {
    _mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
    _currentMapType = [_displayName,"mapType"] call cTab_fnc_getSettings;
    _currentMapTypeIndex = [_mapTypes,_currentMapType] call BIS_fnc_findInPairs;
    if (_currentMapTypeIndex == count _mapTypes - 1) then {
    	[_displayName,[["mapType",_mapTypes select 0 select 0]]] call cTab_fnc_setSettings;
    } else {
    	[_displayName,[["mapType",_mapTypes select (_currentMapTypeIndex + 1) select 0]]] call cTab_fnc_setSettings;
    };
};
if (_mode == "SUPPORT") then {
    _display = uiNamespace getVariable _displayName;
    _mapCtrl = _display displayCtrl IDC_CTAB_SUPPORT;
    _mapTopoCtrl = _display displayCtrl IDC_CTAB_SUPPORT_TOPO;    
    if (ctrlShown _mapCtrl) then {
    	_targetMapScale = ctrlMapScale _mapCtrl;
		_targetMapWorldPos = [_mapCtrl] call cTab_fnc_ctrlMapCenter;		
        _mapCtrl ctrlShow false;
        _mapTopoCtrl ctrlShow true;
        _mapTopoCtrl ctrlMapAnimAdd [0,_targetMapScale,_targetMapWorldPos];
	    ctrlMapAnimCommit _mapTopoCtrl;
	    while {!(ctrlMapAnimDone _mapTopoCtrl)} do {};
    } else {
        _targetMapTopoScale = ctrlMapScale _mapCtrl;
		_targetMapTopoWorldPos = [_mapCtrl] call cTab_fnc_ctrlMapCenter;
        _mapCtrl ctrlShow true;
        _mapTopoCtrl ctrlShow false;
        _mapCtrl ctrlMapAnimAdd [0,_targetMapTopoScale,_targetMapTopoWorldPos];
	    ctrlMapAnimCommit _mapCtrl;
	    while {!(ctrlMapAnimDone _mapCtrl)} do {};
    };
};
true