if (!isNil 'BASEDEFENSE_SWITCH') exitWith {
	["<t color='#F44336' size = '.48'>Защита базы недоступна</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

["<t color='#C6FF00' size = '.48'>Защита базы включена, турели активированы</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
sleep 1;

[[], {_this call compile preProcessFileLineNumbers "scripts\misc\baseDefense.sqf"}] remoteExec ["spawn", 2];
