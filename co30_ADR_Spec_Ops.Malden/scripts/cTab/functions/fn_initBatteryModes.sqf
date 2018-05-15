_ctrlMode = _this select 0;
disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"
lbClear _ctrlMode;
_grpCtrl = ctrlParentControlsGroup _ctrlMode;
_ctrlBattery = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_W;
_vehClass = _ctrlBattery lbData 0;
_weapon = getArray(configfile >> "CfgVehicles" >> _vehClass >> "Turrets" >> "MainTurret" >> "weapons") select 0;
_modes = getArray (configfile >> "CfgWeapons" >> _weapon >> "modes");
{
    _name = getText (configfile >> "CfgWeapons" >> _weapon >> _x >> "displayName");
    _class = format ["%1", _x];
    _idx = _ctrlMode lbAdd _name;
    _ctrlMode lbSetData [_idx, _class];
} forEach _modes;
_ctrlMode lbsetcursel 0;