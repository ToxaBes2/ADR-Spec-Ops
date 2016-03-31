/*
Author:	ToxaBes
Description: catch vehicle killer and move it to prison by given rules
Format: [vehicle] call QS_fnc_killerCatcher;
Rule: any 3 destoyed vehicles in 10 mins closer than 800m from respawn.
*/
private ["_first","_second","_list","_vehicle","_vehiclePos","_killer","_respPos","_radius","_period","_prisonTime","_person","_now","_h1","_h2","_m1","_m2"];
if (!isServer) exitWith {};
_obj = _this select 0;
_obj addMPEventHandler ["MPkilled", {
    _vehicle = _this select 0;
    _vehiclePos = getPos _vehicle;
    _killer = _this select 1;
    _respPos = getMarkerPos "respawn_west";
    _radius = 800;
    _period = 10;
    _prisonTime = 600;
    _person = false;
    if (_vehiclePos distance _respPos <= _radius) then {
        if (_killer isKindOf "LandVehicle" || _killer isKindOf "Air" || _killer isKindOf "Ship") then {
            if (!isNull (gunner (vehicle _killer))) then {
                _person = gunner (vehicle _killer);
            } else {
                if (!isNull (driver (vehicle _killer))) then {
                   _person = driver (vehicle _killer);
                } else {
                   _person = effectiveCommander (vehicle _killer);
                };
            };
        } else {
            _person = _killer;
        };
        if (isNull _person) then {
            _list = nearestObjects [_vehiclePos, ["LandVehicle", "Air", "Ship"], 20];
            {
                if (isNull _person && !isNull (driver (vehicle _x))) then {
                   _person = driver (vehicle _x);
                }; 
            } forEach _list;
        };    
        if (!isNull _person) then {
            _now = date;
            _first = _person getVariable ["VEHICLE_DESTROYED_1", []];
            _second = _person getVariable ["VEHICLE_DESTROYED_2", []];         
            if (count _first == 0 && count _second == 0) then {
               _person setVariable ["VEHICLE_DESTROYED_1", _now]; 
            } else {
                if (count _first > 0) then {
                    if (count _second == 0) then {
                        _person setVariable ["VEHICLE_DESTROYED_1", _now]; 
                        _person setVariable ["VEHICLE_DESTROYED_2", _first]; 
                    } else {
                        if (_now select 0 == _second select 0 &&
                            _now select 1 == _second select 1 &&
                            _now select 2 == _second select 2
                       	) then {
                            _h1 = _second select 3;
                            _h2 = _now select 3;
                            _m1 = _second select 4;
                            _m2 = _now select 4;
                            if (_h2 < _h1) then {
                            	_h2 = _h2 + 24;
                            };
                            if (_h2 - _h1 <= 1) then {
                                if (_m2 < _m1) then {
                                	_m2 = _m2 + 60;
                                };
                                if (_m2 - _m1 <= _period) then {
                                	[[[_person, _prisonTime, "STR_PRISON_VEHICLE"], "scripts\=BTC=_TK_punishment\Prison.sqf"], "BIS_fnc_execVM", true, false, false] call BIS_fnc_MP;     
                                };
                                _first = _person setVariable ["VEHICLE_DESTROYED_1", []];
                                _second = _person setVariable ["VEHICLE_DESTROYED_2", []];
                            };
                        } else {
                            _first = _person setVariable ["VEHICLE_DESTROYED_1", _now];
                            _second = _person setVariable ["VEHICLE_DESTROYED_2", []];
                        };
                    };
                };
            }; 
        };
    };
}];