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
#define INFANTRY_SOLDIERS "O_Soldier_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_TL_F","O_soldier_M_F","O_Soldier_LAT_F","O_medic_F","O_soldier_repair_F","O_soldier_exp_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_recon_F","O_recon_M_F","O_recon_LAT_F","O_recon_medic_F","O_recon_TL_F","O_Soldier_AAT_F","O_soldierU_M_F","O_SoldierU_GL_F"

// define private variables
private ["_enemiesArray", "_unitsArray", "_arr", "_cnt", "_targets", "_helicopters", "_position", "_flatPos", "_startPoint", "_briefing", "_campPos", "_camp", "_campFires", "_tentDome", "_campGroup", "_sleepingBags", "_sleepingPositions", "_sleepingPos", "_i", "_bagPos", "_heliPos", "_heliDir", "_heliLand", "_heliData", "_heliType", "_trig", "_boxes", "_n", "_height", "_posInit", "_posSpawn", "_uavData", "_uav", "_uavGroup", "_fuelPos", "_fuelDir", "_fuelNet", "_fuelVeh", "_aaGroup", "_aaPos", "_aaDir", "_aaVeh", "_aa", "_staticGroup", "_bunkers", "_bunkerPos", "_bunkerDir", "_bunkerBag", "_posBlock", "_block", "_bunkerCamonet", "_posATL", "_static", "_singlePositions", "_heliGroup", "_pilotPositions", "_pilotPos", "_crewPos", "_patrolGroup", "_viperGroup", "_dirSign", "_vehMineDir", "_apMineDir", "_c", "_posSign", "_sign", "_mine", "_minePos", "_nearestMines"];

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

// format: [[coords x,y], [drones],     [camp x,y,z],     [heli x,y,dir],         [fuel x,y,dir],         [AA x,y,dir],            [bunkers x,y,dir],                                                   [guards x,y,z,dir],                                                                                                                                       [pilots x,y,z,dir]]
_targets = [
    [[5028,5785],         [2,3],     [4988.11,5807.55,0], [5084.39,5808.57,300],  [4977.39,5848.3,0],     [4940.78,5843.22,150],   [[5160.17,5872.6,180],[4941.77,5971.52,135],[4947.73,5728.58,30]],   [[4918.03,5951.16,0,245],[5099.44,5695.23,0,123],[4901.64,5828.14,0,172],[4975.16,5776.16,0,236],[4995.54,5941.67,0,83],[5074.81,5888.24,0,43]],          [[5018.15,5820.31,0,0],[5018.18,5823.53,0,180]]],
    [[2679,7210],         [2,3],     [2744.77,7370,0],    [2708.46,7306.69,37],   [2591.24,7107.35,261],  [2593.99,7212.68,0],     [[2743.43,7390.66,175],[2595.53,7055.77,0],[2745.27,7254.13,112]],   [[2523.75,7253.34,0,290],[2631.66,7174.02,0,172],[2689.78,7390.96,0,168],[2766.78,7308.03,9.2,172],[2791.89,7245.14,0,8],[2656.58,7099.45,0,132]],        [[2744.01,7356.8,0,86],[2746.8,7356.27,0,281]]],
    [[1236,11621],        [2,3],     [1255.59,11775.1,0], [1308.17,11774.3,332],  [1156.45,11503.5,211],  [1285.72,11673.1,150],   [[1131.07,11466.9,43],[1384.93,11592.6,265],[1156.33,11692.6,152]],  [[1292.32,11724.2,0,62],[1191.05,11616,0,292],[1181.71,11771.1,0,292],[1231.73,11745.4,0,6],[1348.51,11783.2,0,152],[1317.53,11634.2,0,326]],             [[1271.41,11784.4,0,78],[1275.46,11784.8,0,248]]],
    [[9869,5912],         [2,3],     [9742.52,5897.76,0], [9930.89,5961.42,332],  [9779.43,5933.82,92],   [9842.27,5893.51,61],    [[9732.13,5970.11,152],[9801.49,5814.9,43],[9996.69,5977.5,298]],    [[9696.21,5920.2,19.63,136],[9717.08,5906.12,0.56,346],[9809.22,5965.95,0,36],[9846.76,5855.99,0,262],[9893.13,5821.55,0,146],[9888.51,5942.33,0,152]],   [[9740.73,5905.31,0,247],[9735.69,5904.56,0,79]]],
    [[9394,6913],         [2,3],     [9375.66,6888.05,0], [9500.75,6957.36,332],  [9384.22,6840.76,167],  [9431.85,6936.72,61],    [[9280.11,6768.11,11],[9302.91,6934.81,126],[9478.87,7022.17,111]],  [[9251.25,6845.35,0.36,302],[9271.71,6881.54,2.81,328],[9343.02,6802.13,0,150],[9347.91,6953.32,0,4],[9472.21,6896.38,0,121],[9525.42,7012.06,0,67]],     [[9371.03,6895.49,0,79],[9376.08,6896.24,0,248]]],
    [[8918,4351],         [2,3],     [8907.24,4352.48,0], [8845.52,4360.79,78],   [8946.7,4301.24,10],    [8940.22,4376.56,300],   [[8918.25,4414.93,181],[8844.17,4321.49,65],[8904.5,4278.28,317]],   [[8862.21,4330.71,2.77471,176],[8864.09,4390.55,0,310],[8898.61,4332.88,0,282],[8963.39,4279.88,0,150],[8974.09,4334,0,121],[8958.49,4367.26,0,67]],      [[8922.42,4344.82,0,132],[8924.73,4342.35,0,323]]],
    [[5937,10743],        [2,3],     [5865.37,10767.6,0], [5929.09,10735.9,354],  [6002.2,10799.2,148],   [5904.77,10810.4,176],   [[5850.95,10888.9,241],[5783.61,10748.6,92],[6039.85,10761.7,264]],  [[5871.64,10783.6,3.33,245],[5866.81,10608.7,0,295],[5914.34,10668.5,4,0],[5970.15,10656.4,0,67],[6044.99,10729.4,0,150],[6103.93,10770.7,0,121]],        [[5871.95,10777.9,0,132],[5874.26,10775.5,0,323]]]
];

