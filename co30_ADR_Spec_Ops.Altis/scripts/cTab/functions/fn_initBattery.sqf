_ctrlBattery = _this select 0;
disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"
_allowedVehs = ["B_Mortar_01_F","B_MBT_01_arty_F","B_MBT_01_mlrs_F","O_MBT_02_arty_F","I_Truck_02_MRL_F"];
{
    _name = getText (configfile >> "CfgVehicles" >> _x >> "displayName");
    _class = format ["%1", _x];
    _idx = _ctrlBattery lbAdd _name;
    _ctrlBattery lbSetData [_idx, _class];
} forEach _allowedVehs;
_ctrlBattery lbsetcursel 0;