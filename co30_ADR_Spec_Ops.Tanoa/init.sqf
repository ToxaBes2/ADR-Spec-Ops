if (!hasInterface && !isDedicated) exitWith {};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\createChannels.sqf"};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\speakEvent.sqf"};
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";

// Hide objects inside player base
((getMarkerPos "respawn_west") nearestObject 135606) hideObject true;
((getMarkerPos "respawn_west") nearestObject 134758) hideObject true;
((getMarkerPos "respawn_west") nearestObject 134759) hideObject true;
((getMarkerPos "respawn_west") nearestObject 134802) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135793) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135772) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135762) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135771) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135769) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135770) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135748) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135761) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135794) hideObject true;
((getMarkerPos "respawn_west") nearestObject 130251) hideObject true;
((getMarkerPos "respawn_west") nearestObject 130238) hideObject true;
((getMarkerPos "respawn_west") nearestObject 130249) hideObject true;
((getMarkerPos "respawn_west") nearestObject 130248) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135122) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135120) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135121) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135536) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135535) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135524) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135539) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135538) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135537) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135527) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135525) hideObject true;
((getMarkerPos "respawn_west") nearestObject 135747) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 135746) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 135544) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 135188) allowDamage false;

if (isDedicated) exitWith {
	"addToScore" addPublicVariableEventHandler {
	    ((_this select 1) select 0) addScore ((_this select 1) select 1);
    };
};
