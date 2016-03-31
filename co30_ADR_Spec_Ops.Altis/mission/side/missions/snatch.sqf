/*
Author:	ToxaBes
Description: Snatch helicopter and return it to the base.
*/

// define some keywords
#define INFANTRY_MISSION "Спецоперация: Угон (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_FUEL_VEHICLE "O_Truck_03_fuel_F"
#define INFANTRY_AA_VEHICLE "O_APC_Tracked_02_AA_F"
#define INFANTRY_CAMONET_BIG "CamoNet_OPFOR_big_F"
#define INFANTRY_CAMONET_SMALL "CamoNet_OPFOR_F"
#define INFANTRY_CAMONET_OPEN "CamoNet_OPFOR_open_F"
#define INFANTRY_HELI_PILOT "O_helipilot_F"
#define INFANTRY_HELI_CREW "O_helicrew_F"
#define INFANTRY_STATIC "O_HMG_01_high_F"
#define INFANTRY_GUNNERS "O_support_MG_F", "O_support_GMG_F", "O_support_AMG_F"
#define INFANTRY_SOLDIERS "O_Soldier_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_TL_F","O_soldier_M_F","O_Soldier_LAT_F","O_medic_F","O_soldier_repair_F","O_soldier_exp_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_soldier_PG_F","O_recon_F","O_recon_M_F","O_recon_LAT_F","O_recon_medic_F","O_recon_TL_F","O_Soldier_AAT_F","O_soldierU_M_F","O_SoldierU_GL_F"

// define private variables
private ["_targets","_accepted","_distance","_briefing","_position","_flatPos","_x","_enemiesArray","_startPoint"];         

_enemiesArray = [grpNull];
_unitsArray = [];

// Thanks KK for fastest shuffle alghoritm
KK_fnc_arrayShufflePlus = {
    private ["_arr","_cnt"];
    _arr = _this select 0;
    _cnt = count _arr;
    for "_i" from 1 to (_this select 1) do {
        _arr pushBack (_arr deleteAt floor random _cnt);
    };
    _arr
};

