_ctrlAmmo = _this select 0;
disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"

_grpCtrl = ctrlParentControlsGroup _ctrlAmmo;

_vehicleCtrl = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_W;
_vehIdx = lbCurSel _vehicleCtrl;
_vehClass = _vehicleCtrl lbData _vehIdx;

_weapon = getArray(configfile >> "CfgVehicles" >> _vehClass >> "Turrets" >> "MainTurret" >> "weapons") select 0;
_magazines = getArray(configfile >> "CfgWeapons" >> _weapon >> "magazines");
{
    _name = getText (configfile >> "CfgMagazines" >> _x >> "displayName");
    _class = format ["%1", _x];
    _idx = _ctrlAmmo lbAdd _name;
    _ctrlAmmo lbSetData [_idx, _class];
} forEach _magazines;
_ctrlAmmo lbsetcursel 0;