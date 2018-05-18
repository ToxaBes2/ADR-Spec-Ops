/*
Author: ToxaBes
Description: create partizane base.
Format: [] call QS_fnc_createPartizanBase;
*/
private ["_basePositions", "_dist", "_position", "_accepted", "_curPos", "_respawnPos", "_sd", "_sp"];
_pos = param [0, [0,0,0]];
_basePositions = [
    [7079.04,12195.7,0.258788],[5436.1,11379.6,3.61993],[6082.19,10867.4,0.884155],[6045.56,10726.9,0],[5427.37,10056,0.315811],
    [5210.55,10363.2,0.752335],[4959.13,10308.9,3.27534],[5057.25,8416.87,0.298096],[4494.28,8309.15,0.937469],[2911.58,5573.61,3.68797],
    [6561.44,6051.99,3.92549],[5546.36,7867.23,0.259827],[7018.87,9984.32,0.353157],[7544.43,10567.6,0.789797],[8071.94,9749.4,0.523504],
    [961.65,11870.8,0.290692],[4300.25,6827.59,3.90167],[6349.81,5368.4,3.65686],[7737.9,7550.26,0.143707],[6672.77,8142.7,0.480682],
    [1621.15,4614.49,0.122905],[2465.58,3728.91,0.221741],[4971.27,2560.96,0.120392],[6807.15,2721.49,1.04938],[5049.65,4719.62,0.739098],
    [7963.82,6547.26,1.20404],[9721.11,3879.33,0.234356],[3214.52,8508.26,3.91992],[5369.42,5550.33,0]
];
_dist = 1500;
_position = [0, 0, 0];
_accepted = false;
_curPos = getPos partizan_ammo;

if (format ["%1", _pos] == "[0,0,0]") then {
    while {!_accepted} do {
        _position = _basePositions call BIS_fnc_selectRandom;;
        if (_position distance2D (getMarkerPos "aoMarker") > _dist) then {
            if (_position distance2D (getMarkerPos "sideMarker") > _dist) then {
                if (_position distance2D (getMarkerPos "priorityMarker") > _dist) then {
                    if (_position distance2D (_curPos) > _dist) then {
                        _accepted = true;
                    };
                };
            };
        };
    };
} else {
    _position = _basePositions select 0;
    _delta = _position distance2D _pos;
    {
        if (_x distance2D _pos < _delta) then {
            _position = _x;
            _delta = _position distance2D _pos;
        };
    } forEach _basePositions;
};

_respawnPos = [((_position select 0) + random 3),((_position select 1) + random 3),_position select 2];
partizan_ammo setPos _position;
"respawn_guerrila" setMarkerPos _respawnPos;
"partizan_base" setMarkerPos _position;
["partizan_base", 0] remoteExec ["setMarkerAlphaLocal", west];
partizan_chemlight setPos _position;

if !(isNil "PARTIZAN_BASE_SCORE") then {
    if (PARTIZAN_BASE_SCORE > 18) then {
        _boxes = nearestObjects [_curPos, ["ReammoBox_F"], 50];
        {
            _newPos = [_respawnPos, 5, 50, 2, 0, 10, 0, [], []] call QS_fnc_findSafePos;
            _x setPos _newPos;
        } forEach _boxes;
    };
};