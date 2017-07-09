private ["_xpos", "_ypos", "_size", "_agl", "_aglz", "_wait", "_trs", "_upposx", "_upposy", "_upposz"];

_xpos = _this select 0;
_ypos = _this select 1;

drop ["\a3\Data_f\kouleSvetlo.p3d", "", "Billboard", 1, 5, [_xpos, _ypos, 0], [0, 0, 0], 1, 1.3, 1, 0, [800], [[1, 0.7, 0.4, 1], [1, 0.6, 0.3, 0]], [0], 0, 0, "", "", ""];

sleep 0.1;

_size = 1200;
_agl = random 360;
_aglz = random 90;
_wait = 0.01;
_trs = 1.0;

for "_i" from 0 to 50 do {
	_dist = 1 + random 80;
	_upposx = _xpos + _dist * (sin _agl) * cos _aglz;
	_upposy = _ypos + _dist * (cos _agl) * cos _aglz;
	_upposz = abs ((sin _aglz) * _dist);

	drop ["\a3\Data_f\kouleSvetlo.p3d", "", "Billboard", 1, 5, [_upposx, _upposy, _upposz], [0, 0, 0], 1, 1.3, 1, 0, [_size], [[1, 0.7, 0.4, 1 * _trs], [1, 0.6, 0.3,0]], [0], 0, 0, "", "", ""];

	_agl = random 360;
	_aglz = random 90;
	_wait = _wait * 1.1;
	_trs = _trs * 0.95;
	sleep _wait;
};