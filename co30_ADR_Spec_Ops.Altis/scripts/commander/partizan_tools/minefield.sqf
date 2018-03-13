/*
Author: ToxaBes
Description: add minefield
*/
_center = _this select 0;
_blufor_base = getMarkerPos "respawn_west";
if (_center distance2D _blufor_base < 500) exitWith {
    ["<t color='#F44336' size = '.48'>Слишком близко к базе регулярной армии!</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
["<t color='#7FDA0B' size = '.48'>Постановка минного поля...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
_mineTypes = ["APERSBoundingMine", "APERSMine", "ATMine"];
_unitsArray = [];
for "_x" from 0 to 59 do {
	_mine = createMine [selectRandom [MINE_TYPES], _center, [], 50];
	resistance revealMine _mine;
	_unitsArray = _unitsArray + [_mine];
};
[_unitsArray] spawn {
	_unitsArray = _thise select 0;
	sleep 1800; // 30 mins
	{
        deleteVehicle _x;
    } forEach _unitsArray;
};