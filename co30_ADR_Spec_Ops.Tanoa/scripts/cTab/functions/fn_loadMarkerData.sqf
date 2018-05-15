disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"

_grpCtrl = _this select 0;
_ctrlColor =  _grpCtrl controlsGroupCtrl IDC_INSERTMARKER_COLOR;
{
	private _colorArray = getArray (_x >> "color");
	private _color = _colorArray call BIS_fnc_colorConfigToRGBA;
	private _colorName = configName _x;
    _idx = _ctrlColor lbAdd "";
    _ctrlColor lbSetData [_idx, _colorName];
    _ctrlColor lbSetColor [_idx, _color];
    _ctrlColor lbsetpicture [_idx,"#(argb,8,8,3)color(1,1,1,1)"];
    _ctrlColor lbSetPictureColor [_idx, _color];
} forEach configProperties [configFile >> "CfgMarkerColors"];
_ctrlColor lbsetcursel 3;

_ctrlType =  _grpCtrl controlsGroupCtrl IDC_INSERTMARKER_TYPE;
{
	private _markerClass = getText (_x >> "markerClass");
	private _icon = getText (_x >> "icon");
	private _label = getText (_x >> "name");
	private _shadow = getNumber (_x >> "shadow");
	private _markerName = configName _x;
	if (_markerClass == 'draw' && _shadow == 1) then {
        _idx = _ctrlType lbAdd _label;
        _ctrlType lbSetData [_idx, _markerName];
        _ctrlType lbsetpicture [_idx, _icon];
        _ctrlType lbSetPictureColor [_idx, [1,1,1,1]];
    };
} forEach configProperties [configFile >> "cfgMarkers"];
_ctrlType lbsetcursel 1;

_ctrlChannel = _grpCtrl controlsGroupCtrl IDC_INSERTMARKER_CHANNEL;
{
	_idx = _ctrlChannel lbadd (_x select 0);	
	_ctrlChannel lbSetData [_idx, _x select 1];
	_ctrlChannel lbSetColor [_idx, _x select 2];
} foreach [
	["Групповой","3",[0.709,0.972,0.384,1]],
	["Общий","1",[0.2744,0.8288,0.9884,1]],	
	["Транспортный","4",[1.2082,0.8176,0,1]],
	["Экстренный","7",[0.67,0.14,0.13,1]],
	["Оперативный","8",[0.118,0.565,1,1]],
	["Командный","9",[0.58,0,0.827,1]]
];
_ctrlChannel lbsetcursel 0;

_ctrlName = _grpCtrl controlsGroupCtrl IDC_INSERTMARKER_NAME;
ctrlSetFocus _ctrlName;