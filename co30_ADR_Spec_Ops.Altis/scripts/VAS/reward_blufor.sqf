/*
Author:	ToxaBes
Description: Fill blufor rewards dialog
*/
private ["_display", "_title", "_head", "_ctrl", "_normalFont", "_bigFont"];

disableSerialization;
_display = uiNamespace getVariable['VAS_Reward_Display_Blufor', displayNull];

if (count BLUFOR_REWARDS_LIST == 0) then {
    closeDialog 0;
    ["<t color='#F44336' size = '.48'>У регулярной армии пока нет наград</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
if !(isNil "DEFEND_NOW") then {
    if (DEFEND_NOW) exitWith {
    	closeDialog 0;
        ["<t color='#F44336' size = '.48'>Вызов наградной техники недоступен во время обороны</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };
};
_title = _display displayCtrl 7778;
_ctrl = _display displayCtrl 7777;
_normalFont = (safezoneH - 0.42) / 35;
_bigFont = _normalFont * 2.5;
_title ctrlsetfontheight _bigFont;
_ctrl ctrlsetfontheight _normalFont;
_title ctrlSetText "Наградная Техника";
_n = 0;
{
	_vehName = _x select 0;	
	_vehVarname = (_x select 1) select 0;
    _ctrl lnbAddRow ["", _vehName];
    _pic = getText (configFile >> "CfgVehicles" >> _vehVarname >> "editorPreview");
    _ctrl lnbSetPicture [[_n, 0], _pic];
    _n = _n + 1;
} forEach BLUFOR_REWARDS_LIST;

VAS_blur = ppEffectCreate ["DynamicBlur", 401];
VAS_blur ppEffectEnable true;
VAS_blur ppEffectAdjust [1.5];
VAS_blur ppEffectCommit 0;
