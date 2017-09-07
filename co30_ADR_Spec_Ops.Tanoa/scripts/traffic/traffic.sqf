/*
Author: ToxaBes
Description: add civilian traffic on map
Based on Enigma Traffic script
*/
if (!isServer) exitWith {};
#define CIV_SIDE civilian
#define CIV_VEHICLES "B_Quadbike_01_F", "C_SUV_01_F", "I_G_Offroad_01_F", "C_Offroad_02_unarmed_F", "C_Hatchback_01_sport_F", "I_C_Van_01_transport_F"
#define CIV_COUNT 10
#define CIV_DEBUG false

TRAFFIC_RandomCivilian = {
    _unit = _this select 0;
    _rds_rhs_civilian = ["U_BG_Guerilla1_1","U_BG_Guerilla2_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_Guerilla3_2",
    "U_BG_leader","U_IG_Guerrilla_6_1","U_IG_leader","U_I_G_resistanceLeader_F","U_OG_Guerilla1_1",
    "U_OG_Guerilla2_1","U_OG_Guerilla2_2","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_Guerrilla_6_1","U_OG_leader"] call BIS_fnc_selectRandom;
    _rhsHeadGear = ["H_Bandanna_camo","H_Bandanna_cbr","H_Bandanna_gry","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_mcamo","H_Bandanna_sgg",
    "H_Bandanna_surfer","H_Beret_02","H_Beret_Colonel","H_Beret_blk","H_Beret_blk_POLICE","H_Beret_brn_SF","H_Beret_grn","H_Beret_grn_SF",
    "H_Beret_red","H_Cap_blk","H_Cap_blk_CMMG","H_Cap_blk_ION","H_Cap_blu","H_Cap_grn","H_Cap_grn_BI","H_Cap_headphones","H_Cap_khaki_specops_UK",
    "H_Cap_oli","H_Cap_oli_hs","H_Cap_red","H_Cap_tan","H_Cap_tan_specops_US","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan",
    "H_MilCap_blue","H_MilCap_gry","H_MilCap_mcamo","H_MilCap_rucamo","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_khk","H_Shemag_olive",
    "H_Shemag_olive_hs","H_Shemag_tan","H_StrawHat","H_StrawHat_dark","H_StrawHat_dark","H_TurbanO_blk","H_Watchcap_blk","H_Watchcap_camo",
    "H_Watchcap_khk","H_Watchcap_sgg"] call BIS_fnc_selectRandom;
    _taliFaces = ["AfricanHead_01","AfricanHead_02","AfricanHead_03","AsianHead_A3_01","AsianHead_A3_02","AsianHead_A3_03","GreekHead_A3_01",
    "GreekHead_A3_02","GreekHead_A3_03","GreekHead_A3_04","GreekHead_A3_05","GreekHead_A3_06","GreekHead_A3_07","GreekHead_A3_08","GreekHead_A3_09",
    "NATOHead_01","Nikos","PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03","WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05",
    "WhiteHead_06","WhiteHead_07","WhiteHead_08","WhiteHead_09","WhiteHead_10","WhiteHead_11","WhiteHead_12","WhiteHead_13","WhiteHead_14",
    "WhiteHead_15"] call BIS_fnc_selectRandom;
    _stripHim = {
        _it = _this select 0;
        removeAllWeapons _it;
        removeAllItems _it;
        removeAllAssignedItems _it;
        removeUniform _it;
        removeVest _it;
        removeBackpack _it;
        removeHeadgear _it;
        removeGoggles _it;  
    };
    _reclotheHim = {
        _guy = _this select 0;
        _guy forceAddUniform _rds_rhs_civilian;
        if (random 2 > 1) then {
            _guy addHeadgear _rhsHeadGear;
        };

        [[_guy,_taliFaces], "setCustomFace"] call BIS_fnc_MP;
        _guy setVariable ["BIS_noCoreConversations", true];     
    };
    addBehaviour = {
        group (_this select 0) setBehaviour "CARELESS";
        (_this select 0) disableAI "TARGET";
        (_this select 0) disableAI "AUTOTARGET";
    };
    addKilledEvent = {
        (_this select 0) addMPEventhandler ["MPKilled",
        {
            _killer = _this select 1;
            if (count _this > 2) then {
                _killer = _this select 2;
            };
            if (side _killer == west && _killer isKindOf "Man" && isPlayer _killer) then {
                [[[_killer, 300, "STR_PRISON_CIVILIAN"], "scripts\=BTC=_TK_punishment\Prison.sqf"], "BIS_fnc_execVM", true, false, false] call BIS_fnc_MP;
            } else {
                if (side _killer != resistance) then {
                    (vehicle _killer) setFuel 0;
                    if (getDammage _killer < 0.9) then {
                        _killer setDamage 0.9;
                    };
                };
            };
        }];
    };
    [_unit] call _stripHim;
    [_unit] call _reclotheHim;
    [_unit] spawn addKilledEvent;
    [_unit] call addBehaviour;
};

