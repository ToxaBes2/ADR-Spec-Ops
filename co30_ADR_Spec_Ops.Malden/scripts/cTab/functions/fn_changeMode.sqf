_displayName = _this select 0;
_mode = [_displayName,"mode"] call cTab_fnc_getSettings;
if (_mode == "BFT") exitWith {
	['cTab_Tablet_dlg', 'BFT'] call cTab_fnc_mapTypeToggle;
};
if (_mode == "UAV_FULL") exitWith {
    ['cTab_Tablet_dlg',[['mode','UAV_FULL2']]] call cTab_fnc_setSettings;
};
if (_mode == "UAV_FULL2") exitWith {
    ['cTab_Tablet_dlg',[['mode','UAV_FULL']]] call cTab_fnc_setSettings;
};
if (_mode == "SUPPORT") exitWith {
	['cTab_Tablet_dlg', 'SUPPORT'] call cTab_fnc_mapTypeToggle;
};
if (_mode == "BALLISTIC") exitWith {
	['cTab_Tablet_dlg', 'BALLISTIC'] call cTab_fnc_mapTypeToggle;
};