disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"
_displayName = cTabIfOpen select 1;
_display = uiNamespace getVariable _displayName;
_grpCtrl = _display displayCtrl IDC_CTAB_GROUP_BALLISTIC;
_ctrlTargetX = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_TARGET_X;
_ctrlTargetY = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_TARGET_Y;
_ctrlBatteryX = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_X;
_ctrlBatteryY = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_Y;
_mapCtrl = _display displayCtrl IDC_CTAB_BALLISTIC_MAP;
_coords = _mapCtrl ctrlMapScreenToWorld [_this select 2,_this select 3];
if (!isNil "targetUseMap") then {
	if (targetUseMap) then {
	    _ctrlTargetX ctrlSetText format ["%1", _coords select 0];
	    _ctrlTargetY ctrlSetText format ["%1", _coords select 1];
	    [0] call cTab_fnc_mapCoords;
	};
};
if (!isNil "batteryUseMap") then {
	if (batteryUseMap) then {
	    _ctrlBatteryX ctrlSetText format ["%1", _coords select 0];
	    _ctrlBatteryY ctrlSetText format ["%1", _coords select 1];        
	    [1] call cTab_fnc_mapCoords;        
	};
};