TRAFFIC_MoveVehicle = {
    private ["_vehicle", "_waypoint", "_startPos", "_destinationPos"];
    _vehicle = _this select 0; 
    if (_vehicle isKindOf "AllVehicles") then {
        _corners = _vehicle getVariable ["CORNERS", []];
        if (count _corners > 0) then {
            _startPos = getPos _vehicle;
            _vehicle setFuel 1;
            _cornerPos = selectRandom _corners;
            _destinationSegments = _cornerPos nearRoads 100;
            if (count _destinationSegments > 0) then {
                _destinationSegment = _destinationSegments select 0;
                _destinationPos = getPos _destinationSegment;
                _waypoint = group _vehicle addWaypoint [_destinationPos, 10];
                _waypoint setWaypointCompletionRadius 50;
                _waypoint setWaypointBehaviour "CARELESS";
                _waypoint setWaypointSpeed "NORMAL";
                _waypoint setWaypointStatements ["true", "[(vehicle this)] spawn TRAFFIC_MoveVehicle;"];
            };    
        };
    } else {
        deleteVehicle _vehicle;
    }; 
};

TRAFFIC_CreateVehicle = {
    _startPos = _this select 0;
    _corners = _this select 1;
    _maxDist = _this select 2;
    _units = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_euro","C_man_polo_1_F_asia",
"C_man_polo_2_F","C_man_polo_2_F_afro","C_man_polo_2_F_euro","C_man_polo_2_F_asia","C_man_polo_3_F","C_man_polo_3_F_afro","C_man_polo_3_F_euro",
"C_man_polo_3_F_asia","C_man_polo_4_F","C_man_polo_4_F_afro","C_man_polo_4_F_euro","C_man_polo_4_F_asia","C_man_polo_5_F","C_man_polo_5_F_afro",
"C_man_polo_5_F_euro","C_man_polo_5_F_asia","C_man_polo_6_F","C_man_polo_6_F_afro","C_man_polo_6_F_euro","C_man_polo_6_F_asia","C_man_p_fugitive_F",
"C_man_p_fugitive_F_afro","C_man_p_fugitive_F_euro","C_man_p_fugitive_F_asia","C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_beggar_F_euro",
"C_man_p_beggar_F_asia","C_man_w_worker_F","C_man_hunter_1_F","C_man_p_shorts_1_F","C_man_p_shorts_1_F_afro","C_man_p_shorts_1_F_euro","C_man_p_shorts_1_F_asia",
"C_man_shorts_1_F","C_man_shorts_1_F_afro","C_man_shorts_1_F_euro","C_man_shorts_1_F_asia","C_man_shorts_2_F","C_man_shorts_2_F_afro","C_man_shorts_2_F_euro",
"C_man_shorts_2_F_asia","C_man_shorts_3_F","C_man_shorts_3_F_afro","C_man_shorts_3_F_euro","C_man_shorts_3_F_asia","C_man_shorts_4_F","C_man_shorts_4_F_afro",
"C_man_shorts_4_F_euro","C_man_shorts_4_F_asia","C_Nikos","C_Nikos_aged"];
    _vehicle = false;
    _vehiclesCrew = false;
    _vehiclesGroup = false;
    _dir = random 360;
    _refPosX = (_startPos select 0) + (_maxDist / 2) * sin _dir;
    _refPosY = (_startPos select 1) + (_maxDist / 2) * cos _dir;
    _roadSegments = [_refPosX, _refPosY] nearRoads 800;
    _cornerPos = selectRandom _corners;    
    if (count _roadSegments > 0) then {
        _spawnSegment = selectRandom _roadSegments;                
        _roadSegmentDirection = getDir _spawnSegment;
        _direction = random 360;           
        _posX = (getPos _spawnSegment) select 0;
        _posY = (getPos _spawnSegment) select 1;               
        _posX = _posX + 2.5 * sin (_direction + 90);
        _posY = _posY + 2.5 * cos (_direction + 90);
        _pos = [_posX, _posY, 0];
        _vehicleType = selectRandom [CIV_VEHICLES];
        _vehicle = _vehicleType createVehicle _pos;
        _vehicle addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
        _vehicle setDir _direction;
        _vehiclesGroup  = createGroup CIV_SIDE;
        _unitType = selectRandom _units;
        _unit = _vehiclesGroup createUnit [_unitType, [20,20,0], [], 0, "NONE"];
        _unit setSkill 1;
        _unit moveInDriver _vehicle;                
        if (random 10 > 4) then {
            _unitType = selectRandom _units;
            _passenger = _vehiclesGroup createUnit [_unitType, [20,20,0], [], 0, "NONE"];
            _passenger setSkill 1;
            _passenger moveInCargo _vehicle;
        };
        _vehiclesGroup setVariable ["zbe_cacheDisabled", true, true];
        _vehiclesCrew = crew _vehicle;        
        {
            [_x] call TRAFFIC_RandomCivilian;                                               
        } forEach _vehiclesCrew;
        _vehicle setVariable ["CORNERS", _corners, true];
        [_vehicle] spawn TRAFFIC_MoveVehicle;
        VEHS = VEHS + 1;  
        [_vehicle, _vehiclesGroup] spawn {
            _curVeh = _this select 0;            
            _curGroup = _this select 1;
            while {alive _curVeh || count (units _curGroup) > 0} do {
                sleep 60;
                {
                    if (vehicle _x == _x) then {
                        deleteVehicle _x;
                    };
                } forEach (units _curGroup);
                sleep 60;
                _people = _curVeh nearEntities ["Man", 1000];
                if (count _people == 0 && !alive _curVeh) then {
                    {
                        deleteVehicle _x;
                    } forEach (units _curGroup);
                    deleteVehicle _curVeh;
                    deleteGroup _curGroup;
                    VEHS = VEHS - 1;
                };
                sleep 60;
            };   
        };
        if (CIV_DEBUG) then {
            [_vehicle] spawn {
                _veh = _this select 0;
                _num = floor (random 10000);
                _mkrName = "debug_mkr" + (str _num);
                while {true} do {
                    _marker = createMarker [_mkrName, getPos _veh];
                    _marker  setMarkercolor "colorYellow";
                    _marker  setMarkerSize [1,1];
                    _marker  setMarkerType "Mil_dot";
                    _marker  setMarkerText "traffic";
                    sleep 5;
                    deleteMarker _mkrName;
                };
            };
        };
    };
};

