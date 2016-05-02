/*
Author: ToxaBes
Description: add "Hades" system to monitor and punishplayers by given rules
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
            _trigger = createTrigger ["EmptyDetector", _position, false]; 
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
        }; 
    	case "fire" : {
            _units = _position nearEntities [["Man", "LandVehicle"], _radius];
            {                
                if (_x isKindOf "LandVehicle") then {
                    {
                        if (side _x == ENEMY_SIDE) then { 
                            _x addMPEventHandler ["MPKilled", {
                                _curUnit = _this select 0;
                                _curKiller = _this select 1;
                                _veh = vehicle _curKiller;
                                if (_veh isKindOf "LandVehicle" || _veh isKindOf "Air" || _veh isKindOf "Ship") then {
                                    if !(_veh isKindOf "StaticWeapon") then {
                                        [_veh] call QS_fnc_punishObject;    
                                        if (_veh isKindOf "Autonomous") then {
                                        	{
                                                _x setDamage 1;
                                            } forEach crew _veh;
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
                                    [_veh] call QS_fnc_punishObject; 
                                    if (_veh isKindOf "Autonomous") then {
                                    	{
                                            _x setDamage 1;
                                        } forEach crew _veh;
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
waitUntil {!isNil "sideMissionUp"};
while {true} do {
	sleep 5;
    if (!sideMissionUp) then {
    	deleteVehicle _trigger;
    };
    sleep 5;
};
