/*
Spawn Viper group in a forest at _minDistanceFromStart meters away from _attackPosition, at least _minDistanceFromPlayers meters away from nearby players, use specified faction (CSAT or CSAT Pacific).
In: [_attackPosition, _minDistanceFromStart, _minDistanceFromPlayers, _pacificFaction, _groupSide]
Out: Viper group

_this select 0: Center position to atack (Array)
_this select 1: Minimum distance from the center position. Random distance if array is passed [minValue, maxValue]. Default: 0 (Number or Array)
_this select 2: Minimum distance from players. Random distance if array is passed [minValue, maxValue]. Default: 0(Number or Array)
_this select 3: Use CSAT Pacific faction, instead of CSAT. Default: true (Bool)
_this select 4: Side of the group. Default: EAST (String)
*/

private ["_minDistanceFromStart", "_attackPosition", "_minDistanceFromPlayers", "_pacificFaction", "_groupSide", "_min", "_minDist", "_max", "_dist", "_search", "_players", "_testPos", "_i", "_distance", "_forestPos", "_viperGroup"];

_attackPosition = _this select 0;
_minDistanceFromStart = if (count _this > 1) then {_this select 1} else {0};
_minDistanceFromPlayers = if (count _this > 2) then {_this select 2} else {0};
_pacificFaction = if (count _this > 3) then {_this select 3} else {true};
_groupSide = if (count _this > 4) then {_this select 4} else {EAST};

// Get objects position if object is passed instead of position array
if (typename _attackPosition == "OBJECT") then {_attackPosition = getpos _attackPosition};

// If distance given as an array of min and max. Pick a random between them.
if (typename _minDistanceFromStart == "ARRAY") then {
  _min = _minDist select 0;
  _max = _minDist select 1;
  _minDistanceFromStart = (_min + random(_max - _min));
};
if (typename _minDistanceFromPlayers == "ARRAY") then {
  _min = _minDist select 0;
  _max = _minDist select 1;
  _minDistanceFromStart = (_min + random(_max - _min));
};

// Search for a safe postion to spawn the Viper squad
_dist = _minDistanceFromStart;
_search = true;
_players = allPlayers;
while {_search && _dist < 5000} do {
    scopeName "whileLoop";
    // Search for a land position starting from _minDistanceFromStart from the _attackPosition and
    // then going outwards from it in full circles in 100m, 20 degree steps.
    for "_i" from 0 to 340 step 20 do {
        _testPos = _attackPosition getPos [_dist, _i];
        if (!surfaceIsWater _testPos) then {
            // Check if position is far enough from players
            _minDist = 1e39;
            {
                _distance = _testPos distance2D _x;
                if (_distance < _minDist) then {
                    _minDist = _distance;
                };
            } forEach _players;
            if (_minDist > _minDistanceFromPlayers) then {
                // Find nearby forest
                _forestPos = (selectBestPlaces [_testPos, 100, "forest + trees", 10, 1]) select 0;
                if ((_forestPos select 1) > 0) then {
                    _search = false;
                    _testPos = _forestPos select 0;
                    breakOut "whileLoop";
                };
            };
        };
    };
    _dist = _dist + 100;
};

// If position was found spawn the Viper group and command them to move to the _attackPosition
if (!_search) then {
    // Select CSAT Pacific or CSAT faction
    if (_pacificFaction) then {
        _viperGroup = [_testPos, _groupSide, (configfile >> "CfgGroups" >> "EAST" >> "OPF_T_F" >> "SpecOps" >> "O_T_ViperTeam")] call BIS_fnc_spawnGroup;
    } else {
        _viperGroup = [_testPos, _groupSide, (configfile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "SpecOps" >> "OI_ViperTeam")] call BIS_fnc_spawnGroup;
    };
    [_viperGroup, true] call QS_fnc_moveToHC;
    [_viperGroup, _attackPosition] call BIS_fnc_taskAttack;
    _viperGroup setBehaviour "COMBAT";
    _viperGroup setCombatMode "RED";
    [(units _viperGroup)] call QS_fnc_setSkill4;
    // Add spawned units to Zeus
    {
        _x addCuratorEditableObjects [units _viperGroup, true];
    } forEach allCurators;

    // Return _viperGroup
    _viperGroup
};
