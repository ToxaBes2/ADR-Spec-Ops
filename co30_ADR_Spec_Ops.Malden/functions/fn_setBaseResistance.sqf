/*
Author: ToxaBes
Description: change resistance base score
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
PARTIZAN_BASE_SCORE = _level; publicVariable "PARTIZAN_BASE_SCORE";
[_level] remoteExec ["QS_fnc_updateBaseResistance", 2];
["setBaseScorePartizan",[_map, _level], 0] remoteExec ["sqlServerCall", 2];
"level_resistance" setMarkerText format ["Уровень базы: %1", _level];
["level_resistance", 0] remoteExec ["setMarkerAlphaLocal", west];