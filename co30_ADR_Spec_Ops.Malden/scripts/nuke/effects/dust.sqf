private ["_xpos", "_ypos", "_size", "_scl", "_dis", "_sclz", "_agl"];

_xpos = _this select 0;
_ypos = _this select 1;

sleep 2;

for "_i" from 0 to 4 do {
	_size = 0.03;
	_scl = 20;
	_dis = 0;
	_sclz = 0.6;
	_agl = random 360;

	for "_next" from 0 to 30 do {
		for "_cnt" from 0 to 35 do {
			_velx = (sin _agl) * (100 + random 150);
			_vely = (cos _agl) * (100 + random 150);

			_dis = 1 + random 0.3;
			_upposx = _xpos + ((sin _agl) * _scl * _dis);
			_upposy = _ypos + ((cos _agl) * _scl * _dis);

			_col = 0.2 - random 0.4;

			drop [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 20 + random 20,
				[_upposx, _upposy, -20], [ _velx, _vely, 0 ], 1, 1.2, 1,
				0.08 + random 0.02, [_size * 120 + random 30], [[0.55, 0.5, 0.45, 0],
				[_col + 0.55, _col + 0.5,  _col + 0.45, _sclz * 0.8],
				[_col + 0.55, _col + 0.5,  _col + 0.45, _sclz * 0.6],
				[_col + 0.5,  _col + 0.45, _col + 0.4,  _sclz * 0.4],
				[_col + 0.45, _col + 0.4,  _col + 0.35, _sclz * 0.2],
				[_col + 0.4,  _col + 0.35, _col + 0.3,  0.01]],
				[0], 0, 0.1, "", "", ""];
			drop [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 5 + random 10,
				[_upposx, _upposy, -25], [ 0, 0, 40 ], 1, 1.2, 1,
				0.08 + random 0.02, [40 + random 20], [[0.55, 0.5, 0.45, 0],
				[_col + 0.55, _col + 0.5,  _col + 0.45, _sclz * 0.8],
				[_col + 0.55, _col + 0.5,  _col + 0.45, _sclz * 0.6],
				[_col + 0.5,  _col + 0.45, _col + 0.4,  _sclz * 0.4],
				[_col + 0.45, _col + 0.4,  _col + 0.35, _sclz * 0.2],
				[_col + 0.4,  _col + 0.35, _col + 0.3,  0.01]],
				[0], 0, 0.1, "", "", ""];

			_agl = _agl + 8 + random 4;
		};
		_agl = random 360;
		_scl = _scl + 10;
		_sclz = _sclz * 0.85;
		_size = _size * 1.2;
	};
};
