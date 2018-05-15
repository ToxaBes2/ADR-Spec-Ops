disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"

_vehicleCtrl = _this select 0;
_vehIdx = _this select 1;
_vehClass = _vehicleCtrl lbData _vehIdx;

_grpCtrl = ctrlParentControlsGroup _vehicleCtrl;
_ctrlAmmo = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_A;
lbClear _ctrlAmmo;
_weapon = getArray(configfile >> "CfgVehicles" >> _vehClass >> "Turrets" >> "MainTurret" >> "weapons") select 0;
_magazines = getArray(configfile >> "CfgWeapons" >> _weapon >> "magazines");
{
    _name = getText (configfile >> "CfgMagazines" >> _x >> "displayName");
    _class = format ["%1", _x];
    _idx = _ctrlAmmo lbAdd _name;
    _ctrlAmmo lbSetData [_idx, _class];
} forEach _magazines;
_ctrlAmmo lbsetcursel 0;

_ctrlMode = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_MODE;
lbClear _ctrlMode;
_modes = getArray (configfile >> "CfgWeapons" >> _weapon >> "modes");
{
    _name = getText (configfile >> "CfgWeapons" >> _weapon >> _x >> "displayName");
    _class = format ["%1", _x];
    _idx = _ctrlMode lbAdd _name;
    _ctrlMode lbSetData [_idx, _class];
} forEach _modes;
_ctrlMode lbsetcursel 0;