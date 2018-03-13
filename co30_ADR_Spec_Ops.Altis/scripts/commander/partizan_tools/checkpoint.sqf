/*
Author: ToxaBes
Description: add partizan checkpoint
*/
_center = _this select 0;
_blufor_base = getMarkerPos "respawn_west";
if (_center distance2D _blufor_base < 500) exitWith {
    ["<t color='#F44336' size = '.48'>Слишком близко к базе регулярной армии!</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
["<t color='#7FDA0B' size = '.48'>Развертывание блокпоста...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
_templates = [
    [
    	["Land_HBarrier_3_F",[-0.0281982,3.78906,0],89.5105,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[-0.187378,-1.8418,0],90.1845,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[1.03162,1.94922,0],344.51,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[-3.23499,2.49023,0],14.5105,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[5.35754,-2.20752,0],179.51,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[-3.33716,-2.27344,0],179.51,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[2.47034,-5.29785,0],178.732,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[-0.895752,-5.375,0],177.236,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[6.65002,0.65918,0],119.51,1,0,[0,-0],"","",true,false], 
    	["Land_BagBunker_Small_F",[5.86719,3.40771,0],209.51,1,0,[0,0],"","",true,false], 
    	["Land_BagBunker_Small_F",[-5.93774,3.30713,0],149.51,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[-6.96313,0.52002,0],59.5105,1,0,[0,0],"","",true,false], 
    	["I_HMG_01_high_F",[5.71472,2.66553,0],23.9373,1,0,[0,0],"","",true,false], 
    	["I_GMG_01_high_F",[-5.71887,2.79199,0],334.443,1,0,[0,0],"","",true,false]
    ],    
    [
    	["I_GMG_01_high_F",[-0.223999,-3.08984,0],175.664,1,0,[0,-0],"","",true,false], 
    	["CamoNet_BLUFOR_open_F",[-1.18018,-3.15283,0],165,1,0,[0,-0],"","",true,false], 
    	["Land_PaperBox_open_full_F",[-4.05115,-1.35352,0],0,1,0,[0,0],"","",true,false], 
    	["Land_Bunker_01_small_F",[-2.46094,4.41016,0],180,1,0,[0,0],"","",true,false], 
    	["Land_Sacks_heap_F",[-4.30115,-2.84424,0],345,1,0,[0,0],"","",true,false], 
    	["Land_Bunker_01_blocks_3_F",[-5.60059,0.00537109,0],270,1,0,[0,0],"","",true,false], 
    	["Land_Bunker_01_blocks_1_F",[2.38147,5.32422,0],0,1,0,[0,0],"","",true,false], 
    	["Land_Bunker_01_blocks_1_F",[4.12988,4.84766,0],30,1,0,[0,0],"","",true,false], 
    	["I_HMG_01_high_F",[5.78992,3.61328,0],35.0688,1,0,[0,0],"","",true,false], 
    	["Land_Bunker_01_blocks_3_F",[8.14148,0.97998,0],53.2265,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[-8.81897,-3.73828,0],240,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[3.05054,-9.66162,0],345,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[9.69971,-3.61377,0],285,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[-1.93115,-10.5054,0],180,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[7.39978,-7.73682,0],285,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[-7.36304,-8.33057,0],240,1,0,[0,0],"","",true,false]
    ],    
    [
    	["Land_HBarrier_1_F",[0.97998,-0.090332,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_BagFence_End_F",[1.02881,-2.56543,0],357.521,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Long_F",[-2.43921,-1.26709,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[-1.87842,3.06494,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_BagFence_Long_F",[-1.08167,-2.61719,0],180,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[2.49658,2.18994,0],90,1,0,[0,-0],"","",true,false], 
    	["I_GMG_01_high_F",[0.310791,4.05566,0],359.688,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Long_F",[3.57056,-2.59326,0],180,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[2.28064,3.17822,0],0,1,0,[0,0],"","",true,false], 
    	["Land_BagBunker_Small_F",[0.269653,5.25684,0],180,1,0,[0,0],"","",true,false], 
    	["I_HMG_01_high_F",[5.06274,0.504883,0],77.6798,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Short_F",[5.24512,-1.87549,0],120,1,0,[0,-0],"","",true,false], 
    	["Land_BagFence_Short_F",[6.151,-0.415527,0],120,1,0,[0,-0],"","",true,false], 
    	["Land_BagFence_Short_F",[5.88403,3.07715,0],0,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Long_F",[6.62903,1.69727,0],270,1,0,[0,0],"","",true,false]
    ],
    [
    	["Land_HBarrier_1_F",[0.891724,0.0864258,0],180,1,0,[0,0],"","",true,false], 
    	["Land_Pallets_F",[-2.87988,0.243652,0],87.9089,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[0.981567,3.021,0],180,1,0,[0,0],"","",true,false], 
    	["I_GMG_01_high_F",[-1.62158,2.34131,0],325.676,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[4.45007,0.0541992,0],180,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[-3.41113,0.157715,0],180,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Short_F",[-3.55249,1.13867,0],270,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Long_F",[-0.679932,4.03955,0],0,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Round_F",[-3.43774,3.21143,0],120,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_1_F",[4.3429,1.57422,0],180,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[4.34155,3.02344,0],180,1,0,[0,0],"","",true,false], 
    	["Land_BagBunker_Small_F",[2.32397,5.3291,0],180,1,0,[0,0],"","",true,false], 
    	["I_HMG_01_high_F",[2.66443,5.04688,0],358.045,1,0,[0,0],"","",true,false]
    ],
    [
    	["Land_BagFence_Long_F",[0.026123,-1.50293,0],180,1,0,[0,0],"","",true,false], 
    	["I_HMG_01_high_F",[0.968506,0.226074,0],124.876,1,0,[0,-0],"","",true,false], 
    	["Land_BagFence_Round_F",[2.65881,-0.799805,0],300,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[-2.5459,-0.0698242,0],271.076,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[-1.39209,-1.45361,0],180,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Short_F",[2.77368,1.27344,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[-1.48914,2.91064,0],180,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[2.77209,2.89551,0],180,1,0,[0,0],"","",true,false], 
    	["Land_BagBunker_Small_F",[0.647217,5.06787,0],180,1,0,[0,0],"","",true,false], 
    	["I_GMG_01_high_F",[0.787964,4.39307,0],0,1,0,[0,0],"","",true,false]
    ],
    [
    	["Land_Sacks_heap_F",[-0.664307,2.75195,0],165,1,0,[0,-0],"","",true,false], 
    	["Land_PaperBox_open_empty_F",[-2.03943,2.50195,0],0,1,0,[0,0],"","",true,false], 
    	["Land_Barricade_01_4m_F",[3.5127,1.61328,0],90,1,0,[0,-0],"","",true,false], 
    	["MetalBarrel_burning_F",[-2.20056,-3.16602,0],0,1,0,[0,0],"","",true,false], 
    	["Land_Tyres_F",[3.81531,-0.699707,0],0,1,0,[0,0],"","",true,false],    	
    	["Land_Barricade_01_10m_F",[-4.63098,-1.0459,0],272.098,1,0,[0,0],"","",true,false], 
    	["Land_Wreck_Car2_F",[5.60095,0.10498,0],30,1,0,[0,0],"","",true,false], 
    	["Land_GarbageBags_F",[4.79553,1.36182,0],0,1,0,[0,0],"","",true,false], 
    	["Land_Wreck_Truck_F",[-0.192383,-5.95898,0],285,1,0,[0,0],"","",true,false], 
    	["Land_BagBunker_Tower_F",[0.230103,6.39404,0],90,1,0,[0,-0],"","",true,false], 
    	["I_GMG_01_high_F",[1.61279,6.13135,0],85.5395,1,0,[0,0],"","",true,false], 
    	["I_HMG_01_high_F",[2.40771,-3.67871,0],124.876,1,0,[0,-0],"","",true,false], 
    	["Land_Barricade_01_10m_F",[0.335693,10.502,0],0,1,0,[0,0],"","",true,false]
    ],
    [
    	["Land_BagBunker_Small_F",[-0.0981445,2.96484,0],180,1,0,[0,0],"","",true,false], 
    	["I_GMG_01_high_F",[0.0487061,2.46973,0],0.716353,1,0,[0,0],"","",true,false], 
    	["I_HMG_01_high_F",[1.0929,-3.01758,0],158.797,1,0,[0,-0],"","",true,false], 
    	["Land_Barricade_01_4m_F",[-3.59827,0.53418,0],180,1,0,[0,0],"","",true,false], 
    	["Land_CratesWooden_F",[-3.34888,-1.2876,0],315,1,0,[0,0],"","",true,false], 
    	["Land_PaperBox_closed_F",[-2.30164,-3.12354,0],210,1,0,[0,0],"","",true,false], 
    	["Land_Barricade_01_4m_F",[3.77673,1.40918,0],30,1,0,[0,0],"","",true,false], 
    	["Land_GarbagePallet_F",[5.06628,-1.54297,0],75,1,0,[0,0],"","",true,false], 
    	["Land_Wreck_Car_F",[6.78772,0.0405273,0],300,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[0.654053,-8.13721,0],0,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[-6.00842,-6.61035,0],0,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[-9.11755,-0.196289,0],0,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[-6.29285,6.74951,0],165,1,0,[0,-0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[0.680176,9.35889,0],0,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[7.66187,-6.19775,0],0,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[7.70715,6.76123,0],240,1,0,[0,0],"","",true,false], 
    	["Land_CzechHedgehog_01_F",[11.9559,-0.249023,0],0,1,0,[0,0],"","",true,false]
    ],
    [
    	["Land_BarrelWater_grey_F",[-0.428101,-2.2168,0],180,1,0,[0,0],"","",true,false],     	
    	["Land_BagFence_Short_F",[-1.43884,-2.71533,0],0,1,0,[0,0],"","",true,false], 
    	["Land_BagBunker_Small_F",[-0.0531006,3.58887,0],180,1,0,[0,0],"","",true,false],     	
    	["Land_BagFence_Round_F",[-3.38269,1.90723,0],135,1,0,[0,-0],"","",true,false], 
    	["Land_Wreck_BRDM2_F",[0.746704,-3.53223,0],255,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Round_F",[-3.55212,-2.17139,0],45,1,0,[0,0],"","",true,false], 
    	["I_HMG_01_high_F",[0.182739,3.00635,0],1.68827,1,0,[0,0],"","",true,false], 
    	["I_GMG_01_high_F",[-2.13574,-0.0922852,0],269.821,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Short_F",[-3.92664,-0.0810547,0],90,1,0,[0,-0],"","",true,false]
    ],
    [
    	["Land_BagBunker_Large_F",[-0.380859,-3.08789,0],0,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[-1.17688,1.83057,0],270.913,1,0,[0,0],"","",true,false], 
    	["I_GMG_01_high_F",[2.64783,2.66553,-0.0749998],34.6644,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Long_F",[4.03027,2.99023,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_BagFence_Long_F",[2.61987,4.25391,0],177.578,1,0,[0,-0],"","",true,false], 
    	["MetalBarrel_burning_F",[-1.13196,5.26611,0],180,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_End_F",[-3.35107,4.13281,0],359.711,1,0,[0,0],"","",true,false], 
    	["I_HMG_01_high_F",[-4.81934,2.92627,0],271.23,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_End_F",[1.18799,6.03857,0],359.711,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Round_F",[-6.05579,1.91602,0],52.3407,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Long_F",[-1.11462,6.07813,0],0.346581,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Round_F",[-5.73535,3.89697,0],140.918,1,0,[0,-0],"","",true,false], 
    	["Land_Razorwire_F",[5.73865,-4.96338,0],269.219,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_End_F",[-3.57361,6.0083,0],176.799,1,0,[0,-0],"","",true,false], 
    	["Land_Razorwire_F",[-6.52441,-5.14453,0],269.219,1,0,[0,0],"","",true,false], 
    	["Land_Razorwire_F",[1.32227,-9.13916,0],180,1,0,[0,0],"","",true,false]
    ],
    [
    	["Land_Wreck_Car_F",[1.10962,2.04102,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_BagFence_Long_F",[2.44031,-1.68652,0],180,1,0,[0,0],"","",true,false], 
    	["I_HMG_01_high_F",[2.58569,-0.39502,0],251.334,1,0,[0,0],"","",true,false], 
    	["Land_CampingChair_V2_F",[-3.48328,1.61816,0],144.732,1,0,[0,-0],"","",true,false], 
    	["MetalBarrel_burning_F",[-4.32092,-0.599121,0],8,1,0,[0,0],"","",true,false], 
    	["Land_CncBarrier_F",[-1.81018,-4.04688,0],358.955,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_End_F",[-3.78784,-1.54443,0],357.63,1,0,[0,0],"","",true,false], 
    	["Land_WoodenTable_small_F",[-3.84631,2.64355,0],60.0004,1,0,[0,0],"","",true,false], 
    	["Land_CncBarrier_F",[2.61194,-3.94482,0],358.955,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Short_F",[4.68176,-1.64063,0],179.331,1,0,[0,-0],"","",true,false], 
    	["I_GMG_01_high_F",[0.295288,4.91211,0],10.3969,1,0,[0,0],"","",true,false], 
    	["Land_Razorwire_F",[-1.22571,-5.04785,0],0.212366,1,0,[0,0],"","",true,false], 
    	["Land_CratesWooden_F",[-5.24048,1.18115,0],59.1111,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Long_F",[-5.44299,-0.40332,0],55.4343,1,0,[0,0],"","",true,false], 
    	["Land_Wreck_Ural_F",[4.6228,3.26953,0],135,1,0,[0,-0],"","",true,false], 
    	["Land_CncBarrier_F",[4.48108,4.07178,0],46.3628,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Round_F",[0.634277,6.45996,0],195.777,1,0,[0,0],"","",true,false], 
    	["Land_Wreck_Truck_dropside_F",[-5.19702,3.92871,0],60,1,0,[0,0],"","",true,false], 
    	["Land_Tyres_F",[-2.27539,6.31641,0],0,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Round_F",[6.98669,-1.28809,0],317.528,1,0,[0,0],"","",true,false], 
    	["Land_CncBarrier_F",[0.762085,6.95215,0],15.0742,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Round_F",[-4.33643,-6.00732,0],49.5084,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Long_F",[-7.04932,1.97266,0],55.4343,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Round_F",[5.07092,-5.95508,0],305.002,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Short_F",[7.55298,0.929688,0],270.163,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_End_F",[-7.49304,3.88428,0],295,1,0,[0,0],"","",true,false]
    ]
];
_composition = selectRandom _templates;
_dir = random 360;
[_center, _dir, _composition] call BIS_fnc_ObjectsMapper;

_staticGroup = createGroup resistance;
_objs = nearestObjects [_pos, ["StaticWeapon"], 20];
{
    "I_C_Soldier_Bandit_1_F" createUnit [(getPos _x), _staticGroup, "unit = this;"];
    unit assignAsGunner _x;
    unit moveInGunner _x;    
} forEach _objs;
_staticGroup setBehaviour "COMBAT";
_staticGroup setCombatMode "RED";
[(units _staticGroup)] call QS_fnc_setSkill4;
[_staticGroup, true] call QS_fnc_moveToHC;

_patrolGroup = createGroup resistance;
_units = ["I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_4_F",
"I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_7_F",
"I_C_Soldier_Para_6_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_1_F"];
for "_i" from 1 to 3 do {
    _spawnPos = [_center, 0, 30, 1, 0, 10, 0, []] call QS_fnc_findSafePos;
    (selectRandom _units) createUnit [_spawnPos, _patrolGroup];
};

_nearestTargets = nearestObjects [_center, ["Man","LandVehicle"], 200];
{
    _patrolGroup reveal [_x, 4];
} forEach _nearestTargets;

[_patrolGroup, _center] call BIS_fnc_taskDefend;
_patrolGroup setBehaviour "COMBAT";
_patrolGroup setCombatMode "RED";
[(units _patrolGroup)] call QS_fnc_setSkill3;
[_patrolGroup, true] call QS_fnc_moveToHC;

[_center, _staticGroup, _patrolGroup] spawn {
	_center = _this select 0;
	_staticGroup = _this select 1;
	_patrolGroup = _this select 2;
	sleep 900;
    {
        deleteVehicle _x;
    } forEach (units _staticGroup);
    deleteGroup _staticGroup;
    {
        deleteVehicle _x;
    } forEach (units _patrolGroup);
    deleteGroup _patrolGroup;
    _objs = nearestObjects [_center, ["All"], 25];
    {
        deleteVehicle _x;
    } forEach _objs;
};