// format: ["heli name",                 "removed weapon1",           "removed magazine1",                       "added weapon1",                "added magazine1",                       "removed weapon2",            "removed magazine2",              "added weapon2",                "added magazine2"]
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
_position = selectRandom _targets;
_flatPos  = _position select 0;

// set zone area
_startPoint = [(_flatPos select 0),(_flatPos select 1),1];
{ _x setMarkerPos _flatPos; } forEach ["sideMarker", "sideCircle"];
"sideCircle" setMarkerSize [200, 200]; publicVariable "sideCircle";
sideMarkerText = [INFANTRY_MISSION, true]; publicVariable "sideMarkerText";
"sideMarker" setMarkerText INFANTRY_MISSION; publicVariable "sideMarker";
SM_SNATCH_FAIL = false; publicVariable "SM_SNATCH_FAIL";
SM_SNATCH_SUCCESS = false; publicVariable "SM_SNATCH_SUCCESS";

// show brief information
_briefing = "<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FFC107'>Угон</t><br/>____________________<br/>Неделю назад противник атаковал один из наших складов и захватил экспериментальный вертолет. Сегодня наша разведка обнаружила его на одной из замаскированных баз противника. Командование назначило пехотную спецоперацию.<br/><br/>Ваша задача — выдвинуться в указанный район, захватить вертолет и вернуть его на базу.</t>";
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSpecMission", "Угон"]; publicVariable "showNotification";
sideMissionUp = true; publicVariable "sideMissionUp";

// spawn camp
_campPos = _position select 2;
_camp = [_campPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "Empty" >> "Guerrilla" >> "Camps" >> "CampC")] call BIS_fnc_spawnGroup;
_campFires = nearestObjects [_campPos, ["Land_Campfire_F", "Campfire_burning_F"], 5];
{
    _x inflame true;
} forEach _campFires;
_unitsArray pushBack _camp;
for "_x" from 1 to 6 do {
    _tentDome = createVehicle ["Land_TentDome_F", _campPos, [], 10, "NONE"];
    _unitsArray pushBack _tentDome;
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
_enemiesArray pushBack _campGroup;

// spawn heli
_heliPos =  [(_position select 3) select 0, (_position select 3) select 1, 0];
_heliDir = (_position select 3) select 2;
_heliLand = createVehicle ["Land_HelipadSquare_F", _heliPos, [], 0, "CAN_COLLIDE"];
_heliLand setDir (_heliDir + 180);
_unitsArray pushBack _heliLand;
_heliData = selectRandom _helicopters;
_heliType = _heliData select 0;
heliSnatch = createVehicle [_heliType, _heliPos, [], 0, "NONE"];
heliSnatch addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
heliSnatch setDir _heliDir;
heliSnatch addMPEventHandler ["MPKilled",
    {
        if (isServer) then {
            SM_SNATCH_FAIL = true; publicVariable "SM_SNATCH_FAIL";
        };
    }
];
heliSnatch setVariable ["ALLOW_ONCE", true, true];

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
    if (_heliType == "B_Heli_Transport_01_camo_F" || _heliType == "B_Heli_Transport_01_F") then {
       heliSnatch removeWeaponTurret [_heliData select 5, [2]];
       heliSnatch removeMagazinesTurret [_heliData select 6, [2]];
       heliSnatch addWeaponTurret [_heliData select 7, [2]];
       heliSnatch addMagazineTurret [_heliData select 8, [2]];
    };
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
    _unitsArray pushBack _boxes;
};

