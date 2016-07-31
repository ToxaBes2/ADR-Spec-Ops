private ["_activeTimer"];

// Variables
_activeTimer = 900;	// How long will it remain active for, in seconds. 300 = 5 minutes

// Restrict use of this action while procedure is in progress
BASESHIP_SWITCH = true; publicVariable "BASESHIP_SWITCH";
sleep 1;

_shipPos = _this select 0;
_ship = createVehicle ["I_C_Boat_Transport_02_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
_ship setPos _shipPos;
_ship setDir (random 360);
0 = [_ship, _shipPos] spawn {
    _ship = _this select 1;
    _shipPos = _this select 1;
    while {true} do {
        sleep 30;
        if (_shipPos distance _ship > 100) then {
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
            if (({(_ship distance _x) < 300} count _u) < 1) then {
			    if ((count (crew _ship)) == 0) then {
                    deleteVehicle _ship;
	            };
		    };
        };
    };
};

//---------- Active time
sleep _activeTimer;
BASESHIP_SWITCH = nil; publicVariable "BASESHIP_SWITCH";
