_timeout = 3600; // 60 mins
if (isNil "COMMANDER_DESCENT") then {
    COMMANDER_DESCENT = time - 1; publicVariable "COMMANDER_DESCENT";
};
_diff = COMMANDER_DESCENT - time;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Десант будет доступен через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
openMap true;
cutText ["Выберите место на карте", "PLAIN"];
onMapSingleClick "[_pos] call compile preProcessFileLineNumbers 'scripts\commander\tools\descent.sqf'; onMapSingleClick '';openMap false;true;";
COMMANDER_DESCENT = time + _timeout; publicVariable "COMMANDER_DESCENT";