// spawn patrolling drones
_n = selectRandom (_position select 1);
for "_i" from 1 to _n do {
    _height = (random 20) + 15;
    _posInit = [_campPos, 1, 100, 2, 1, 1, 0, [], [_campPos]] call QS_fnc_findSafePos;
    _posSpawn = [_posInit select 0, _posInit select 1, _height];
    _uavData = [_posSpawn, 90, "O_UAV_01_F", ENEMY_SIDE] call BIS_fnc_spawnVehicle;
    _uav = _uavData select 0;
    _uavGroup = _uavData select 2;
    _uav addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    _uav addWeapon ("LMG_Mk200_F");
    _uav addMagazine ("200Rnd_65x39_cased_Box_Tracer");
    _uavGroup setBehaviour "SAFE";
    _uavGroup setCombatMode "RED";
    [(units _uavGroup)] call QS_fnc_setSkill2;
    [_uavGroup, _posSpawn, (40 + (random 80))] call BIS_fnc_taskPatrol;
    _unitsArray pushBack _uav;
    _enemiesArray pushBack _uavGroup;
    [_uav] spawn {
        _u = _this select 0;
        while {alive _u} do {
            sleep 180;
            _u setFuel 1;
        };        
    };
};

// spawn fuel vehicle
_fuelPos =  [(_position select 4) select 0, (_position select 4) select 1, 0];
_fuelDir = (_position select 4) select 2;
_fuelNet = createVehicle [INFANTRY_CAMONET_BIG, _fuelPos, [], 0, "CAN_COLLIDE"];
_fuelNet setDir _fuelDir;
_unitsArray pushBack _fuelNet;
_fuelVeh = createVehicle [INFANTRY_FUEL_VEHICLE, _fuelPos, [], 0, "CAN_COLLIDE"];
_fuelVeh setDir _fuelDir;
_fuelVeh addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
_unitsArray pushBack _fuelVeh;

// spawn AA vehicle
_aaGroup =  createGroup ENEMY_SIDE;
_aaPos =  [(_position select 5) select 0, (_position select 5) select 1, 0];
_aaDir = (_position select 5) select 2;
_aaVeh = [_aaPos, _aaDir, INFANTRY_AA_VEHICLE, _aaGroup] call BIS_fnc_spawnVehicle;
_aa = _aaVeh select 0;
_aa addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
_aa setFuel 0;
_aa setVehicleLock "LOCKED";
_aa lock true;
_unitsArray pushBack _aa;
_aaGroup setBehaviour "SAFE";
_aaGroup setCombatMode "RED";
_enemiesArray pushBack _aaGroup;

