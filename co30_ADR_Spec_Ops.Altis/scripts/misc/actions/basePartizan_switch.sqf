if (isNil "BASEPARTIZAN_SWITCH" || {typename BASEPARTIZAN_SWITCH != "SCALAR"}) then {
    BASEPARTIZAN_SWITCH = 0; publicVariable "BASEPARTIZAN_SWITCH";
};
_curTime = time;
if (typename _curTime != "SCALAR") then {
    _curTime = 0;
};
_diff = BASEPARTIZAN_SWITCH - _curTime;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Эвакуация базы будет доступна через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
BASEPARTIZAN_SWITCH = _curTime + 900; publicVariable "BASEPARTIZAN_SWITCH";
if (PARTIZAN_BASE_SCORE < 28) then {
	["<t color='#7FDA0B' size = '.48'>Эвакуация базы партизан...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    [] remoteExec ["QS_fnc_basePartizanSwitch", 2];
} else {
    openMap true;
    cutText ["Выберите примерное место на карте", "PLAIN"];
	onMapSingleClick "[_pos] remoteExec ['QS_fnc_basePartizanSwitch', 2]; onMapSingleClick '';openMap false;true;";
};