// format: [[coords x,y], [drons],     [camp x,y,z],        [heli x,y,dir],      [fuel x,y,dir],      [AA x,y,dir],        [bunkers x,y,dir],                                                [guards x,y,z,dir],                                                                                                                                       [pilots x,y,z,dir]]
_targets = [
    [[13581.3,12129.8],   [1,2],     [13562.7,12095.5,0], [13589.3,12169.8,0], [13614.3,12247.7,0], [13578.5,12132.1,0], [[13643.8,12239.3,45],[13503,12076.1,204],[13550.7,12131.2,300]], [[13476,12145.7,1.7,297],[13635.6,12127.4,0.1,283],[13492.9,12017.7,0.1,211],[13668.2,12287.2,0.1,54],[13575.2,12196.3,4,263],[13574.5,12188.1,0.1,146]], [[13597.8,12170.2,0.1,221],[13595.5,12167,0.1,37]]],
    [[3122.71,21960.9],   [1,2],     [3078.34,22008.9,0], [3139.74,21977.4,0], [3136,22026,148],    [3167,21920,180],    [[3173.8,21806,181],[2950.61,21992.4,285],[3273.55,22051.3,131]], [[3080.01,22059.8,0.1,154],[3153.43,21987.2,0.1,231],[3160.18,21982,0.1,229],[3126.3,21988.8,0.1,148],[3050.95,21916,0.1,205],[3253.05,21937.9,0.1,165]], [[3157.7,21975.9,0.1,318],[3155.91,21978.3,0.1,145]]],
    [[25977.1,19847.4],   [1,2],     [26023.3,19806.2,0], [25873,19854,161],   [26048,19726,298],   [25843,19890,314],   [[26006,19964,353],[25850,19943,325],[25838.8,19758.3,274]],      [[26051,19709,0.1,320],[25951.9,19748.3,0.1,343],[26093.4,19946.2,0.1,71],[25804.2,19873.3,0.1,221],[25983.6,19872.3,0.1,319],[25873.2,19907.7,4,156]],   [[25875.6,19902.3,0.1,136],[25877.9,19900.8,0.1,300]]],
    [[28289.8,25750.8],   [1,2],     [28281.9,25578.6,0], [28316.1,25775.2,0], [28345,25745,348],   [28271,25771,155],   [[28225,25600.9,187],[28158.4,25707.1,245],[28125,25767,239]],    [[28151.3,25658.1,0.1,233],[28379.3,25643.9,0.1,254],[28323,25785.2,18.3,232],[28298.1,25777.4,3.8,139],[28297.2,25787.9,0.3,318],[28341,25867,0.1,35]],  [[28320.2,25764,0.1,260],[28317.1,25763.3,0.24892,71]]],       
    [[24809.8,23367.5],   [1,2],     [24816.5,23372.5,0], [24912.4,23372,204], [24862,23231,48],    [24731,23392,292],   [[24703.6,23437.9,345],[24758.4,23223.9,233],[24931,23290,94]],   [[24921.2,23414.4,0.1,201],[24757.8,23504.1,0.1,330],[24680.7,23309.6,0.1,287],[24968.8,23309.1,0.1,145],[24869,23366,0.1,357],[24873.8,23215.5,4,169]],  [[24842.3,23210.5,0.1,101],[24845.9,23209.8,0.1,283]]],
    [[11543.4,22864.9],   [1,2],     [11539.9,22936.3,0], [11481.9,22945,280], [11657,22754,197],   [11543,22865,144],   [[11449,22792,215],[11653,22889,81],[11551,22793,148]],           [[11422.3,22930.6,0.1,297],[11577,22966,0.1,90],[11656.7,22837.5,0.1,142],[11543,22754,0.1,174],[11437.4,22831.9,0.1,266],[11673.6,22748.3,0.5,90]],      [[11451.7,22964.4,7.8,122],[11455.7,22962.5,5.3,282]]],
    [[2284.69,22367],     [1,2],     [2169.99,22373.7,0], [2277,22347,327],    [2379,22318,320],    [2273,22262,37],     [[2359.53,22429.6,98],[2335.54,22283.3,99],[2203.73,22213,249]],  [[2422.92,22342.1,0.1,107],[2391.9,22277,0.1,356],[2169.27,22323.5,14.6,259],[2291.35,22428.7,6.5,187],[2461.6,22428.9,0.1,205],[2212,22269,0.1,258]],    [[2282.68,22374.8,0.1,82],[2286.84,22374.8,0.1,271]]],
    [[14470.6,6186.7],    [1,2],     [14471.2,6187.57,0], [14566,6238,266],    [14476,6254,167],    [14448,6191,262],    [[14327.9,6235.4,295],[14479.2,6146.32,181],[14445,6259.8,311]],  [[14586.7,6298.93,0.1,42],[14552,6196.7,0.1,248],[14423.3,6166.07,0.1,265],[14370.4,6231.24,0.1,290],[14307.6,6251.89,0.1,294],[14469.6,6267.85,0.1,2]],  [[14522.5,6234.24,0.1,152],[14524.1,6231.93,0.1,333]]],
    [[2690.58,19757.8],   [1,2],     [2671.54,19780.7,0], [2689.4,19750.2,60], [2799.6,19791.5,52], [2743.26,19811,64],  [[2683.,19942,106],[2713,19593,4],[2809,19837,33]],               [[2625.28,19697.8,0.1,8],[2587.95,19885,0.1,302],[2801.6,19882.9,0.1,19],[2794.39,19690.5,0.1,170],[2781.86,19813,0.1,45],[2533.53,19790.2,0.1,106]],     [[2777.45,19769.7,0.7,50],[2779.6,19771.5,0.7,232]]],
    [[10023.1,11246.9],   [1,2],     [10003.7,11223.9,0], [10019.2,11243,0],   [10010,11292.5,0],   [10042.7,11271.4,0], [[10185.5,11318.3,0],[10066.4,11385.1,0],[9987.42,11341.4,0]],    [[10046.7,11215.3,0.1,150],[10129.6,11334.4,4.3,31],[10140.9,11260.8,3.7,101],[10003.4,11235.6,4.2,340],[10045.5,11303.8,0.3,208],[9882,11278,0.1,352]],  [[9952.95,11188,0.1,95],[9955.88,11187.3,0.1,276]]]
];

