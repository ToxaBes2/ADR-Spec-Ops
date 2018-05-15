disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"

if (isNil "cTabWaypointIcons") then {
    cTabWaypointIcons = [];
};

if (count cTabWaypointIcons >= 10) exitWith {
    systemChat "Разрешено не более 10 команд в цепочке!";
};

_displayName = cTabIfOpen select 1;
_display = uiNamespace getVariable _displayName;
_grpCtrl = _display displayCtrl IDC_CTAB_GROUP_GROUP;

_ctrlPos   = ctrlPosition _grpCtrl;
_mapCtrl   = _display displayCtrl IDC_CTAB_GROUP_MAP;
_markerPos = _mapCtrl ctrlMapScreenToWorld [_this select 2,_this select 3];

_ctrlType     = _grpCtrl controlsGroupCtrl IDC_CTAB_GROUP_TYPE;
_ctrlWarmode  = _grpCtrl controlsGroupCtrl IDC_CTAB_GROUP_WARMODE;
_ctrlBehavior = _grpCtrl controlsGroupCtrl IDC_CTAB_GROUP_BEHAVIOR;
_ctrlSpeed    = _grpCtrl controlsGroupCtrl IDC_CTAB_GROUP_SPEED;

_typeIdx = lbCurSel _ctrlType;
_type = _ctrlType lbData _typeIdx;
_icon = _ctrlType lbPicture _typeIdx;

_warmodeIdx = lbCurSel _ctrlWarmode;
_warmode = _ctrlWarmode lbData _warmodeIdx;

_behaviorIdx = lbCurSel _ctrlBehavior;
_behavior = _ctrlBehavior lbData _behaviorIdx;

_speedIdx = lbCurSel _ctrlSpeed;
_speed = _ctrlSpeed lbData _speedIdx;

_data = [_markerPos, _type, _icon, _warmode, _behavior, _speed];
cTabWaypointIcons pushBack _data;
