if (!isNil 'AIRBASEDEFENSE_SWITCH') exitWith {
	["<t color='#F44336' size = '.48'>Противовоздушная оборона не доступна</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

["<t color='#C6FF00' size = '.48'>Противовоздушная оборона активирована</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
sleep 1;

[[], {_this call compile preProcessFileLineNumbers "scripts\misc\airbaseDefense.sqf"}] remoteExec ["spawn", 2];