// format: ["heli name",                 "removed weapon1",           "removed magazine1",                       "added weapon1",                "added magazine1",                     "removed weapon2",            "removed magazine2",              "added weapon2",                "added magazine2"]
_helicopters = [     
           ["O_Heli_Attack_02_black_F",   "rockets_Skyfire",           "38Rnd_80mm_rockets",                      "missiles_ASRAAM",              "2Rnd_AAA_missiles"],
           ["B_Heli_Light_01_armed_F",    "M134_minigun",              "5000Rnd_762x51_Belt",                     "missiles_ASRAAM",              "2Rnd_AAA_missiles"],
           ["B_Heli_Light_01_armed_F",    "M134_minigun",              "5000Rnd_762x51_Belt",                     "missiles_ASRAAM",              "2Rnd_AAA_missiles",                    "missiles_DAR",              "24Rnd_missiles",                 "Gatling_30mm_Plane_CAS_01_F",  "1000Rnd_Gatling_30mm_Plane_CAS_01_F"],
           ["B_Heli_Attack_01_F",         "missiles_DAGR",             "4Rnd_AAA_missiles",                       "missiles_ASRAAM",              "2Rnd_AAA_missiles",                    "gatling_20mm",              "1000Rnd_20mm_shells",            "Gatling_30mm_Plane_CAS_01_F",  "1000Rnd_Gatling_30mm_Plane_CAS_01_F"],
           ["I_Heli_light_03_F",          "M134_minigun",              "5000Rnd_762x51_Yellow_Belt",              "missiles_ASRAAM",              "2Rnd_AAA_missiles",                    "missiles_DAR",              "24Rnd_missiles",                 "missiles_DAGR",                "12Rnd_PG_missiles"],
           ["B_Heli_Transport_01_camo_F", "LMG_Minigun_Transport",     "2000Rnd_65x39_Belt_Tracer_Red",           "Gatling_30mm_Plane_CAS_01_F",  "1000Rnd_Gatling_30mm_Plane_CAS_01_F",  "LMG_Minigun_Transport2",    "2000Rnd_65x39_Belt_Tracer_Red",  "Gatling_30mm_Plane_CAS_01_F",  "1000Rnd_Gatling_30mm_Plane_CAS_01_F"],
           ["B_Heli_Transport_01_F",      "LMG_Minigun_Transport",     "2000Rnd_65x39_Belt_Tracer_Red",           "autocannon_35mm",              "680Rnd_35mm_AA_shells_Tracer_Yellow",  "LMG_Minigun_Transport2",    "2000Rnd_65x39_Belt_Tracer_Red",  "autocannon_35mm",  "680Rnd_35mm_AA_shells_Tracer_Yellow"],
           ["O_Heli_Light_02_F",          "LMG_Minigun_heli",          "2000Rnd_65x39_Belt_Tracer_Green_Splash",  "Cannon_30mm_Plane_CAS_02_F",   "500Rnd_Cannon_30mm_Plane_CAS_02_F"],
           ["O_Heli_Light_02_v2_F",       "LMG_Minigun_heli",          "2000Rnd_65x39_Belt_Tracer_Green_Splash",  "Gatling_30mm_Plane_CAS_01_F",  "1000Rnd_Gatling_30mm_Plane_CAS_01_F"]
];
_helicopters = [_helicopters, 7] call KK_fnc_arrayShufflePlus;

// select correct place for mission
if (PARAMS_AO == 1) then {
    _accepted = false;
    while {!_accepted} do {    
        _position = _targets call BIS_fnc_selectRandom;
        _flatPos  = _position select 0;  
        _distance = [_flatPos, getMarkerPos currentAO] call BIS_fnc_distance2D;
        if (_distance > 3000) then {
            _distance = [_flatPos, getMarkerPos "priorityMarker"] call BIS_fnc_distance2D;
            if (_distance > 1500) then {
                _accepted = true;
            };  
        };
        sleep 5;
    };
} else {
    _position = _targets call BIS_fnc_selectRandom;
    _flatPos  = _position select 0;
};

