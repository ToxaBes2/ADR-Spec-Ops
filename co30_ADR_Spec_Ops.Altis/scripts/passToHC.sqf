/*
 * Author: eulerfoiler (from reddit)
 * Modified for 2 HC: ToxaBes
 * Description: round-robing balancing for headless clients
 */
if (!isServer) exitWith {};
[] spawn {
    waitUntil {!isNil "HC1"};
    waitUntil {!isNull HC1};
    HC1_ID = -1;
    HC2_ID = -1; 
    rebalanceTimer = 600;
    while {true} do {
        sleep rebalanceTimer;
        _loadBalance = false;
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
        if ((isNull HC1) && (isNull HC2)) then { 
            waitUntil {!isNull HC1};
        };  
        if (!isNull HC1 && !isNull HC2) then { 
            _loadBalance = true;
        };
        _currentHC = 0;  
        if (!isNull HC1) then { 
            _currentHC = 1; 
        } else { 
            if (!isNull HC2) then { 
                _currentHC = 2; 
            };
        };  
        _numTransfered = 0;
        {
            _swap = true;
            {
                if (isPlayer _x) then {
                    _swap = false;
                } else {
                    if (_x getVariable ["hc_blacklist", false]) then {
                        _swap = false;
                    };
                };
            } forEach (units _x);
            if (side _x == blufor || side _x == resistance) then {
                _swap = false;
            };
            if (_swap) then {
                _rc = false;
                if (_loadBalance) then {
                  switch (_currentHC) do {
                    case 1: { 
                        _rc = _x setGroupOwner HC1_ID; 
                        if (!isNull HC2) then { 
                            _currentHC = 2; 
                        } else { 
                            _currentHC = 1;
                        };
                    };
                    case 2: { 
                        _rc = _x setGroupOwner HC2_ID; 
                        if (!isNull HC1) then { 
                            _currentHC = 1; 
                        } else { 
                            _currentHC = 2;
                        };
                    };
                  };
                } else {
                    switch (_currentHC) do {
                        case 1: { 
                            _rc = _x setGroupOwner HC1_ID;
                        };
                        case 2: { 
                            _rc = _x setGroupOwner HC2_ID;
                        };
                    };
                };    
                if (_rc) then {
                    _numTransfered = _numTransfered + 1;
                };
            };
        } forEach (allGroups);  
        if (_numTransfered > 0) then {
            _numHC1 = 0;
            _numHC2 = 0;  
            {
                switch (owner ((units _x) select 0)) do {
                    case HC1_ID: { 
                        _numHC1 = _numHC1 + 1;
                    };
                    case HC2_ID: {
                        _numHC2 = _numHC2 + 1;
                    };
                };
            } forEach (allGroups);    
            if (_numHC1 > 0) then { 
                diag_log format ["passToHCs: %1 AI groups currently on HC1", _numHC1];
            };
            if (_numHC2 > 0) then { 
                diag_log format ["passToHCs: %1 AI groups currently on HC2", _numHC2]; 
            };
        };
    };
};