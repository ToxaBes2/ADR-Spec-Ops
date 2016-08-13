/*
Author:	ToxaBes
Description: spawn partizan reward
*/
if (!isNil "SELECTED_REWARD" && {count SELECTED_REWARD == 2}) then {
	disableSerialization;
    _idx = SELECTED_REWARD select 1;
    SELECTED_REWARD = nil; publicVariable "SELECTED_REWARD";
    _data = PARTIZAN_REWARDS_LIST deleteAt _idx;
    publicVariable "PARTIZAN_REWARDS_LIST";
    _display = uiNamespace getVariable['VAS_Reward_Dispaly', displayNull];
    _ctrl = _display displayCtrl 7777;
    _ctrl lnbDeleteRow _idx;
    _vehName = _data select 1;
    _useAirfield = _data select 2;
    _ammoPos = getPos partizan_ammo;
    _rewardPos = [0,0,0];
    _rewardDir = random 360;
    _airfieldPositions = [[[12181.8,12942.2,0.0794663], 16], [[2210.11,13444.2,0.0440073], 142],
						  [[2152.83,3431.47,0], 317], [[11786.3,3135.41,0.21855], 215]];
    if (_useAirfield) then {
    	_row = _airfieldPositions select 0;
        _rewardPos = _row select 0;
        _rewardDir = _row select 1;
        _distance = _ammoPos distance2D _rewardPos;
        {
            _newDistance = (_x select 0) distance2D _ammoPos;
            if (_newDistance < _distance) then {
                _distance = _newDistance;
                _rewardPos = _x select 0;
                _rewardDir = _x select 1;
            };
        } forEach _airfieldPositions;
    } else {
        _dist = 10;
	    _accepted = false;
	    _rewardPos = [_ammoPos, 3, _dist, 0.5, 0, 1, 0] call QS_fnc_findSafePos;
	    if !(_rewardPos isEqualTo [0,0,0]) then {
	    	_rewardPos = _rewardPos findEmptyPosition [0, 5, _vehName];
	    	if (count _rewardPos > 0) then {
	    	    if (_rewardPos distance2D _ammoPos <= _dist) then {
	    	        _accepted = true;
	    	    };
	    	};
	    };
	    while {!_accepted and (_dist <= 200)} do {
	        _dist = _dist + 10;
	        _rewardPos = [_ammoPos, 3, _dist, 0.5, 0, 1, 0] call QS_fnc_findSafePos;
	    	if !(_rewardPos isEqualTo [0,0,0]) then {
	    	    _rewardPos = _rewardPos findEmptyPosition [0, 5, _vehName];
	    	    if (count _rewardPos > 0) then {
	    	        if (_rewardPos distance2D _ammoPos <= _dist) then {
	    	            _accepted = true;
	    	        };
	    	    };
	    	};
	    };
    };

    // Spawn the vehicle
    _veh = createVehicle [_vehName, _rewardPos, [], 0, "NONE"];
    _veh setDir _rewardDir;
    _veh lock 0;
    _veh setVariable ["irTarget", false, true];
    if(getNumber(configFile >> "CfgVehicles" >> typeof _veh >> "isUav") == 1) then {
        createVehicleCrew _veh;
        _crew = crew _veh;
        _grp = createGroup resistance;
        _crew joinSilent _grp;
        _grp addVehicle _veh;
        {
            _x setName "[AI]";
        } forEach units _grp;
    };

    // Put market on the spawned vehicle for 60 seconds
    0 = [_rewardPos] spawn {
        ["partizan_vehicle", 0] remoteExec ["setMarkerAlphaLocal", west, true];
        ["partizan_vehicle", 1] remoteExec ["setMarkerAlphaLocal", resistance, true];
        "partizan_vehicle" setMarkerPos (_this select 0);
        sleep 60;
        "partizan_vehicle" setMarkerPos [-10000, -10000];
    };
} else {
	hint "Выберите награду!";
};
