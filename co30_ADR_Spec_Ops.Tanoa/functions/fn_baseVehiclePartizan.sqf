private ["_vehiclePos", "_class", "_veh"];

_vehiclePos = _this select 0;
_class = _this select 1;
_veh = createVehicle [_class, _vehiclePos, [], 0, "NONE"];
_veh setDir (random 360);
_veh lock 0;
_veh setVariable ["irTarget", false, true];

// Put market on the spawned vehicle for 60 seconds
0 = [_vehiclePos] spawn {
    ["partizan_vehicle", 0] remoteExec ["setMarkerAlphaLocal", west, true];
    ["partizan_vehicle", 1] remoteExec ["setMarkerAlphaLocal", resistance, true];
    "partizan_vehicle" setMarkerPos (_this select 0);
    sleep 60;
    "partizan_vehicle" setMarkerPos [-10000, -10000];
};

// add box in vehicle
_box = createVehicle ["Box_Syndicate_WpsLaunch_F", [0,0,0], [], 0, "NONE"];
_box setVariable ["box", true];
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearItemCargoGlobal _box;
_box attachTo [_veh, [0,0,0]];
_box hideObjectGlobal true;
_veh addAction ["<t color='#EDBC64'>Выгрузить ящик</t>","scripts\partizan\unload.sqf",[],-100,true,true,"","playerSide == resistance", 5];

// Delete vehicle if there are no partizan palyers nearby
0 = [_veh, _vehiclePos] spawn {
    private ["_veh", "_vehiclePos", "_u"];
    _veh = _this select 0;
    _vehiclePos = _this select 1;
    while {true} do {
        sleep 60;
        if (_vehiclePos distance2D _veh > 100) then {
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
            _remove = true;
            {            
                if (_remove && {(_veh distance2D _x) < 300}) then {
                    _remove = false;                    
                };
            } forEach _u;
            if (_remove && {count (crew _veh) == 0}) then {
                deleteVehicle _veh;
            };
        };
    };
};
true
