/*
Author:	ToxaBes
Description: Change in-game time speed depends of daytime
*/
private ["_dayK", "_nightK", "_delay", "_null"];
_dayK   = 2.72;
_nightK = 9;
_delay  = 120;
if (isServer) then {
    lastWeatherTime = 0; publicVariable "lastWeatherTime";        
    while {true} do {
        if ((dayTime >= 5 && dayTime <= 6) || (dayTime >= 19 && dayTime <= 20)) then {
            setTimeMultiplier (_dayK/2);
        } else {
            if (dayTime > 20 || dayTime < 5) then {
                setTimeMultiplier _nightK;            
            } else {
                setTimeMultiplier _dayK;
            };
        };        
        _null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\weather\weather.sqf"};
        sleep _delay;
    };
};