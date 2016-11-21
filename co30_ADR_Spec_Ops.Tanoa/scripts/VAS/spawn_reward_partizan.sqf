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
    _display = uiNamespace getVariable['VAS_Reward_Display_Partizan', displayNull];
    _ctrl = _display displayCtrl 7777;
    _ctrl lnbDeleteRow _idx;
    _vehs = _data select 1;    
    _vehName = _vehs select 0;
    _useAirfield = _data select 2;
    _ammoPos = getPos partizan_ammo;
    _rewardPos = [0,0,0];
    _rewardDir = random 360;
    _airfieldPositions = [[[9264.86,21576.4,0], 225], [[11688.3,11937.4,0], 217], [[26832.7,24541.6,0], 40],
                          [[23147,18404.4,0], 0], [[21076.3,7096.31,0], 10], [[9629.85,12461.7,0], 137]];
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

    if (count _vehs > 1) then {
        _vehs deleteAt 0;
        {  
            if (_x isKindOf "ReammoBox_F") then {
                _newPos = [_rewardPos, 1, 5, 0.5, 0, 1, 0] call QS_fnc_findSafePos;
                _newVeh = createVehicle [_x, _newPos, [], 0, "NONE"];                                
            };
            if (_x isKindOf "StaticWeapon" && _vehName == "I_G_Offroad_01_F") then {
                _newVeh = createVehicle [_x, [10,10,10], [], 0, "NONE"];
                switch (_x) do { 
                    case "I_static_AT_F" : {
                        _newDir = _rewardDir + 180;
                        _newVeh attachTo [_veh, [0,-1.8, 0.3]];
                        _newVeh setDir _newDir;
                    }; 
                    case "I_static_AA_F" : {
                        _newVeh attachTo [_veh, [0,-2.3, 0.3]];
                    }; 
                    case "I_G_Mortar_01_F" : {
                        _newVeh attachTo [_veh, [0,-2.3, 0]];
                    }; 
                    case "I_GMG_01_high_F" : {
                        _newVeh attachTo [_veh, [0,-2.3, 1]];
                    }; 
                };                
            };
            if (_vehName == "I_Truck_02_ammo_F") then {
                _newVeh = createVehicle [_x, [10,10,10], [], 0, "NONE"];
                _newVeh attachTo [_veh, [0,-2, 1.95]];
            };            
        } forEach _vehs;
    };
    if (_vehName == "I_Truck_02_ammo_F") then {

        // add EW (anti-UAV) actions
        _veh setVariable ["EW_ENABLED", 0, true];
        [_veh, "QS_fnc_addActionAntiUAV", nil, true] spawn BIS_fnc_MP;
    };
    if (_vehName == "I_Truck_02_medical_F") then {

        // add avanpost actions
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
