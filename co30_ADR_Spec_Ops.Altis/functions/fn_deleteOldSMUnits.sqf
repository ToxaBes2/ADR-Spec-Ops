private ["_unitsArray", "_obj", "_isGroup"];
sleep 1;
_unitsArray = _this select 0;
for "_c" from 0 to (count _unitsArray) do {
	_obj = _unitsArray select _c;
	_isGroup = false;
	if (_obj in allGroups) then {_isGroup = true;};
	if (_isGroup) then {
		{
			if (!isNull _x) then {deleteVehicle _x;};
		} forEach (units _obj);
	} else {
		if (!isNull _obj) then {deleteVehicle _obj;};
	};
};