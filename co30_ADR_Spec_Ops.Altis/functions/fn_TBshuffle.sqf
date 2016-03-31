/*
Author:	ToxaBes
Description: shuffle array by Fisher–Yates algorithm
Format: [some values] call QS_fnc_TBshuffle;
*/
private ["_idx", "_val"];
for "_i" from count _this - 1 to 1 step -1 do {
	_idx = floor random (_i + 1);
	if (_i != _idx) then {
		_val = _this select _i;
		_this set [_i, _this select _idx];
		_this set [_idx, _val]; 
	};
};

_this