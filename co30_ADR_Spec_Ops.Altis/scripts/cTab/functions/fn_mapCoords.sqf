disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"
_mode = _this select 0;
_displayName = cTabIfOpen select 1;
_display = uiNamespace getVariable _displayName;
_grpCtrl = _display displayCtrl IDC_CTAB_GROUP_BALLISTIC;
_ctrlTarget = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_TARGET;
_ctrlBattery = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY;

// target
if (_mode == 0) exitWith {
    if (isNil "targetUseMap") exitWith {
        targetUseMap = true;
        _ctrlTarget ctrlSetText "Отменить указание";
    };
    if (targetUseMap) then {
    	targetUseMap = false;
    	_ctrlTarget ctrlSetText "Указать на карте";
    } else {
        targetUseMap = true;
        _ctrlTarget ctrlSetText "Отменить указание";
    };
};

// battery
if (_mode == 1) exitWith {
    if (isNil "batteryUseMap") exitWith {
        batteryUseMap = true;
        _ctrlBattery ctrlSetText "Отменить указание";
    };
    if (batteryUseMap) then {
    	batteryUseMap = false;
    	_ctrlBattery ctrlSetText "Указать на карте";
    } else {
        batteryUseMap = true;
        _ctrlBattery ctrlSetText "Отменить указание";
    };
};