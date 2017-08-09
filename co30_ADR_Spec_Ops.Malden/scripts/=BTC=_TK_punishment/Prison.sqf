/*
Author:	ToxaBes
Description: prison logic.
*/
private ["_tk_prison_coords", "_time", "_n", "_count","_target","_reason"];
_prisonCoords = [8000,9990,0];
_defaultTime  = 120;
_target       = _this select 0;
_prisonTime   = param [1, 0];
_reason       = param [2, "STR_PRISON_TEAMKILL"];
if (!isDedicated) then {
    _effects = [] spawn BTC_Effects;
    if (_target == player) then {
        _time = profileNamespace getVariable ["btc_tk_prison", 0];
        if (_time == 0) then {
            if (_prisonTime > 0)  then {
                _time = _prisonTime;
            } else {
                _time = _defaultTime;
            };
            profileNamespace setVariable ["btc_tk_prison", _time];
            saveProfileNamespace;
        };
        player setPos _prisonCoords;
        removeAllWeapons player;
        removeAllItems player;
        removeBackpack player;
        removeHeadgear player;
        removeVest player;
        player unassignItem "NVGoggles";
        player removeItem "NVGoggles";
        player connectTerminalToUAV objNull;
        player unassignItem "B_UavTerminal";
        player removeItem "B_UavTerminal";
        _n = 0;
        _k = 1;
        _text = localize _reason;
        while {_n < _time} do {
        	_count = _time - _n;
            cutText [format[_text, _count], "PLAIN DOWN"];
            _n = _n + 1;
            _k = _k + 1;
            if (_k > 5) then {
            	if (player distance _prisonCoords > 10) then {
            		player setPos _prisonCoords;
            	};
                _k = 1;
            };
            if (!alive player) exitWith {};
            sleep 1;
        };
        if (alive player) then {
            profileNamespace setVariable ["btc_tk_prison", 0];
		    saveProfileNamespace;
		    cutText ["", "PLAIN DOWN"];
		    player setDamage 1;
		    sleep 3;
            BTC_respawn_cond = true;
            _respawn = [] spawn BTC_player_respawn;
        };
    };
};
