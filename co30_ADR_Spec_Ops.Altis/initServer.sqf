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

_urbanMarkers =["sm1","sm2","sm3","sm4","sm5","sm6","sm7","sm8","sm9","sm10","sm11","sm12","sm13","sm14","sm15","sm16","sm17","sm18","sm19","sm20","sm21","sm22","sm23","sm24","sm25","sm26","sm27","sm28","sm29","sm30","sm31","sm32","sm33","sm34","sm35","sm36","sm37","sm38","sm39"];
{ _x setMarkerAlpha 0; } count _urbanMarkers;

crossroad disableAI "ANIM";
enemyCasArray = [];
enemyCasGroup = createGroup east; 
sleep 0.1; 
deleteGroup enemyCasGroup;