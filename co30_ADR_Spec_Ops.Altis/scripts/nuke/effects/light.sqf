private ["_xpos", "_ypos", "_zpos", "_light1", "_lightg1", "_scl", "_sclg"];

_xpos = _this select 0;
_ypos = _this select 1;

_light1 = "#lightpoint" createVehicle [0, 0, 0];
_light1 setPos [_xpos, _ypos, 100];
_light1 setLightBrightness 160;
_light1 setLightAmbient [1, 1, 1];
_light1 setLightColor [1, 1, 1];

_lightg1 = "#lightpoint" createVehicle [0, 0, 0];
_lightg1 setPos [_xpos, _ypos, 100];
_lightg1 setLightBrightness 60;
_lightg1 setLightAmbient [0.9, 0.6, 0.5];
_lightg1 setLightColor [0.9, 0.6, 0.5];

_scl = 1;
_sclg = 1;
_zpos = 100;

for "_cnt" from 0 to 5000 do {
	if ( _cnt == 5000 ) then {deleteVehicle _light1};

	_light1 setLightBrightness (160 * _scl);
	_light1 setPos [_xpos, _ypos, _zpos];
	_lightg1 setLightBrightness (60 * _sclg);
	_lightg1 setPos [_xpos, _ypos, _zpos];

	_zpos = _zpos + 0.5;
	_scl = _scl * 0.8;
	_sclg = _sclg * 0.995;
	sleep 0.1;
};

deleteVehicle _lightg1;
