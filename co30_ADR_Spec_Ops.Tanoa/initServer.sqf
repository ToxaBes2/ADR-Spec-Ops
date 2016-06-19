/*
@filename: initServer.sqf
Author:	Quiksilver
Description: Server scripts such as missions, modules, third party and clean-up.
Credit:
	Invade & Annex 2.00 was created by Rarek [ahoyworld.co.uk] with countless hours of work,
	and further developed by Quiksilver [allFPS.com.au] with countless hours more.
	Contributors: Razgriz33 [AW], Jester [AW], Kamaradski [AW], David [AW], chucky [allFPS].
	Please be respectful and do not remove/alter credits.
*/
enableSaving [false, false];

// Set up curator classes
adminCurators = allCurators;

// Handle parameters
for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

// Server scripts
_null = [] spawn {_this call compile preProcessFileLineNumbers "mission\missionControl.sqf";};          // Main AO and side objectives
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\misc\airbaseDefense.sqf";};		// Airbase air defense
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\clean.sqf";};					// cleanup
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\misc\clearItemsBASE.sqf";};		// clear items around base
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\time.sqf"};                     // time and weather
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\zbe_cache\cache.sqf"};          // ZBE Cache

crossroad disableAI "ANIM";
enemyCasArray = [];
enemyCasGroup = createGroup east;
sleep 0.1;
deleteGroup enemyCasGroup;

// Animate arsenal models. Does not always work in their inits.
[base_arsenal_infantry, "STAND_U2", "ASIS"] call BIS_fnc_ambientAnim;
[base_arsenal_pilots, "STAND_U3", "ASIS"] call BIS_fnc_ambientAnim;
