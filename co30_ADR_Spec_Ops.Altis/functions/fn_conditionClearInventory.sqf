// Author: Quiksilver
// Clear inventory add action condition

private ["_c"];
_v = vehicle player;
_c = false;
if ((_v isKindOf "LandVehicle") || {(_v isKindOf "Helicopter")} || {(_v isKindOf "Ship")}) then {
	if (player == (driver _v)) then {
		if (!(inventory_cleared)) then {
			_c = true;
		};
	};
};
_c;