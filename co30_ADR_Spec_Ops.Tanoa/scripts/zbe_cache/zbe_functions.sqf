zbe_cache = {
	_toCache = (units _group) - [(_leader)];
	{
	    if (!(isPlayer _x) && {!("driver" in assignedVehicleRole _x)}) then {
		    _x enablesimulationglobal false;
		    _x hideobjectglobal true;
	    };
	} forEach _toCache;
};
zbe_unCache = {
	{
	    if (!(isPlayer _x) && {!("driver" in assignedVehicleRole _x)}) then {
		    _x enablesimulationglobal true;
		    _x hideobjectglobal false;
	    };
	} forEach _toCache;
};
zbe_setPosLight = {
	{_testpos = (formationPosition _x);
		if (!(isNil "_testpos") && (count _testpos > 0)) then {
		    if (!(isPlayer _x) && (vehicle _x == _x)) then {
			    _x setPos _testpos;
			};
		};
	} forEach _toCache;
};
zbe_setPosFull = {
	{_testpos = (formationPosition _x);
	if (!(isNil "_testpos") && (count _testpos > 0)) then {
		if (!(isPlayer _x) && (vehicle _x == _x)) then {
				_x setPos _testpos;
				_x allowDamage false;
				[_x] spawn {sleep 3;(_this select 0) allowDamage true;};
			};
		};
	} forEach _toCache;
};
zbe_removeDead = {
	{
	    if !(alive _x) then {
	    	_x enablesimulation true;
		    _x hideobject false;		
	        _toCache = _toCache - [_x];
	    };
	} forEach _toCache;
};
zbe_cacheEvent = {
	({_x distance _leader < _distance} count (switchableUnits + playableUnits) > 0) || !isNull (_leader findNearestEnemy _leader)
};