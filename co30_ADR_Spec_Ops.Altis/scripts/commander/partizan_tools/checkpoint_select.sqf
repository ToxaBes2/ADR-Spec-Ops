_timeout = 1800; // 30 mins
if (isNil "PARTIZAN_CHECKPOINT") then {
    PARTIZAN_CHECKPOINT = time - 1; publicVariable "PARTIZAN_CHECKPOINT";
};
_diff = PARTIZAN_CHECKPOINT - time;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Блокопст будет доступен через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
openMap true;
cutText ["Выберите место на карте", "PLAIN"];
onMapSingleClick "[_pos] call compile preProcessFileLineNumbers 'scripts\commander\partizan_tools\checkpoint.sqf'; onMapSingleClick '';openMap false;true;";
PARTIZAN_CHECKPOINT = time + _timeout; publicVariable "PARTIZAN_CHECKPOINT";