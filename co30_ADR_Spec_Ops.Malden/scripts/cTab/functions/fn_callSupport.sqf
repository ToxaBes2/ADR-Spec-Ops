
_action = _this select 0;
_pos = _this select 1;
_diff = 0;
_timeout = 3600; // 60 mins
_pilots = ["B_Helipilot_F", "B_T_Helipilot_F"];
_players = objNull;
if (isMultiplayer) then {
    _players = playableUnits;
} else {
    _players = switchableUnits;
};
_allow = true;
{
    if (_allow && (typeOf _x) in _pilots) then {
        _allow = false;
    };
} forEach _players;
if !(_allow) exitWith {
    systemChat "Поддержка недоступна т.к. на сервере есть пилоты!";
};
_level = 9999;
if !(isNil "BLUFOR_BASE_SCORE") then {
    _level = BLUFOR_BASE_SCORE;
};

if (_type == 1) then { // Боеприпасы
	if (_level < 6) exitWith {
	    systemChat "Данный вид поддержки недоступен при текущем уровне развития базы!";
	};
    _timeout = 2400; // 40 mins
    if (isNil "COMMANDER_SUPPORT") then {
        COMMANDER_SUPPORT = serverTime - 1; publicVariable "COMMANDER_SUPPORT";
    };
    _diff = COMMANDER_SUPPORT - serverTime;
    if (_diff <= 0) exitWith {
    	[_pos] call compile preProcessFileLineNumbers "scripts\commander\tools\supplydrop.sqf";
        COMMANDER_SUPPORT = serverTime + _timeout; publicVariable "COMMANDER_SUPPORT";
    }; 
};
if (_type == 2) then { // Авиаподдержка
	if (_level < 24) exitWith {
	    systemChat "Данный вид поддержки недоступен при текущем уровне развития базы!";
	};
    if (isNil "COMMANDER_AIRSUPPORT") then {
        COMMANDER_AIRSUPPORT = serverTime - 1; publicVariable "COMMANDER_AIRSUPPORT";
    };
    _diff = COMMANDER_AIRSUPPORT - serverTime;
    if (_diff <= 0) exitWith {
    	[_pos] call compile preProcessFileLineNumbers "scripts\commander\tools\blackfish.sqf";
        COMMANDER_AIRSUPPORT = serverTime + _timeout; publicVariable "COMMANDER_AIRSUPPORT";
    };  
};
if (_type == 3) then { // Десант
	if (_level < 33) exitWith {
	    systemChat "Данный вид поддержки недоступен при текущем уровне развития базы!";
	};
    if (isNil "COMMANDER_DESCENT") then {
        COMMANDER_DESCENT = serverTime - 1; publicVariable "COMMANDER_DESCENT";
    };
    _diff = COMMANDER_DESCENT - serverTime;
    if (_diff <= 0) exitWith {
    	[_pos] call compile preProcessFileLineNumbers "scripts\commander\tools\descent.sqf";
        COMMANDER_DESCENT = serverTime + _timeout; publicVariable "COMMANDER_DESCENT";
    };
};
if (_type == 4) then { // Ремонтный
	if (_level < 6) exitWith {
	    systemChat "Данный вид поддержки недоступен при текущем уровне развития базы!";
	};
    if (isNil "COMMANDER_MODULE") then {
        COMMANDER_MODULE = serverTime - 1; publicVariable "COMMANDER_MODULE";
    };
    _diff = COMMANDER_MODULE - serverTime;
    if (_diff <= 0) exitWith {
    	[_pos] call compile preProcessFileLineNumbers "scripts\commander\tools\repairdrop.sqf";
        COMMANDER_MODULE = serverTime + _timeout; publicVariable "COMMANDER_MODULE";
    };
};
if (_type == 5) then { // Топливный
	if (_level < 6) exitWith {
	    systemChat "Данный вид поддержки недоступен при текущем уровне развития базы!";
	};
    if (isNil "COMMANDER_MODULE") then {
        COMMANDER_MODULE = serverTime - 1; publicVariable "COMMANDER_MODULE";
    };
    _diff = COMMANDER_MODULE - serverTime;
    if (_diff <= 0) exitWith {
    	[_pos] call compile preProcessFileLineNumbers "scripts\commander\tools\refueldrop.sqf";
        COMMANDER_MODULE = serverTime + _timeout; publicVariable "COMMANDER_MODULE";
    };
};
if (_type == 6) then { // Боеприпасы
	if (_level < 6) exitWith {
	    systemChat "Данный вид поддержки недоступен при текущем уровне развития базы!";
	};
    if (isNil "COMMANDER_MODULE") then {
        COMMANDER_MODULE = serverTime - 1; publicVariable "COMMANDER_MODULE";
    };
    _diff = COMMANDER_MODULE - serverTime;
    if (_diff <= 0) exitWith {
    	[_pos] call compile preProcessFileLineNumbers "scripts\commander\tools\rearmdrop.sqf";
        COMMANDER_MODULE = serverTime + _timeout; publicVariable "COMMANDER_MODULE";
    };
};
if (_type == 7) then { // Дымовые
	if (_level < 15) exitWith {
	    systemChat "Данный вид поддержки недоступен при текущем уровне развития базы!";
	};
    _timeout = 1200; // 20 mins
    if (isNil "COMMANDER_ARTSTRIKE") then {
        COMMANDER_ARTSTRIKE = serverTime - 1; publicVariable "COMMANDER_ARTSTRIKE";
    };
    _diff = COMMANDER_ARTSTRIKE - serverTime;
    if (_diff <= 0) exitWith {
    	["6Rnd_155mm_Mo_smoke", _pos] call compile preProcessFileLineNumbers "scripts\commander\tools\artillery.sqf";
        COMMANDER_ARTSTRIKE = serverTime + _timeout; publicVariable "COMMANDER_ARTSTRIKE";
    };
};
if (_type == 8) then { // Управляемые
	if (_level < 15) exitWith {
	    systemChat "Данный вид поддержки недоступен при текущем уровне развития базы!";
	};
    _timeout = 1200; // 20 mins
    if (isNil "COMMANDER_ARTSTRIKE") then {
        COMMANDER_ARTSTRIKE = serverTime - 1; publicVariable "COMMANDER_ARTSTRIKE";
    };
    _diff = COMMANDER_ARTSTRIKE - serverTime;
    if (_diff <= 0) exitWith {
    	["2Rnd_155mm_Mo_guided", _pos] call compile preProcessFileLineNumbers "scripts\commander\tools\artillery.sqf";
        COMMANDER_ARTSTRIKE = serverTime + _timeout; publicVariable "COMMANDER_ARTSTRIKE";
    };
};
if (_type == 9) then { // Фугасные
	if (_level < 15) exitWith {
	    systemChat "Данный вид поддержки недоступен при текущем уровне развития базы!";
	};
    _timeout = 1200; // 20 mins
    if (isNil "COMMANDER_ARTSTRIKE") then {
        COMMANDER_ARTSTRIKE = serverTime - 1; publicVariable "COMMANDER_ARTSTRIKE";
    };
    _diff = COMMANDER_ARTSTRIKE - serverTime;
    if (_diff <= 0) exitWith {
    	["32Rnd_155mm_Mo_shells", _pos] call compile preProcessFileLineNumbers "scripts\commander\tools\artillery.sqf";
        COMMANDER_ARTSTRIKE = serverTime + _timeout; publicVariable "COMMANDER_ARTSTRIKE";
    };
};
if (_type == 10) then { // Машина
    if (isNil "COMMANDER_CARSUPPORT") then {
        COMMANDER_CARSUPPORT = serverTime - 1; publicVariable "COMMANDER_CARSUPPORT";
    };
    _diff = COMMANDER_CARSUPPORT - serverTime;
    if (_diff <= 0) exitWith {
    	[_pos] call compile preProcessFileLineNumbers "scripts\commander\tools\cardrop.sqf";
        COMMANDER_CARSUPPORT = serverTime + _timeout; publicVariable "COMMANDER_CARSUPPORT";
    }; 
};

if (_diff > 0) exitWith {
    _diff = ceil (_diff/60);
    systemChat format ["Поддержка будет доступна через %1 мин", _diff];
};
