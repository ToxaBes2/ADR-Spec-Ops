if (!hasInterface && !isDedicated) exitWith {};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\time.sqf"};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\createChannels.sqf"};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\speakEvent.sqf"};
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";

// Hide objects near heli landing
((getMarkerPos "respawn_west") nearestObject 492374) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492375) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492438) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492359) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492364) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492365) hideObject true;
((getMarkerPos "respawn_west") nearestObject 492366) hideObject true;
((getMarkerPos "respawn_west") nearestObject 529331) hideObject true;
((getMarkerPos "respawn_west") nearestObject 493984) hideObject true;
((getMarkerPos "respawn_west") nearestObject 491093) allowDamage false;

if (isDedicated) exitWith {
	"addToScore" addPublicVariableEventHandler { 
	    ((_this select 1) select 0) addScore ((_this select 1) select 1); 
    };
};