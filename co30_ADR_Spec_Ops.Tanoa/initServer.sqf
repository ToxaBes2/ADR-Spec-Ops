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

// extDB2 load
_database = "Arma3";
_protocol = "SQL_CUSTOM_V2";
_protocol_options = "specops";
_continue = true;
if (isNil {uiNamespace getVariable "life_sql_id"}) then {
    life_sql_id = round(random(999999));
    uiNamespace setVariable ["life_sql_id",life_sql_id];
    _version = "extDB2" callExtension "9:VERSION";
    if(_version == "") then {
        _continue = false;
    };
    if (_continue) then {
        _result = call compile ("extDB2" callExtension format["9:ADD_DATABASE:%1", _database]);
	    if (_result select 0 isEqualTo 0) then {
            _continue = false;
	    };
        if (_continue) then {
            _result = call compile ("extDB2" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:%2:%3:%4", _database, _protocol, life_sql_id, _protocol_options]);
            if ((_result select 0) isEqualTo 0) then {
                _continue = false;
            } else {
                "extDB2" callExtension "9:LOCK";
            };
        };
    };
};

// Create partizan base
_null = [] call QS_fnc_createPartizanBase;
PARTIZAN_REWARDS_LIST = []; publicVariable "PARTIZAN_REWARDS_LIST";
BLUFOR_REWARDS_LIST = []; publicVariable "BLUFOR_REWARDS_LIST";
AVANPOST_PARTIZAN_RESPAWN = []; publicVariable "AVANPOST_PARTIZAN_RESPAWN";

// Hide turrets
_grpTurret1 = createGroup west;

_turrets = [baseTurret1, baseTurret2, baseTurret3, baseTurret4, baseTurret5, baseTurret6, baseTurret7, baseTurret8, baseTurret9, baseTurret10, 
baseTurret11, baseTurret12, baseTurret13, baseTurret14, baseTurret15];
{
    deleteVehicle (gunner _x);
} foreach _turrets;

"B_T_Support_MG_F" createUnit [getposATL baseTurret1, _grpTurret1, "this moveInGunner baseTurret1"];
"B_T_Support_MG_F" createUnit [getposATL baseTurret3, _grpTurret1, "this moveInGunner baseTurret3"];
"B_T_Support_MG_F" createUnit [getposATL baseTurret5, _grpTurret1, "this moveInGunner baseTurret5"];
"B_T_Support_MG_F" createUnit [getposATL baseTurret7, _grpTurret1, "this moveInGunner baseTurret7"];
"B_T_Support_MG_F" createUnit [getposATL baseTurret9, _grpTurret1, "this moveInGunner baseTurret9"];
"B_T_Support_MG_F" createUnit [getposATL baseTurret11, _grpTurret1, "this moveInGunner baseTurret11"];
"B_T_Support_MG_F" createUnit [getposATL baseTurret13, _grpTurret1, "this moveInGunner baseTurret13"];
"B_T_Support_MG_F" createUnit [getposATL baseTurret15, _grpTurret1, "this moveInGunner baseTurret15"];
_grpTurret1 setBehaviour "COMBAT";
_grpTurret1 setCombatMode "RED";
[(units _grpTurret1)] call QS_fnc_setSkill4;

// Server scripts
_null = [] spawn {_this call compile preProcessFileLineNumbers "mission\missionControl.sqf";};          // Main AO and side objectives
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\clean.sqf";};					// cleanup
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\time.sqf"};                     // time and weather
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\zbe_cache\cache.sqf"};          // ZBE Cache
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\bridges.sqf"};                  // Custom bridges
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\traffic\traffic.sqf"};          // Civilian traffic system
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\patrolAA.sqf"};                 // random AA patrols 

crossroad disableAI "ANIM";
enemyCasArray = [];
enemyCasGroup = createGroup east;
sleep 0.1;
deleteGroup enemyCasGroup;

// Animate arsenal models. Does not always work in their inits, units become invisible in multiplayer.
[base_arsenal_infantry, "SIT1", "ASIS"] call BIS_fnc_ambientAnim;
[base_arsenal_pilots, "STAND_U3", "ASIS"] call BIS_fnc_ambientAnim;

// monitor and kill freezed UAVs
_null = [] spawn {
    while {true} do {
        sleep 60;
        {
            if (isUAVConnected _x) then {
                _control = UAVControl _x;
                if (count _control > 0) then {
                    _unit = _control select 0;
                    if (isNull _unit) then {
                        _side = side _x;
                        _x setDamage 1;
                        [_side, "HQ"] sideChat "Беспилотник потерял управление и был уничтожен";
                    };          
                };           
            };
        } forEach allUnitsUAV;
        sleep 60;
    };
};

// Disable autoreport in chat
{
    if (isDedicated) exitWith {};
    [] spawn {
        waitUntil {!(isNull player) && (time > 0)};
        enableSentences false;
        showSubtitles false;
        player addMPEventHandler ["MPRespawn", { enableSentences false; showSubtitles false; }];
    };
} remoteExec ["bis_fnc_call", 0, true]; 

// remove polygonal markers from channels
//_null = [] spawn {
//    while {true} do {
//        sleep 15;
//        {
//            if (markerShape _x == "POLYLINE") then {
//                _allowedChannels = ["1", "3", "4"];
//                _channelId = 0;
//                _arr = (format ["%1", _x]) splitString "/"; 
//                if (count _arr == 3) then {
//                    _channelId = _arr select 2;                   
//                };        
//                if !(_channelId in _allowedChannels) then {
//                    deleteMarker _x;
//                };
//            };
//        } forEach allMapMarkers;
//    };
//};