// set zone area
_startPoint = [(_flatPos select 0),(_flatPos select 1),1];
{ _x setMarkerPos _flatPos; } forEach ["sideMarker", "sideCircle"];
"sideCircle" setMarkerSize [200, 200]; publicVariable "sideCircle";
sideMarkerText = [INFANTRY_MISSION, true]; publicVariable "sideMarkerText";
"sideMarker" setMarkerText INFANTRY_MISSION; publicVariable "sideMarker";
SM_SNATCH_FAIL = false; publicVariable "SM_SNATCH_FAIL";
SM_SNATCH_SUCCESS = false; publicVariable "SM_SNATCH_SUCCESS";

// show brief information
_briefing = "<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FF9999'>Угон</t><br/>____________________<br/>Неделю назад противник атаковал один из наших складов и захватил экспериментальный вертолет. Сегодня наша разведка обнаружила его на одной из замаскированных баз противника. Командование назначило пехотную спецоперацию.<br/><br/>Ваша задача — выдвинуться в указанный район, захватить вертолет и вернуть его на базу.</t>";
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSideMission", "Угон"]; publicVariable "showNotification";
sideMissionUp = true; publicVariable "sideMissionUp";

// spawn camp
_campPos = _position select 2;
_camp = [_campPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "Empty" >> "Guerrilla" >> "Camps" >> "CampC")] call BIS_fnc_spawnGroup;
_campFires = nearestObjects [_campPos, ["Land_Campfire_F", "Campfire_burning_F"], 5];
{
    _x inflame true;
} forEach _campFires;
_unitsArray = _unitsArray + [_camp];
for "_x" from 1 to 6 do {
    _tentDome = createVehicle ["Land_TentDome_F", _campPos, [], 10, "NONE"];
    _unitsArray = _unitsArray + [_tentDome];
    _tentDome = nil;
};

// camp guards
_campGroup = createGroup ENEMY_SIDE;
_sleepingBags = nearestObjects [_campPos, ["Land_Sleeping_bag_F", "Land_Sleeping_bag_brown_F"], 10];
_sleepingPositions = [_sleepingBags, 7] call KK_fnc_arrayShufflePlus;
for "_i" from 0 to 2 do {
    _sleepingPos = _sleepingPositions select _i;
    _bagPos = [(getPos _sleepingPos) select 0, (getPos _sleepingPos) select 1, 0.1];
    "O_Soldier_F" createUnit [[10,10,10], _campGroup, "currentGuard = this"];
    currentGuard allowDamage false;
    currentGuard setPos _bagPos;
    currentGuard setDir ([currentGuard, _campPos] call BIS_fnc_dirTo);
    currentGuard allowDamage true;
    [currentGuard, "SIT_LOW", "FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
};
_campGroup setBehaviour "SAFE";
_campGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_campGroup];

// spawn heli
_heliPos =  [(_position select 3) select 0, (_position select 3) select 1, 0];
_heliDir = (_position select 3) select 2;
_heliLand = createVehicle ["Land_HelipadSquare_F", _heliPos, [], 0, "CAN_COLLIDE"]; 
_heliLand setDir (_heliDir + 180);
_unitsArray = _unitsArray + [_heliLand];
_heliData = _helicopters call BIS_fnc_selectRandom;
_heliType = _heliData select 0;
heliSnatch = createVehicle [_heliType, _heliPos, [], 0, "NONE"]; 
heliSnatch setDir _heliDir;
heliSnatch addMPEventHandler ["MPKilled",
    {
        if (isServer) then {
            SM_SNATCH_FAIL = true; publicVariable "SM_SNATCH_FAIL";
        };
    }
];

