// http://forums.bistudio.com/showthread.php?176691-Making-placed-units-be-editable-for-every-Zeus
{	_x addEventHandler ["CuratorGroupPlaced", {[_this, "FETT_fnc_grpPlaced", false] spawn BIS_fnc_MP}];
	_x addEventHandler ["CuratorObjectPlaced", {[_this, "FETT_fnc_objPlaced", false] spawn BIS_fnc_MP}];
} forEach allCurators;