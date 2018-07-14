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

// extDB3 load
_database = "Arma3";
_protocol = "SQL_CUSTOM";
_protocol_name = "sql";
_protocol_options = "specops.ini";
_continue = true;
_version = "extDB3" callExtension "9:VERSION";
if(_version == "") then {
    _continue = false;
};
if (_continue) then {
    _result = call compile ("extDB3" callExtension format["9:ADD_DATABASE:%1", _database]);
    if (_result select 0 isEqualTo 0) then {
        _continue = false;
    };
    if (_continue) then {
        _result = call compile ("extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:%2:%3:%4", _database, _protocol, _protocol_name, _protocol_options]);
        if ((_result select 0) isEqualTo 0) then {
            _continue = false;
        } else {
            "extDB3" callExtension "9:LOCK";
        };
    };
};

// Create partizan base
_null = [] call QS_fnc_createPartizanBase;
PARTIZAN_REWARDS_LIST = []; publicVariable "PARTIZAN_REWARDS_LIST";
BLUFOR_REWARDS_LIST = []; publicVariable "BLUFOR_REWARDS_LIST";
AVANPOST_PARTIZAN_RESPAWN = []; publicVariable "AVANPOST_PARTIZAN_RESPAWN";

// Hide turrets
_turrets = [baseTurret1, baseTurret2, baseTurret3, baseTurret4, baseTurret5, baseTurret6, baseTurret7, baseTurret8, baseTurret9, baseTurret10, 
baseTurret11, baseTurret12, baseTurret13, baseTurret14, baseTurret15];
{
    deleteVehicle (gunner _x);
} foreach _turrets;

addMissionEventHandler ["BuildingChanged",{[_this select 0,_this select 1,_this select 2] call QS_fnc_mapBuildings;}];

// Server scripts
_null = [] spawn {_this call compile preProcessFileLineNumbers "mission\missionControl.sqf";};          // Main AO and side objectives
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\clean.sqf";};					// cleanup
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\time.sqf"};                     // time and weather
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\zbe_cache\cache.sqf"};          // ZBE Cache
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\bridges.sqf"};                  // Custom bridges
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\traffic\traffic.sqf"};          // Civilian traffic system
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\traffic\airsupport.sqf"};       // Blufor air support system 
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\patrolAA.sqf"};                 // random AA patrols 
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\passToHC.sqf"};                 // Headless clients with balncing 
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\clearObjects.sqf";};            // Clear objects
_null = [] spawn {_this call compile preProcessFileLineNumbers "scripts\partizan\cache.sqf";};          // Partizan Caches

//crossroad disableAI "ANIM";
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