// spawn bunkers
_staticGroup = createGroup ENEMY_SIDE;
_bunkers = _position select 6;
{

    // bunker
    _bunkerPos =  [_x select 0, _x select 1, 0];
    _bunkerDir = (_x select 2) + 180;
    _bunkerBag = createVehicle ["Land_BagBunker_Small_F", _bunkerPos, [], 0, "CAN_COLLIDE"];
    _bunkerBag setDir _bunkerDir;
    _unitsArray pushBack _bunkerBag;

    // put cargo at back
    _posBlock = [_bunkerBag, 5, _bunkerDir] call BIS_fnc_relPos;
    _block = createVehicle ["Land_Cargo20_military_green_F",[1,1,1],[],0,"CAN_COLLIDE"];
    _block setPos _posBlock;
    _block setDir _bunkerDir;
    _unitsArray pushBack _block;

    // camonet for bunker
    _bunkerCamonet = createVehicle [INFANTRY_CAMONET_SMALL, _bunkerPos, [], 0, "CAN_COLLIDE"];
    _bunkerCamonet setDir _bunkerDir;
    _bunkerCamonet allowDamage false;
    _unitsArray pushBack _bunkerCamonet;

    // camonet for cargo
    _bunkerCamonet = createVehicle [INFANTRY_CAMONET_OPEN, [_posBlock select 0, _posBlock select 1, (_posBlock select 2) + 0.5], [], 0, "CAN_COLLIDE"];
    _bunkerCamonet setDir _bunkerDir;
    _bunkerCamonet allowDamage false;
    _unitsArray pushBack _bunkerCamonet;

    // static weapon
    _posATL = getPos _bunkerBag;
    _posATL = [(_posATL select 0), (_posATL select 1), (_posATL select 2) + 0.2];
    _static = INFANTRY_STATIC createVehicle [10,10,10];
    waitUntil{!isNull _static};
    _static allowDamage false;
    _static setPos _posATL;
    _static setDir _bunkerDir;
    (selectRandom [INFANTRY_GUNNERS]) createUnit [[10,10,10], _staticGroup, "currentGuard = this"];
    currentGuard allowDamage false;
    sleep 0.1;
    currentGuard assignAsGunner _static;
    currentGuard moveInGunner _static;
    _static setVectorUp [0,0,1];
    _static lock 3;
    currentGuard allowDamage true;
    _static allowDamage true;
    _unitsArray pushBack _static;
    _static = nil;
} forEach _bunkers;

// spawn single guards
_singlePositions = _position select 7;
{
    (selectRandom [INFANTRY_SOLDIERS]) createUnit [[10,10,10], _staticGroup, "currentGuard = this"];
    currentGuard setPos [_x select 0, _x select 1, _x select 2];
    currentGuard setDir (_x select 3);
    [currentGuard,"STAND","FULL", {!isNull (currentGuard findNearestEnemy (getPos currentGuard)) || lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
} forEach _singlePositions;

_staticGroup setBehaviour "SAFE";
_staticGroup setCombatMode "RED";
_enemiesArray pushBack _staticGroup;

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
_enemiesArray pushBack _heliGroup;

// spawn patrol group
_patrolGroup = [_startPoint, ENEMY_SIDE, (configfile >> "CfgGroups" >> "EAST" >> "OPF_T_F" >> "Infantry" >> "O_T_reconPatrol")] call BIS_fnc_spawnGroup;
[_patrolGroup, _startPoint, 100] call QS_fnc_taskMaxDistPatrol;
_patrolGroup setBehaviour "SAFE";
_patrolGroup setCombatMode "RED";

// spawn Viper group
if (random 1 > 0.5) then {
    _viperGroup = [_startPoint, ENEMY_SIDE, (configfile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "SpecOps" >> "OI_ViperTeam")] call BIS_fnc_spawnGroup;
    [_viperGroup, _startPoint, 175] call QS_fnc_taskMaxDistPatrol;
    _viperGroup setCombatMode "RED";
    _viperGroup setBehaviour "STEALTH";
    [(units _viperGroup)] call QS_fnc_setSkill4;
    _enemiesArray pushBack _viperGroup;
};

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
            _unitsArray pushBack _sign;
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
[_startPoint, 200, ["vehicles", "fire"]] call QS_fnc_addHades;

// save info in DB
try {
    _position = format ["%1,%2", floor (_flatPos select 0), floor (_flatPos select 1)];
    ["setInfo",["spec_name", "Угон"], 0] remoteExec ["sqlServerCall", 2];
    ["setInfo",["spec_position", _position], 0] remoteExec ["sqlServerCall", 2];
} catch {};

while { sideMissionUp } do {
    sleep 2;

    // de-briefing
    if (SM_SNATCH_SUCCESS || SM_SNATCH_FAIL) exitWith {
        sideMissionUp = false; publicVariable "sideMissionUp";
        { _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
        if (SM_SNATCH_FAIL) then {
            [true] call QS_fnc_SMhintFAIL;
        } else {
            if (side (driver heliSnatch) == west) then {
                WIN_WEST = WIN_WEST + 1; publicVariable "WIN_WEST";
            } else {
                WIN_GUER = WIN_GUER + 1; publicVariable "WIN_GUER";
            };
            if (WIN_WEST > WIN_GUER) then {
                [4] spawn QS_fnc_bluforSUCCESS;
            } else {
                [4] spawn QS_fnc_partizanSUCCESS;
            };
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
            [_x] call QS_fnc_TBdeleteObjects;
        } forEach [_enemiesArray, _unitsArray];
        [_startPoint, 500] call QS_fnc_DeleteEnemyEAST;
    };
    sleep 3;
};
