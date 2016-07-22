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

// Server scripts
_null = [] spawn {_this call compile preProcessFileLineNumbers "mission\missionControl.sqf";};                              // Main AO and side objectives
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\clean.sqf";};					                    // cleanup
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\time.sqf"};                                         // time and weather
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\zbe_cache\cache.sqf"};                              // ZBE Cache

crossroad disableAI "ANIM";
enemyCasArray = [];
enemyCasGroup = createGroup east;
sleep 0.1;
deleteGroup enemyCasGroup;
