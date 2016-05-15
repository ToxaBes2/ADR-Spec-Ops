/*
Author: ToxaBes
Description: add "Hades" system to monitor and punish players by given rules
Format: [position, radius, [restriction rules]] call QS_fnc_addHades;
*/
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
_position = _this select 0;
_radius = _this select 1;
_rules =  _this select 2;// ["vehicles", "fire"]
_trigger = objNull;
_punishObject = objNull;
{
    _rule = _x;
    switch (_rule) do { 
    	case "vehicles" : {
            _trigger = createTrigger ["EmptyDetector", _position, true]; 
            _trigger setTriggerArea [_radius, _radius, 0, false];
            _trigger setTriggerActivation ["WEST", "PRESENT", true];
            _trigger setTriggerStatements ["this", "
                {
                    _veh = vehicle _x;
                    if (_veh isKindOf 'LandVehicle' || _veh isKindOf 'Ship') then {
                    	if !(_veh isKindOf 'StaticWeapon') then {
                            [_veh] call QS_fnc_punishObject;
                        };
                    };
                } forEach thislist;
            ", ""];
            AID_TRIGGER = _trigger; publicVariable "AID_TRIGGER";
        }; 
    	case "fire" : {
            _units = _position nearEntities [["Man", "LandVehicle"], _radius];
            {                
                _x setVariable ["AID_POSITION", _position];
                _x setVariable ["AID_RADIUS", _radius];
                if (_x isKindOf "LandVehicle") then {
                    {
                        if (side _x == ENEMY_SIDE) then { 
                            
                            _x addMPEventHandler ["MPKilled", {
                                _curUnit = _this select 0;
                                _curKiller = _this select 1;
                                _veh = vehicle _curKiller;
                                if (_veh isKindOf "LandVehicle" || _veh isKindOf "Air" || _veh isKindOf "Ship") then {
                                    if !(_veh isKindOf "StaticWeapon") then {
                                        if (side _veh == OUR_SIDE) then {                                   
                                            if (_veh isKindOf "Autonomous") then {
                                                if (isUAVConnected _veh) then {
                                                    _data = UAVControl _veh;
                                                    (_data select 0) setDamage 1;
                                                };
                                            };         
                                            _aidPosition = _curUnit getVariable ["AID_POSITION", [0,0,0]];
                                            _aidRadius = _curUnit getVariable ["AID_RADIUS", 200];
                                            if (_curUnit distance _aidPosition <= _aidRadius) then {
                                                [_veh] call QS_fnc_punishObject; 
                                            };                                        
                                        };                            
                                    };
                                };
                            }];
                        };
                    } forEach crew (vehicle _x);
                } else { 
                    if (side _x == ENEMY_SIDE) then {                   
                        _x addMPEventHandler ["MPKilled", {
                            _curUnit = _this select 0;
                            _curKiller = _this select 1;
                            _veh = vehicle _curKiller;
                            if (_veh isKindOf "LandVehicle" || _veh isKindOf "Air" || _veh isKindOf "Ship") then {
                                if !(_veh isKindOf "StaticWeapon") then { 
                                    if (side _veh == OUR_SIDE) then {                                   
                                        if (_veh isKindOf "Autonomous") then {
                                        	if (isUAVConnected _veh) then {
                                                _data = UAVControl _veh;
                                                (_data select 0) setDamage 1;
                                            };
                                        };         
                                        _aidPosition = _curUnit getVariable ["AID_POSITION", [0,0,0]];
                                        _aidRadius = _curUnit getVariable ["AID_RADIUS", 200];
                                        if (_curUnit distance _aidPosition <= _aidRadius) then {
                                            [_veh] call QS_fnc_punishObject; 
                                        };  
                                    };                      
                                };
                            };
                        }]; 
                    };
                };                               
            } forEach _units;
        }; 
    	default {}; 
    };
} forEach _rules;
