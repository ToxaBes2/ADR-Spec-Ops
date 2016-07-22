/*
Select a random shoreline position based on anchor position, minimum distance, object distance and max gradient of the shoreline position.
In: [startPosition, minDistance, objectDistance, maxGradient]
Out: position

_this select 0: Center position (Array)
_this select 1: Minimum distance from the center position. Random distance if array is passed [minValue, maxValue] (Number or Array)
_this select 2: Objects within 50m cannot be closer than minDistance. -1 to ignore proximity check. Default: -1 (Number)
_this select 3: Maximum terrain steepness allowed. -1 to ignore. Default: -1 (Number)

Based on SHK_pos by shuko.
*/

private ["_startPos", "_minDist", "_objDist", "_maxGradient", "_min", "_max", "_testPos", "_d", "_l", "_a", "_p", "_i", "_returnPos"];
scopeName "main";

_startPos = _this select 0;
_minDist = if (count _this > 1) then {_this select 1} else {0};
_objDist = if (count _this > 2) then {_this select 2} else {-1};
_maxGradient = if (count _this > 3) then {_this select 3} else {-1};

// Get objects position if object is passed instead of position array
if (typename _startPos == "OBJECT") then {_startPos = getpos _startPos};

// If distance given as an array of min and max. Pick a random between them.
if (typename _minDist == "ARRAY") then {
  _min = _minDist select 0;
  _max = _minDist select 1;
  _minDist = (_min + random(_max - _min));
};

// Get position that is _minDist away from _startPos in random direction
_testPos = _startPos getPos [_minDist, random 360];

// If position is in water find the closest land position
if (surfaceIsWater _testPos) then {
    // Search for a land position starting from the randomly picked position and
    // then going outwards from it in full circles in 50m, 20 degree steps.
    _d = 50; _l = true;
    _a = selectRandom [0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320];

    while {_l && _d < 10000} do {
        for "_i" from _a to 340 step 20 do {
            _p = _testPos getPos [_d, _i];
            if (!surfaceIsWater _p) exitWith {_l = false};
        };
        _a = 0;
        _d = _d + 50;
    };

    // If land position was not found return previously found random position
    if (_l) then {
        _testPos breakOut "main";
    } else {
        _testPos = _p;
    };
};

// Check if selected land position is on a shore
if !(_testPos isFlatEmpty  [_objDist, -1, _maxGradient, _objDist max 5, 0, true, objNull] isEqualTo []) then {
    _returnPos = _testPos;
} else {
    // Search for a shore position starting from the selected land position and
    // then going outwards from it in full circles in 10m, 10 degree steps.
    _d = 10; _l = true;
    _a = selectRandom [0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320];

    while {_l && _d < 2000} do {
        scopeName "whileLoop";
        for "_i" from _a to 350 step 10 do {
            _p = _testPos getPos [_d, _i];
            if (!surfaceIsWater _p) then {
                if !(_p isFlatEmpty  [_objDist, 0, _maxGradient, _objDist max 5, 0, true, objNull] isEqualTo []) then {
                    _l = false;
                    breakOut "whileLoop";
                };
            };
        };
        _a = 0;
        _d = _d + 10;
    };

    // If shore position was not found return previously found land position
    if (_l) then {
        _returnPos = _testPos;
    } else {
        _returnPos = _p;
    };
};

// Return the final shore position
_returnPos;
