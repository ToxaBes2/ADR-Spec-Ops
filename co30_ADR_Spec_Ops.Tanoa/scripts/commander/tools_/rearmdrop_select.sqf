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
    ["<t color='#F44336' size = '.48'>Поддержка недоступна т.к. на сервере есть пилоты!</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
if (isNil "COMMANDER_MODULE") then {
    COMMANDER_MODULE = time - 1; publicVariable "COMMANDER_MODULE";
};
_diff = COMMANDER_MODULE - time;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Поддержка будет доступна через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
openMap true;
cutText ["Выберите место на карте", "PLAIN"];
onMapSingleClick "[_pos] call compile preProcessFileLineNumbers 'scripts\commander\tools\rearmdrop.sqf'; onMapSingleClick '';openMap false;true;";
COMMANDER_MODULE = time + _timeout; publicVariable "COMMANDER_MODULE";