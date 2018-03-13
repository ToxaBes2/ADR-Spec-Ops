_timeout = 1800; // 30 mins
if (isNil "PARTIZAN_TECHNICAL") then {
    PARTIZAN_TECHNICAL = time - 1; publicVariable "PARTIZAN_TECHNICAL";
};
_diff = PARTIZAN_TECHNICAL - time;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Технички будут доступны через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
openMap true;
cutText ["Выберите место на карте", "PLAIN"];
onMapSingleClick "[_pos] call compile preProcessFileLineNumbers 'scripts\commander\partizan_tools\technical.sqf'; onMapSingleClick '';openMap false;true;";
PARTIZAN_TECHNICAL = time + _timeout; publicVariable "PARTIZAN_TECHNICAL";