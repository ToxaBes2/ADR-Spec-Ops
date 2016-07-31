if (!hasInterface && !isDedicated) exitWith {};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\createChannels.sqf"};                         // Custom channels
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\speakEvent.sqf"};                             // Radio effects (psh-psh)
[] spawn {_this call compile preProcessFileLineNumbers "scripts\outlw_magRepack\MagRepack_init_sv.sqf"};            // Magazines repack
[] spawn {_this call compile preProcessFileLineNumbers "scripts\extDB2\bridge.sqf";};                               // DB call function
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";                                           // Revive system
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";                                        // Teamkill punish action

// Hide objects inside player base
((getMarkerPos "respawn_west") nearestObject 136404) hideObject true; // lamphalogen_f.p3d
((getMarkerPos "respawn_west") nearestObject 136555) hideObject true; // tbox_f.p3d
((getMarkerPos "respawn_west") nearestObject 136586) hideObject true; // cargo40_brick_red_f.p3d
((getMarkerPos "respawn_west") nearestObject 136588) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 136589) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 136585) hideObject true; // lamphalogen_f.p3d
((getMarkerPos "respawn_west") nearestObject 136596) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136595) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136553) hideObject true; // dp_smalltank_f.p3d
((getMarkerPos "respawn_west") nearestObject 136346) hideObject true; // ttowersmall_2_f.p3d
((getMarkerPos "respawn_west") nearestObject 135618) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 135617) hideObject true; // cargo40_blue_f.p3d
((getMarkerPos "respawn_west") nearestObject 135537) hideObject true; // cargo40_brick_red_f.p3d
((getMarkerPos "respawn_west") nearestObject 135678) hideObject true; // shed_07_f.p3d
((getMarkerPos "respawn_west") nearestObject 131053) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 131039) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 131051) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 131050) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135985) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 135923) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 135986) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136322) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136321) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136332) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 136323) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136319) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136320) hideObject true; // netfence_01_m_8m_f.p3d
((getMarkerPos "respawn_west") nearestObject 136336) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136331) hideObject true; // netfence_01_m_d_f.p3d
((getMarkerPos "respawn_west") nearestObject 136559) allowDamage false; // airport_02_hangar_right_f.p3d
((getMarkerPos "respawn_west") nearestObject 136554) allowDamage false; // airport_02_hangar_left_f.p3d
((getMarkerPos "respawn_west") nearestObject 136351) allowDamage false; // airport_01_hangar_f.p3d
((getMarkerPos "respawn_west") nearestObject 135916) allowDamage false; // airport_01_hangar_f.p3d

if (isDedicated) exitWith {
	"addToScore" addPublicVariableEventHandler {
	    ((_this select 1) select 0) addScore ((_this select 1) select 1);
    };
};
