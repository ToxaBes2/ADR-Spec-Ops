if (!isNil 'BASEPARTIZAN_SWITCH') exitWith {
	["<t color='#F44336' size = '.48'>Эвакуация базы недоступна</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

["<t color='#7FDA0B' size = '.48'>Эвакуация базы партизан...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
sleep 1;

[[], {_this call compile preProcessFileLineNumbers "scripts\misc\basePartizan.sqf"}] remoteExec ["spawn", 2];