// make heli a bit special
heliSnatch setFuel 0.005;
heliSnatch setVehicleAmmo 0;
clearMagazineCargo heliSnatch;
heliSnatch removeWeapon (_heliData select 1);
heliSnatch removeMagazine (_heliData select 2);
heliSnatch addweapon (_heliData select 3);
heliSnatch addMagazine (_heliData select 4);        
if (count (_heliData) > 8) then {
    heliSnatch removeWeapon (_heliData select 5);
    heliSnatch removeMagazine (_heliData select 6);
    heliSnatch addweapon (_heliData select 7);
    heliSnatch addMagazine (_heliData select 8); 
};
if (_heliType == "B_Heli_Light_01_armed_F") then {
    heliSnatch addweapon "CMFlareLauncher";
    heliSnatch addMagazine "168Rnd_CMFlare_Chaff_Magazine";
};

// set trigger for success heli out
_trig = createTrigger ["EmptyDetector", _flatPos, false]; 
_trig setTriggerArea [1000, 1000, 0, false];
_trig setTriggerActivation ["ANY", "PRESENT", false];
_trig setTriggerStatements ["this && ((alive heliSnatch) && !(heliSnatch in thisList))", "SM_SNATCH_SUCCESS = true; publicVariable ""SM_SNATCH_SUCCESS""; heliSnatch removeAllMPEventHandlers ""MPKilled"";", ""];

// spawn few mil boxes
for "_x" from 1 to 2 do {
    _boxes = createVehicle ["Land_Pallet_MilBoxes_F", _heliPos, [], 4, "NONE"];
    _boxes allowDamage false;
    _unitsArray = _unitsArray + [_boxes];
};

// spawn patrolling drons
_n = (_position select 1) call BIS_fnc_selectRandom;
for "_i" from 1 to _n do {
    _height = (random 20) + 15;
    _posInit = [_campPos, 1, 100, 2, 1, 1, 0] call BIS_fnc_findSafePos;        
    _posSpawn = [_posInit select 0, _posInit select 1, _height];
    _uavData = [_posSpawn, 90, "B_UAV_01_F", ENEMY_SIDE] call BIS_fnc_spawnVehicle;     
    _uav = _uavData select 0;   
    _uavGroup = _uavData select 2;     
    _uav addWeapon ("LMG_Mk200_F");
    _uav addMagazine ("200Rnd_65x39_cased_Box_Tracer");
    _uavGroup setBehaviour "SAFE";
    _uavGroup setCombatMode "RED";
    [(units _uavGroup)] call QS_fnc_setSkill2;              
    [_uavGroup, _posSpawn, (40 + (random 80))] call BIS_fnc_taskPatrol;
    _unitsArray = _unitsArray + [_uav];
    _enemiesArray = _enemiesArray + [_uavGroup]; 
};

// spawn fuel vehicle
_fuelPos =  [(_position select 4) select 0, (_position select 4) select 1, 0];
_fuelDir = (_position select 4) select 2;
_fuelNet = createVehicle [INFANTRY_CAMONET_BIG, _fuelPos, [], 0, "CAN_COLLIDE"]; 
_fuelNet setDir _fuelDir;
_unitsArray = _unitsArray + [_fuelNet];
_fuelVeh = createVehicle [INFANTRY_FUEL_VEHICLE, _fuelPos, [], 0, "CAN_COLLIDE"]; 
_fuelVeh setDir _fuelDir;

unitsArray = _unitsArray + [_fuelVeh];

// spawn AA vehicle
_aaGroup =  createGroup ENEMY_SIDE; 
_aaPos =  [(_position select 5) select 0, (_position select 5) select 1, 0];
_aaDir = (_position select 5) select 2;
_aaVeh = [_aaPos, _aaDir, INFANTRY_AA_VEHICLE, _aaGroup] call BIS_fnc_spawnVehicle;
_aa = _aaVeh select 0;
_aa setFuel 0;
_aa setVehicleLock "LOCKED"; 
_aa lock true;
_unitsArray = _unitsArray + [_aa];
_aaGroup setBehaviour "SAFE";
_aaGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_aaGroup];

