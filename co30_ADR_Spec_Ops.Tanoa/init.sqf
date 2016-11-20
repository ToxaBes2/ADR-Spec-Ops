if (!hasInterface && !isDedicated) exitWith {};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\createChannels.sqf"};                         // Custom channels
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\speakEvent.sqf"};                             // Radio effects (psh-psh)
[] spawn {_this call compile preProcessFileLineNumbers "scripts\outlw_magRepack\MagRepack_init_sv.sqf"};            // Magazines repack
[] spawn {_this call compile preProcessFileLineNumbers "scripts\extDB2\bridge.sqf";};                               // DB call function
[] spawn {_this call compile preProcessFileLineNumbers "scripts\Traffic\Init.sqf";};                                // Civilian traffic system
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
((getMarkerPos "respawn_west") nearestObject 136336) hideObject true; // t_leucaena_f.p3d
((getMarkerPos "respawn_west") nearestObject 136559) allowDamage false; // airport_02_hangar_right_f.p3d
((getMarkerPos "respawn_west") nearestObject 136554) allowDamage false; // airport_02_hangar_left_f.p3d
((getMarkerPos "respawn_west") nearestObject 136351) allowDamage false; // airport_01_hangar_f.p3d
((getMarkerPos "respawn_west") nearestObject 135916) allowDamage false; // airport_01_hangar_f.p3d
([5130,11680] nearestObject 1471614) hideObject true;
([5130,11680] nearestObject 1471615) hideObject true;
([5130,11680] nearestObject 1471616) hideObject true;
([5130,11680] nearestObject 1471620) hideObject true;
([5130,11680] nearestObject 1471621) hideObject true;
([5130,11680] nearestObject 1471622) hideObject true;
([5130,11680] nearestObject 1471636) hideObject true;
([5130,11680] nearestObject 1471637) hideObject true;
([5130,11680] nearestObject 1471638) hideObject true;
([5130,11680] nearestObject 1471649) hideObject true;
([5130,11680] nearestObject 1471655) hideObject true;
([5130,11680] nearestObject 1471656) hideObject true;
([5130,11680] nearestObject 1471658) hideObject true;
([5130,11680] nearestObject 1471659) hideObject true;
([5130,11680] nearestObject 1471662) hideObject true;
([5130,11680] nearestObject 1471663) hideObject true;
([5130,11680] nearestObject 1471664) hideObject true;
([5130,11680] nearestObject 1471665) hideObject true;
([5130,11680] nearestObject 1471666) hideObject true;
([5130,11680] nearestObject 1471667) hideObject true;
([7187,4244] nearestObject 79825) hideObject true; 

_points = [          
[2785.14,8694.25],      
[2812.89,8699.12],      
[2831.58,8701.82],      
[2849.65,8706.98],      
[2866.36,8709.76],      
[2892.93,8717.03],     
[3545.9,8829],
[4526.57,9001.51],
[4531.17,9006.96]     
];      
{      
    _nearestUnits = nearestObjects [_x, [], 20];      
    {      
        _x hideObjectGLobal true;      
    } forEach _nearestUnits;      
} forEach _points;

if (isDedicated) exitWith {
	"addToScore" addPublicVariableEventHandler {
	    ((_this select 1) select 0) addScore ((_this select 1) select 1);
    };
};
