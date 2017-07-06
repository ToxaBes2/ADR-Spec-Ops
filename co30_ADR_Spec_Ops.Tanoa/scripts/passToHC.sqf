/*
 * Author: eulerfoiler (from reddit)
 * Modified for 2 HC: ToxaBes
 * Description: move opfor and civilian groups to 2 headless clients
 */
if (!isServer || !isMultiplayer) exitWith {};
[] spawn {
    waitUntil {!isNil "HC1" && !isNil "HC2"};
    waitUntil {!isNull HC1 && !isNull HC2};
    while {true} do {
        sleep 120;
        HC1_ID = -1;
        HC2_ID = -1;
        if (!isNil "HC1") then {
            try {
                HC1_ID = owner HC1;
                if !(HC1_ID > 2) then {
                    HC1 = objNull;
                    HC1_ID = -1;
                };
            } catch {
                HC1 = objNull; 
                HC1_ID = -1; 
            };
        };
        if (!isNil "HC2") then {
            try {
                HC2_ID = owner HC2;
                if !(HC2_ID > 2) then {
                    HC2 = objNull;
                    HC2_ID = -1;
                };
            } catch { 
                HC2 = objNull; 
                HC2_ID = -1; 
            };
        };

        // move opfor and civilian groups
        { 
            _group = _x;
            if (side _group == opfor || side _group == civilian) then {
                _group deleteGroupWhenEmpty true;
                _move = true;

                // exclude blacklisted units
                if (_group getVariable ["hc_blacklist", false]) then {
                    _move = false;
                };
                if (_move) then {
                    {
                        if (isPlayer _x) then {
                            _move = false;
                        } else {
                            if (_x getVariable ["hc_blacklist", false]) then {
                                _move = false;
                            };
                        };
                    } forEach (units _group);
                };

                // don't move already moved groups but move groups which placed on disconnected HC (fallback) 
                _curOwner = groupOwner _group;                 
                if (_move) then {                    
                    if (_curOwner == HC1_ID && {!isNull HC1}) then {
                        _move = false;                       
                    };
                    if (_curOwner == HC2_ID && {!isNull HC2}) then {
                        _move = false;                        
                    };
                };

                // move group to HC
                if (_move) then {
                    _idToMove = 2; // server id
                    _count = count (units _group);
                    if (HC1_ID > 0 && HC2_ID > 0) then {
                        _cent = floor random 10;
                        if (_cent < 6) then {
                            _idToMove = HC1_ID;
                        } else {
                            _idToMove = HC2_ID;
                        };
                    } else {
                        if (HC1_ID > 0) then {
                            _idToMove = HC1_ID;
                        } else {
                            if (HC2_ID > 0) then {
                                _idToMove = HC2_ID;
                            };
                        };
                    };
                    if !(_curOwner == _idToMove) then {
                        _group setGroupOwner _idToMove;
                    };                    
                };
            };
        } forEach (allGroups);
    };
};
