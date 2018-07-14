/*
    Author: ToxaBes
    Description: call sql query via extDB custom v2 
    Note: this module use several functions from String Functions Library (started with "KRON_") developed by Kronzky.
    Parameters: 
        0 - STRING (Query name to be ran).
        1 - ARRAY (params)
    Example:        
        _uid = getPlayerUID player;                
        _clientId = owner player; // 0 for server
        ["getPlayerHours",[_uid], _clientId] remoteExec ["sqlServerCall", 2];
*/
sqlServerCall = {
    _queryName = param [0, ""];
    _params = param [1, []];
    _player = param [2, 0];
    _clientId = 0;
    if (typeName _player == "OBJECT") then {
        _clientId = owner _player;
    };   
    _par = "";
    _peace = "";
    _sql = "";
    _queryResult = "";
    if (!isServer) exitWith {_queryResult};      
    _connectionId = "sql";   
    if (count _params > 0) then {
        _par = _params joinString ":";        
        _sql = format ["0:%1:%2:%3", _connectionId, _queryName, _par];
    } else {
        _sql = format ["0:%1:%2", _connectionId, _queryName];
    };
    _queryResult = "extDB3" callExtension _sql;
    if (_clientId > 0) then {          
        _queryResult = _queryResult splitString ","; 
        if (count _queryResult < 2) then {
            _queryResult = format ["%1", _queryResult];
        } else {
            _queryResult = _queryResult select 1;
            _queryResult = [_queryResult,"[",""] call KRON_Replace;
            _queryResult = [_queryResult,"]",""] call KRON_Replace;
        };
    };
    [_clientId, _queryName, _queryResult] remoteExec ["sqlResponse", _clientId];
};
sqlResponse = {
    _clientId = param [0, false];
    _queryName = param [1, ""];    
    _queryResult = param [2, false];
    _allowedLimit = 6000;
    _allowedPilotLimit = 120;
    switch _queryName do {
        case "getPlayerHours": {
            _hrs = 0;
            _queryResult = _queryResult call BIS_fnc_parseNumber;
            if (typeName _queryResult == "ARRAY") then {
                if (getPlayerUID player == "76561198114622790") then {                   
                    _queryResult = _allowedLimit + 1; // for local tests
                } else {
                    _queryResult = 0;
                };                
            };
            if (_queryResult <= _allowedLimit) then {
                if (_queryResult == 0 || !(finite _queryResult)) then {
                    _hrs = 0;
                } else {
                    _hrs = floor (_queryResult / 60);
                };              
                _text = format["Слоты партизан доступны только после 100 часов игры на сервере!\nВаше время: %1 ч.", _hrs];
                0 cutText[_text, "BLACK FADED"];
                0 cutFadeOut 99999;
                sleep 6;
                ["end1", false, 2, false] call BIS_fnc_endMission;
            } else {
                0 cutText["", "BLACK IN"];
            };
        };
        case "getPilotHours": {
            _hrs = 0;
            _queryResult = _queryResult call BIS_fnc_parseNumber;
            if (typeName _queryResult == "ARRAY") then {
                if (getPlayerUID player == "76561198114622790") then {                   
                    _queryResult = _allowedPilotLimit + 1; // for local tests
                } else {
                    _queryResult = 0;
                };                
            };
            if (_queryResult <= _allowedPilotLimit) then {
                if (_queryResult == 0 || !(finite _queryResult)) then {
                    _hrs = 0;
                } else {
                    _hrs = floor (_queryResult / 60);
                };              
                _text = format["Слоты пилотов доступны только после 2х часов игры на сервере!\nВаше время: %1 ч.", _hrs];
                0 cutText[_text, "BLACK FADED"];
                0 cutFadeOut 99999;
                sleep 6;
                ["end1", false, 2, false] call BIS_fnc_endMission;
            } else {
                0 cutText["", "BLACK IN"];
            };
        };
        case "getPartizanItems": { 
            clearWeaponCargoGlobal partizan_ammo;
            clearItemCargoGlobal partizan_ammo;
            clearMagazineCargoGlobal partizan_ammo;
            clearBackpackCargoGlobal partizan_ammo;
            _queryResult = call compile _queryResult;                
            _queryResult = _queryResult select 1; 
            {
                _item = _x select 0;
                _qty = _x select 1;
                _type = _x select 2;
                switch (_type) do { 
                    case "weapon" :   {partizan_ammo addWeaponCargoGlobal [_item, _qty];}; 
                    case "magazine" : {partizan_ammo addMagazineCargoGlobal [_item, _qty];};
                    case "uniform" :  {partizan_ammo addItemCargoGlobal [_item, _qty];}; 
                    case "vest" :     {partizan_ammo addItemCargoGlobal [_item, _qty];}; 
                    case "backpack" : {partizan_ammo addBackpackCargoGlobal [_item, _qty];}; 
                    case "headgear" : {partizan_ammo addItemCargoGlobal [_item, _qty];};
                    case "glassess" : {partizan_ammo addItemCargoGlobal [_item, _qty];};
                    case "item" :     {partizan_ammo addItemCargoGlobal [_item, _qty];};
                    default {}; 
                };                   
            } forEach _queryResult;             
        };
        case "getRewardsBlufor": {
            _queryResult = call compile _queryResult;
            if (typeName _queryResult == "ARRAY") then {
                if (count _queryResult > 1) then {
                    _queryResult = _queryResult select 1;
                    BLUFOR_REWARDS_LIST = [];
                    {
                        BLUFOR_REWARDS_LIST pushBack [_x select 0, _x select 1, false];
                    } forEach _queryResult;
                    publicVariable "BLUFOR_REWARDS_LIST";  
                };
            };
        };
        case "getRewardsPartizans": {
            _queryResult = call compile _queryResult;
            if (typeName _queryResult == "ARRAY") then {
                if (count _queryResult > 1) then {
                    _queryResult = _queryResult select 1;
                    PARTIZAN_REWARDS_LIST = []; 
                    {
                        PARTIZAN_REWARDS_LIST pushBack [_x select 0, _x select 1, false];
                    } forEach _queryResult;
                    publicVariable "PARTIZAN_REWARDS_LIST";  
                };
            };
        };
        case "getAvanpostPartizans": {
            _queryResult = call compile _queryResult;
            if (typeName _queryResult == "ARRAY") then {
                if (count _queryResult > 1) then {
                    _queryResult = _queryResult select 1;
                    if (count _queryResult > 0) then {
                        {
                            [_x] call QS_fnc_addAvanpost;
                        } forEach _queryResult;              
                    };
                };
            };
        };
       case "getWeather": {
            _queryResult = call compile _queryResult;  
            if (isNil "_queryResult") exitWith {};          
            if (typeName _queryResult == "ARRAY") then {
                if (count _queryResult > 1) then {
                    _queryResult = _queryResult select 1; 
                    //diag_log format ["weather result: %1", _queryResult];
                    _fog = 0;
                    _delay = 1200;
                    {
                        _param = _x select 0;
                        _value = _x select 1;
                        switch (_param) do { 
                            case "overcast": {
                                _delay setOvercast _value;
                            }; 
                            case "wind": {
                                _delay setWindStr _value;
                                _delay setWindForce _value;
                            }; 
                            case "wind_dir": {
                                _delay setWindDir _value;
                            };
                            case "wind_gusts": {
                                //_delay setGusts _value;
                            };
                            case "waves": {
                                _delay setWaves _value;
                            };
                            case "rain": {
                                _delay setRain _value;
                            };
                            case "ligthning": {
                                _delay setLightnings _value;
                            };
                            case "fog": {
                                _value = _value / 2;
                                _fog = _value;
                                _delay setFog _value;
                            };
                        };                       
                    } forEach _queryResult;  
                    simulWeatherSync; 
                    if (lastWeatherTime == 0) then {
                        forceWeatherChange;
                        if (_fog == 0) then {
                            0 setFog 0; 
                        };
                    } else {
                        _null = [_delay, _fog] spawn { 
                            sleep (_this select 0);   
                            forceWeatherChange;
                            _fog = _this select 1; 
                            if (_fog == 0) then {
                                0 setFog 0; 
                            };
                        };
                    };                    
                };
            };
        };
        case "getBaseScorePartizan": {
            _scorePartizan = 0;            
            _queryResult = _queryResult call BIS_fnc_parseNumber;            
            if !(typeName _queryResult == "ARRAY") then {
                _scorePartizan = 0;
            } else {
                _queryResult = _queryResult select 1;
                while {typeName _queryResult == "ARRAY"} do {
                    _queryResult = _queryResult select 0;
                };
                _scorePartizan = _queryResult;
            };
            PARTIZAN_BASE_SCORE = _scorePartizan; publicVariable "PARTIZAN_BASE_SCORE";
        };
        case "getBaseScoreBlufor": {
            _scoreBlufor = 0;            
            _queryResult = _queryResult call BIS_fnc_parseNumber;            
            if !(typeName _queryResult == "ARRAY") then {
                _scoreBlufor = 0;
            } else {
                _queryResult = _queryResult select 1;
                while {typeName _queryResult == "ARRAY"} do {
                    _queryResult = _queryResult select 0;
                };
                _scoreBlufor = _queryResult;
            };
            BLUFOR_BASE_SCORE = _scoreBlufor; publicVariable "BLUFOR_BASE_SCORE";
        };
        case "setRequest": {
            ["getRequestId",[], 0] remoteExec ["sqlServerCall", 2];
        };
        case "getRequestId": {
            _queryResult = _queryResult call BIS_fnc_parseNumber;    
            _last_id = 0;        
            if !(typeName _queryResult == "ARRAY") then {
                _last_id = 0;
            } else {
                _queryResult = _queryResult select 1;
                while {typeName _queryResult == "ARRAY"} do {
                    _queryResult = _queryResult select 0;
                };
                _last_id = _queryResult;
            };
            missionNamespace setVariable ["LAST_REQUEST_ID", _last_id];
        };
        case "getRequest": {
            _queryResult = call compile _queryResult;  
            if (isNil "_queryResult") exitWith {};          
            if (typeName _queryResult == "ARRAY") then {
                if (count _queryResult > 1) then {
                    _queryResult = _queryResult select 1; 
                    if (typeName _queryResult == "ARRAY") then {
                        if (count _queryResult > 0) then {
                            _queryResult = _queryResult select 0;
                        };
                    };
                    //systemChat format ["RQ: %1", _queryResult]; 
                    [_queryResult] call QS_fnc_executeRQ;    
                };
            };
        };
    };           
};
KRON_StrToArray = {
    private["_in","_i","_arr","_out"];
    _in=_this select 0;
    _arr = toArray(_in);
    _out=[];
    for "_i" from 0 to (count _arr)-1 do {
        _out=_out+[toString([_arr select _i])];
    };
    _out
};
KRON_StrLen = {
    private["_in","_arr","_len"];
    _in=_this select 0;
    _arr=[_in] call KRON_StrToArray;
    _len=count (_arr);
    _len
};
KRON_Replace = {
    private["_str","_old","_new","_out","_tmp","_jm","_la","_lo","_ln","_i"];
    _str=_this select 0;
    _arr=toArray(_str);
    _la=count _arr;
    _old=_this select 1;
    _new=_this select 2;
    _na=[_new] call KRON_StrToArray;
    _lo=[_old] call KRON_StrLen;
    _ln=[_new] call KRON_StrLen;
    _out="";
    for "_i" from 0 to (count _arr)-1 do {
        _tmp="";
        if (_i <= _la-_lo) then {
            for "_j" from _i to (_i+_lo-1) do {
                _tmp=_tmp + toString([_arr select _j]);
            };
        };
        if (_tmp==_old) then {
            _out=_out+_new;
            _i=_i+_lo-1;
        } else {
            _out=_out+toString([_arr select _i]);
        };
    };
    _out
};