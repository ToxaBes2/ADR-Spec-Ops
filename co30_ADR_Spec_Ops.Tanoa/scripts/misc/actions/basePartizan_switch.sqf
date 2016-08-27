if (isNil "BASEPARTIZAN_SWITCH") then {
    BASEPARTIZAN_SWITCH = time - 1; publicVariable "BASEPARTIZAN_SWITCH";
};
_diff = BASEPARTIZAN_SWITCH - time;
if (_diff > 0) exitWith {
	_diff = ceil (_diff/60);
    [format ["<t color='#F44336' size = '.48'>Эвакуация базы будет доступна через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
["<t color='#7FDA0B' size = '.48'>Эвакуация базы партизан...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
BASEPARTIZAN_SWITCH = time + 120; publicVariable "BASEPARTIZAN_SWITCH";
sleep 1;
[] remoteExec ["QS_fnc_basePartizanSwitch", 2];
