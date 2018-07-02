/*
Author: ToxaBes
Description: execute Red Queen order
*/
_order = _this select 0;
if !(typeName _order == "ARRAY") exitWith {};
if (count _order > 7) then {
    [_order] spawn {
        _data = _this select 0;
        _attackPos = [_data select 0, _data select 1, _data select 2];
        _infantry = _data select 3;
        _light_vehs = _data select 4;
        _heavy_vehs = _data select 5;
        _air = _data select 6;
        _mortar = _data select 7;
        _groups = allGroups select {side _x isEqualTo east};
        _nearestInfantryGroup = grpNull;
        _nearestLighVehsGroup = grpNull;
        _nearestHeavyVehsGroup = grpNull;
        _nearestAirGroup = grpNull;
        _nearestMortarGroup = grpNull;        
        {           
            _leader = leader _x;
            _grpPos = getPos _leader;
            if (vehicle _leader == _leader) then {
                if (isNull _nearestInfantryGroup) then {
                    _nearestInfantryGroup = _x;
                } else {
                    _curDistance = (leader _nearestInfantryGroup) distance2D _attackPos;
                    if (_leader distance2D _attackPos < _curDistance) then {
                        _nearestInfantryGroup = _x;
                    };
                };
            };
            if (vehicle _leader isKindOf "LandVehicle") then {
                if (vehicle _leader isKindOf "Tank") then {
                    if (isNull _nearestHeavyVehsGroup) then {
                        _nearestHeavyVehsGroup = _x;
                    } else {
                        _curDistance = (leader _nearestHeavyVehsGroup) distance2D _attackPos;
                        if (_leader distance2D _attackPos < _curDistance) then {
                            _nearestHeavyVehsGroup = _x;
                        };
                    };
                } else {;
                    if (count (allTurrets [vehicle _leader, false]) > 0) then {
                        if (isNull _nearestLighVehsGroup) then {
                            _nearestLighVehsGroup = _x;
                        } else {
                            _curDistance = (leader _nearestLighVehsGroup) distance2D _attackPos;
                            if (_leader distance2D _attackPos < _curDistance) then {
                                _nearestLighVehsGroup = _x;
                            };
                        };
                    };
                };
            };
            if (vehicle _leader isKindOf "Helicopter") then {
                if (isNull _nearestAirGroup) then {
                    _nearestAirGroup = _x;
                } else {
                    _curDistance = (leader _nearestAirGroup) distance2D _attackPos;
                    if (_leader distance2D _attackPos < _curDistance) then {
                        _nearestAirGroup = _x;
                    };
                };
            };               
            if (vehicle _leader isKindOf "StaticMortar") then {
                if (isNull _nearestAirGroup) then {
                    _nearestMortarGroup = _x;
                } else {
                    _curDistance = (leader _nearestMortarGroup) distance2D _attackPos;
                    if (_leader distance2D _attackPos < _curDistance) then {
                        _nearestMortarGroup = _x;
                    };
                };
            }; 
        } forEach _groups;  

        if (_infantry == 1 && !isNull _nearestInfantryGroup) then {            
            while {(count (waypoints _nearestInfantryGroup)) > 0} do {
		        deleteWaypoint ((waypoints _nearestInfantryGroup) select 0);
	        };
            [_nearestInfantryGroup, _attackPos] call BIS_fnc_taskAttack;
            [_nearestInfantryGroup, 150] spawn QS_fnc_patrol;
        };

        if (_light_vehs == 1 && !isNull _nearestLighVehsGroup) then {
        	while {(count (waypoints _nearestLighVehsGroup)) > 0} do {
		        deleteWaypoint ((waypoints _nearestLighVehsGroup) select 0);
	        };
            [_nearestLighVehsGroup, _attackPos] call BIS_fnc_taskAttack;
            [_nearestLighVehsGroup, 250] spawn QS_fnc_patrol;
        };

        if (_heavy_vehs == 1 && !isNull _nearestHeavyVehsGroup) then {
        	while {(count (waypoints _nearestHeavyVehsGroup)) > 0} do {
		        deleteWaypoint ((waypoints _nearestHeavyVehsGroup) select 0);
	        };
            [_nearestHeavyVehsGroup, _attackPos] call BIS_fnc_taskAttack;
            [_nearestHeavyVehsGroup, 250] spawn QS_fnc_patrol;
        };

        if (_air == 1 && !isNull _nearestAirGroup) then {
        	while {(count (waypoints _nearestAirGroup)) > 0} do {
		        deleteWaypoint ((waypoints _nearestAirGroup) select 0);
	        };
            [_nearestAirGroup, _attackPos] call BIS_fnc_taskAttack;
            [_nearestAirGroup, 500] spawn QS_fnc_patrol;
        };

        if (_mortar == 1 && !isNull _nearestMortarGroup) then {
            _ammo = "";
            if ("8Rnd_82mm_Mo_shells" in getArtilleryAmmo [vehicle (leader _nearestMortarGroup)]) then {
                _ammo = "8Rnd_82mm_Mo_shells";
            } else {
                if ("8Rnd_82mm_Mo_guided" in getArtilleryAmmo [vehicle (leader _nearestMortarGroup)]) then {
                    _ammo = "8Rnd_82mm_Mo_guided";
                } else {
                    if ("8Rnd_82mm_Mo_LG" in getArtilleryAmmo [vehicle (leader _nearestMortarGroup)]) then {
                        _ammo = "8Rnd_82mm_Mo_LG";
                    };
                };
            };
            if (_ammo != "") then {
                _i = 1;
                while {_i <= 5} do {
                	_R = _i * 5;
                    _newPos = [(_attackPos select 0) + random _R - random _R, (_attackPos select 1) + random _R - random _R];
                    (leader _nearestMortarGroup) commandArtilleryFire [_newPos, "8Rnd_82mm_Mo_shells", 1];
                    _i = _i + 1;
                    sleep 3;
                };  
            };      	            
        };
    };
};