if (!hasInterface && !isDedicated) exitWith {};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\createChannels.sqf"};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\speakEvent.sqf"};
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";

// Hide objects inside player base
((getMarkerPos "respawn_west") nearestObject 135837) hideObject true; // lamphalogen_f.p3d
((getMarkerPos "respawn_west") nearestObject 135993) hideObject true; // tbox_f.p3d
((getMarkerPos "respawn_west") nearestObject 136002) hideObject true; // cargo40_brick_red_f.p3d
((getMarkerPos "respawn_west") nearestObject 136000) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 136001) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 136003) hideObject true; // lamphalogen_f.p3d
((getMarkerPos "respawn_west") nearestObject 136025) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136024) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 135988) hideObject true; // dp_smalltank_f.p3d
((getMarkerPos "respawn_west") nearestObject 134989) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 130486) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 130471) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 130484) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 130483) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135353) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135351) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 135352) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135767) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135766) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135755) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 135770) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135769) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135768) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135758) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 135756) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 135989) allowDamage false; // airport_02_hangar_left_f.p3d
((getMarkerPos "respawn_west") nearestObject 135977) allowDamage false; // airport_02_hangar_right_f.p3d
((getMarkerPos "respawn_west") nearestObject 135775) allowDamage false; // airport_01_hangar_f.p3d
((getMarkerPos "respawn_west") nearestObject 135419) allowDamage false; // airport_01_hangar_f.p3d

if (isDedicated) exitWith {
	"addToScore" addPublicVariableEventHandler {
	    ((_this select 1) select 0) addScore ((_this select 1) select 1);
    };
};
