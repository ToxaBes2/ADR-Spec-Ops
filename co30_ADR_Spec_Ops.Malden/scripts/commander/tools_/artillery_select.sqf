_timeout = 1200; // 20 mins
if (isNil "COMMANDER_ARTSTRIKE") then {
    COMMANDER_ARTSTRIKE = time - 1; publicVariable "COMMANDER_ARTSTRIKE";
};
_diff = COMMANDER_ARTSTRIKE - time;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Артподдержка будет доступна через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
openMap true;
cutText ["Выберите место на карте", "PLAIN"];
_magazine = _this select 0;
_magazine onMapSingleClick "[_this, _pos] call compile preProcessFileLineNumbers 'scripts\commander\tools\artillery.sqf'; onMapSingleClick '';openMap false;true;";
COMMANDER_ARTSTRIKE = time + _timeout; publicVariable "COMMANDER_ARTSTRIKE";