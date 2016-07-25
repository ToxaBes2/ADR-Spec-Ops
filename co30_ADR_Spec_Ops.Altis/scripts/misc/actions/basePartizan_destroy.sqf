_points = 10;
_unit = _this select 1;
_unit addScore _points;
["ScoreBonus", ["База партизан уничтожена!", _points]] remoteExec ["BIS_fnc_showNotification", _unit];
_null = [] call QS_fnc_createPartizanBase;