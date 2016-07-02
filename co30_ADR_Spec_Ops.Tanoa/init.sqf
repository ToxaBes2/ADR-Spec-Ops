if (!hasInterface && !isDedicated) exitWith {};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\createChannels.sqf"};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\speakEvent.sqf"};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\outlw_magRepack\MagRepack_init_sv.sqf"};
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";

// Hide objects inside player base
((getMarkerPos "respawn_west") nearestObject 136459) hideObject true; // tbox_f.p3d
((getMarkerPos "respawn_west") nearestObject 136483) hideObject true; // cargo40_brick_red_f.p3d
((getMarkerPos "respawn_west") nearestObject 136480) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 136481) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 136484) hideObject true; // lamphalogen_f.p3d
((getMarkerPos "respawn_west") nearestObject 136525) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136524) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136461) hideObject true; // dp_smalltank_f.p3d
((getMarkerPos "respawn_west") nearestObject 135449) hideObject true; // shed_07_f.p3d
((getMarkerPos "respawn_west") nearestObject 135590) hideObject true; // cargo40_brick_red_f.p3d
((getMarkerPos "respawn_west") nearestObject 135509) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 135510) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 130964) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 130950) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 130962) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 130961) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135827) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135895) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 135828) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136248) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136247) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136240) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 136249) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136249) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136245) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136234) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136246) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136239) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 136321) hideObject true; // lamphalogen_f.p3d
((getMarkerPos "respawn_west") nearestObject 136265) hideObject true; // ttowersmall_2_f.p3d
((getMarkerPos "respawn_west") nearestObject 136260) allowDamage false; // airport_01_hangar_f.p3d
((getMarkerPos "respawn_west") nearestObject 135897) allowDamage false; // airport_01_hangar_f.p3d
((getMarkerPos "respawn_west") nearestObject 136460) allowDamage false; // airport_02_hangar_left_f.p3d
((getMarkerPos "respawn_west") nearestObject 136455) allowDamage false; // airport_02_hangar_right_f.p3d

if (isDedicated) exitWith {
	"addToScore" addPublicVariableEventHandler {
	    ((_this select 1) select 0) addScore ((_this select 1) select 1);
    };
};
