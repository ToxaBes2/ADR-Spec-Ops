/*
Author:	ToxaBes
Description: Change weather by real date/month and in-game time
*/
private ["_delay", "_days", "_hours", "_hour", "_null", "_deltaDay", "_deltaMonth", "_curDate", "_curMonth", "_resDate", "_resMonth", "_dayOfYear", "_row", "_data", "_wind", "_waves", "_rand"];
_delay = 1200;
_days = [0, 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
_hours = [5, 9, 12, 15, 18];
_hour = floor (date select 3);
if (lastWeatherTime == _hour) exitWith {};
if (_hour in _hours) then {
    _deltaDay = (missionStart select 2) - (date select 2); 
    _deltaMonth = (missionStart select 1) - (date select 1);
    _curDate  = date select 2;
    _curMonth = date select 1;
    _resDate  = _curDate + _deltaDay;
    _resMonth = _curMonth + _deltaMonth;
    if (_resDate < 0) then {
    	_resDate = 30 - _resDate;
    };
    if (_resMonth < 0) then {
    	_resMonth = 12 - _resMonth;
    };
    while {_resDate > 31} do {
    	_resDate = _resDate - 31;
    	_resMonth = _resMonth + 1;
    };
    if (_resMonth > 12) then {
        _resMonth = _resMonth - 12;	
    };
    _dayOfYear = (_days select _resMonth) + _resDate;
    if (_dayOfYear > 365 || _dayOfYear <= 0) then {
        _dayOfYear = 365;	
    };        
    _n = 1;
    switch (_hour) do { 
    	case 5 :  { _n = 1; }; 
    	case 9 :  { _n = 2; };
    	case 12 : { _n = 3; };
    	case 15 : { _n = 4; };
    	case 18 : { _n = 5; }; 
    	default   { _n = 1; }; 
    };
    _row = ((_dayOfYear - 1) * 5) + _n;
    if (_row > 1825) then {
        _row = 1825;
    };
    _data = [_row] call compile preprocessFileLineNumbers "scripts\weather\data.sqf"; 
    _waves = _data select 5;
    _wind = _data select 7;
    if (_waves == 0 && _wind == 0) then {
        _rand = (floor (random 3)) / 10;
        _waves = _rand;
        _wind = _rand;
    };
    _delay setOvercast (_data select 0);
    _delay setRain (_data select 1);
    _delay setFog [_data select 2, _data select 3, _data select 4];
    _delay setWaves _waves;
    _delay setRainbow (_data select 6);
    _delay setWindStr _wind;
    _delay setWindForce _wind;
    _delay setLightnings (_data select 8);
    simulWeatherSync;
    if (lastWeatherTime == 0) then {
        forceWeatherChange;
    } else {
        _null = [_delay] spawn { 
            sleep (_this select 0);   
            forceWeatherChange;
        };
    };      

    // save info in DB
    try {
        ["clearWeather",[], 0] remoteExec ["sqlServerCall", 2];
        ["setWeather",["overcast", _data select 0], 0] remoteExec ["sqlServerCall", 2];
        ["setWeather",["rain", _data select 1], 0] remoteExec ["sqlServerCall", 2];
        ["setWeather",["fog", _data select 2], 0] remoteExec ["sqlServerCall", 2];
        ["setWeather",["fogDecay", _data select 3], 0] remoteExec ["sqlServerCall", 2];
        ["setWeather",["fogBase", _data select 4], 0] remoteExec ["sqlServerCall", 2];
        ["setWeather",["waves", _waves], 0] remoteExec ["sqlServerCall", 2];
        ["setWeather",["wind", _wind], 0] remoteExec ["sqlServerCall", 2];
        ["setWeather",["lightning", _data select 8], 0] remoteExec ["sqlServerCall", 2];
    } catch {};
} else {
    if (_hour == 20) then {
        _delay setOvercast 0;
        _delay setRain 0;
        _delay setFog [0, 0, 0];
        0 setRainbow 0;
        0 setLightnings 0;
        _rand = (random 10) / 10;
        _delay setWaves _rand;    
        _delay setWindStr _rand;
        _delay setWindForce _rand;
        simulWeatherSync;
        if (lastWeatherTime == 0) then {
            forceWeatherChange;            
        } else {
            _null = [_delay] spawn { 
                sleep (_this select 0);   
                forceWeatherChange;
            };
        };

        // save info in DB
        try {
            ["clearWeather",[], 0] remoteExec ["sqlServerCall", 2];
            ["setWeather",["overcast", 0], 0] remoteExec ["sqlServerCall", 2];
            ["setWeather",["rain", 0], 0] remoteExec ["sqlServerCall", 2];
            ["setWeather",["fog", 0], 0] remoteExec ["sqlServerCall", 2];
            ["setWeather",["fogDecay", 0], 0] remoteExec ["sqlServerCall", 2];
            ["setWeather",["fogBase", 0], 0] remoteExec ["sqlServerCall", 2];
            ["setWeather",["waves", _rand], 0] remoteExec ["sqlServerCall", 2];
            ["setWeather",["wind", _rand], 0] remoteExec ["sqlServerCall", 2];
            ["setWeather",["lightning", 0], 0] remoteExec ["sqlServerCall", 2];
        } catch {};
    };
};
lastWeatherTime = _hour; publicVariable "lastWeatherTime";