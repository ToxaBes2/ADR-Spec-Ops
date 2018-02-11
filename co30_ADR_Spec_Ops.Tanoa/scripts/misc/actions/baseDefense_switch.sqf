if (BLUFOR_BASE_SCORE < 19) exitWith {
	["<t color='#F44336' size = '.48'>Недостаточный уровень базы</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
if (!isNil 'BASEDEFENSE_SWITCH' || BLUFOR_BASE_SCORE < 10) exitWith {
	["<t color='#F44336' size = '.48'>Защита базы недоступна</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
["<t color='#C6FF00' size = '.48'>Защита базы включена, турели активированы</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
sleep 1;
[] remoteExec ["QS_fnc_baseDefense", 2];