/*
Author: ToxaBes
Description: start Red Queen AI for defend zone
*/
_base = _this select 0;
_radius = _this select 1;
_txid = _this param [2, false];
if (!_txid) then {
	_rand = round (random 100000);
	_time = round (serverTime);
    _txid = format["TX_ID_%1_%2", _time, _rand];
};
missionNamespace setVariable [format["%1", _txid], true];

if (isNil "TRANSACTIONS") then {
    TRANSACTIONS = [];
};
TRANSACTIONS pushBack _txid; publicVariable "TRANSACTIONS";

[_base, _radius, _txid] spawn {
    _base = _this select 0;
    _radius = _this select 1;
    _txid = _this select 2;
    _rq_ids = [];
    _run = missionNamespace getVariable [format["%1", _txid], false];
    while {_run} do {
    	sleep 60;
        _forceGroup = [0,0,0,0,0];
        _allTargets = [];
        _enemySides = [east] call BIS_fnc_enemySides;
        _groups = allGroups select {side _x isEqualTo east};
        _hasForces = false;
        {           
            _hasForces = true;
            _leader = leader _x;
            _grpPos = getPos _leader; 
            if (_grpPos distance2D _base <= _radius) then {                
                if ((combatMode _x) == "RED" || {(combatMode _x) == "Yellow"}) then {
                	_distance = 450 + random 50;
                    if (vehicle _leader isKindOf "LandVehicle") then {
                        _distance = 650 + random 50;
                    };
                    if (vehicle _leader isKindOf "Helicopter") then {
                        _distance = 950 + random 50;
                    };                                                       
                    _targets = nearestObjects [_leader, ["Man","LandVehicle","Air"], _distance]; 
                    {            
                        _target = _x;     
                        if (side _target in _enemySides) then {
                            if (_target isKindOf "Man") then {
                                _allTargets pushBackUnique _target;
                            } else {
                                {
                                    _allTargets pushBackUnique _x;
                                } forEach (crew _target);
                            };
                            
                        };
                    } forEach _targets;
                };
                if (vehicle _leader == _leader) then {
                    if (count (units (group _leader)) > 4) then {
                        _forceGroup set [0, 1];
                    };
                };
                if (vehicle _leader isKindOf "LandVehicle") then {
                    if (vehicle _leader isKindOf "Tank") then {
                        _forceGroup set [2, 1];
                    } else {;
                        if (count (allTurrets [vehicle _leader, false]) > 0) then {
                            _forceGroup set [1, 1];
                        };
                    };
                };
                if (vehicle _leader isKindOf "Helicopter") then {
                    _forceGroup set [3, 1];
                };               
                if (vehicle _leader isKindOf "StaticMortar") then {
                    _forceGroup set [4, 1];
                }; 
            };
        } forEach _groups;    
        _targetGroups = [];    
        if (count _allTargets > 0) then {            
            while {count _allTargets > 0} do {  
                _addTarget = true; 
                _index = -1;        	
                _unit = _allTargets select 0;
                if (!alive _unit) then {
                    _allTargets deleteAt 0;                    
                } else {
                    _unitPos = getPos _unit;
                    _targetGroup = [0,0,0,0,0,round (_unitPos select 0), round (_unitPos select 1), round (_unitPos select 2)];               
                    {
                        if ([_x select 5, _x select 6, _x select 7] distance _unitPos < 200) then {
                            _targetGroup = _x;
                            _index = _targetGroups find _x;
                        };
                    } forEach _targetGroups;
        
                    _nearUnits = [_unit];
                    if (_index < 0) then {
                        _nearUnits = _unit nearEntities ["Man", 200];                    
                        _nearUnits = [_nearUnits, _unit] call BIS_fnc_arrayUnShift;
                    };           

                    {
                        _rqCoords = _x select 1;
                        if (_rqCoords distance2D _unit <= 200) then {
                            _addTarget = false; 
                        };
                    } forEach _rq_ids;

                    if (_addTarget) then {
                        {
                            if (_x in _allTargets) then {
                                _allTargets deleteAt (_allTargets find _x);
                                if (_x getUnitTrait "Medic" || {secondaryWeapon _x != ""}) then {
                                    _targetGroup set [0, 1];
                                };
                                if (vehicle _x isKindOf "LandVehicle") then {
                                	if (count (allTurrets [vehicle _x, false]) > 0) then {
                                	    _targetGroup set [2, 1];
                                	} else {
                                        _targetGroup set [1, 1];
                                    };                    
                                };
                                if (vehicle _x isKindOf "Air") then {
                                    _targetGroup set [3, 1];
                                };
                                _alreadyAttacked = _x getVariable ["ALREADY_ATTACKED", false];
                                if (_alreadyAttacked || _x distance2D _base < 250) then {
                                	_targetGroup set [4, 1];
                                } else {
                                    _x setVariable ["ALREADY_ATTACKED", true];
                                };                            
                            };
                        } forEach _nearUnits;        
                        if (_index < 0) then {
                            _targetGroups pushBack _targetGroup;
                        } else {
                            _targetGroups set [_index, _targetGroup];
                        };   
                    };
                };
            };
        };

        // receive data from RQ
       	while {count _rq_ids > 0} do { 
       		_rqData = _rq_ids select 0;
       		_rq_id = _rqData select 0;
            ["getRequest",[_rq_id], 0] remoteExec ["sqlServerCall", 2];

            // add auto learning here
            _rq_ids deleteAt 0; 
       	};

        // send data to RQ
        if (count _targetGroups > 0 && _hasForces) then {
            {
                _curTarget = _x;
                _data = [
                    _curTarget select 5,  // x
                    _curTarget select 6,  // y
                    _curTarget select 7,  // z
                    _curTarget select 0,  // infantry
                    _curTarget select 1,  // light vehs
                    _curTarget select 2,  // heavy vehs
                    _curTarget select 3,  // air
                    _curTarget select 4,  // survive
                    _forceGroup select 0, // has infantry
                    _forceGroup select 1, // has light vehs
                    _forceGroup select 2, // has heavy vehs
                    _forceGroup select 3, // has air
                    _forceGroup select 4  // has mortar
                ];
                ["setRequest", _data, 0] remoteExec ["sqlServerCall", 2];
                sleep 2;
                _rq_id = missionNamespace getVariable ["LAST_REQUEST_ID", 0];
                if (_rq_id > 0) then {
                	_rqData = [_rq_id, [_data select 0, _data select 1]];
                	_rq_ids pushBack _rqData;
                };                 
            } forEach _targetGroups;
        };
        sleep 60;
        _run = missionNamespace getVariable [format["%1", _txid], false];
    };
};

_txid