// add hide body action
_null = [] spawn {
    while {true} do {
        sleep 60;
        {
            _unit = _x;
            _action = _unit getVariable ["hide_action", false];
            if (!_action) then {
                [_unit, "QS_fnc_addActionHideBody", nil, true] spawn BIS_fnc_MP;
                _unit setVariable ["hide_action", true, true];
            };
        } forEach AllDeadMen;
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

// initialise support cycles
SUPPORT_CYCLES = 0; 
publicVariableServer "SUPPORT_CYCLES";

// arsenal availability
ARSENAL_ENABLED = true;
publicVariable "ARSENAL_ENABLED";

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

// persistent data management
if (_continue) then {

    // load partizan base items and then save it every 43 mins
    _map = 0;
    if (worldName == "Tanoa") then {
        _map = 1;
    };
    if (worldName == "Malden") then {
        _map = 2;
    };
    ["getPartizanItems",[_map], 0] remoteExec ["sqlServerCall", 2];
    [_map] spawn {
        _map = _this select 0;
        while {true} do {
            sleep 2580;
            ["clearPartizanItems",[_map], 0] remoteExec ["sqlServerCall", 2];
            sleep 3;       
            _data = [partizan_ammo, _map] call QS_fnc_getCargoData;
            {
                ["setPartizanItems",[_x select 0, _x select 1, _x select 2, _x select 3], 0] remoteExec ["sqlServerCall", 2];
            } forEach _data;
        };
    };
    
    // load rewards and save it every 34 mins
    ["getRewardsBlufor",[_map], 0] remoteExec ["sqlServerCall", 2];
    ["getRewardsPartizans",[_map], 0] remoteExec ["sqlServerCall", 2];
    [_map] spawn {
        _map = _this select 0;
        while {true} do {
            sleep 2040;
            ["clearRewards",[_map, 0], 0] remoteExec ["sqlServerCall", 2];
            ["clearRewards",[_map, 1], 0] remoteExec ["sqlServerCall", 2];
            sleep 3;       
    
            // blufor save
            _data = [0] call QS_fnc_getRewardsData;
            {
                _name = format ['"%1"', _x select 0];
                _item = format ["%1", _x select 1];
                _airfield = 0;
                ["setRewards",[_map, 0, _name, _item, _airfield], 0] remoteExec ["sqlServerCall", 2];
            } forEach _data;
    
            // partizans save
            _data = [1] call QS_fnc_getRewardsData;
            {
                _name = format ['"%1"', _x select 0];
                _item = format ["%1", _x select 1];
                _airfield = 0;
                ["setRewards",[_map, 1, _name, _item, _airfield], 0] remoteExec ["sqlServerCall", 2];
            } forEach _data;
        };
    };
    
    // load avanposts and save it every 26 mins
    ["getAvanpostPartizans",[_map], 0] remoteExec ["sqlServerCall", 2];
    [_map] spawn {
        _map = _this select 0;
        while {true} do {
            sleep 1560;
            ["clearAvanpostPartizans",[_map], 0] remoteExec ["sqlServerCall", 2];
            if (count AVANPOST_PARTIZAN_RESPAWN > 0) then {
                _markers = AVANPOST_PARTIZAN_RESPAWN;
                _n = 0;
                {
                    _mkrName = format ["mkr_%1", _x];
                    _mkrPos = getMarkerPos _mkrName;
                    if (_n < 2) then {
                        if !(_mkrPos isEqualTo [0,0,0]) then {
                            _position = format ["%1,%2", floor (_mkrPos select 0), floor (_mkrPos select 1)];
                            ["setAvanpostPartizans",[_map, _position], 0] remoteExec ["sqlServerCall", 2];
                            _n = _n + 1;
                        };
                    };
                } forEach _markers;
            };
            
            // update current time in DB
            _hour = floor (date select 3);
            ["setTime",[_hour], 0] remoteExec ["sqlServerCall", 2];
        };
    };
    
    // Score for bases
    ["getBaseScorePartizan",[_map], 0] remoteExec ["sqlServerCall", 2];
    ["getBaseScoreBlufor",[_map], 0] remoteExec ["sqlServerCall", 2];  
} else {
    BLUFOR_BASE_SCORE = 9999; publicVariable "BLUFOR_BASE_SCORE";
    PARTIZAN_BASE_SCORE = 9999; publicVariable "PARTIZAN_BASE_SCORE";
};

//apply base changes
[] spawn {
    sleep 10;
    [BLUFOR_BASE_SCORE] call QS_fnc_setBaseBlufor;
    [PARTIZAN_BASE_SCORE] call QS_fnc_setBaseResistance;
};

// show restart warnings
[] spawn {
    waitUntil { if (serverTime > 0) then {true} else {sleep 1; false} };
    _missionStartTime = missionStart;
    _hours = [4,16];
    _longCheck = true;
    while {true} do {
        _minsStart = ((_missionStartTime select 3) * 60) + (_missionStartTime select 4);
        _minsDuration = floor (serverTime / 60);  
        _total = _minsStart + _minsDuration;
        _hour = floor (_total / 60);
        _min = _total - (_hour * 60);
        if (_hour in _hours) then {
            _m = 0;
            switch (_min) do { 
                case 30 : {
                    _m = 30;
                }; 
                case 45 : {
                    _m = 15;
                }; 
                case 59 : {
                    _m = 1;
                };
                default {}; 
            };
            if (_m > 0) then {
               (format["Внимание: %1 мин. до рестарта сервера!", _m]) remoteExec ["systemChat"]; 
            };
            _longCheck = false;
        } else {
            _longCheck = true;
        };
        if (_longCheck) then {
            sleep 1200;
        } else {
            sleep 60;
        };
    };    
};

_showFPS = "ShowFPS" call BIS_fnc_getParamValue;
if (_showFPS == 1) then {
    [] spawn {
        while {true} do {
            SERVER_FPS = round diag_fps;
            publicVariable "SERVER_FPS";
            sleep 3;
        };  
    };
};

// CBA related staff
CBA_display_ingame_warnings = false;
publicVariable "CBA_display_ingame_warnings";

// Ctab init settings
cTab_helmetClass_has_HCam_server = ["H_HelmetB_light","H_Helmet_Kerry","H_HelmetSpecB","H_HelmetO_ocamo"];
publicVariable "cTab_helmetClass_has_HCam_server";
cTab_userMarkerLists = [];
cTab_userMarkerTransactionId = -1;