/*
Author:	ToxaBes
Description: Snatch helicopter and return it to the base.
*/

// define some keywords
#define INFANTRY_MISSION "Спецоперация: Угон (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_FUEL_VEHICLE "O_T_Truck_03_fuel_ghex_F"
#define INFANTRY_AA_VEHICLE "O_T_APC_Tracked_02_AA_ghex_F"
#define INFANTRY_CAMONET_BIG "CamoNet_ghex_big_F"
#define INFANTRY_CAMONET_SMALL "CamoNet_ghex_F"
#define INFANTRY_CAMONET_OPEN "CamoNet_ghex_open_F"
#define INFANTRY_HELI_PILOT "O_T_Helipilot_F"
#define INFANTRY_HELI_CREW "O_T_Helicrew_F"
#define INFANTRY_STATIC "O_HMG_01_high_F"
#define INFANTRY_GUNNERS "O_T_Support_MG_F", "O_T_Support_GMG_F", "O_T_Support_AMG_F"
#define INFANTRY_SOLDIERS "O_T_Engineer_F","O_T_Medic_F","O_T_Recon_Exp_F","O_T_Recon_F","O_T_Recon_JTAC_F","O_T_Recon_LAT_F","O_T_Recon_M_F","O_T_Recon_Medic_F","O_T_Recon_TL_F","O_T_Soldier_AA_F","O_T_Soldier_AR_F","O_T_Soldier_AT_F","O_T_Soldier_Exp_F","O_T_Soldier_F","O_T_Soldier_GL_F","O_T_Soldier_LAT_F","O_T_Soldier_M_F","O_T_Soldier_Repair_F","O_T_Soldier_SL_F","O_T_Soldier_TL_F"

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