_name = worldName;
_startPos = [0,0,0];
_corners = [];
_maxDist = 0;
if (_name == "Altis") then {
    _maxDist = 15000;
    _startPos = [15000,15000,0];
    _corners = [[14246.5,12997.5,0],[13783.2,6378.66,0],[8907.49,7509.31,0],[4241.59,16440.7,0],[4666.15,22313.5,0],[6584,22666,0],[13930.8,23120.8,0],
        [14769.3,10751.2,0],[22198.8,8485.48,0],[24001.4,15465.1,0],[23383.1,24368.6,0],[22016.1,21061.8,0],[17858.4,18184.6,0],[15478.1,15886.1,0],
        [2664.31,9833.44,0],[2714.08,22077,0],[28306.1,25768.4,0],[22276.2,5107.15,0]];
};
if (_name == "Tanoa") then {
    _maxDist = 5000;
    _startPos = [10000,10000,0];
    _corners = [[13004.7,2140.59,0],[9439.39,4050.89,0],[6690.45,7008.12,0],[5452.54,10102.1,0],[8342.29,11978.1,0],[10016.7,11769.7,0],[12134,10423.8,0],
        [11382.4,12359.4,0],[13807.3,8477.45,0],[9166.55,8718.56,0],[11013.7,9327.18,0],[4218.75,8380.51,0],[6783.37,13376.6,0],[14072.4,12194.1,0],
        [12654.2,6649.99,0]];
};
if (_name == "Malden") then {
    _maxDist = 3000;
    _startPos = [8000,8000,0];
    _corners = [[1086.77,645.721,0],[3137.06,6806.64,0],[3041.03,8449.45,0],[2840.37,7545.06,0],[5554.22,11191.3,0],[8165.71,10532,0],[5971.03,8644.59,0],
        [8153.99,3117.61,0],[7828.13,3126.02,0],[5759.88,2419.58,0],[5444.19,2342.34,0],[5137.68,1208.2,0],[3739.64,3065.6,0],[8275.32,6037.04,0]];
};
if (_maxDist == 0) exitWith {};
VEHS = 0;
for "_i" from 0 to (CIV_COUNT-1) do {   
    [_startPos, _corners, _maxDist] call TRAFFIC_CreateVehicle;    
};
while {true} do {
    sleep 60;
    if (VEHS < (CIV_COUNT-1)) then {
        [_startPos, _corners, _maxDist] call TRAFFIC_CreateVehicle;  
    };
    sleep 120;
};