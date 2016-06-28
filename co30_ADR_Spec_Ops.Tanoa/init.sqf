if (!hasInterface && !isDedicated) exitWith {};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\createChannels.sqf"};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\speakEvent.sqf"};
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";

// Hide objects inside player base
((getMarkerPos "respawn_west") nearestObject 136315) hideObject true; // lamphalogen_f.p3d
((getMarkerPos "respawn_west") nearestObject 136466) hideObject true; // tbox_f.p3d
((getMarkerPos "respawn_west") nearestObject 136519) hideObject true; // cargo40_brick_red_f.p3d
((getMarkerPos "respawn_west") nearestObject 136521) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 136522) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 136518) hideObject true; // lamphalogen_f.p3d
((getMarkerPos "respawn_west") nearestObject 136480) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136479) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136464) hideObject true; // dp_smalltank_f.p3d
((getMarkerPos "respawn_west") nearestObject 135456) hideObject true; // shed_07_f.p3d
((getMarkerPos "respawn_west") nearestObject 135516) hideObject true; // cargo40_brick_red_f.p3d
((getMarkerPos "respawn_west") nearestObject 135518) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 135517) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 130964) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 130950) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 130962) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 130961) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135831) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135830) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 135832) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136231) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136230) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136243) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 136234) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136233) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136232) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136247) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136242) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 136465) allowDamage false; // airport_02_hangar_left_f.p3d
((getMarkerPos "respawn_west") nearestObject 136470) allowDamage false; // airport_02_hangar_right_f.p3d
((getMarkerPos "respawn_west") nearestObject 136262) allowDamage false; // airport_01_hangar_f.p3d
((getMarkerPos "respawn_west") nearestObject 135827) allowDamage false; // airport_01_hangar_f.p3d

if (isDedicated) exitWith {
	"addToScore" addPublicVariableEventHandler {
	    ((_this select 1) select 0) addScore ((_this select 1) select 1);
    };
};
