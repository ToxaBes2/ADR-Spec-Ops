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
    _player = param [2, false];
    _clientId = owner _player;
    _par = "";
    _peace = "";
    _sql = "";
    _queryResult = "";
    if (!isServer) exitWith {_queryResult};      
    _connectionId = uiNamespace getVariable ["life_sql_id", ""];    
    _connectionId = format ["%1", _connectionId];
    _connectionId = [_connectionId,"{",""] call KRON_Replace;
    _connectionId = [_connectionId,"}",""] call KRON_Replace;    
    if (count _params > 0) then {
    	_par = _params joinString ":";        
        _sql = format ["0:%1:%2:%3", _connectionId, _queryName, _par];
    } else {
        _sql = format ["0:%1:%2", _connectionId, _queryName];
    };
    _queryResult = "extDB2" callExtension _sql;
    _queryResult = _queryResult splitString ","; 
    if (count _queryResult < 2) then {
    	_queryResult = format ["%1", _queryResult];
    } else {
        _queryResult = _queryResult select 1;
        _queryResult = [_queryResult,"[",""] call KRON_Replace;
        _queryResult = [_queryResult,"]",""] call KRON_Replace;
    };
    [_clientId, _queryName, _queryResult] remoteExec ["sqlResponse", _clientId];
};
sqlResponse = {
    _clientId = param [0, false];
    _queryName = param [1, ""];    
    _queryResult = param [2, false];
    _allowedLimit = 6000;
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