if (!isNil 'CLEARITEMSBASE_SWITCH') exitWith {
	["<t color='#F44336' size = '.48'>Очистка базы недоступна</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

["<t color='#C6FF00' size = '.48'>Очистка базы от мусора</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
sleep 1;

[[], {_this call compile preProcessFileLineNumbers "scripts\misc\clearItemsBASE.sqf"}] remoteExec ["spawn", 2];
