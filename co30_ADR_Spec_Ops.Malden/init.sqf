if (!hasInterface && !isDedicated) exitWith {
    _showFPS = "ShowFPS" call BIS_fnc_getParamValue;
    if (_showFPS == 1) then {
        [] spawn {
            while {true} do {
            	if !(isNil "HC1") then {
                    HC1_FPS = round diag_fps;
                    publicVariable "HC1_FPS";
                    sleep 3;
                };
                if !(isNil "HC2") then {
                    HC2_FPS = round diag_fps;
                    publicVariable "HC2_FPS";
                    sleep 3;
                };
            };
        };
    };
};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\AI\init.sqf"};                                      // AI custom system
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\createChannels.sqf"};                         // Custom channels
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\speakEvent.sqf"};                             // Radio effects (psh-psh)
[] spawn {_this call compile preProcessFileLineNumbers "scripts\outlw_magRepack\MagRepack_init_sv.sqf"};            // Magazines repack
[] spawn {_this call compile preProcessFileLineNumbers "scripts\extDB3\bridge.sqf";};                               // DB call function
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";                                           // Revive system
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";                                        // Teamkill punish action
UAV_RANGE = compileFinal preprocessFileLineNumbers "scripts\UAV_Range.sqf";                                         // UAV range restriction
["darter","onEachFrame",{0 call UAV_RANGE }] call BIS_fnc_addStackedEventHandler;                                 

// Hide objects inside player base
((getMarkerPos "respawn_west") nearestObject 168677) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168683) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168680) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168681) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168707) hideObject true;
//((getMarkerPos "respawn_west") nearestObject 168711) hideObject true;
((getMarkerPos "respawn_west") nearestObject 167578) hideObject true;
((getMarkerPos "respawn_west") nearestObject 167570) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168751) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168755) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168746) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168749) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168740) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168698) hideObject true;
((getMarkerPos "respawn_west") nearestObject 169421) hideObject true;
((getMarkerPos "respawn_west") nearestObject 165417) hideObject true;
((getMarkerPos "respawn_west") nearestObject 165420) hideObject true;
((getMarkerPos "respawn_west") nearestObject 165423) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168892) hideObject true;
((getMarkerPos "respawn_west") nearestObject 168702) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 167567) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 168827) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 169208) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 167558) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 167491) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 168760) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 168668) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 168667) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 168666) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 168665) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 167610) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 167611) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 167492) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 168671) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 165424) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 169188) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 168691) allowDamage false;

// old oupost
([6287,10830] nearestObject 281483) hideObject true;
([6287,10830] nearestObject 281787) hideObject true;
([6287,10830] nearestObject 281332) hideObject true;
([6287,10830] nearestObject 281446) hideObject true;
([6287,10830] nearestObject 281447) hideObject true;

// bad rocks on turn
([7309,8827] nearestObject 35022) hideObject true;
([7309,8827] nearestObject 35346) hideObject true;
([7309,8827] nearestObject 35024) hideObject true;
([7309,8827] nearestObject 35294) hideObject true;
([7309,8827] nearestObject 36774) hideObject true;
([7309,8827] nearestObject 35370) hideObject true;
([7309,8827] nearestObject 35021) hideObject true;
([7309,8827] nearestObject 35352) hideObject true;
([7309,8827] nearestObject 35368) hideObject true;
([7309,8827] nearestObject 35367) hideObject true;
([7309,8827] nearestObject 35502) hideObject true;
([7309,8827] nearestObject 36790) hideObject true;

if (isDedicated) exitWith {
	"addToScore" addPublicVariableEventHandler {
	    ((_this select 1) select 0) addScore ((_this select 1) select 1);
    };
};
