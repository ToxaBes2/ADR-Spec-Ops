if (!hasInterface && !isDedicated) exitWith {};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\createChannels.sqf"};                         // Custom channels
[] spawn {_this call compile preProcessFileLineNumbers "scripts\radio\speakEvent.sqf"};                             // Radio effects (psh-psh)
[] spawn {_this call compile preProcessFileLineNumbers "scripts\outlw_magRepack\MagRepack_init_sv.sqf"};            // Magazines repack
[] spawn {_this call compile preProcessFileLineNumbers "scripts\extDB2\bridge.sqf";};                               // DB call function
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";                                           // Revive system
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";                                        // Teamkill punish action

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
((getMarkerPos "respawn_west") nearestObject 491010) allowDamage false;
((getMarkerPos "respawn_west") nearestObject 493386) allowDamage false;

// Hide turrets
baseTurret1 hideObject true;
baseTurret2 hideObject true;
baseTurret3 hideObject true;
baseTurret4 hideObject true;
baseTurret5 hideObject true;
baseTurret6 hideObject true;
baseTurret7 hideObject true;
baseTurret8 hideObject true;
baseTurret9 hideObject true;
baseTurret10 hideObject true;
baseTurret11 hideObject true;

if (isDedicated) exitWith {
	"addToScore" addPublicVariableEventHandler { 
	    ((_this select 1) select 0) addScore ((_this select 1) select 1); 
    };
};

// Deal with static map markers
if (side player == west) then {
    "partizan_base" setMarkerAlphaLocal 0;
    "Helipad" setMarkerAlphaLocal 1;
    "Arsenal" setMarkerAlphaLocal 1;
    "Laptops" setMarkerAlphaLocal 1;
    "Vehicle_depot_1" setMarkerAlphaLocal 1;
    "Armor" setMarkerAlphaLocal 1;
    "UAVspawn" setMarkerAlphaLocal 1;
    "Arsenal_1" setMarkerAlphaLocal 1;
    "Helo_spawn" setMarkerAlphaLocal 1;
    "Side" setMarkerAlphaLocal 1;
    "m_mod" setMarkerAlphaLocal 1;
    "Repair_1" setMarkerAlphaLocal 1;
    "changeLoadout" setMarkerAlphaLocal 1;
    "Repair_2" setMarkerAlphaLocal 1;
    "Repair_2_1" setMarkerAlphaLocal 1;
    "B2" setMarkerAlphaLocal 1;
    "B2_1" setMarkerAlphaLocal 1;
    "med" setMarkerAlphaLocal 1;
    "vehService" setMarkerAlphaLocal 1;
} else {
    "partizan_base" setMarkerAlphaLocal 1;
    "Helipad" setMarkerAlphaLocal 0;
    "Arsenal" setMarkerAlphaLocal 0;
    "Laptops" setMarkerAlphaLocal 0;
    "Vehicle_depot_1" setMarkerAlphaLocal 0;
    "Armor" setMarkerAlphaLocal 0;
    "UAVspawn" setMarkerAlphaLocal 0;
    "Arsenal_1" setMarkerAlphaLocal 0;
    "Helo_spawn" setMarkerAlphaLocal 0;
    "Side" setMarkerAlphaLocal 0;
    "m_mod" setMarkerAlphaLocal 0;
    "Repair_1" setMarkerAlphaLocal 0;
    "changeLoadout" setMarkerAlphaLocal 0;
    "Repair_2" setMarkerAlphaLocal 0;
    "Repair_2_1" setMarkerAlphaLocal 0;
    "B2" setMarkerAlphaLocal 0;
    "B2_1" setMarkerAlphaLocal 0;
    "med" setMarkerAlphaLocal 0; 
    "vehService" setMarkerAlphaLocal 0;
};