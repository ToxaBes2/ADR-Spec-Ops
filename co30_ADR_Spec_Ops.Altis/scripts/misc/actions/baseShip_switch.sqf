_flagPos = getPos partizan_flag;
_shipPos = [_flagPos, 10, 150, 2, 2,-1, 0] call BIS_fnc_findSafePos;

if (!isNil 'BASESHIP_SWITCH' || (_shipPos distance _flagPos) > 200) exitWith {
	["<t color='#F44336' size = '.48'>Вызов лодки недоступен</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

["<t color='#7FDA0B' size = '.48'>Вызываем лодку...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
sleep 1;

[[_shipPos], {_this call compile preProcessFileLineNumbers "scripts\misc\baseShipPartizan.sqf"}] remoteExec ["spawn", 2];