// spawn bunkers
_staticGroup = createGroup ENEMY_SIDE;
_bunkers = _position select 6;
{

    // bunker
    _bunkerPos =  [_x select 0, _x select 1, 0];
    _bunkerDir = (_x select 2) + 180;    
    _bunkerBag = createVehicle ["Land_BagBunker_Small_F", _bunkerPos, [], 0, "CAN_COLLIDE"]; 
    _bunkerBag setDir _bunkerDir;
    _unitsArray = _unitsArray + [_bunkerBag];

    // put cargo at back
    _posBlock = [_bunkerBag, 5, _bunkerDir] call BIS_fnc_relPos;
    _block = createVehicle ["Land_Cargo20_military_green_F",[1,1,1],[],0,"CAN_COLLIDE"];
    _block setPos _posBlock;
    _block setDir _bunkerDir;  
    _unitsArray = _unitsArray + [_block];

    // camonet for bunker
    _bunkerCamonet = createVehicle [INFANTRY_CAMONET_SMALL, _bunkerPos, [], 0, "CAN_COLLIDE"]; 
    _bunkerCamonet setDir _bunkerDir;
    _bunkerCamonet allowDamage false;
    _unitsArray = _unitsArray + [_bunkerCamonet];

    // camonet for cargo
    _bunkerCamonet = createVehicle [INFANTRY_CAMONET_OPEN, [_posBlock select 0, _posBlock select 1, (_posBlock select 2) + 0.5], [], 0, "CAN_COLLIDE"]; 
    _bunkerCamonet setDir _bunkerDir;
    _bunkerCamonet allowDamage false;
    _unitsArray = _unitsArray + [_bunkerCamonet];

    // static weapon
    _posATL = getPos _bunkerBag;  
    _posATL = [(_posATL select 0), (_posATL select 1), (_posATL select 2) + 0.2];
    _static = INFANTRY_STATIC createVehicle [10,10,10];      
    waitUntil{!isNull _static}; 
    _static allowDamage false;
    _static setPos _posATL;
    _static setDir _bunkerDir;
    ([INFANTRY_GUNNERS] call BIS_fnc_selectRandom) createUnit [[10,10,10], _staticGroup, "currentGuard = this"];
    currentGuard allowDamage false;
    sleep 0.1;
    currentGuard assignAsGunner _static;
    currentGuard moveInGunner _static;
    _static setVectorUp [0,0,1];
    _static lock 3;
    currentGuard allowDamage true;
    _static allowDamage true;
    _unitsArray = _unitsArray + [_static];
    _static = nil; 
} forEach _bunkers;

// spawn single guards
_singlePositions = _position select 7;
{
    ([INFANTRY_SOLDIERS] call BIS_fnc_selectRandom) createUnit [[10,10,10], _staticGroup, "currentGuard = this"];
    currentGuard setPos [_x select 0, _x select 1, _x select 2];
    currentGuard setDir (_x select 3);
    [currentGuard,"STAND","FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;  
} forEach _singlePositions;

_staticGroup setBehaviour "SAFE";
_staticGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_staticGroup];

