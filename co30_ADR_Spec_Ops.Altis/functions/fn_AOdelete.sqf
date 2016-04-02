{
	sleep 1;
	if (typeName _x == "GROUP") then {
		{
			if (vehicle _x != _x) then {
				deleteVehicle (vehicle _x);
			};
			deleteVehicle _x;
		} forEach (units _x);
	} else {
		if (vehicle _x != _x) then {
			deleteVehicle (vehicle _x);
		};
		if !(_x isKindOf "Man") then {
			{deleteVehicle _x;} forEach (crew _x)
		};
		deleteVehicle _x;
	};
} forEach (_this select 0);

private ["_unitsArray", "_obj", "_isGroup"];
sleep 1;
_unitsArray = _this select 0;

for "_c" from 0 to (count _unitsArray) do {
	_obj = _unitsArray select _c;	
    if (!isNull _obj) then {
    	_isGroup = false;
	    if (_obj in allGroups) then {
	    	_isGroup = true;
	    };
	    if (_isGroup) then {
	    	{
	    		if (!isNull _x) then {
	    			deleteVehicle _x;
	    		};
	    	} forEach (units _obj);
	    } else {		
	    	deleteVehicle _obj;		
	    };
	};
};