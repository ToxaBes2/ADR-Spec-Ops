_displayName = _this select 0;
_step = _this select 1;
_mode = [_displayName,"mode"] call cTab_fnc_getSettings;

if !(_mode in ["HCAM","HCAM_FULL","UAV","UAV_FULL","UAV_FULL2"]) exitWith {true};

// UAV modes (0,1,2)
_visualModeUAV = [_displayName,"visualModeUAV"] call cTab_fnc_getSettings;
_newVisualModeUAV = _visualModeUAV + _step;
if (_newVisualModeUAV > 2) then {
    _newVisualModeUAV = 0;
};
if (_newVisualModeUAV < 0) then {
    _newVisualModeUAV = 2;
};
if (_mode in ["UAV","UAV_FULL","UAV_FULL2"]) then {
    [_displayName,[["visualModeUAV",_newVisualModeUAV]]] call cTab_fnc_setSettings;
};

// HCAM modes (0,1)
_visualModeHCAM = [_displayName,"visualModeHCAM"] call cTab_fnc_getSettings;
_newVisualModeHCAM = _visualModeHCAM + _step;
if (_newVisualModeHCAM > 1) then {
    _newVisualModeHCAM = 0;
};
if (_newVisualModeHCAM < 0) then {
    _newVisualModeHCAM = 1;
};
if (_mode in ["HCAM","HCAM_FULL"]) then {
    [_displayName,[["visualModeHCAM",_newVisualModeHCAM]]] call cTab_fnc_setSettings;
};

if (_mode == "HCAM") exitWith {
	"rendertarget12" setPiPEffect [_newVisualModeHCAM];
};
if (_mode == "HCAM_FULL") exitWith {
	"rendertarget13" setPiPEffect [_newVisualModeHCAM];
};
if (_mode == "UAV") exitWith {
    {
        _renderTarget = _x select 1;
        _renderTarget setPiPEffect [_newVisualModeUAV];
    } forEach cTabUAVcams;
};
if (_mode == "UAV_FULL") exitWith {
    {
        _renderTarget = _x select 1;
        _renderTarget setPiPEffect [_newVisualModeUAV];
    } forEach cTabUAVcams;
};
if (_mode == "UAV_FULL2") exitWith {
    {
        _renderTarget = _x select 1;
        _renderTarget setPiPEffect [_newVisualModeUAV];
    } forEach cTabUAVcams;
};