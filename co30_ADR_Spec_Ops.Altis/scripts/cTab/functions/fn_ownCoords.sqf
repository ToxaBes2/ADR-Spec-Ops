disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"
_displayName = cTabIfOpen select 1;
_display = uiNamespace getVariable _displayName;
_grpCtrl = _display displayCtrl IDC_CTAB_GROUP_BALLISTIC;
_ctrlBatteryX = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_X;
_ctrlBatteryY = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_Y;

_coords = getPos player;
_ctrlBatteryX ctrlSetText format ["%1", _coords select 0];
_ctrlBatteryY ctrlSetText format ["%1", _coords select 1]; 