// spawn heli pilot and crew
_heliGroup = createGroup ENEMY_SIDE;
_pilotPositions = _position select 8;
_pilotPos = _pilotPositions select 0;
INFANTRY_HELI_PILOT createUnit [[10,10,10], _heliGroup, "currentGuard = this"];
currentGuard setPos [_pilotPos select 0, _pilotPos select 1, _pilotPos select 2];
currentGuard setDir (_pilotPos select 3);
[currentGuard,"STAND","FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;  
_crewPos = _pilotPositions select 1;
INFANTRY_HELI_CREW createUnit [[10,10,10], _heliGroup, "currentGuard = this"];
currentGuard setPos [_crewPos select 0, _crewPos select 1, _crewPos select 2];
currentGuard setDir (_crewPos select 3);
[currentGuard,"STAND","FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;  
_heliGroup setBehaviour "SAFE";
_heliGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_heliGroup];

// spawn mines, mines everythere
_dirSign = 180;
_vehMineDir = 180;
_apMineDir = 180;
for "_c" from 0 to 150 do {

    // warning signs/naval bottom mines
    if (_c < 91) then {
        _posSign = [_startPoint, 190, _dirSign] call BIS_fnc_relPos;
        if (!surfaceIsWater _posSign) then {
            _sign = createVehicle ["Land_Sign_Mines_F", [70,70,70], [], 0, "CAN_COLLIDE"];
            waitUntil {alive _sign};
            _sign allowDamage false; 
            _sign setDir _dirSign;
            _sign setPos [_posSign select 0, _posSign select 1, 0];            
            _pos = getPosATL _sign; 
            if (_pos select 2 > 0.2) then {
                _pos = [_pos select 0, _pos select 1, 0];
                _sign setPosATL _pos;
            };      
            _unitsArray = _unitsArray + [_sign];
            _mine = createMine ["APERSBoundingMine", [(_posSign select 0) + random 3, (_posSign select 1) + random 3, 0.1], [], 0];
            waitUntil {alive _mine};
            _pos = getPosATL _mine;
            if (_pos select 2 > 0.2) then {
                _pos = [_pos select 0, _pos select 1, 0];
                _mine setPosATL _pos;
            };
        };
        _dirSign = _dirSign + 4;
    };

    // AT/underwater mines    
    _minePos = [_startPoint, 195, _vehMineDir] call BIS_fnc_relPos;
    if (surfaceIsWater _minePos) then {        
        _height = random (floor ((getTerrainHeightASL _minePos) * -1));
        _pos = [(_minePos select 0) + random 3, (_minePos select 1) + random 3, (0 - _height)];
        _mine = createMine ["UnderwaterMine", _pos, [], 0];     
        _vehMineDir = _vehMineDir + 6; 
    } else {
        _mine = createVehicle ["ATMine", [40,40,40], [], 0, "CAN_COLLIDE"];
        _mine setPos [(_minePos select 0) + random 3, (_minePos select 1) + random 3, 0]; 
        _pos = getPosATL _mine; 
        if (_pos select 2 > 0.2) then {
            _pos = [_pos select 0, _pos select 1, 0];
            _mine setPosATL _pos;
        };           
        _vehMineDir = _vehMineDir + 3; 
    };               

    // AP bounding mines
    _minePos = [_startPoint, 200, _apMineDir] call BIS_fnc_relPos;
    if (surfaceIsWater _minePos) then {
        _height = random (floor ((getTerrainHeightASL _minePos) * -1));
        _pos = [(_minePos select 0) + random 3, (_minePos select 1) + random 3, (0 - _height)];
        _mine = createMine ["UnderwaterMine", _pos, [], 0];
        _apMineDir = _apMineDir + 2; 
    } else {
        _mine = createMine ["APERSBoundingMine", [(_minePos select 0) + random 6, (_minePos select 1) + random 6, 0.1], [], 0];
        waitUntil {alive _mine};
        _pos = getPosATL _mine;
        if (_pos select 2 > 0.2) then {
            _pos = [_pos select 0, _pos select 1, 0];
            _mine setPosATL _pos;
        };
        _apMineDir = _apMineDir + 4; 
    };
    
};

// set skills
[(units _campGroup)] call QS_fnc_setSkill3;
[(units _aaGroup)] call QS_fnc_setSkill3;
[(units _staticGroup)] call QS_fnc_setSkill3;
[(units _heliGroup)] call QS_fnc_setSkill3;

while { sideMissionUp } do {
    sleep 2;

    // de-briefing
    if (SM_SNATCH_SUCCESS || SM_SNATCH_FAIL) exitWith {  
        sideMissionUp = false; publicVariable "sideMissionUp";        
        { _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
        if (SM_SNATCH_FAIL) then {
            [] call QS_fnc_SMhintFAIL;            
        } else {
            [] call QS_fnc_SMhintSUCCESS;                     
        };

        // delete mines
        {
            if (_x distance _startPoint < 300) then {
               deleteVehicle _x;
            };            
        } forEach allMines;
        _nearestMines = nearestObjects [_startPoint, ["ATMine","APERSTripMine","APERSBoundingMine","UnderwaterMinePDM","UnderwaterMine"], 300];   
        {
            deleteVehicle _x;
        } forEach _nearestMines;

        sleep 120;  
        { 
            [_x] spawn QS_fnc_SMdelete;
        } forEach [_enemiesArray, _unitsArray];       
    };
    sleep 3;
};