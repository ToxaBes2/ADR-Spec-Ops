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
            _trigger1 = createTrigger ["EmptyDetector", _position, true]; 
            _trigger1 setTriggerArea [_radius, _radius, 0, false];
            _trigger1 setTriggerActivation ["WEST", "PRESENT", true];
            _trigger1 setTriggerStatements ["this", "
                {
                    _allowed = ['O_Truck_03_covered_F', 'O_Truck_03_device_F', 'O_Truck_03_transport_F', 'O_T_Truck_03_device_ghex_F', 'O_T_Truck_03_transport_ghex_F','O_T_Truck_03_covered_ghex_F'];
                    _veh = vehicle _x;
                    if (_veh isKindOf 'LandVehicle' || _veh isKindOf 'Ship') then {
                    	if !(_veh isKindOf 'StaticWeapon' || (typeOf _veh) in _allowed) then {
                            [_veh] call QS_fnc_punishObject;
                        };
                    };
                } forEach thislist;
            ", ""];
            AID_TRIGGER1 = _trigger1; publicVariable "AID_TRIGGER1";
            _trigger2 = createTrigger ["EmptyDetector", _position, true]; 
            _trigger2 setTriggerArea [_radius, _radius, 0, false];
            _trigger2 setTriggerActivation ["GUER", "PRESENT", true];
            _trigger2 setTriggerStatements ["this", "
                {
                    _allowed = ['O_Truck_03_covered_F', 'O_Truck_03_device_F', 'O_Truck_03_transport_F', 'O_T_Truck_03_device_ghex_F', 'O_T_Truck_03_transport_ghex_F','O_T_Truck_03_covered_ghex_F'];
                    _veh = vehicle _x;
                    if (_veh isKindOf 'LandVehicle' || _veh isKindOf 'Ship') then {
                        if !(_veh isKindOf 'StaticWeapon' || (typeOf _veh) in _allowed) then {
                            [_veh] call QS_fnc_punishObject;
                        };
                    };
                } forEach thislist;
            ", ""];
            AID_TRIGGER2 = _trigger2; publicVariable "AID_TRIGGER2";
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
