/*
	File: findSafePos.sqf
	Author: Joris-Jan van 't Land

	Description:
	Function to retrieve and dynamic position in the world according to several parameters.

	Parameter(s):
	_this select 0: center position (Array)
						Note: passing [] (empty Array), the world's safePositionAnchor entry will be used.
	_this select 1: minimum distance from the center position (Number)
	_this select 2: maximum distance from the center position (Number)
						Note: passing -1, the world's safePositionRadius entry will be used.
	_this select 3: minimum distance from the nearest object (Number)
	_this select 4: water mode (Number)
						0: cannot be in water
						1: can either be in water or not
						2: must be in water
	_this select 5: maximum terrain gradient (average altitude difference in meters - Number)
	_this select 6: shore mode (Number):
						0: does not have to be at a shore
						1: must be at a shore
	_this select 7: (optional) blacklist (Array of Arrays):
						(_this select 7) select X: Top-left and bottom-right coordinates of blacklisted area (Array)
	_this select 8: (optional) default positions (Array of Arrays):
						(_this select 8) select 0: default position on land (Array)
						(_this select 8) select 1: default position on water (Array)
	
	Returns:
	Coordinate array with a position solution.
	
	TODO:
	* Maybe allow passing several combinations of position, min and max dist ... so that you can 
	avoid several things?
	* Interpretation of minDist / maxDist is wrong. It's not true distance that is used. Too bad?
*/
scopeName "main";
private ["_pos", "_minDist", "_maxDist", "_objDist", "_waterMode", "_maxGradient", "_shoreMode", "_defaultPos", "_blacklist"];
_pos = _this select 0;
_minDist = _this select 1;
_maxDist = _this select 2;
_objDist = _this select 3;
_waterMode = _this select 4;
_maxGradient = _this select 5;
_shoreMode = _this select 6;
_result = [];
if (_shoreMode == 0) then {_shoreMode = false} else {_shoreMode = true};
_blacklist = [];
if ((count _this) > 7) then {
	_blacklist = _this select 7;
};
_defaultPos = [];
if ((count _this) > 8) then {
	_defaultPos = _this select 8;
};
//See if default world values should be used.
if ((count _pos) == 0) then {
	_pos = getArray(configFile >> "CfgWorlds" >> worldName >> "safePositionAnchor");
};
if ((count _pos) == 0) exitWith {debugLog "Log: [findSafePos] No center position was passed!"; []};
if (_maxDist == -1) then {
	_maxDist = getNumber(configFile >> "CfgWorlds" >> worldName >> "safePositionRadius");
};
private ["_newPos", "_posX", "_posY"];
_newPos = [];
_posX = _pos select 0;
_posY = _pos select 1;
private ["_attempts"];
_attempts = 0;
while {_attempts < 1000} do {
	private ["_newX", "_newY", "_testPos"];
	_newX = _posX + (_maxDist - (random (_maxDist * 2)));
	_newY = _posY + (_maxDist - (random (_maxDist * 2)));
	_testPos = [_newX, _newY];
	if (!([_testPos, _blacklist] call BIS_fnc_isPosBlacklisted)) then {
		if ((_pos distance _testPos) >= _minDist) then {
			if (!((count (_testPos isFlatEmpty [_objDist, 0, _maxGradient, _objDist max 5, _waterMode, _shoreMode, objNull])) == 0)) then {
				_newPos = _testPos;
				breakTo "main";
			};
		};
	};
	_attempts = _attempts + 1;
};
if ((count _newPos) == 0) then {
	_newPos = [0,0,0];
	if (_waterMode == 0) then {
		if ((count _defaultPos) > 0) then {
			_newPos = _defaultPos select 0;		
	    };
	} else {
		if ((count _defaultPos) > 1) then {
			_newPos = _defaultPos select 1;
		};
	};
};
if (_newPos distance2D _pos > (_maxDist*1.2)) then {
    _result = selectBestPlaces [_pos, _maxDist, "meadow", 1, 1];
    if (count _result > 0) then {
        _result = _result select 0;
        if ((_result select 1) >= 0.87) then {
            _newPos = _result select 0;
        };
    };
    if ((count _newPos) == 0) then {
        _newPos = [0,0,0];
        _log = format ["error: safe position not found, start pos: %1, max distance: %2, gradient: %3", _pos, _maxDist, _maxGradient];
        _log call BIS_fnc_log;
    };
};
_newPos