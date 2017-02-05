if (!hasInterface && !isDedicated) exitWith {};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\createChannels.sqf"};                         // Custom channels
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\speakEvent.sqf"};                             // Radio effects (psh-psh)
[] spawn {_this call compile preProcessFileLineNumbers "scripts\outlw_magRepack\MagRepack_init_sv.sqf"};            // Magazines repack
[] spawn {_this call compile preProcessFileLineNumbers "scripts\extDB2\bridge.sqf";};                               // DB call function
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";                                           // Revive system
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";                                        // Teamkill punish action

// Hide objects inside player base
((getMarkerPos "respawn_west") nearestObject 490993) hideObject true;
((getMarkerPos "respawn_west") nearestObject 529331) hideObject true;
((getMarkerPos "respawn_west") nearestObject 493984) hideObject true;
((getMarkerPos "respawn_west") nearestObject 491093) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 491010) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 493386) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 490995) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 490879) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 490856) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 490857) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 490734) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 490766) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 490818) allowDamage false;

if (isDedicated) exitWith {
	"addToScore" addPublicVariableEventHandler {
	    ((_this select 1) select 0) addScore ((_this select 1) select 1);
    };
};
