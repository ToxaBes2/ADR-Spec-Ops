/*
Author: ToxaBes
Description: call partizan vehicles
*/
_player = _this select 1;
_type = _this select 3;
_pos = getPos _player;
_timeout = 3600;

if (_type == 1) then {
	if (PARTIZAN_BASE_SCORE < 5) exitWith {
        ["<t color='#F44336' size = '.48'>Вызов грузовика недоступен на данном уровне базы</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
	};
	_groundPos = [_pos, 5, 40, 2, 0, 10, 0, []] call QS_fnc_findSafePos;
    if (format ["%1", _groundPos] == "[0,0,0]") exitWith {
        ["<t color='#F44336' size = '.48'>Нет места для вызова техники</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };
    called_time = _player getVariable ["PARTIZAN_CAR", nil];
    if (isNil "called_time") then {
        called_time = time - 1;
        _player setVariable ["PARTIZAN_CAR", called_time];
    };
    _diff = called_time - time;
    if (_diff > 0) exitWith {
        _diff = ceil (_diff/60);
        [format ["<t color='#F44336' size = '.48'>Вызов грузовика будет доступен через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };    
    _vehs = ["I_C_Van_01_transport_F","I_C_Van_02_transport_F","I_G_Van_01_transport_F","I_G_Van_02_transport_F"];
    _veh = selectRandom _vehs;
    _veh createVehicle _groundPos;
    called_time = time + _timeout;
    _player setVariable ["PARTIZAN_CAR", called_time];
    ["<t color='#7FDA0B' size = '.48'>Вызов техники...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

// quadbike
if (_type == 2) then {
	if (PARTIZAN_BASE_SCORE < 14) exitWith {
        ["<t color='#F44336' size = '.48'>Вызов гидроцикла недоступен на данном уровне базы</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
	};
    _groundPos = [_pos, 10, getDir _player] call BIS_fnc_relPos;
    if !(surfaceIsWater _groundPos) exitWith {
        ["<t color='#F44336' size = '.48'>Нет места для вызова техники</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };
    called_time = _player getVariable ["PARTIZAN_HYDROCYCLE", nil];
    if (isNil "called_time") then {
        called_time = time - 1;
        _player setVariable ["PARTIZAN_HYDROCYCLE", called_time];
    };
    _diff = called_time - time;
    if (_diff > 0) exitWith {
        _diff = ceil (_diff/60);
        [format ["<t color='#F44336' size = '.48'>Вызов гидроцикла будет доступен через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };    
    _vehs = ["C_Scooter_Transport_01_F"];
    _veh = selectRandom _vehs;
    _veh createVehicle _groundPos;
    called_time = time + _timeout;
    _player setVariable ["PARTIZAN_HYDROCYCLE", called_time];
    ["<t color='#7FDA0B' size = '.48'>Вызов техники...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

// air
_air = [
    [26846.9,24554.8,40],
    [23146.8,18932.6,180],
    [21070.9,7072.49,11],
    [14168.1,16190.9,107],
    [11690.2,11936.3,213],
    [9230.47,21601.3,148]
];
if (_type == 3) then {
    if (worldName == "Malden") then {
        _air = [
            [784.838,12196.6,323],
            [8013.42,10626.5,82]
        ];
    };
    if (worldName == "Tanoa") then {
        _air = [
            [2238.77,13409.1,144],
            [2129.59,3456.56,347],
            [11703.3,3152.32,215],
            [11841.2,13072,15],
            [7007.31,7678.84,82]
        ];
    };
    if (PARTIZAN_BASE_SCORE < 14) exitWith {
        ["<t color='#F44336' size = '.48'>Вызов самолета недоступен на данном уровне базы</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
	};
    _groundPos = [0,0,0];
    _groundDir = 0;
    _distance = 999999;
    {
        _tmpPos = [_x select 0, _x select 1];
        _tmpDir = _x select 2;
        if (_pos distance2D _tmpPos < _distance) then {
        	_groundPos = _tmpPos;
            _groundDir = _tmpDir;
            _distance = _pos distance2D _groundPos;
        };
    } forEach _air;
    if (format ["%1", _groundPos] == "[0,0,0]") exitWith {
        ["<t color='#F44336' size = '.48'>Нет места для вызова техники</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };
    called_time = _player getVariable ["PARTIZAN_AIR", nil];
    if (isNil "called_time") then {
        called_time = time - 1;
        _player setVariable ["PARTIZAN_AIR", called_time];
    };
    _diff = called_time - time;
    if (_diff > 0) exitWith {
        _diff = ceil (_diff/60);
        [format ["<t color='#F44336' size = '.48'>Вызов самолета будет доступен через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };    
    _vehs = ["C_Plane_Civil_01_F","C_Plane_Civil_01_racing_F"];
    _veh = selectRandom _vehs;
    _v = _veh createVehicle _groundPos;
    _v setDir _groundDir;
    called_time = time + _timeout;
    _player setVariable ["PARTIZAN_AIR", called_time];
    ["<t color='#7FDA0B' size = '.48'>Вызов техники...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};

// heli
_heli = [
    [26787.5,24622.3,127],
    [23044,18883.6,100],
    [20797.8,7228.28,142],
    [14245.4,16228.5,304],
    [11578.4,11908.2,120],
    [9188.34,21663.9,148]
];
if (_type == 4) then {
	if (worldName == "Malden") then {
        _heli = [
            [773.53,12138.6,0],
            [8005.64,10683.6,82]
        ];
    };
    if (worldName == "Tanoa") then {
        _heli = [
            [2419.51,13337.3,180],
            [2158.88,3459.42,347],
            [11745,3145.43,215],
            [11790.5,13085.5,15],
            [6998.36,7622.02,82]
        ];
    };
    if (PARTIZAN_BASE_SCORE < 32) exitWith {
        ["<t color='#F44336' size = '.48'>Вызов вертолета недоступен на данном уровне базы</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
	};
    _groundPos = [0,0,0];
    _groundDir = 0;
    _distance = 999999;
    {
        _tmpPos = [_x select 0, _x select 1];
        _tmpDir = _x select 2;
        if (_pos distance2D _tmpPos < _distance) then {
        	_groundPos = _tmpPos;
            _groundDir = _tmpDir;
            _distance = _pos distance2D _groundPos;
        };
    } forEach _heli;
    if (format ["%1", _groundPos] == "[0,0,0]") exitWith {
        ["<t color='#F44336' size = '.48'>Нет места для вызова техники</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };
    called_time = _player getVariable ["PARTIZAN_HELI", nil];
    if (isNil "called_time") then {
        called_time = time - 1;
        _player setVariable ["PARTIZAN_HELI", called_time];
    };
    _diff = called_time - time;
    if (_diff > 0) exitWith {
        _diff = ceil (_diff/60);
        [format ["<t color='#F44336' size = '.48'>Вызов вертолета будет доступен через %1 мин</t>", _diff], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    };    
    _vehs = ["C_Heli_Light_01_civil_F","I_C_Heli_Light_01_civil_F"];
    _veh = selectRandom _vehs;
    _v = _veh createVehicle _groundPos;
    _v setDir _groundDir;
    called_time = time + _timeout;
    _player setVariable ["PARTIZAN_HELI", called_time];
    ["<t color='#7FDA0B' size = '.48'>Вызов техники...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
