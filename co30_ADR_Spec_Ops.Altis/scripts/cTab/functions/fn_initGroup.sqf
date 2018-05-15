_ctrlUnits = _this select 0;
disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"

_name = "";
_type= "";
_icon = "";
_allowedTypes = ["Move","Cycle","SCRIPTED","Destroy","Guard","SeekAndDestroy","Loiter","Sentry","GetIn","GetInNearest","GetOut",
"TransportUnload","Hook","Unhook","Load","Unload","VehicleInVehicleGetIn","VehicleInVehicleGetOut","VehicleInVehicleUnload"];
{
	if (_x == "SCRIPTED") then {
        _name = "ЗАЧИСТИТЬ ЗДАНИЕ";
        _type = "Scripted";
        _icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\attack_ca.paa";
	} else {
        _name = getText (configfile >> "cfgWaypoints" >> "Default" >> _x >> "displayName");
        _icon = getText (configfile >> "cfgWaypoints" >> "Default" >> _x >> "icon");
        _type = getText (configfile >> "cfgWaypoints" >> "Default" >> _x >> "type");
    };
    _idx = _ctrlUnits lbAdd _name;
    _ctrlUnits lbSetData [_idx, _type];
    _ctrlUnits lbSetPicture [_idx, _icon]; 
} forEach _allowedTypes;
_ctrlUnits lbsetcursel 0;
