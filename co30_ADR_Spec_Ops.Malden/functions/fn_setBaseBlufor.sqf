/*
Author: ToxaBes
Description: change blufor base score
*/
_level = _this select 0;
if (_level < 0) then {
    _level = 0;
};
_map = 0;
if (worldName == "Tanoa") then {
    _map = 1;
};
if (worldName == "Malden") then {
    _map = 2;
};
BLUFOR_BASE_SCORE = _level; publicVariable "BLUFOR_BASE_SCORE";
[_level] remoteExec ["QS_fnc_updateBaseBlufor", 2];
["setBaseScoreBlufor",[_map, _level], 0] remoteExec ["sqlServerCall", 2];
"level_blufor" setMarkerText format ["Уровень базы: %1", _level];
["level_blufor", 0] remoteExec ["setMarkerAlphaLocal", resistance];