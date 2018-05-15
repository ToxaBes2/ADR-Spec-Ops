disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"

_displayName = cTabIfOpen select 1;
_display = uiNamespace getVariable _displayName;
_insertCtrl = _display displayCtrl IDC_INSERTMARKER_GROUP;

_ctrlPos = ctrlPosition _insertCtrl;
_mapCtrl = _display displayCtrl IDC_CTAB_SCREEN;
_markerPos = _mapCtrl ctrlMapScreenToWorld [_ctrlPos select 0, _ctrlPos select 1];

_ctrlColor   = _insertCtrl controlsGroupCtrl IDC_INSERTMARKER_COLOR;
_ctrlType    = _insertCtrl controlsGroupCtrl IDC_INSERTMARKER_TYPE;
_ctrlChannel = _insertCtrl controlsGroupCtrl IDC_INSERTMARKER_CHANNEL;
_ctrlText    = _insertCtrl controlsGroupCtrl IDC_INSERTMARKER_NAME;

_colorIdx = lbCurSel _ctrlColor;
_markerColor = _ctrlColor lbData _colorIdx;

_typeIdx = lbCurSel _ctrlType;
_markerType = _ctrlType lbData _typeIdx;

_markerText = ctrlText _ctrlText;
_ctrlText ctrlSetText "";
_markerSize = [1,1];
_markerDir = 0;

_markerCounterVar = _fnc_scriptName + "_counter";
_markerCounter = if (isnil _markerCounterVar) then {-1} else {missionnamespace getvariable _markerCounterVar};
_markerCounter = _markerCounter + 1;
_markerName = format ["_USER_DEFINED_%1",_markerCounter];
missionnamespace setvariable [_markerCounterVar,_markerCounter];

_oldChannel = currentChannel;
_channelIdx = lbCurSel _ctrlChannel;
_newChannel = parseNumber (_ctrlChannel lbData _channelIdx);
if (isMultiplayer) then {
    setCurrentChannel _newChannel;
};
_marker = createMarker [_markerName,_markerPos];
_marker setmarkersize  _markerSize;
_marker setmarkertext _markerText;
_marker setmarkerdir _markerDir;
if (_markerColor != "") then {_marker setmarkercolor _markerColor};
if (_markerType != "") then {_marker setmarkertype _markerType};
setCurrentChannel _oldChannel;