// format:
//  [[coords x,y],   [drones], [camp x,y,z],     [heli x,y,dir],        [fuel x,y,dir],        [AA x,y,dir],          [bunkers x,y,dir],
//  [guards x,y,z,dir],                                                                                                                                    [pilots x,y,z,dir]]
_targets = [
    [[4126,11691],   [2,3],    [4042,11638,0],   [4160,11721,241],      [3978,11592,145],      [4037,11727,152],      [[3958,11718.7,238],[4076.9,11867.5,351],[4181.9,11683.8,143]],
    [[4120.3,11664.1,0,287],[4066.1,11749,0.1,258],[4253.4,11773.6,0.1,340],[4141.5,11849.6,0.1,22],[4161.4,11688.1,0.1,13],[4218.4,11774.7,0.1,277]],     [[4178,11697,0.1,0],[4187.6,11695.7,0.1,227]]],

    [[3869,13919],   [2,3],    [3828,13880,0],   [4005,13886,9],        [3771,14036,241],      [3790.8,14009.7,98],   [[3965.2,13770.7,127],[3784.6,13843.5,227],[3950.5,13941,29]],
    [[3990.5,13867.7,0.1,199],[3899.1,13872,0.1,179],[3842.3,13911,0.1,281],[3761.7,14013.1,0.1,281],[3802,14045.8,0.1,98],[3889.7,13894.7,0.1,78]],       [[3984.2,13893.6,0.1,78],[3783.9,14000.5,0.1,145]]],

    [[2653,9298],    [2,3],    [2702,9333,0],    [2697,9266,233],       [2628,9276.4,357],     [2665,9342.4,0],       [[2643.8,9201.7,203],[2691.9,9223.8,136],[2658,9361.4,16]],
    [[2635.5,9358.9,0.1,319],[2626.4,9298.2,0.1,209],[2666,9225,0.1,179],[2673.5,9267.2,0.1,72],[2684.7,9341.7,0.1,35],[2653.3,9259.5,0.1,0]],             [[2649.3,9328.4,0.1,108],[2672,9341,0.1,252]]],

    [[2721,7310],    [2,3],    [2764,7309,0],    [2691,7364,203],       [2850.1,7322.5,255],   [2586.8,7396.4,64],    [[2565,7374,290],[2579.4,7309,176],[2883.7,7297,40]],
    [[2850.2,7346.7,0.1,115],[2719.7,7317.2,0.1,254],[2626.6,7325,0.1,214],[2546.7,7391.8,0.1,262],[2536,7342.4,0.1,148],[2676.7,7391.6,0.1,158]],         [[2714.7,7342,0.1,321],[2714.8,7335.9,0.1,23]]],

    [[1736,6148],    [2,3],    [1697,6227,0],    [1681,6187,250],       [1721.4,6059.5,196],   [1645.5,6214.3,298],   [[1761.7,6242.4,67],[1696.2,6069,238],[1772,6124.6,88]],
    [[1715,6175.3,0.1,30],[1673.4,6108.2,0.1,252],[1684.4,6160.1,0.1,279],[1748.8,6169.9,0.1,37],[1719,6197.2,0.1,31],[1746.8,6062.6,0.1,11]],             [[1706.8,6085.3,0.1,11],[1738,6092.7,0.1,70]]],

    [[3685,2132],    [2,3],    [3765,2134,0],    [3681,2055,115],       [3615.5,2130.6,186],   [3662.6,2125.8,37],    [[3593.6,2162.6,328],[3699.6,2155.8,75],[3702,2036.9,209]],
    [[3715.2,2032.5,0.1,134],[3613.6,2064.2,0.1,211],[3660.5,2132.7,0.1,80],[3612.6,2161.2,0.1,264],[3647.7,2129.5,0.1,246],[3676.4,2166,0.1,159]],        [[3708.6,2045.9,0.1,297],[3669.4,2065.5,0.1,82]]],

    [[8999,4726],    [2,3],    [8971,4643,0],    [8921,4620,315],       [9083,4726,83],        [8973.7,4715.4,320],   [[8901.5,4676.5,226],[9033.8,4800.4,67],[8949.8,4773.7,318]],
    [[8950.2,4749.6,0.1,303],[9007,4726.3,0.1,85],[8995.3,4676.6,0.1,156],[8937,4697.5,0.1,224],[8952.1,4677.9,0.1,191],[9063,4787,0.1,9]],                [[8943.4,4674.7,0.1,169],[8956.7,4635.3,0.1,276]]],

    [[8885,3632],    [2,3],    [8906,3668,0],    [8977,3516.7,326],     [8818.1,3698.8,12],    [9013.7,3584,291],     [[9044,3643.3,48],[8979.5,3486,236],[8768.5,3737.2,346]],
    [[8806.9,3692.8,0.1,100],[8823.5,3644.4,0.1,189],[8906,3621.8,0.1,146],[8948.4,3532.2,0.1,220],[9012.3,3549,0.1,264],[8872.3,3617,0.1,118]],           [[8950.5,3554.4,0.1,78],[8967.9,3496.3,0.1,275]]],

    [[10370,2685],   [2,3],    [10461,2647,0],   [10401.2,2700.2,346],  [10320,2639.5,203],    [10442.5,2669,316],    [[10461.2,2747.1,101],[10205.4,2671.7,244],[10437.8,2560.3,182]],
    [[10419.7,2725.3,0.1,48],[10325.2,2663.7,0.1,100],[10332.4,2620.1,0.1,196],[10368.4,2604.8,0.1,170],[10434,2653,0.1,253],[10324.3,2707,0.1,328]],      [[10414.7,2681.3,0.1,281],[10404.2,2720.9,0.1,171]]],

    [[12789,4788],   [2,3],    [12769,4751,0],   [12837.7,4876.5,241],  [12649,4798.8,314],    [12886.7,4827,242],    [[12776.5,4903.2,326],[12857.9,4604.2,178],[12669.9,4710.1,350]],
    [[12662.7,4780.6,0.1,222],[12771.7,4822.1,0.1,53],[12814.3,4896.7,0.1,307],[12895.9,4732.5,0.1,176],[12801.8,4698.2,0.1,134],[12621.7,4795.1,0.1,65]], [[12825.1,4847.4,0.1,3],[12870.9,4869.3,0.1,173]]],

    [[8408,10286],   [2,3],   [8419,10379,0],    [8497.3,10250,215],    [8391.6,10381.7,35],   [8411,10253.6,186],    [[8532.6,10183.8,124],[8359.2,10383.3,304],[8362.4,10259.2,124]],
    [[8503.5,10239.1,0.1,152],[8386.9,10269.4,0.1,203],[8393,10392.5,0.1,352],[8347.2,10404.6,0.1,203],[8328.4,10242.1,0.1,170],[8533.6,10348.4,0.1,89]],  [[8485,10255.1,0.1,130],[8482.4,10206.6,0.1,21]]],

    [[9296,8634],    [2,3],   [9283,8620,0],     [9207,8734.3,92],      [9303.6,8582.9,337],   [9355,8576,197],       [[9343,8555.7,183],[9380,8631.9,54],[9248.3,8713.2,121]],
    [[9189.6,8705,0.1,223],[9327.7,8572.9,0.1,171],[9364.5,8600.5,0.1,113],[9365.3,8638.2,0.1,27],[9323.2,8608,0.1,91],[9333.2,8677.9,204]],               [[9177.2,8743.4,0.1,100],[9154.7,8719.6,0.1,87]]],

    [[13989,9914],   [2,3],   [13906,10025,0],   [14036,9959.9,97],     [13965.1,10012.4,273], [14021.6,9940.2,204],  [[13977.1,9981,181],[14155,9916.4,95],[14030.9,10006.3,68]],
    [[13985.6,10006.3,0.1,210],[13941.1,9982.3,0.1,181],[14132.9,9938,0.1,211],[14132.8,9964.2,0.1,80],[14044,9978.8,0.1,53],[13979.5,10022.2,0.1,53]],    [[14032.5,9947.6,0.1,35],[14139.4,9942.6,0.1,289]]],

    [[13452,12268],  [2,3],   [13382,12429,0],   [13331.4,12371.7,57],  [13608,12290.5,204],   [13539.1,12354.9,203], [[13501.5,12266.2,202],[13307.2,12353.1,237],[13331.3,12326.1,204]],
    [[13365,12443.4,0.1,241],[13295.2,12321,0.1,144],[13313.6,12345,0.1,243],[13582.2,12318.7,0.1,265],[13602.4,12300.7,0.1,27],[13502,12323.2,0.1,159]],  [[13354.4,12403.4,0.1,145],[13369.2,12378.5,0.1,296]]],

    [[12426,12706],  [2,3],   [12544.8,12732,0], [12326,12795.5,127],   [12501,12751.2,88],    [12406.6,12663,337],   [[12467.9,12690.2,90],[12300,12750.5,309],[12382.5,12780.5,37]],
    [[12515.2,12770.6,0.1,34],[12455,12754.7,0.1,182],[12430.6,12725,0.1,206],[12346.7,12734,0.1,245],[12361,12779.5,0.1,289],[12329.4,12703.6,0.1,252]],  [[12351.8,12769.8,0.1,309],[12350.5,12806.2,0.1,229]]],

    [[10987,13196],  [2,3],   [10901,13263,0],   [10946.5,13081.7,256], [10944.7,13286.1,304], [10965.8,13111.2,180], [[10967.4,13063.8,176],[11022.1,13114.6,75],[11007,13309.3,297]],
    [[10962.2,13269.5,0.1,89],[11034.4,13254,0.1,88],[10941.7,13237,0.1,110],[10919.3,13159.6,0.1,146],[10969,13148.7,0.1,266],[10918.6,13109.8,0.1,143]], [[10986.8,13076.5,0.1,276],[10983.1,13117,0.1,172]]],

    [[13230,13800],  [2,3],   [13200,13798,0],   [13279.7,13731.4,111], [13055.2,13803.8,205], [13203.9,13728.8,220], [[13116.6,13801.1,307],[13236.8,13749.2,304],[13297,13687.5,200]],
    [[13266.7,13721.7,0.1,293],[13280,13759.5,0.1,12],[13267.7,13807.4,0.1,347],[13130.7,13761.5,0.1,219],[13047,13809.4,0.1,359],[13148,13794,0.1,175]],  [[13294.6,13711.4,0.1,301],[13292.4,13746.8,0.1,218]]],

    [[6865,13345],   [2,3],   [6809.7,13319,0],  [6707,13397.7,47],     [7024.1,13416.3,352],  [6927,13370.5,164],    [[6860.8,13266.2,252],[6952,13295.5,156],[7034.1,13394.4,80]],
    [[7033.5,13419.8,0.1,176],[6978.8,13361.6,0.1,285],[6854,13388,0.1,109],[6712.2,13353.6,0.1,333],[6777,13317.8,0.1,14],[6811.5,13407.4,0.1,315]],      [[6724,13417,0.1,39],[6710,13380.3,0.1,351]]],

    [[5739,12287],   [2,3],   [5748.3,12348,0],  [5697,12344.7,145],    [5786.38,12271.5,137], [5643.6,12354.2,281],  [[5679.6,12255,225],[5638.1,12370,285],[5770.3,12207,101]],
    [[5755,12254.6,0.1,95],[5799,12275.8,0.1,1],[5742.7,12327.6,0.1,22],[5698.3,12360.8,0.1,4],[5677.2,12303.6,0.1,224],[5723.5,12289,0.1,232]],           [[5692.4,12323,0.1,46],[5716.6,12342.5,0.1,235]]],

    [[4309,8432],    [2,3],   [4263,8432,0],     [4260.7,8480.5,145],   [4389.4,8418,139],     [4309.7,8466.2,56],    [[4323,8427,64],[4226,8366.5,180],[4438.8,8426.6,63]],
    [[4405.9,8409.2,0.1,117],[4461.7,8470.5,0.1,258],[4304.4,8453.5,0.1,55],[4238.6,8490.6,0.1,272],[4291.7,8384.3,0.1,347],[4203.9,8437.1,0.1,268]],      [[4289.4,8456.4,0.1,293],[4282,8429.8,0.1,334]]],

    [[10051,9295],   [2,3],   [10064,9323,0],    [10032.2,9284.9,17],   [10121.7,9201.2,121],  [10197.3,9228.6,314],  [[9903.3,9350.7,306],[10007.9,9408.5,338],[10106.9,9186.8,173]],
    [[10123.4,9216.7,0.1,296],[10151.7,9205.8,0.1,55],[9996,9321.2,0.1,35],[10073.9,9374.8,0.1,222],[10068.5,9398.1,0.1,359],[10109.1,9330,0.1,268]],      [[10006.6,9306,0.1,110],[10054.8,9279,0.1,288]]]
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
    "O_T_Soldier_F" createUnit [[10,10,10], _campGroup, "currentGuard = this"];
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
    _uavData = [_posSpawn, 90, "B_UAV_01_F", ENEMY_SIDE] call BIS_fnc_spawnVehicle;
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
    _bunkerBag = createVehicle ["Land_BagBunker_01_small_green_F", _bunkerPos, [], 0, "CAN_COLLIDE"];
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
_enemiesArray pushBack _patrolGroup;

// spawn Viper group
if (random 1 > 0.5) then {
    _viperGroup = [_startPoint, ENEMY_SIDE, (configfile >> "CfgGroups" >> "EAST" >> "OPF_T_F" >> "SpecOps" >> "O_T_ViperTeam")] call BIS_fnc_spawnGroup;
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
[(units _patrolGroup)] call QS_fnc_setSkill3;
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
