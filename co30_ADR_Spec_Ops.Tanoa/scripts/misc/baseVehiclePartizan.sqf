_vehiclePos = _this select 0;
_class = _this select 1;
_veh = createVehicle [_class, _vehiclePos, [], 0, "NONE"];
_veh setDir (random 360);
_veh lock 0;
_veh setVariable ["irTarget", false, true];
0 = [_veh, _vehiclePos] spawn {
    _veh = _this select 1;
    _vehiclePos = _this select 1;
    while {true} do {
        sleep 30;
        if (_vehiclePos distance _veh > 100) then {
            _u = [];
		    if (isMultiplayer) then {			
		    	{
                    if (side _x == resistance) then {
                    	_u pushBack _x;
                    };
		        } forEach playableUnits;
		    } else {
		        {
                    if (side _x == resistance) then {
                    	_u pushBack _x;
                    };
		        } forEach switchableUnits;
	        };
            if (({(_veh distance _x) < 300} count _u) < 1) then {
			    if ((count (crew _veh)) == 0) then {
                    deleteVehicle _veh;
	            };
		    };
        };
    };
};
true